unit unCadConstrutora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, ComCtrls, ToolWin,
  StdCtrls, Mask, plsTMaskEdit, plsEdit, unObjConstrutora, ExtCtrls;

type
  TfrmCadConstrutora = class(TfrmCadastroBasico)
    zQryDadosCODIGO: TIntegerField;
    zQryDadosNOME: TStringField;
    zQryDadosTELEFONE_1: TStringField;
    zQryDadosTELEFONE_2: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosNOME: TStringField;
    cdsDadosTELEFONE_1: TStringField;
    cdsDadosTELEFONE_2: TStringField;
    plsEdCodigo: TPlsEdit;
    Label1: TLabel;
    Label2: TLabel;
    plsEdNome: TPlsEdit;
    lblTelefone1: TLabel;
    lblTelefone2: TLabel;
    plsMedTelefone1: TPlsMaskEdit;
    plsMedTelefone2: TPlsMaskEdit;
    lblCampoObrigatorio1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure plsEdNomeExit(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure plsEdCodigoExit(Sender: TObject);
    procedure plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsEdNomeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdCodigoEnter(Sender: TObject);
    procedure plsEdCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdNomeEnter(Sender: TObject);
    procedure plsEdNomeKeyPress(Sender: TObject; var Key: Char);
    procedure plsMedTelefone1Enter(Sender: TObject);
    procedure plsMedTelefone1KeyPress(Sender: TObject; var Key: Char);
    procedure plsMedTelefone2Enter(Sender: TObject);
    procedure plsMedTelefone2KeyPress(Sender: TObject; var Key: Char);
    procedure lblDicasClick(Sender: TObject);
  private
    FoConstrutora: TObjConstrutora;

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
  frmCadConstrutora: TfrmCadConstrutora;

implementation

uses unConstantes, unPesquisandoConstrutora, unDM, unVariaveis,
  unSelecionaRegistroConstrutora, unPrincipal;

{$R *.dfm}

{ TfrmCadConstrutora }

(* procedimentos de controle *)

procedure TfrmCadConstrutora.iniciarTela(poForm: TForm);
begin
  inherited;

  Application.CreateForm(TfrmPesquisandoConstrutora, Self.FoPesquisa);
  Self.FoPesquisa.iniciarTela(frmCadConstrutora);
  FoPesquisa.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadConstrutora.passarParametro(pTipo:String; pValores:OleVariant);
var
  nCodFK_Bairro: Integer;
begin
  inherited;

  if(pTipo = PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.FbChamadaExternaInserirRegistro := True;
    Self.FiTelaExternaChamouInserirRegistro := pValores;
  end;
end;


procedure TfrmCadConstrutora.limparObjeto();
begin
  if (Assigned(Self.FoConstrutora)) then
  begin
    Self.FoConstrutora.setCodigo(NUMERO_INDEFINIDO);
    Self.FoConstrutora.setNome(STRING_INDEFINIDO);
    Self.FoConstrutora.setTelefone1(STRING_INDEFINIDO);
    Self.FoConstrutora.setTelefone2(STRING_INDEFINIDO);
  end
end;

procedure TfrmCadConstrutora.limparTela(poForm: TForm);
begin
  inherited;
end;

procedure TfrmCadConstrutora.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoConstrutora))) then
  begin
    Self.FoConstrutora.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoConstrutora.setNome(cdsDadosNOME.AsString);
    Self.FoConstrutora.setTelefone1(cdsDadosTELEFONE_1.AsString);
    Self.FoConstrutora.setTelefone2(cdsDadosTELEFONE_2.AsString);
  end
  else
  begin
    FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadConstrutora.limparTela(poForm: TForm);','Acesso Indisponível');
  end;
end;

procedure TfrmCadConstrutora.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoConstrutora))then
  begin
    if(Self.FoConstrutora.getCodigo <> 0)then
      plsEdCodigo.Text := IntToStr(Self.FoConstrutora.getCodigo)
    else
      plsEdCodigo.Clear;
    plsEdNome.Text := Self.FoConstrutora.getNome;
    plsMedTelefone1.Text := Self.FoConstrutora.getTeleone1;
    plsMedTelefone2.Text := Self.FoConstrutora.getTeleone2;
  end;
end;

procedure TfrmCadConstrutora.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM construtora ');
  zQryDados.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadConstrutora.verificarHouveAlteracoes(): boolean;
var
  sNome: String;
  sTelefone1: String;
  sTelefone2: String;
  bAlteracao: Boolean;
begin
  sNome := Trim(plsEdNome.Text);
  sTelefone1 := Trim(plsMedTelefone1.Text);
  sTelefone2 := Trim(plsMedTelefone2.Text);
  try
    bAlteracao := Self.FoConstrutora.verificarDiferencaCadastro(sNome,sTelefone1,sTelefone2);
  except
    bAlteracao := True;
  end;

  Result := bAlteracao;
end;

function TfrmCadConstrutora.verificarCamposObrigatorios(): boolean;
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

function TfrmCadConstrutora.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;
  
  Result := bPodeDeletar;
end;

function TfrmCadConstrutora.verificarRegistroJaExiste(): boolean;
begin
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM construtora WHERE nome=:nom');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoConstrutora.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoConstrutora.getCodigo;
  end;
  zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
  zQryDados.Open;
  if(zQryDados.RecordCount <> 0)then
  begin
    Result := True;
    MessageDlg('Construtora já cadastrada.', mtWarning, [mbOK], 0);
    plsEdNome.SetFocus;
  end
  else
    Result := False;
end;

