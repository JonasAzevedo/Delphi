unit unCadMeioCaptacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, StdCtrls, plsEdit,
  ComCtrls, ToolWin, plsMemo, unObjMeioCaptacao;

type
  TfrmCadMeioCaptacao = class(TfrmCadastroBasico)
    zQryDadosCODIGO: TIntegerField;
    zQryDadosNOME: TStringField;
    zQryDadosDESCRICAO: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosNOME: TStringField;
    cdsDadosDESCRICAO: TStringField;
    lblCodigo: TLabel;
    plsEdCodigo: TPlsEdit;
    lblNome: TLabel;
    plsEdNome: TPlsEdit;
    lblDescricao: TLabel;
    plsMmDescricao: TPlsMemo;
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
    procedure plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsEdNomeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FoMeioCaptacao: TObjMeioCaptacao;

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
    procedure verificarInseriuChamadaTelaExterna(); override;
  public
    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadMeioCaptacao: TfrmCadMeioCaptacao;

implementation

uses unDM, unPesquisandoMeioCaptacao, unConstantes, unVariaveis,
  unSelecionaRegistroMeioCaptacao;


{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmCadMeioCaptacao.iniciarTela(poForm: TForm);
begin
  inherited;

  Application.CreateForm(TfrmPesquisandoMeioCaptacao, FoPesquisa);
  FoPesquisa.iniciarTela(frmCadMeioCaptacao);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadMeioCaptacao.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;

  if(pTipo = PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.FbChamadaExternaInserirRegistro := True;
    Self.FiTelaExternaChamouInserirRegistro := pValores;
  end
end;

procedure TfrmCadMeioCaptacao.limparObjeto();
begin
  if (Assigned(FoMeioCaptacao)) then
  begin
    Self.FoMeioCaptacao.limparObjeto();
  end
end;

procedure TfrmCadMeioCaptacao.limparTela(poForm: TForm);
begin
  inherited;

end;

procedure TfrmCadMeioCaptacao.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoMeioCaptacao))) then
  begin
    Self.FoMeioCaptacao.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoMeioCaptacao.setNome(cdsDadosNOME.AsString);
    Self.FoMeioCaptacao.setDescricao(cdsDadosDESCRICAO.AsString);
  end
  else
  begin
    Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadMeioCaptacao.carregarObjeto();','Acesso Indisponível');
  end;
end;

procedure TfrmCadMeioCaptacao.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoMeioCaptacao))then
  begin
    if(Self.FoMeioCaptacao.getCodigo <> 0)then
      plsEdCodigo.Text := IntToStr(Self.FoMeioCaptacao.getCodigo)
    else
      plsEdCodigo.Clear;
    plsEdNome.Text := Self.FoMeioCaptacao.getNome;
    plsMmDescricao.Text := Self.FoMeioCaptacao.getDescricao;
  end;
end;

procedure TfrmCadMeioCaptacao.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM meio_captacao ');
  zQryDados.SQL.Add(Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadMeioCaptacao.verificarHouveAlteracoes(): boolean;
var
  sNome: String;
  sDescricao: String;
  bAlteracao: Boolean;
begin
  sNome := Trim(plsEdNome.Text);
  sDescricao := Trim(plsMmDescricao.Text);

  try
    bAlteracao := Self.FoMeioCaptacao.verificarDiferencaCadastro(sNome, sDescricao);
  except
    bAlteracao := True;
  end;

  Result := bAlteracao;
end;

function TfrmCadMeioCaptacao.verificarCamposObrigatorios(): boolean;
var
  bRetorno: boolean;
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
    Self.FoFuncoes.focarComponente(compFoco);

  Result := bRetorno;
end;

function TfrmCadMeioCaptacao.verificarRegistroJaExiste(): boolean;
begin
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM meio_captacao WHERE nome=:nome AND descricao=:descricao');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoMeioCaptacao.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoMeioCaptacao.getCodigo;
  end;
  zQryDados.ParamByName('nome').AsString := Trim(plsEdNome.Text);
  zQryDados.ParamByName('descricao').AsString := Trim(plsMmDescricao.Text);
  zQryDados.Open;
  if(zQryDados.RecordCount <> 0)then
  begin
    Result := True;
    MessageDlg('Meio de captação já cadastrado.', mtWarning, [mbOK], 0);
  end
  else
    Result := False;
end;

function TfrmCadMeioCaptacao.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;

  Result := bPodeDeletar;
end;

procedure TfrmCadMeioCaptacao.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsMmDescricao.Enabled := False;
                       plsEdCodigo.SetFocus;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsMmDescricao.Enabled := True;
                       plsEdNome.SetFocus;
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsMmDescricao.Enabled := True;
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
                       plsMmDescricao.Enabled := False;
                     end;
  end; //fim - case

end;

procedure TfrmCadMeioCaptacao.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadMeioCaptacao);
  visibilidade(OPC_NOVO);
