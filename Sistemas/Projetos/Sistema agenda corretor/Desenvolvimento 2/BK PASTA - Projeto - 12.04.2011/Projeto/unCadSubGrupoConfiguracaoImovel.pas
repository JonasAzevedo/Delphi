unit unCadSubGrupoConfiguracaoImovel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, StdCtrls, plsEdit,
  ExtCtrls, ComCtrls, ToolWin, Buttons, unObjSubGrupoConfImovel, unConjuntoDadosGrupo;

type
    TGrupo = record
      codigo: Integer;
      nome: string[50];
    end;

type
  TfrmCadSubGrupoConfiguracaoImovel = class(TfrmCadastroBasico)
    pnlGrupo: TPanel;
    spBtnBuscaGrupo: TSpeedButton;
    lblCampoObrigatorio1: TLabel;
    lblGrupo: TLabel;
    plsEdGrupo: TPlsEdit;
    lblCodigo: TLabel;
    plsEdCodigo: TPlsEdit;
    plsEdNome: TPlsEdit;
    lblCampoObrigatorio2: TLabel;
    lblNomeSubGrupo: TLabel;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosCOD_FK_GRUPO: TIntegerField;
    zQryDadosNOME: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosCOD_FK_GRUPO: TIntegerField;
    cdsDadosNOME: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure plsEdCodigoExit(Sender: TObject);
    procedure plsEdNomeExit(Sender: TObject);
    procedure spBtnBuscaGrupoClick(Sender: TObject);
    procedure plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsEdNomeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure plsEdGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdGrupoExit(Sender: TObject);
    procedure plsEdCodigoEnter(Sender: TObject);
    procedure plsEdNomeEnter(Sender: TObject);
    procedure plsEdGrupoEnter(Sender: TObject);
    procedure plsEdCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdNomeKeyPress(Sender: TObject; var Key: Char);
    procedure lblDicasClick(Sender: TObject);
  private
    FoSubGrupoConfImovel: TObjSubGrupoConfImovel;
    FoConjuntoDadosGrupo: TConjuntoDadosGrupo;

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
    procedure AbreTelaSelecaoGrupo(pnTpSelecao:Word);
    procedure VerificarGrupoExiste();
  public
    FoGrupo: TGrupo;
    FoGrupoAux: TGrupo;

    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadSubGrupoConfiguracaoImovel: TfrmCadSubGrupoConfiguracaoImovel;

implementation

uses unDM, unPesquisandoSubGrupoConfImovel, unConstantes,
  unSelecionaRegistroSubGrupoConfImovel,
  unSelecionaRegistroGrupoConfiguracaoImovel, unVariaveis;

const
  fnSELECIONAR_GRUPO_NORMAL    = 1;
  fnSELECIONAR_GRUPO_DIGITANDO = 2;

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmCadSubGrupoConfiguracaoImovel.iniciarTela(poForm: TForm);
begin
  inherited;

  Application.CreateForm(TfrmPesquisandoSubGrupoConfImovel, FoPesquisa);
  FoPesquisa.iniciarTela(frmCadSubGrupoConfiguracaoImovel);
  FoPesquisa.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;

  //objeto auxiliar para armazenar grupo do sub-grupo que será inserido - FbChamadaExternaInserirRegistro=True
  Self.FoGrupo.codigo := NUMERO_INDEFINIDO;
  Self.FoGrupoAux.nome := STRING_INDEFINIDO;
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.passarParametro(pTipo:String; pValores:OleVariant);
var
  nCodFK_Grupo: Integer;
