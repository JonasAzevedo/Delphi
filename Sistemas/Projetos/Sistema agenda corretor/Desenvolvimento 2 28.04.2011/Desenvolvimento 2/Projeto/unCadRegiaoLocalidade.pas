unit unCadRegiaoLocalidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, StdCtrls, ExtCtrls,
  ComCtrls, ToolWin, plsEdit, unObjRegiaoLocalidade, Grids, DBGrids,
  Buttons, unConjuntoDadosBairro;

  type
    TBairro = record
      codigo: Integer;
      nome: string[100];
    end;

type
  TfrmCadRegiaoLocalidade = class(TfrmCadastroBasico)
    Label1: TLabel;
    plsEdCodigo: TPlsEdit;
    Label2: TLabel;
    lblCampoObrigatorio2: TLabel;
    plsEdNome: TPlsEdit;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosNOME: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosNOME: TStringField;
    dbGrdBairros: TDBGrid;
    cdsBairros: TClientDataSet;
    dsBairros: TDataSource;
    zQryBairros: TZQuery;
    pnlAddDeleteBairros: TPanel;
    btBtnDeletarBairro: TBitBtn;
    btBtnAdicionarBairro: TBitBtn;
    zQryBairrosCODIGO: TIntegerField;
    zQryBairrosCOD_FK_REGIAO_LOCALIDADE: TIntegerField;
    zQryBairrosCOD_FK_BAIRRO: TIntegerField;
    zQryBairrosNOME: TStringField;
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
    procedure plsEdNomeEnter(Sender: TObject);
    procedure plsEdCodigoEnter(Sender: TObject);
    procedure lblDicasClick(Sender: TObject);
    procedure plsEdNomeKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdBairroEnter(Sender: TObject);
    procedure plsEdBairroKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnAdicionarBairroClick(Sender: TObject);
    procedure btBtnDeletarBairroClick(Sender: TObject);
  private
    FoRegiaoLocalidade: TObjRegiaoLocalidade;
    FoConjuntoDadosBairro: TConjuntoDadosBairro;

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
    procedure AbreTelaSelecaoBairro(pnTpSelecao:Word);
    procedure ExibirBairros;
    procedure CriarDataSetBairros;
    procedure AdicionarBairro;
    procedure DeletarBairro;
  public
    FoBairro: TBairro;

    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadRegiaoLocalidade: TfrmCadRegiaoLocalidade;

implementation

uses unPesquisandoRegiaoLocalidade, unConstantes, unDM,
  unSelecionaRegistroRegiaoLocalidade, unVariaveis, unDicas,
  unSelecionaRegistroBairro, unPrincipal;

const
  fnSELECIONAR_BAIRRO_NORMAL    = 1;
  fnSELECIONAR_BAIRRO_DIGITANDO = 2;

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmCadRegiaoLocalidade.iniciarTela(poForm: TForm);
begin
  inherited;
  Application.CreateForm(TfrmPesquisandoRegiaoLocalidade, Self.FoPesquisa);
  Self.FoPesquisa.iniciarTela(frmCadRegiaoLocalidade);
  FoPesquisa.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadRegiaoLocalidade.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;

  if(pTipo = PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.FbChamadaExternaInserirRegistro := True;
    Self.FiTelaExternaChamouInserirRegistro := pValores;
  end

  else if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS)then
    FoConjuntoDadosBairro.ExecutarSQLSelecao();
end;

procedure TfrmCadRegiaoLocalidade.limparObjeto();
begin
  if (Assigned(Self.FoRegiaoLocalidade)) then
  begin
    Self.FoRegiaoLocalidade.setCodigo(NUMERO_INDEFINIDO);
    Self.FoRegiaoLocalidade.setNome(STRING_INDEFINIDO);
  end
end;

procedure TfrmCadRegiaoLocalidade.limparTela(poForm: TForm);
begin
  inherited;
  Self.FoBairro.codigo := NUMERO_INDEFINIDO;
  Self.FoBairro.nome := STRING_INDEFINIDO;
end;

