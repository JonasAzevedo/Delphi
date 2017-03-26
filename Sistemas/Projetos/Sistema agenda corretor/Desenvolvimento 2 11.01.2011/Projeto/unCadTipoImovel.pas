unit unCadTipoImovel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, ComCtrls, ToolWin,
  StdCtrls, plsEdit, unObjTipoImovel;

type
  TfrmCadTipoImovel = class(TfrmCadastroBasico)
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosNOME: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosNOME: TStringField;
    Label1: TLabel;
    plsEdCodigo: TPlsEdit;
    plsEdNome: TPlsEdit;
    Label2: TLabel;
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
    FoTipoImovel: TObjTipoImovel;

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
    procedure realizouPesquisa(piCodigo: Integer); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
  end;

var
  frmCadTipoImovel: TfrmCadTipoImovel;

implementation

uses unPesquisandoTipoImovel, unDM, unConstantes, unVariaveis,
  unSelecionaRegistroTipoImovel;

{$R *.dfm}

{ TfrmCadTipoImovel }

(* procedimentos de controle *)

procedure TfrmCadTipoImovel.iniciarTela(poForm: TForm);
begin
  inherited;
  Application.CreateForm(TfrmPesquisandoTipoImovel, Self.FoPesquisa);
  Self.FoPesquisa.iniciarTela(frmCadTipoImovel);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadTipoImovel.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;

  if(pTipo = PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.FbChamadaExternaInserirRegistro := True;
    Self.FiTelaExternaChamouInserirRegistro := pValores;
  end;
end;

procedure TfrmCadTipoImovel.limparObjeto();
begin
  if (Assigned(Self.FoTipoImovel)) then
  begin
    Self.FoTipoImovel.setCodigo(NUMERO_INDEFINIDO);
    Self.FoTipoImovel.setNome(STRING_INDEFINIDO);
  end
end;

procedure TfrmCadTipoImovel.limparTela(poForm: TForm);
begin
  inherited;
end;

procedure TfrmCadTipoImovel.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoTipoImovel))) then
  begin
    Self.FoTipoImovel.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoTipoImovel.setNome(cdsDadosNOME.AsString);
  end
  else
  begin
    FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadTipoImovel.carregarObjeto();','Acesso Indisponível');
  end;
end;

procedure TfrmCadTipoImovel.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoTipoImovel))then
  begin
    if(Self.FoTipoImovel.getCodigo <> NUMERO_INDEFINIDO)then
      plsEdCodigo.Text := IntToStr(Self.FoTipoImovel.getCodigo)
    else
      plsEdCodigo.Clear;
    plsEdNome.Text := Self.FoTipoImovel.getNome;
  end;
end;

procedure TfrmCadTipoImovel.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM tipo_imovel ');
  zQryDados.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadTipoImovel.verificarHouveAlteracoes(): boolean;
var
  sNome: String;
  bAlteracao: Boolean;
begin
  sNome := Trim(plsEdNome.Text);
  try
    bAlteracao := Self.FoTipoImovel.verificarDiferencaCadastro(sNome);
  except
    bAlteracao := True;
  end;

  Result := bAlteracao;
end;

function TfrmCadTipoImovel.verificarCamposObrigatorios(): boolean;
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

function TfrmCadTipoImovel.verificarRegistroJaExiste(): boolean;
begin 
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM tipo_imovel WHERE nome=:nom');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoTipoImovel.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoTipoImovel.getCodigo;
  end;
  zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
  zQryDados.Open;
  if(zQryDados.RecordCount <> 0)then
  begin
    Result := True;
    MessageDlg('Tipo de Imóvel já cadastrado.', mtWarning, [mbOK], 0);
    plsEdNome.SetFocus;
  end
  else
    Result := False;
end;

function TfrmCadTipoImovel.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;

  //verifica se tipo_imovel não está associado a um imovel
  DM.zQryImovel.Close;
  DM.zQryImovel.SQL.Clear;
  DM.zQryImovel.SQL.Add('SELECT * FROM imovel WHERE cod_fk_tipo_imovel=:cod_fk_tip_imo');
  DM.zQryImovel.ParamByName('cod_fk_tip_imo').AsInteger := Self.FoTipoImovel.getCodigo;
  DM.zQryImovel.Open;
  if(DM.zQryImovel.RecordCount <> 0)then
  begin
    MessageDlg('Tipo de Imóvel não pode ser deletado, pois existe um imóvel deste tipo de imóvel.',
      mtInformation, [mbOK], 0);
    bPodeDeletar := False;
  end;

  //verifica se tipo_imovel não está associado a um imovel_de_interesse
  if(bPodeDeletar)then
  begin
    DM.zQryImovelDeInteresse.Close;
    DM.zQryImovelDeInteresse.SQL.Clear;
    DM.zQryImovelDeInteresse.SQL.Add('SELECT * FROM imovel_de_interesse WHERE cod_fk_tipo_imovel=:cod_fk_tip_imo');
    DM.zQryImovelDeInteresse.ParamByName('cod_fk_tip_imo').AsInteger := Self.FoTipoImovel.getCodigo;
    DM.zQryImovelDeInteresse.Open;
    if(DM.zQryImovelDeInteresse.RecordCount <> 0)then
    begin
      MessageDlg('Tipo de Imóvel não pode ser deletado, pois existe um imóvel de interesse deste tipo de imóvel.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  Result := bPodeDeletar;
end;

procedure TfrmCadTipoImovel.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsEdCodigo.SetFocus;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_TIPO_IMOVEL,True));    
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