procedure TfrmCadConstrutora.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsMedTelefone1.Enabled := False;
                       plsMedTelefone2.Enabled := False;
                       plsEdCodigo.SetFocus;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_CONSTRUTORA,True));    
                       plsEdCodigo.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsMedTelefone1.Enabled := True;
                       plsMedTelefone2.Enabled := True;
                       plsEdNome.SetFocus;
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsMedTelefone1.Enabled := True;
                       plsMedTelefone2.Enabled := True;
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
                       plsMedTelefone1.Enabled := False;
                       plsMedTelefone2.Enabled := False;
                     end;
  end; //fim - case

end;

procedure TfrmCadConstrutora.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadConstrutora);
  visibilidade(OPC_NOVO);
end;

function TfrmCadConstrutora.salvar(): boolean;
var
  sNome,sTelefone1,sTelefone2: String;
  bSalvou: boolean;

  procedure carregarValores();
  begin
    sNome := Trim(plsEdNome.Text);
    if(Self.FoFuncoes.retirarCaracteres(plsMedTelefone1.Text,'()-')<>STRING_INDEFINIDO)then
      sTelefone1 := plsMedTelefone1.Text
    else
      sTelefone1 := STRING_INDEFINIDO;
    if(Self.FoFuncoes.retirarCaracteres(plsMedTelefone2.Text,'()-')<>STRING_INDEFINIDO)then
      sTelefone2 := plsMedTelefone2.Text
    else
      sTelefone2 := STRING_INDEFINIDO
  end;

begin
  bSalvou := False;
  carregarValores();

  if(Self.FiFuncaoRegistro in [FUNCAO_REGISTRO_EDITAR, FUNCAO_REGISTRO_NOVO]) then
  begin
    inherited;
    if (Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR) then
    begin
      try
        DM.ZConnection.StartTransaction;
        zQryDados.Close;
        zQryDados.SQL.Clear;
        zQryDados.SQL.Add('UPDATE construtora SET nome=:nom,telefone_1=:tel1,telefone_2=:tel2 ');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('nom').AsString := sNome;
        zQryDados.ParamByName('tel1').AsString := sTelefone1;
        zQryDados.ParamByName('tel2').AsString := sTelefone2;
        zQryDados.ParamByName('cod').AsInteger := Self.FoConstrutora.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO construtora (nome,telefone_1,telefone_2) ');
        zQryDados.SQL.Add('VALUES (:nom,:tel1,:tel2)');
        zQryDados.ParamByName('nom').AsString := sNome;
        zQryDados.ParamByName('tel1').AsString := sTelefone1;
        zQryDados.ParamByName('tel2').AsString := sTelefone2;
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

function TfrmCadConstrutora.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM construtora WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoConstrutora.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadConstrutora.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

procedure TfrmCadConstrutora.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
begin
  DM.zQryConstrutora.Close;
  DM.zQryConstrutora.SQL.Clear;
  DM.zQryConstrutora.SQL.Add('SELECT * FROM construtora ORDER BY codigo DESC ROWS 1');
  DM.zQryConstrutora.Open;
  if(DM.zQryConstrutora.RecordCount = 1)then
    nCodigo := DM.zQryConstrutoraCODIGO.AsInteger
  else
    nCodigo := NUMERO_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_CONSTRUTORA)then
    begin
      frmSelecionaRegistroConstrutora.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadConstrutora.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoConstrutora := TObjConstrutora.Create;
end;

procedure TfrmCadConstrutora.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoConstrutora);
end;

procedure TfrmCadConstrutora.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadConstrutora.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadConstrutora.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadConstrutora.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadConstrutora.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  //visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadConstrutora.plsEdCodigoExit(Sender: TObject);
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

procedure TfrmCadConstrutora.plsEdNomeExit(Sender: TObject);
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

procedure TfrmCadConstrutora.plsEdCodigoKeyUp(Sender: TObject;
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
          FoFuncoes.AjustarPosicaoFormCadastroPesquisa(frmPrincipal, frmCadConstrutora, FoPesquisa);
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadConstrutora.plsEdNomeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
          FnCampoPesquisou := CAMPO_PESQUISOU_POR_NOME;
          sValor := UpperCase(sValor);
          ActiveControl := nil;
          Self.FoPesquisa.atualizarPesquisando('NOME', 'Nome:', sValor, cdsDados);
          if(FoPesquisa.PodeAbrirTelaPesquisandoRegistro)then
          begin
            Self.FoPesquisa.Show;
            FoFuncoes.AjustarPosicaoFormCadastroPesquisa(frmPrincipal, frmCadConstrutora, FoPesquisa);
          end;
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadConstrutora.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadConstrutora.plsEdCodigoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Construtora pelo Código',STRING_INDEFINIDO);
end;

procedure TfrmCadConstrutora.plsEdCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos('Construtora pelo Código',STRING_INDEFINIDO);
end;

procedure TfrmCadConstrutora.plsEdNomeEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Construtora pelo Nome','Nome da Construtora');
end;

procedure TfrmCadConstrutora.plsEdNomeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos('Construtora pelo Nome','Nome da Construtora');
end;

procedure TfrmCadConstrutora.plsMedTelefone1Enter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone 1 da Construtora');
end;

procedure TfrmCadConstrutora.plsMedTelefone1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone 1 da Construtora');
end;

procedure TfrmCadConstrutora.plsMedTelefone2Enter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone 2 da Construtora');
end;

procedure TfrmCadConstrutora.plsMedTelefone2KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone 2 da Construtora');
end;

procedure TfrmCadConstrutora.lblDicasClick(Sender: TObject);
begin
  inherited;
  FoFuncoes.CriarTelaDicas(FORM_CAD_CONSTUTORA);
end;

end.