procedure TfrmCadRegiaoLocalidade.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoRegiaoLocalidade))) then
  begin
    Self.FoRegiaoLocalidade.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoRegiaoLocalidade.setNome(cdsDadosNOME.AsString);
  end
  else
  begin
    FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadRegiaoLocalidade.carregarObjeto(); ','Acesso Indisponível');
  end;
end;

procedure TfrmCadRegiaoLocalidade.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoRegiaoLocalidade))then
  begin
    if(Self.FoRegiaoLocalidade.getCodigo <> NUMERO_INDEFINIDO)then
      plsEdCodigo.Text := IntToStr(Self.FoRegiaoLocalidade.getCodigo)
    else
      plsEdCodigo.Clear;
    ExibirBairros;
    plsEdNome.Text := Self.FoRegiaoLocalidade.getNome;
  end;
end;

procedure TfrmCadRegiaoLocalidade.ExibirBairros;
begin
  zQryBairros.Close;
  zQryBairros.SQL.Clear;
  zQryBairros.SQL.Add('SELECT r.codigo, r.cod_fk_regiao_localidade, r.cod_fk_bairro, b.nome ');
  zQryBairros.SQL.Add('FROM regiao_localidade_bairro r ');
  zQryBairros.SQL.Add('JOIN bairro b ON r.cod_fk_bairro=b.codigo ');
  zQryBairros.SQL.Add('WHERE r.cod_fk_regiao_localidade =:cod_fk_regiao_localidade');
  zQryBairros.ParamByName('cod_fk_regiao_localidade').AsInteger := Self.FoRegiaoLocalidade.getCodigo;
  zQryBairros.Open;
  if(zQryBairros.Active)and(zQryBairros.RecordCount > NUMERO_INDEFINIDO)then
  begin
    zQryBairros.First;
    cdsBairros.Open;
    cdsBairros.EmptyDataSet;
    while not(zQryBairros.Eof)do
    begin
      cdsBairros.Append;
      cdsBairros.FieldByName('CODIGO_BAIRRO').AsInteger := zQryBairros.FieldByName('COD_FK_BAIRRO').AsInteger;
      cdsBairros.FieldByName('NOME_BAIRRO').AsString := zQryBairros.FieldByName('NOME').AsString;
      cdsBairros.Post;
      zQryBairros.Next;
    end;
  end;
end;

procedure TfrmCadRegiaoLocalidade.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM regiao_localidade ');
  zQryDados.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadRegiaoLocalidade.verificarHouveAlteracoes(): boolean;
var
  sNome: String;
  bAlteracao: Boolean;
begin
  sNome := Trim(plsEdNome.Text);
  try
    bAlteracao := Self.FoRegiaoLocalidade.verificarDiferencaCadastro(sNome,cdsBairros.Data);
  except
    bAlteracao := True;
  end;

  Result := bAlteracao;
end;

function TfrmCadRegiaoLocalidade.verificarCamposObrigatorios(): boolean;
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

  if(Trim(plsEdNome.Text) = STRING_INDEFINIDO)then
  begin
    campos := 'Nome';
    compFoco := plsEdNome;
  end;

  if(cdsBairros.RecordCount = NUMERO_INDEFINIDO)then
  begin
    if(campos = STRING_INDEFINIDO)then
    begin
      campos := 'Bairros';
      compFoco := dbGrdBairros;
    end
    else
      campos := campos + ', Bairros';
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

function TfrmCadRegiaoLocalidade.verificarRegistroJaExiste(): boolean;
begin
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM regiao_localidade WHERE nome=:nome');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoRegiaoLocalidade.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :codigo');
    zQryDados.ParamByName('codigo').AsInteger := Self.FoRegiaoLocalidade.getCodigo;
  end;
  zQryDados.ParamByName('nome').AsString := Trim(plsEdNome.Text);
  zQryDados.Open;
  if(zQryDados.RecordCount <> 0)then
  begin
    Result := True;
    MessageDlg('Região Localidade já cadastrads.', mtWarning, [mbOK], 0);
  end
  else
    Result := False;
end;