procedure TfrmCadTipoImovel.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadTipoImovel);
  visibilidade(OPC_NOVO);
end;

function TfrmCadTipoImovel.salvar(): boolean;
var
  bSalvou: Boolean;
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
        zQryDados.SQL.Add('UPDATE tipo_imovel SET nome=:nom ');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
        zQryDados.ParamByName('cod').AsInteger := Self.FoTipoImovel.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO tipo_imovel (nome) ');
        zQryDados.SQL.Add('VALUES (:nom)');
        zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
        zQryDados.ExecSQL();
        DM.ZConnection.Commit;
        bSalvou := True;
        verificarInseriuChamadaTelaExterna();
      except
        DM.ZConnection.Rollback;
      end;
    end;
  end;

  if((bSalvou)and(not(FbChamadaExternaInserirRegistro)))then
    Self.FoPesquisa.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS,null);

  Result := bSalvou;
end;

function TfrmCadTipoImovel.excluir(): Boolean;
var
  bDeletou: Boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM tipo_imovel WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoTipoImovel.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadTipoImovel.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
begin
  DM.zQryTipoImovel.Close;
  DM.zQryTipoImovel.SQL.Clear;
  DM.zQryTipoImovel.SQL.Add('SELECT * FROM tipo_imovel ORDER BY codigo DESC ROWS 1');
  DM.zQryTipoImovel.Open;
  if(DM.zQryTipoImovel.RecordCount = 1)then
    nCodigo := DM.zQryTipoImovelCODIGO.AsInteger
  else
    nCodigo := NUMERO_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_TIPO_IMOVEL)then
    begin
      frmSelecionaRegistroTipoImovel.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end;
end;

procedure TfrmCadTipoImovel.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadTipoImovel.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoTipoImovel := TObjTipoImovel.Create;
end;

procedure TfrmCadTipoImovel.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoTipoImovel);
end;

procedure TfrmCadTipoImovel.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadTipoImovel.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadTipoImovel.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadTipoImovel.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadTipoImovel.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadTipoImovel.plsEdCodigoExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;

  if(FiFuncaoRegistro = FUNCAO_REGISTRO_NENHUM)and(plsEdCodigo.Text = STRING_INDEFINIDO)
  and(FnCampoPesquisou = CAMPO_PESQUISOU_POR_CODIGO)then
  begin
    limparObjeto();
    limparTela(Self);
    visibilidade(OPC_CANCELAR);
  end;    
end;

procedure TfrmCadTipoImovel.plsEdNomeExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;

  if(FiFuncaoRegistro = FUNCAO_REGISTRO_NENHUM)and(plsEdNome.Text = STRING_INDEFINIDO)
  and(FnCampoPesquisou = CAMPO_PESQUISOU_POR_NOME)then
  begin
    limparObjeto();
    limparTela(Self);
    visibilidade(OPC_CANCELAR);
  end;
end;

procedure TfrmCadTipoImovel.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadTipoImovel.plsEdCodigoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  sValor: string;
begin
  inherited;
  if(FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[numeros],False))then
  begin
    if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter)) then
    begin
      if(Key=27)then //esc
      begin
        if(Assigned(Self.FoPesquisa))then
          Self.FoPesquisa.Hide;
      end
      else
      begin
        FnCampoPesquisou := CAMPO_PESQUISOU_POR_CODIGO;
        sValor := plsEdCodigo.Text;
        ActiveControl := nil;
        Self.FoPesquisa.atualizarPesquisando('CC_CODIGO', 'Código:', sValor, cdsDados);
        Self.FoPesquisa.Show;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;                                

procedure TfrmCadTipoImovel.plsEdNomeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sValor: string;
begin
  inherited;
  if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter)) then
  begin
    if(Key=27)then
    begin
      if(Assigned(Self.FoPesquisa))then
        Self.FoPesquisa.Hide;
    end
    else
    begin
      if(Self.FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[alfanumericas],False))then
      begin
        FnCampoPesquisou := CAMPO_PESQUISOU_POR_NOME;
        sValor := UpperCase(sValor);
        ActiveControl := nil;
        if(sValor <> STRING_INDEFINIDO)then
        begin
          Self.FoPesquisa.atualizarPesquisando('NOME', 'Nome:', sValor, cdsDados);
          Self.FoPesquisa.Show;
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

end.
