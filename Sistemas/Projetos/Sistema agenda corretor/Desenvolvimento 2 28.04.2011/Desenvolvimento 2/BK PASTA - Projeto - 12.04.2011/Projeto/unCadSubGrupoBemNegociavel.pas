unit unCadSubGrupoBemNegociavel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, StdCtrls, plsEdit,
  ExtCtrls, ComCtrls, ToolWin,unObjSubGrupoBemNegociavel, unConjuntoDadosGrupoBemNegociavel,
  Buttons;

type
    TGrupo = record
      codigo: Integer;
      nome: string[50];
    end;

type
  TfrmCadSubGrupoBemNegociavel = class(TfrmCadastroBasico)
    zQryDadosCODIGO: TIntegerField;
    zQryDadosCOD_FK_GRUPO: TIntegerField;
    zQryDadosNOME: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosCOD_FK_GRUPO: TIntegerField;
    cdsDadosNOME: TStringField;
    lblCodigo: TLabel;
    plsEdCodigo: TPlsEdit;
    pnlGrupo: TPanel;
    spBtnBuscaGrupo: TSpeedButton;
    lblCampoObrigatorio1: TLabel;
    lblGrupo: TLabel;
    plsEdGrupo: TPlsEdit;
    lblNomeSubGrupo: TLabel;
    lblCampoObrigatorio2: TLabel;
    plsEdNome: TPlsEdit;
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
    procedure plsEdNomeKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdGrupoExit(Sender: TObject);
    procedure plsEdGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdCodigoEnter(Sender: TObject);
    procedure plsEdNomeEnter(Sender: TObject);
    procedure plsEdGrupoEnter(Sender: TObject);
    procedure plsEdCodigoKeyPress(Sender: TObject; var Key: Char);
  private
    FoSubGrupoBemNegociavel: TObjSubGrupoBemNegociavel;
    FoConjuntoDadosGrupo: TConjuntoDadosGrupoBemNegociavel;

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
  frmCadSubGrupoBemNegociavel: TfrmCadSubGrupoBemNegociavel;

implementation

uses unDM, unConstantes, unVariaveis, unPesquisandoSubGrupoBemNegociavel,
unSelecionaRegistroSubGrupoBemNegociavel,unSelecionaRegistroGrupoBemNegociavel;

const
  fnSELECIONAR_GRUPO_NORMAL    = 1;
  fnSELECIONAR_GRUPO_DIGITANDO = 2;

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmCadSubGrupoBemNegociavel.iniciarTela(poForm: TForm);
begin
  inherited;

  Application.CreateForm(TfrmPesquisandoSubGrupoBemNegociavel, FoPesquisa);
  FoPesquisa.iniciarTela(frmCadSubGrupoBemNegociavel);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;

  //objeto auxiliar para armazenar grupo do sub-grupo que ser� inserido - FbChamadaExternaInserirRegistro=True
  Self.FoGrupo.codigo := NUMERO_INDEFINIDO;
  Self.FoGrupoAux.nome := STRING_INDEFINIDO;
end;

procedure TfrmCadSubGrupoBemNegociavel.passarParametro(pTipo:String; pValores:OleVariant);
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
        DM.zQryGrupoBemNegociavel.Close;
        DM.zQryGrupoBemNegociavel.SQL.Clear;
        DM.zQryGrupoBemNegociavel.SQL.Add('SELECT * FROM grupo_bem_negociavel WHERE codigo = :est');
        DM.zQryGrupoBemNegociavel.ParamByName('est').AsInteger := nCodFK_Grupo;
        DM.zQryGrupoBemNegociavel.Open;
        if(DM.zQryGrupoBemNegociavel.RecordCount=1)then
        begin
          Self.FoGrupoAux.codigo := DM.zQryGrupoBemNegociavelCODIGO.AsInteger;
          Self.FoGrupoAux.nome := DM.zQryGrupoBemNegociavelNOME.AsString;
        end;
      end;
    end;
  end

  else if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS)then
    FoConjuntoDadosGrupo.ExecutarSQLSelecao();
end;

procedure TfrmCadSubGrupoBemNegociavel.limparObjeto();
begin
  if (Assigned(FoSubGrupoBemNegociavel)) then
  begin
    Self.FoSubGrupoBemNegociavel.setCodigo(NUMERO_INDEFINIDO);
    Self.FoSubGrupoBemNegociavel.setFkGrupo(NUMERO_INDEFINIDO);
    Self.FoSubGrupoBemNegociavel.setNome(STRING_INDEFINIDO);
  end
end;

procedure TfrmCadSubGrupoBemNegociavel.limparTela(poForm: TForm);
begin
  inherited;

  Self.FoGrupo.codigo := NUMERO_INDEFINIDO;
  Self.FoGrupo.nome := STRING_INDEFINIDO;