function TfrmCadRegiaoLocalidade.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;
  Result := bPodeDeletar;
end;

procedure TfrmCadRegiaoLocalidade.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       plsEdNome.Enabled := True;
                       cdsBairros.Close;
                       pnlAddDeleteBairros.Enabled := False;
                       plsEdCodigo.SetFocus;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_REGIAO_LOCALIDADE,True));
                       plsEdCodigo.Enabled := False;
                       plsEdNome.Enabled := True;
                       cdsBairros.Open;
                       if(cdsBairros.Active)and(cdsBairros.RecordCount > NUMERO_INDEFINIDO)then
                         cdsBairros.EmptyDataSet;
                       pnlAddDeleteBairros.Enabled := True;
                       plsEdNome.SetFocus;
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       plsEdNome.Enabled := True;
                       cdsBairros.Open;                       
                       pnlAddDeleteBairros.Enabled := True;
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

procedure TfrmCadRegiaoLocalidade.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadRegiaoLocalidade);
  visibilidade(OPC_NOVO);
end;

function TfrmCadRegiaoLocalidade.salvar(): boolean;
var
  bSalvou: boolean;
  nCodigo: Integer;

  procedure InserirRegiaoLocalidadeBairro;
  begin
    cdsBairros.DisableControls;
    cdsBairros.First;
    while not(cdsBairros.Eof)do
    begin
      DM.zQryRegiaoLocalidadeBairro.Close;
      DM.zQryRegiaoLocalidadeBairro.SQL.Clear;
      DM.zQryRegiaoLocalidadeBairro.SQL.Add('INSERT INTO regiao_localidade_bairro (cod_fk_regiao_localidade,cod_fk_bairro) ');
      DM.zQryRegiaoLocalidadeBairro.SQL.Add('VALUES (:cod_fk_regiao_localidade,:cod_fk_bairro)');
      DM.zQryRegiaoLocalidadeBairro.ParamByName('cod_fk_regiao_localidade').AsInteger := nCodigo;
      DM.zQryRegiaoLocalidadeBairro.ParamByName('cod_fk_bairro').AsInteger := cdsBairros.FieldByName('CODIGO_BAIRRO').AsInteger;
      DM.zQryRegiaoLocalidadeBairro.ExecSQL;
      cdsBairros.Next;
    end;
    cdsBairros.EnableControls;
  end;

begin
  bSalvou := False;

  if(Self.FiFuncaoRegistro in [FUNCAO_REGISTRO_EDITAR, FUNCAO_REGISTRO_NOVO]) then
  begin
    inherited;
    if (Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR) then
    begin
      try
        DM.ZConnection.StartTransaction;
        nCodigo := FoRegiaoLocalidade.getCodigo;
        //deleta todos os bairro_regiao_localidade
        zQryBairros.Close;
        zQryBairros.SQL.Clear;
        zQryBairros.SQL.Add('DELETE FROM regiao_localidade_bairro WHERE cod_fk_regiao_localidade=:codigo');
        zQryBairros.ParamByName('codigo').AsInteger := nCodigo;
        zQryBairros.ExecSQL;
        //insere novamente os bairro_regiao_localidade
        InserirRegiaoLocalidadeBairro;

        zQryDados.Close;
        zQryDados.SQL.Clear;
        zQryDados.SQL.Add('UPDATE regiao_localidade SET nome=:nome ');
        zQryDados.SQL.Add('WHERE codigo=:codigo');
        zQryDados.ParamByName('nome').AsString := Trim(plsEdNome.Text);
        zQryDados.ParamByName('codigo').AsInteger := Self.FoRegiaoLocalidade.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO regiao_localidade (nome) ');
        zQryDados.SQL.Add('VALUES (:nome)');
        zQryDados.ParamByName('nome').AsString := Trim(plsEdNome.Text);
        zQryDados.ExecSQL();

        //pegando código da regiao_localidade que foi inserida
        DM.zQryRegiaoLocalidade.Close;
        DM.zQryRegiaoLocalidade.SQL.Clear;
        DM.zQryRegiaoLocalidade.SQL.Add('SELECT * FROM regiao_localidade ORDER BY codigo DESC ROWS 1');
        DM.zQryRegiaoLocalidade.Open;
        if(DM.zQryRegiaoLocalidade.RecordCount = 1)then
        begin
          nCodigo := DM.zQryRegiaoLocalidadeCODIGO.AsInteger;
          //inserindo regiao_localidade_bairro
          InserirRegiaoLocalidadeBairro;
        end;
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

