unit unCadGrupoConfiguracaoImovel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, StdCtrls, plsEdit,
  ExtCtrls, ComCtrls, ToolWin, unObjGrupoConfiguracaoImovel;

type
  TfrmCadGrupoConfiguracaoImovel = class(TfrmCadastroBasico)
    lblCodigo: TLabel;
    plsEdCodigo: TPlsEdit;
    lblNome: TLabel;
    plsEdNome: TPlsEdit;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosNOME: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosNOME: TStringField;
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
    procedure plsEdCodigoEnter(Sender: TObject);
    procedure plsEdNomeEnter(Sender: TObject);
    procedure plsEdCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdNomeKeyPress(Sender: TObject; var Key: Char);
    procedure lblDicasClick(Sender: TObject);
  private
    FoGrupoConfiguracaoImovel: TObjGrupoConfiguracaoImovel;

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
    function GetTotalGrupo: Integer;
  public
    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadGrupoConfiguracaoImovel: TfrmCadGrupoConfiguracaoImovel;

implementation

uses unPesquisandoGrupoConfiguracaoImovel, unDM, unConstantes,
  unSelecionaRegistroGrupoConfiguracaoImovel, unVariaveis;

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmCadGrupoConfiguracaoImovel.iniciarTela(poForm: TForm);
begin
  inherited;

  Application.CreateForm(TfrmPesquisandoGrupoConfiguracaoImovel, FoPesquisa);
  FoPesquisa.iniciarTela(frmCadGrupoConfiguracaoImovel);
  FoPesquisa.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadGrupoConfiguracaoImovel.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;

  if(pTipo = PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.FbChamadaExternaInserirRegistro := True;
    Self.FiTelaExternaChamouInserirRegistro := pValores;
  end;
end;

procedure TfrmCadGrupoConfiguracaoImovel.limparObjeto();
begin
  if (Assigned(FoGrupoConfiguracaoImovel)) then
  begin
    Self.FoGrupoConfiguracaoImovel.setCodigo(NUMERO_INDEFINIDO);
    Self.FoGrupoConfiguracaoImovel.setNome(STRING_INDEFINIDO);
  end
end;

procedure TfrmCadGrupoConfiguracaoImovel.limparTela(poForm: TForm);
begin
  inherited;
end;

procedure TfrmCadGrupoConfiguracaoImovel.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoGrupoConfiguracaoImovel))) then
  begin
    Self.FoGrupoConfiguracaoImovel.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoGrupoConfiguracaoImovel.setNome(cdsDadosNOME.AsString);
  end
  else
  begin
    Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadGrupoConfiguracaoImovel.carregarObjeto();','Acesso Indisponível');
  end;
end;

procedure TfrmCadGrupoConfiguracaoImovel.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoGrupoConfiguracaoImovel))then
  begin
    if(Self.FoGrupoConfiguracaoImovel.getCodigo <> 0)then
      plsEdCodigo.Text := IntToStr(Self.FoGrupoConfiguracaoImovel.getCodigo)
    else
      plsEdCodigo.Clear;
    plsEdNome.Text := Self.FoGrupoConfiguracaoImovel.getNome;
  end;
end;

procedure TfrmCadGrupoConfiguracaoImovel.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM grupo_configuracao_imovel ');
  zQryDados.SQL.Add(Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadGrupoConfiguracaoImovel.verificarHouveAlteracoes(): boolean;
var
  sNome: string;
  bAlteracao: boolean;
begin
  sNome := Trim(plsEdNome.Text);

  try
    bAlteracao := Self.FoGrupoConfiguracaoImovel.verificarDiferencaCadastro(sNome);
  except
    bAlteracao := True;
  end;

  Result := bAlteracao;
end;

function TfrmCadGrupoConfiguracaoImovel.verificarCamposObrigatorios(): boolean;
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

function TfrmCadGrupoConfiguracaoImovel.verificarRegistroJaExiste(): boolean;
begin
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM grupo_configuracao_imovel WHERE nome=:nom');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoGrupoConfiguracaoImovel.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoGrupoConfiguracaoImovel.getCodigo;
  end;
  zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
  zQryDados.Open;
  if(zQryDados.RecordCount <> 0)then
  begin
    Result := True;
    MessageDlg('Grupo já cadastrado.', mtWarning, [mbOK], 0);
  end
  else
    Result := False;
end;

function TfrmCadGrupoConfiguracaoImovel.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;

  //verifica se o grupo não está associado a um sub-grupo
  DM.zQrySubGrupoConfImovel.Close;
  DM.zQrySubGrupoConfImovel.SQL.Clear;
  DM.zQrySubGrupoConfImovel.SQL.Add('SELECT * FROM sub_grupo_conf_imovel WHERE cod_fk_grupo=:cod_fk_gru');
  DM.zQrySubGrupoConfImovel.ParamByName('cod_fk_gru').AsInteger := Self.FoGrupoConfiguracaoImovel.getCodigo;
  DM.zQrySubGrupoConfImovel.Open;
  if(DM.zQrySubGrupoConfImovel.RecordCount <> 0)then
  begin
    MessageDlg('Grupo não pode ser deletado, pois existe um sub-grupo deste grupo.',
      mtInformation, [mbOK], 0);
    bPodeDeletar := False;
  end;

  Result := bPodeDeletar;
end;

procedure TfrmCadGrupoConfiguracaoImovel.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsEdCodigo.SetFocus;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_GRUPO_CONFIGURACAO_IMOVEL,True));
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

procedure TfrmCadGrupoConfiguracaoImovel.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadGrupoConfiguracaoImovel);
  visibilidade(OPC_NOVO);
end;