end;

procedure TfrmCadSubGrupoBemNegociavel.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoSubGrupoBemNegociavel))) then
  begin
    Self.FoSubGrupoBemNegociavel.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoSubGrupoBemNegociavel.setFkGrupo(cdsDadosCOD_FK_GRUPO.AsInteger);
    Self.FoSubGrupoBemNegociavel.setNome(cdsDadosNOME.AsString);
    Self.FoSubGrupoBemNegociavel.setExibeGrupo();
  end
  else
  begin
    Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadSubGrupoBemNegociavel.carregarObjeto();','Acesso Indispon�vel');
  end;
end;

procedure TfrmCadSubGrupoBemNegociavel.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoSubGrupoBemNegociavel))then
  begin
    if(Self.FoSubGrupoBemNegociavel.getCodigo <> 0)then
      plsEdCodigo.Text := IntToStr(Self.FoSubGrupoBemNegociavel.getCodigo)
    else
      plsEdCodigo.Clear;
    plsEdGrupo.Text := Self.FoSubGrupoBemNegociavel.getExibeGrupo;
    Self.FoGrupo.codigo := Self.FoSubGrupoBemNegociavel.getFkGrupo;
    Self.FoGrupo.nome := Self.FoSubGrupoBemNegociavel.getExibeGrupo;
    plsEdNome.Text := Self.FoSubGrupoBemNegociavel.getNome;
  end;
end;

procedure TfrmCadSubGrupoBemNegociavel.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM sub_grupo_bem_negociavel ');
  zQryDados.SQL.Add(Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadSubGrupoBemNegociavel.verificarHouveAlteracoes(): boolean;
var
  iGrupo: Integer;
  sNome: string;
  bAlteracao: boolean;
begin
  iGrupo := Self.FoGrupo.codigo;
  sNome := Trim(plsEdNome.Text);

  try
    bAlteracao := Self.FoSubGrupoBemNegociavel.verificarDiferencaCadastro(iGrupo, sNome);
  except
    bAlteracao := True;
  end;

  Result := bAlteracao;
end;

function TfrmCadSubGrupoBemNegociavel.verificarCamposObrigatorios(): boolean;
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

  //setar foco no componente que n�o foi validado
  if((not(bRetorno))and(compFoco is TWinControl))then
    Self.FoFuncoes.focarComponente(compFoco);

  Result := bRetorno;
end;

function TfrmCadSubGrupoBemNegociavel.verificarRegistroJaExiste(): boolean;
begin
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM sub_grupo_bem_negociavel WHERE cod_fk_grupo=:cod_fk_gru AND nome=:nom');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoSubGrupoBemNegociavel.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoSubGrupoBemNegociavel.getCodigo;
  end;
  zQryDados.ParamByName('cod_fk_gru').AsInteger := Self.FoGrupo.codigo;
  zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
  zQryDados.Open;
  if(zQryDados.RecordCount <> 0)then
  begin
    Result := True;
    MessageDlg('Sub-Grupo j� cadastrado.', mtWarning, [mbOK], 0);
  end
  else
    Result := False;
end;

function TfrmCadSubGrupoBemNegociavel.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;
  Result := bPodeDeletar;
end;

procedure TfrmCadSubGrupoBemNegociavel.visibilidade(pnVisib: Integer);
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
                       plsEdCodigo.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_SUB_GRUPO_BEM_NEGOCIAVEL,True));
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

procedure TfrmCadSubGrupoBemNegociavel.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadSubGrupoBemNegociavel);
  visibilidade(OPC_NOVO);
end;

function TfrmCadSubGrupoBemNegociavel.salvar(): boolean;
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
        zQryDados.SQL.Add('UPDATE sub_grupo_bem_negociavel SET cod_fk_grupo=:cod_fk_gru, nome=:nom');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('cod_fk_gru').AsInteger := Self.FoGrupo.codigo;
        zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
        zQryDados.ParamByName('cod').AsInteger := Self.FoSubGrupoBemNegociavel.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO sub_grupo_bem_negociavel (cod_fk_grupo, nome) VALUES (:cod_fk_gru,:nom)');
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

function TfrmCadSubGrupoBemNegociavel.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM sub_grupo_bem_negociavel WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoSubGrupoBemNegociavel.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadSubGrupoBemNegociavel.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
begin
  DM.zQrySubGrupoBemNegociavel.Close;
  DM.zQrySubGrupoBemNegociavel.SQL.Clear;
  DM.zQrySubGrupoBemNegociavel.SQL.Add('SELECT * FROM sub_grupo_bem_negociavel ORDER BY codigo DESC ROWS 1');
  DM.zQrySubGrupoBemNegociavel.Open;
  if(DM.zQrySubGrupoBemNegociavel.RecordCount = 1)then
    nCodigo := DM.zQrySubGrupoBemNegociavelCODIGO.AsInteger
  else
    nCodigo := NUMERO_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_SUB_GRUPO_CONF_IMOVEL)then
    begin
      frmSelecionaRegistroSubGrupoBemNegociavel.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end;