function TfrmCadRegiaoLocalidade.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    //deletando os bairros da região localidade
    zQryBairros.Close;
    zQryBairros.SQL.Clear;
    zQryBairros.SQL.Add('DELETE FROM regiao_localidade_bairro WHERE cod_fk_regiao_localidade=:codigo');
    zQryBairros.ParamByName('codigo').AsInteger := FoRegiaoLocalidade.getCodigo;
    zQryBairros.ExecSQL;
    //deletando a região localidade
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM regiao_localidade WHERE codigo=:codigo');
    zQryDados.ParamByName('codigo').AsInteger := Self.FoRegiaoLocalidade.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadRegiaoLocalidade.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
begin
  DM.zQryRegiaoLocalidade.Close;
  DM.zQryRegiaoLocalidade.SQL.Clear;
  DM.zQryRegiaoLocalidade.SQL.Add('SELECT * FROM regiao_localidade ORDER BY codigo DESC ROWS 1');
  DM.zQryRegiaoLocalidade.Open;
  if(DM.zQryRegiaoLocalidade.RecordCount = 1)then
    nCodigo := DM.zQryRegiaoLocalidadeCODIGO.AsInteger
  else
    nCodigo := NUMERO_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_REGIAO_LOCALIDADE)then
    begin
      frmSelecionaRegistroRegiaoLocalidade.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end;
end;

procedure TfrmCadRegiaoLocalidade.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

procedure TfrmCadRegiaoLocalidade.AbreTelaSelecaoBairro(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  case pnTpSelecao of

    fnSELECIONAR_BAIRRO_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroBairro, frmSelecionaRegistroBairro);
        frmSelecionaRegistroBairro.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_REGIAO_LOCALIDADE);
        frmSelecionaRegistroBairro.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroBairro.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE, null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadRegiaoLocalidade,frmSelecionaRegistroBairro,pnlAddDeleteBairros,ToolBar);
        frmSelecionaRegistroBairro.ShowModal;
      finally
        if(Self.FoBairro.codigo <> NUMERO_INDEFINIDO)then
          AdicionarBairro;
        FreeAndNil(frmSelecionaRegistroBairro);
      end;
    end;

(*
    fnSELECIONAR_BAIRRO_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroBairro, frmSelecionaRegistroBairro);
        frmSelecionaRegistroBairro.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_REGIAO_LOCALIDADE);
        frmSelecionaRegistroBairro.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        vParametros := VarArrayCreate([0,2],varVariant);
        vParametros[0] := PRM_PESQUISA_NOME;
        vParametros[1] := plsEdBairro.Text;
        vParametros[2] := False;
        frmSelecionaRegistroBairro.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadRegiaoLocalidade,frmSelecionaRegistroBairro,pnlAddDeleteBairros,ToolBar);        
        frmSelecionaRegistroBairro.ShowModal;
      finally
        if(Self.FoBairro.codigo <> NUMERO_INDEFINIDO)then
          AdicionarBairro;
        FreeAndNil(frmSelecionaRegistroBairro);
      end;
    end;
*)    
  end;
end;

procedure TfrmCadRegiaoLocalidade.CriarDataSetBairros;
begin
  if(cdsBairros.Active)then
    cdsBairros.EmptyDataSet;
  cdsBairros.FieldDefs.Add('CODIGO_BAIRRO', ftInteger, 0, True);
  cdsBairros.FieldDefs.Add('NOME_BAIRRO', ftString, 100, True);
  cdsBairros.CreateDataSet;
  cdsBairros.Open;
end;