begin
  inherited;

  if(pTipo = PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.FbChamadaExternaInserirRegistro := True;
    Self.FiTelaExternaChamouInserirRegistro := pValores;
  end

  else if(pTipo = PRM_DEFINE_GRUPO_SUBGRUPO_INSERINDO)then
  begin
    if(VarIsNumeric(pValores))then
    begin
      nCodFK_Grupo := pValores;
      if(nCodFK_Grupo <> NUMERO_INDEFINIDO)then
      begin
        DM.zQryGrupoConfiguracaoImovel.Close;
        DM.zQryGrupoConfiguracaoImovel.SQL.Clear;
        DM.zQryGrupoConfiguracaoImovel.SQL.Add('SELECT * FROM grupo_configuracao_imovel WHERE codigo = :est');
        DM.zQryGrupoConfiguracaoImovel.ParamByName('est').AsInteger := nCodFK_Grupo;
        DM.zQryGrupoConfiguracaoImovel.Open;
        if(DM.zQryGrupoConfiguracaoImovel.RecordCount=1)then
        begin
          Self.FoGrupoAux.codigo := DM.zQryGrupoConfiguracaoImovelCODIGO.AsInteger;
          Self.FoGrupoAux.nome := DM.zQryGrupoConfiguracaoImovelNOME.AsString;
        end;
      end;
    end;
  end

  else if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS)then
    FoConjuntoDadosGrupo.ExecutarSQLSelecao();
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.limparObjeto();
begin
  if (Assigned(FoSubGrupoConfImovel)) then
  begin
    Self.FoSubGrupoConfImovel.setCodigo(NUMERO_INDEFINIDO);
    Self.FoSubGrupoConfImovel.setFkGrupo(NUMERO_INDEFINIDO);
    Self.FoSubGrupoConfImovel.setNome(STRING_INDEFINIDO);
  end
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.limparTela(poForm: TForm);
begin
  inherited;

  Self.FoGrupo.codigo := NUMERO_INDEFINIDO;
  Self.FoGrupo.nome := STRING_INDEFINIDO;
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoSubGrupoConfImovel))) then
  begin
    Self.FoSubGrupoConfImovel.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoSubGrupoConfImovel.setFkGrupo(cdsDadosCOD_FK_GRUPO.AsInteger);
    Self.FoSubGrupoConfImovel.setNome(cdsDadosNOME.AsString);
    Self.FoSubGrupoConfImovel.setExibeGrupo();
  end
  else
  begin
    Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadSubGrupoConfiguracaoImovel.carregarObjeto();','Acesso Indisponível');
  end;
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoSubGrupoConfImovel))then
  begin
    if(Self.FoSubGrupoConfImovel.getCodigo <> 0)then
      plsEdCodigo.Text := IntToStr(Self.FoSubGrupoConfImovel.getCodigo)
    else
      plsEdCodigo.Clear;
    plsEdGrupo.Text := Self.FoSubGrupoConfImovel.getExibeGrupo;
    Self.FoGrupo.codigo := Self.FoSubGrupoConfImovel.getFkGrupo;
    Self.FoGrupo.nome := Self.FoSubGrupoConfImovel.getExibeGrupo;
    plsEdNome.Text := Self.FoSubGrupoConfImovel.getNome;
  end;
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM sub_grupo_conf_imovel ');
  zQryDados.SQL.Add(Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadSubGrupoConfiguracaoImovel.verificarHouveAlteracoes(): boolean;
var
  iGrupo: Integer;
  sNome: string;
  bAlteracao: boolean;
begin
  iGrupo := Self.FoGrupo.codigo;
  sNome := Trim(plsEdNome.Text);

  try
    bAlteracao := Self.FoSubGrupoConfImovel.verificarDiferencaCadastro(iGrupo, sNome);
  except
    bAlteracao := True;
  end;

  Result := bAlteracao;
end;

function TfrmCadSubGrupoConfiguracaoImovel.verificarCamposObrigatorios(): boolean;
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

  if(Self.FoGrupo.codigo = NUMERO_INDEFINIDO)then
  begin
    campos := 'Grupo';
    compFoco := plsEdGrupo;
  end;

  if(Trim(plsEdNome.Text) = '')then
  begin
    if(campos <> '')then
      campos := campos + ', Nome'
    else
    begin
      campos := 'Nome';
      compFoco := plsEdNome;
    end;
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

function TfrmCadSubGrupoConfiguracaoImovel.verificarRegistroJaExiste(): boolean;
begin
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM sub_grupo_conf_imovel WHERE cod_fk_grupo=:cod_fk_gru AND nome=:nom');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoSubGrupoConfImovel.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoSubGrupoConfImovel.getCodigo;
  end;
  zQryDados.ParamByName('cod_fk_gru').AsInteger := Self.FoGrupo.codigo;
  zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
  zQryDados.Open;
  if(zQryDados.RecordCount <> 0)then
  begin
    Result := True;
    MessageDlg('Sub-Grupo já cadastrado.', mtWarning, [mbOK], 0);
  end
  else
    Result := False;
end;

function TfrmCadSubGrupoConfiguracaoImovel.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;
  Result := bPodeDeletar;
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       pnlGrupo.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsEdCodigo.SetFocus;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_SUB_GRUPO_CONF_IMOVEL,True));
                       plsEdCodigo.Enabled := False;
                       pnlGrupo.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsEdGrupo.SetFocus;
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       pnlGrupo.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsEdGrupo.SetFocus;
                     end;
    OPC_SALVAR:      begin
                     end;
    OPC_EXCLUIR:     begin
                     end;
    OPC_CANCELAR:    begin
                     end;
    OPC_PESQUISOU:   begin
                       plsEdCodigo.Enabled := True;
                       pnlGrupo.Enabled := False;
                       plsEdNome.Enabled := True;
                     end;
  end; //fim - case