function TfrmCadGrupoConfiguracaoImovel.salvar(): boolean;
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
        zQryDados.SQL.Add('UPDATE grupo_configuracao_imovel SET nome=:nom ');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
        zQryDados.ParamByName('cod').AsInteger := Self.FoGrupoConfiguracaoImovel.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO grupo_configuracao_imovel (nome) VALUES (:nom)');
        zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
        zQryDados.ExecSQL();
        DM.ZConnection.Commit;
        bSalvou := True;
        Self.verificarInseriuChamadaTelaExterna();
      except
        DM.ZConnection.Rollback;
      end;
    end;
  end;

  if((bSalvou)and(not(FbChamadaExternaInserirRegistro)))then
    Self.FoPesquisa.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS,null);

  Result := bSalvou;
end;

function TfrmCadGrupoConfiguracaoImovel.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM grupo_configuracao_imovel WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoGrupoConfiguracaoImovel.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadGrupoConfiguracaoImovel.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
begin
  DM.zQryGrupoConfiguracaoImovel.Close;
  DM.zQryGrupoConfiguracaoImovel.SQL.Clear;
  DM.zQryGrupoConfiguracaoImovel.SQL.Add('SELECT * FROM grupo_configuracao_imovel ORDER BY codigo DESC ROWS 1');
  DM.zQryGrupoConfiguracaoImovel.Open;
  if(DM.zQryGrupoConfiguracaoImovel.RecordCount = 1)then
    nCodigo := DM.zQryGrupoConfiguracaoImovelCODIGO.AsInteger
  else
    nCodigo := NUMERO_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_GRUPO_CONFIGURACAO_IMOVEL)then
    begin
      frmSelecionaRegistroGrupoConfiguracaoImovel.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end;
end;

procedure TfrmCadGrupoConfiguracaoImovel.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

function TfrmCadGrupoConfiguracaoImovel.GetTotalGrupo: Integer;
begin
  DM.zQryGrupoConfiguracaoImovel.Close;
  DM.zQryGrupoConfiguracaoImovel.SQL.Clear;
  DM.zQryGrupoConfiguracaoImovel.SQL.Add('SELECT * FROM grupo_configuracao_imovel');
  DM.zQryGrupoConfiguracaoImovel.Open;
  Result := DM.zQryGrupoConfiguracaoImovel.RecordCount;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadGrupoConfiguracaoImovel.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoGrupoConfiguracaoImovel := TObjGrupoConfiguracaoImovel.Create;
end;

procedure TfrmCadGrupoConfiguracaoImovel.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoGrupoConfiguracaoImovel);
end;

procedure TfrmCadGrupoConfiguracaoImovel.tlBtnNovoClick(Sender: TObject);
begin
  if(GetTotalGrupo > 20)then //cadastro máximo de 20 grupos
  begin
    MessageDlg('Não é possível cadastrar mais de 20 grupos.' +#13+ 'Contacte o administrador do sistema.',
      mtInformation, [mbOK], 0);
    tlBtnCancelarClick(Self);
  end
  else
  begin
    inherited;
    //Self.novo;
  end;
end;

procedure TfrmCadGrupoConfiguracaoImovel.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadGrupoConfiguracaoImovel.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadGrupoConfiguracaoImovel.tlBtnExcluirClick(
  Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadGrupoConfiguracaoImovel.tlBtnCancelarClick(
  Sender: TObject);
begin
  inherited;
  //visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadGrupoConfiguracaoImovel.plsEdCodigoExit(Sender: TObject);
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

procedure TfrmCadGrupoConfiguracaoImovel.plsEdNomeExit(Sender: TObject);
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

procedure TfrmCadGrupoConfiguracaoImovel.plsEdCodigoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  sValor: string;
begin
  inherited;
  if(plsEdCodigo.Text <> STRING_INDEFINIDO)then
  begin
    if(FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[numeros],False))then
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
          FnCampoPesquisou := CAMPO_PESQUISOU_POR_CODIGO;
          sValor := plsEdCodigo.Text;
          ActiveControl := nil;
          FoPesquisa.atualizarPesquisando('CC_CODIGO', 'Código:', sValor, cdsDados);
          if(FoPesquisa.PodeAbrirTelaPesquisandoRegistro)then
            FoPesquisa.Show;
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadGrupoConfiguracaoImovel.plsEdNomeKeyUp(Sender: TObject;
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
      if(Self.FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[todas],False))then
      begin
        sValor := plsEdNome.Text;
        if(sValor <> STRING_INDEFINIDO)then
        begin
          FnCampoPesquisou := CAMPO_PESQUISOU_POR_NOME;
          sValor := UpperCase(sValor);
          ActiveControl := nil;
          FoPesquisa.atualizarPesquisando('NOME', 'Nome:', sValor, cdsDados);
          if(FoPesquisa.PodeAbrirTelaPesquisandoRegistro)then 
            FoPesquisa.Show;
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadGrupoConfiguracaoImovel.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadGrupoConfiguracaoImovel.plsEdCodigoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Grupo pelo Código',STRING_INDEFINIDO);
end;

procedure TfrmCadGrupoConfiguracaoImovel.plsEdNomeEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Grupo pelo Nome','Nome do Grupo');
end;

procedure TfrmCadGrupoConfiguracaoImovel.plsEdCodigoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos('Grupo pelo Código',STRING_INDEFINIDO);
end;

procedure TfrmCadGrupoConfiguracaoImovel.plsEdNomeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos('Grupo pelo Nome','Nome do Grupo');
end;

procedure TfrmCadGrupoConfiguracaoImovel.lblDicasClick(Sender: TObject);
begin
  inherited;
  FoFuncoes.CriarTelaDicas(FORM_CAD_GRUPO_CONFIGURACAO_IMOVEL);
end;

end.