procedure TfrmCadRegiaoLocalidade.AdicionarBairro;
begin
  cdsBairros.First;
  if not(cdsBairros.Locate('CODIGO_BAIRRO',FoBairro.codigo,[])) then
  begin
    cdsBairros.Append;
    cdsBairros.FieldByName('CODIGO_BAIRRO').AsInteger := FoBairro.codigo;
    cdsBairros.FieldByName('NOME_BAIRRO').AsString := FoBairro.nome;
    cdsBairros.Post;
  end;
end;

procedure TfrmCadRegiaoLocalidade.DeletarBairro;
begin
end;

(* fim - procedimentos de controle *)

procedure TfrmCadRegiaoLocalidade.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoRegiaoLocalidade := TObjRegiaoLocalidade.Create;
  FoConjuntoDadosBairro := TConjuntoDadosBairro.CriaObjeto;
  CriarDataSetBairros;
end;

procedure TfrmCadRegiaoLocalidade.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoRegiaoLocalidade);
  FreeAndNil(FoConjuntoDadosBairro); 
end;

procedure TfrmCadRegiaoLocalidade.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadRegiaoLocalidade.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadRegiaoLocalidade.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadRegiaoLocalidade.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadRegiaoLocalidade.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadRegiaoLocalidade.plsEdCodigoExit(Sender: TObject);
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

procedure TfrmCadRegiaoLocalidade.plsEdNomeExit(Sender: TObject);
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

procedure TfrmCadRegiaoLocalidade.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadRegiaoLocalidade.plsEdCodigoKeyUp(Sender: TObject;
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
        if(FoPesquisa.PodeAbrirTelaPesquisandoRegistro)then
        begin
          Self.FoPesquisa.Show;
          FoFuncoes.AjustarPosicaoFormCadastroPesquisa(frmPrincipal, frmCadRegiaoLocalidade, FoPesquisa);
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadRegiaoLocalidade.plsEdNomeKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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
      if(Self.FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[todas],False))then
      begin
        sValor := plsEdNome.Text;
        if(sValor <> STRING_INDEFINIDO)then
        begin
          FnCampoPesquisou := CAMPO_PESQUISOU_POR_NOME;
          sValor := UpperCase(sValor);
          ActiveControl := nil;
          Self.FoPesquisa.atualizarPesquisando('NOME', 'Nome:', sValor, cdsDados);
          if(FoPesquisa.PodeAbrirTelaPesquisandoRegistro)then
          begin
            Self.FoPesquisa.Show;
            FoFuncoes.AjustarPosicaoFormCadastroPesquisa(frmPrincipal, frmCadRegiaoLocalidade, FoPesquisa);
          end;
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadRegiaoLocalidade.plsEdNomeEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Região Localidade pelo Nome','Nome da Região Localidade');
end;

procedure TfrmCadRegiaoLocalidade.plsEdCodigoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Região Localidade pelo Código',STRING_INDEFINIDO);
end;

procedure TfrmCadRegiaoLocalidade.lblDicasClick(Sender: TObject);
begin
  inherited;
  FoFuncoes.CriarTelaDicas(FORM_CAD_REGIAO_LOCALIDADE);
end;

procedure TfrmCadRegiaoLocalidade.plsEdNomeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos('Região Localidade pelo Nome','Nome da Região Localidade');
end;

procedure TfrmCadRegiaoLocalidade.plsEdCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos('Região Localidade pelo Código',STRING_INDEFINIDO);
end;

procedure TfrmCadRegiaoLocalidade.plsEdBairroEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Nome do Bairro');
end;

procedure TfrmCadRegiaoLocalidade.plsEdBairroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Nome do Bairro');
end;

procedure TfrmCadRegiaoLocalidade.btBtnAdicionarBairroClick(Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoBairro(fnSELECIONAR_BAIRRO_NORMAL);
end;

procedure TfrmCadRegiaoLocalidade.btBtnDeletarBairroClick(Sender: TObject);
begin
  inherited;
  if(cdsBairros.Active)and(cdsBairros.RecordCount > NUMERO_INDEFINIDO)then
    cdsBairros.Delete;
end;

end.