end;

procedure TfrmCadSubGrupoBemNegociavel.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

procedure TfrmCadSubGrupoBemNegociavel.AbreTelaSelecaoGrupo(pnTpSelecao:Word);
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
        Application.CreateForm(TfrmSelecionaRegistroGrupoBemNegociavel, frmSelecionaRegistroGrupoBemNegociavel);
        frmSelecionaRegistroGrupoBemNegociavel.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_SUB_GRUPO_BEM_NEGOCIAVEL);
        frmSelecionaRegistroGrupoBemNegociavel.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroGrupoBemNegociavel.ShowModal;
      finally
        if(Self.FoGrupo.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdGrupo.Text := Self.FoGrupo.nome;
          Self.FoFuncoes.focarComponente(plsEdNome);
        end;
        FreeAndNil(frmSelecionaRegistroGrupoBemNegociavel);
      end;
    end;

    fnSELECIONAR_GRUPO_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroGrupoBemNegociavel, frmSelecionaRegistroGrupoBemNegociavel);
        frmSelecionaRegistroGrupoBemNegociavel.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_SUB_GRUPO_BEM_NEGOCIAVEL);
        frmSelecionaRegistroGrupoBemNegociavel.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroGrupoBemNegociavel.ShowModal;
      finally
        if(Self.FoGrupo.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdGrupo.Text := Self.FoGrupo.nome;
          Self.FoFuncoes.focarComponente(plsEdNome);
        end
        else
          plsEdGrupo.Clear;
        FreeAndNil(frmSelecionaRegistroGrupoBemNegociavel);
      end;
    end;

  end;

end;

procedure TfrmCadSubGrupoBemNegociavel.VerificarGrupoExiste();
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
      MessageDlg('Grupo n�o encontrado.', mtInformation, [mbOK], 0);
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


procedure TfrmCadSubGrupoBemNegociavel.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoSubGrupoBemNegociavel := TObjSubGrupoBemNegociavel.Create;
  FoConjuntoDadosGrupo := TConjuntoDadosGrupoBemNegociavel.CriaObjeto;
end;

procedure TfrmCadSubGrupoBemNegociavel.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoSubGrupoBemNegociavel);
  FreeAndNil(FoConjuntoDadosGrupo);
end;

procedure TfrmCadSubGrupoBemNegociavel.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadSubGrupoBemNegociavel.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadSubGrupoBemNegociavel.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadSubGrupoBemNegociavel.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadSubGrupoBemNegociavel.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  //visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadSubGrupoBemNegociavel.plsEdCodigoExit(Sender: TObject);
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

procedure TfrmCadSubGrupoBemNegociavel.plsEdNomeExit(Sender: TObject);
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

procedure TfrmCadSubGrupoBemNegociavel.spBtnBuscaGrupoClick(
  Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoGrupo(fnSELECIONAR_GRUPO_NORMAL);
end;

procedure TfrmCadSubGrupoBemNegociavel.plsEdCodigoKeyUp(Sender: TObject;
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
          FoPesquisa.atualizarPesquisando('CC_CODIGO', 'C�digo:', sValor, cdsDados);
          if(FoPesquisa.PodeAbrirTelaPesquisandoRegistro)then
            FoPesquisa.Show;
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;



procedure TfrmCadSubGrupoBemNegociavel.plsEdNomeKeyUp(Sender: TObject;
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

procedure TfrmCadSubGrupoBemNegociavel.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadSubGrupoBemNegociavel.FormShow(Sender: TObject);
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

procedure TfrmCadSubGrupoBemNegociavel.plsEdNomeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos('Sub-Grupo pelo Nome', 'Nome do Sub-Grupo');
end;

procedure TfrmCadSubGrupoBemNegociavel.plsEdGrupoExit(Sender: TObject);
begin
  inherited;
  VerificarGrupoExiste();
end;

procedure TfrmCadSubGrupoBemNegociavel.plsEdGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Nome do Grupo');
end;

procedure TfrmCadSubGrupoBemNegociavel.plsEdCodigoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Sub-Grupo pelo C�digo', STRING_INDEFINIDO);
end;

procedure TfrmCadSubGrupoBemNegociavel.plsEdNomeEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Sub-Grupo pelo Nome', 'Nome do Sub-Grupo');
end;

procedure TfrmCadSubGrupoBemNegociavel.plsEdGrupoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Nome do Grupo');
end;

procedure TfrmCadSubGrupoBemNegociavel.plsEdCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos('Sub-Grupo pelo C�digo', STRING_INDEFINIDO);
end;

end.