end;

procedure TfrmCadSubGrupoConfiguracaoImovel.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadSubGrupoConfiguracaoImovel);
  visibilidade(OPC_NOVO);
end;

function TfrmCadSubGrupoConfiguracaoImovel.salvar(): boolean;
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
        zQryDados.SQL.Add('UPDATE sub_grupo_conf_imovel SET cod_fk_grupo=:cod_fk_gru, nome=:nom');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('cod_fk_gru').AsInteger := Self.FoGrupo.codigo;
        zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
        zQryDados.ParamByName('cod').AsInteger := Self.FoSubGrupoConfImovel.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO sub_grupo_conf_imovel (cod_fk_grupo, nome) VALUES (:cod_fk_gru,:nom)');
        zQryDados.ParamByName('cod_fk_gru').AsInteger := Self.FoGrupo.codigo;
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

function TfrmCadSubGrupoConfiguracaoImovel.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM sub_grupo_conf_imovel WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoSubGrupoConfImovel.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
begin
  DM.zQrySubGrupoConfImovel.Close;
  DM.zQrySubGrupoConfImovel.SQL.Clear;
  DM.zQrySubGrupoConfImovel.SQL.Add('SELECT * FROM sub_grupo_conf_imovel ORDER BY codigo DESC ROWS 1');
  DM.zQrySubGrupoConfImovel.Open;
  if(DM.zQrySubGrupoConfImovel.RecordCount = 1)then
    nCodigo := DM.zQrySubGrupoConfImovelCODIGO.AsInteger
  else
    nCodigo := NUMERO_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_SUB_GRUPO_CONF_IMOVEL)then
    begin
      frmSelecionaRegistroSubGrupoConfiguracaoImovel.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end;
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.AbreTelaSelecaoGrupo(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  //caiu a ficha de um conjunto de dados
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdGrupo.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_GRUPO_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroGrupoConfiguracaoImovel, frmSelecionaRegistroGrupoConfiguracaoImovel);
        frmSelecionaRegistroGrupoConfiguracaoImovel.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_SUB_GRUPO_CONF_IMOVEL);
        frmSelecionaRegistroGrupoConfiguracaoImovel.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroGrupoConfiguracaoImovel.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE, null);
        frmSelecionaRegistroGrupoConfiguracaoImovel.ShowModal;
      finally
        if(Self.FoGrupo.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdGrupo.Text := Self.FoGrupo.nome;
          Self.FoFuncoes.focarComponente(plsEdNome);
        end;
        FreeAndNil(frmSelecionaRegistroGrupoConfiguracaoImovel);
      end;
    end;

    fnSELECIONAR_GRUPO_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroGrupoConfiguracaoImovel, frmSelecionaRegistroGrupoConfiguracaoImovel);
        frmSelecionaRegistroGrupoConfiguracaoImovel.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_SUB_GRUPO_CONF_IMOVEL);
        frmSelecionaRegistroGrupoConfiguracaoImovel.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroGrupoConfiguracaoImovel.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE, null);        
        frmSelecionaRegistroGrupoConfiguracaoImovel.ShowModal;
      finally
        if(Self.FoGrupo.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdGrupo.Text := Self.FoGrupo.nome;
          Self.FoFuncoes.focarComponente(plsEdNome);
        end
        else
          plsEdGrupo.Clear;
        FreeAndNil(frmSelecionaRegistroGrupoConfiguracaoImovel);
      end;
    end;

  end;

end;

procedure TfrmCadSubGrupoConfiguracaoImovel.VerificarGrupoExiste();
begin
  if(Trim(plsEdGrupo.Text) <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosGrupo.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdGrupo.Text + '%'));
    FoConjuntoDadosGrupo.ExecutarFiltrar();

    if(FoConjuntoDadosGrupo.TotalRegistros = 1)then
    begin
      FoGrupo.codigo := FoConjuntoDadosGrupo.GetCodigo;
      FoGrupo.nome := FoConjuntoDadosGrupo.GetNome;
      plsEdGrupo.Text := FoGrupo.nome;
    end
    else if(FoConjuntoDadosGrupo.TotalRegistros > 1)then
      AbreTelaSelecaoGrupo(fnSELECIONAR_GRUPO_DIGITANDO)
    else
    begin
      MessageDlg('Grupo não encontrado.', mtInformation, [mbOK], 0);
        FoFuncoes.focarComponente(plsEdGrupo);
    end;
  end
  else
  begin
    plsEdGrupo.Clear;
    FoGrupo.codigo := NUMERO_INDEFINIDO;
    FoGrupo.nome := STRING_INDEFINIDO;
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadSubGrupoConfiguracaoImovel.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoSubGrupoConfImovel := TObjSubGrupoConfImovel.Create;
  FoConjuntoDadosGrupo := TConjuntoDadosGrupo.CriaObjeto;
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoSubGrupoConfImovel);
  FreeAndNil(FoConjuntoDadosGrupo);
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.tlBtnNovoClick(
  Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.tlBtnEditarClick(
  Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.tlBtnSalvarClick(
  Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.tlBtnExcluirClick(
  Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.tlBtnCancelarClick(
  Sender: TObject);
begin
  inherited;
  //visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.plsEdCodigoExit(
  Sender: TObject);
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

procedure TfrmCadSubGrupoConfiguracaoImovel.plsEdNomeExit(Sender: TObject);
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

procedure TfrmCadSubGrupoConfiguracaoImovel.spBtnBuscaGrupoClick(
  Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoGrupo(fnSELECIONAR_GRUPO_NORMAL);
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.plsEdCodigoKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfrmCadSubGrupoConfiguracaoImovel.plsEdNomeKeyUp(Sender: TObject;
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

procedure TfrmCadSubGrupoConfiguracaoImovel.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.FormShow(Sender: TObject);
begin
  inherited;
  //caso for pra inserir com um grupo definido
  if(Self.FoGrupoAux.codigo <> NUMERO_INDEFINIDO)then
  begin
    Self.FoGrupo.codigo := Self.FoGrupoAux.codigo;
    Self.FoGrupo.nome := Self.FoGrupoAux.nome;
    plsEdGrupo.Text := Self.FoGrupo.nome;
    pnlGrupo.Enabled := False;
    Self.FoFuncoes.focarComponente(plsEdNome);
  end;
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.plsEdGrupoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Nome do Grupo');
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.plsEdGrupoExit(
  Sender: TObject);
begin
  inherited;
  VerificarGrupoExiste();
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.plsEdCodigoEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Sub-Grupo pelo Código', STRING_INDEFINIDO);
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.plsEdNomeEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Sub-Grupo pelo Nome', 'Nome do Sub-Grupo');
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.plsEdGrupoEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Nome do Grupo');
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.plsEdCodigoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos('Sub-Grupo pelo Código', STRING_INDEFINIDO);
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.plsEdNomeKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos('Sub-Grupo pelo Nome', 'Nome do Sub-Grupo');
end;

procedure TfrmCadSubGrupoConfiguracaoImovel.lblDicasClick(Sender: TObject);
begin
  inherited;
  FoFuncoes.CriarTelaDicas(FORM_CAD_SUB_GRUPO_CONF_IMOVEL);
end;

end.