end;

function TfrmCadMeioCaptacao.salvar(): boolean;
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
        zQryDados.SQL.Add('UPDATE meio_captacao SET nome=:nome, descricao=:descricao ');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('nome').AsString := Trim(plsEdNome.Text);
        zQryDados.ParamByName('descricao').AsString := Trim(plsMmDescricao.Text);
        zQryDados.ParamByName('cod').AsInteger := Self.FoMeioCaptacao.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO meio_captacao (nome, descricao) VALUES (:nome,:descricao)');
        zQryDados.ParamByName('nome').AsString := Trim(plsEdNome.Text);
        zQryDados.ParamByName('descricao').AsString := Trim(plsMmDescricao.Text);
        zQryDados.ExecSQL();
        DM.ZConnection.Commit;
        bSalvou := True;
        Self.verificarInseriuChamadaTelaExterna();
      except
        DM.ZConnection.Rollback;
      end;
    end;
  end;

  (* esta tela não irá usar chamada externa para inserir registro
  if((bSalvou)and(not(FbChamadaExternaInserirRegistro)))then
    Self.FoPesquisa.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS,null);
  *)

  Result := bSalvou;
end;

function TfrmCadMeioCaptacao.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM meio_captacao WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoMeioCaptacao.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadMeioCaptacao.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
begin
  DM.zQryMeioCaptacao.Close;
  DM.zQryMeioCaptacao.SQL.Clear;
  DM.zQryMeioCaptacao.SQL.Add('SELECT * FROM meio_captacao ORDER BY codigo DESC ROWS 1');
  DM.zQryMeioCaptacao.Open;
  if(DM.zQryMeioCaptacao.RecordCount = 1)then
    nCodigo := DM.zQryMeioCaptacaoCODIGO.AsInteger
  else
    nCodigo := NUMERO_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_MEIO_CAPTACAO)then
    begin
      frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end;
end;

procedure TfrmCadMeioCaptacao.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadMeioCaptacao.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoMeioCaptacao := TObjMeioCaptacao.Create;
end;

procedure TfrmCadMeioCaptacao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoMeioCaptacao);
end;

procedure TfrmCadMeioCaptacao.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadMeioCaptacao.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadMeioCaptacao.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadMeioCaptacao.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadMeioCaptacao.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  //visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadMeioCaptacao.plsEdCodigoExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoMeioCaptacao))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadMeioCaptacao.plsEdNomeExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadMeioCaptacao.plsEdCodigoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  sValor: string;
begin
  inherited;
  if(Self.FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[numeros],False))then
  begin
    if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter)) then
    begin
      if(Key=27)then //27 = esc
      begin
        if(Assigned(Self.FoPesquisa))then
          Self.FoPesquisa.Hide;
      end
      else
      begin
        sValor := plsEdCodigo.Text;
        FoPesquisa.atualizarPesquisando('CC_CODIGO', 'Código:', sValor, cdsDados);
        FoPesquisa.Show;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;                                

procedure TfrmCadMeioCaptacao.plsEdNomeKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  sValor: string;
begin
  inherited;
  if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter)) then
  begin
    if(Key=27)then //esc
    begin
      if(Assigned(Self.FoPesquisa))then
        Self.FoPesquisa.Hide;
    end
    else
    begin
      if(Self.FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[alfanumericas],False))then
      begin
        sValor := plsEdNome.Text;
        if(sValor <> STRING_INDEFINIDO)then
        begin
          sValor := UpperCase(sValor);
          FoPesquisa.atualizarPesquisando('NOME', 'Nome:', sValor, cdsDados);
          FoPesquisa.Show;
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadMeioCaptacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

end.
