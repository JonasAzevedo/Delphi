unit unCadCidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, AppEvnts, ImgList, ComCtrls, ToolWin, StdCtrls, plsEdit,
  Buttons, unObjCidade, DBClient, Provider, ExtCtrls, unConjuntoDadosEstado;

type
    TEstado = record
      codigo: Integer;
      nome: string[50];
    end;

type
  TfrmCadCidade = class(TfrmCadastroBasico)
    lblCodigo: TLabel;
    plsEdCodigo: TPlsEdit;
    plsEdNome: TPlsEdit;
    lblNome: TLabel;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosCOD_FK_ESTADO: TIntegerField;
    zQryDadosNOME: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosCOD_FK_ESTADO: TIntegerField;
    cdsDadosNOME: TStringField;
    pnlEstado: TPanel;
    lblEstado: TLabel;
    plsEdEstado: TPlsEdit;
    spBtnBuscaEstado: TSpeedButton;
    lblCampoObrigatorio1: TLabel;
    lblCampoObrigatorio2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure spBtnBuscaEstadoClick(Sender: TObject);
    procedure plsEdNomeExit(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure plsEdCodigoExit(Sender: TObject);
    procedure plsEdEstadoClick(Sender: TObject);
    procedure plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsEdNomeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure plsEdEstadoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdEstadoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsEdEstadoExit(Sender: TObject);
  private
    FoCidade: TObjCidade;
    FoConjuntoDadosEstado: TConjuntoDadosEstado;

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
    procedure AbreTelaSelecaoEstado(pnTpSelecao:Word);
    procedure VerificarEstadoExiste();
  public
    FoEstado: TEstado;
    FoEstadoAux: TEstado;

    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadCidade: TfrmCadCidade;

implementation

uses unConstantes, unDM, unSelecionaRegistroEstado, unPesquisandoCidade,
  unVariaveis, unSelecionaRegistroCidade, Math;

const
  fnSELECIONAR_ESTADO_NORMAL    = 1;
  fnSELECIONAR_ESTADO_DIGITANDO = 2;

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmCadCidade.iniciarTela(poForm: TForm);
begin
  inherited;

  Application.CreateForm(TfrmPesquisandoCidade, FoPesquisa);
  FoPesquisa.iniciarTela(frmCadCidade);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;

  //objeto auxiliar para armazenar estado da cidade que será inserida - FbChamadaExternaInserirRegistro=True 
  Self.FoEstadoAux.codigo := NUMERO_INDEFINIDO;
  Self.FoEstadoAux.nome := STRING_INDEFINIDO;
end;

procedure TfrmCadCidade.passarParametro(pTipo:String; pValores:OleVariant);
var
  nCodFK_Estado: Integer;
begin
  inherited;

  if(pTipo = PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.FbChamadaExternaInserirRegistro := True;
    Self.FiTelaExternaChamouInserirRegistro := pValores;
  end

  else if(pTipo = PRM_DEFINE_ESTADO_CIDADE_INSERINDO)then
  begin
    if(VarIsNumeric(pValores))then
    begin
      nCodFK_Estado := pValores;
      if(nCodFK_Estado <> NUMERO_INDEFINIDO)then
      begin
        DM.zQryEstado.Close;
        DM.zQryEstado.SQL.Clear;
        DM.zQryEstado.SQL.Add('SELECT * FROM estado WHERE codigo = :est');
        DM.zQryEstado.ParamByName('est').AsInteger := nCodFK_Estado;
        DM.zQryEstado.Open;
        if(DM.zQryEstado.RecordCount=1)then
        begin
          Self.FoEstadoAux.codigo := DM.zQryEstadoCODIGO.AsInteger;
          Self.FoEstadoAux.nome := DM.zQryEstadoSIGLA.AsString;
        end;
      end;
    end;
  end;
end;

procedure TfrmCadCidade.limparObjeto();
begin
  if (Assigned(FoCidade)) then
  begin
    Self.FoCidade.setCodigo(NUMERO_INDEFINIDO);
    Self.FoCidade.setFkEstado(NUMERO_INDEFINIDO);
    Self.FoCidade.setNome(STRING_INDEFINIDO);
  end
end;

procedure TfrmCadCidade.limparTela(poForm: TForm);
begin
  inherited;

  Self.FoEstado.codigo := NUMERO_INDEFINIDO;
  Self.FoEstado.nome := STRING_INDEFINIDO;
end;

procedure TfrmCadCidade.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoCidade))) then
  begin
    Self.FoCidade.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoCidade.setFkEstado(cdsDadosCOD_FK_ESTADO.AsInteger);
    Self.FoCidade.setNome(cdsDadosNOME.AsString);
    Self.FoCidade.setExibeEstado();
  end
  else
  begin
    Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadCidade.carregarObjeto();','Acesso Indisponível');
  end;
end;

procedure TfrmCadCidade.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoCidade))then
  begin
    if(Self.FoCidade.getCodigo <> 0)then
      plsEdCodigo.Text := IntToStr(Self.FoCidade.getCodigo)
    else
      plsEdCodigo.Clear;
    plsEdEstado.Text := Self.FoCidade.getExibeEstado;
    Self.FoEstado.codigo := Self.FoCidade.getFkEstado;
    Self.FoEstado.nome := Self.FoCidade.getExibeEstado;
    plsEdNome.Text := Self.FoCidade.getNome;
  end;
end;

procedure TfrmCadCidade.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM cidade ');
  zQryDados.SQL.Add(Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadCidade.verificarHouveAlteracoes(): boolean;
var
  iEstado: Integer;
  sNome: string;
  bAlteracao: boolean;
begin
  iEstado := Self.FoEstado.codigo;
  sNome := Trim(plsEdNome.Text);

  try
    bAlteracao := Self.FoCidade.verificarDiferencaCadastro(iEstado, sNome);
  except
    bAlteracao := True;
  end;

  Result := bAlteracao;
end;

function TfrmCadCidade.verificarCamposObrigatorios(): boolean;
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

  if(Self.FoEstado.codigo = NUMERO_INDEFINIDO)then
  begin
    campos := 'Estado';
    //compFoco := plsEdEstado;
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

function TfrmCadCidade.verificarRegistroJaExiste(): boolean;
begin
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM cidade WHERE cod_fk_estado=:cod_fk_est AND nome=:nom');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoCidade.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoCidade.getCodigo;
  end;
  zQryDados.ParamByName('cod_fk_est').AsInteger := Self.FoEstado.codigo;
  zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
  zQryDados.Open;
  if(zQryDados.RecordCount <> 0)then
  begin
    Result := True;
    MessageDlg('Cidade já cadastrada.', mtWarning, [mbOK], 0);
  end
  else
    Result := False;
end;

function TfrmCadCidade.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;

  //verifica se cidade não está associado a um bairro
  DM.zQryBairro.Close;
  DM.zQryBairro.SQL.Clear;
  DM.zQryBairro.SQL.Add('SELECT * FROM bairro WHERE cod_fk_cidade=:cod_fk_cid');
  DM.zQryBairro.ParamByName('cod_fk_cid').AsInteger := Self.FoCidade.getCodigo;
  DM.zQryBairro.Open;
  if(DM.zQryBairro.RecordCount <> 0)then
  begin
    MessageDlg('Cidade não pode ser deletada, pois existe um bairro desta cidade.',
      mtInformation, [mbOK], 0);
    bPodeDeletar := False;
  end;

  //verifica se cidade não está associado a um cliente pessoa fisica
  if(bPodeDeletar)then
  begin
    DM.zQryClientePessoaFisica.Close;
    DM.zQryClientePessoaFisica.SQL.Clear;
    DM.zQryClientePessoaFisica.SQL.Add('SELECT * FROM cliente_pessoa_fisica WHERE cod_fk_cidade=:cod_fk_cid');
    DM.zQryClientePessoaFisica.ParamByName('cod_fk_cid').AsInteger := Self.FoCidade.getCodigo;
    DM.zQryClientePessoaFisica.Open;
    if(DM.zQryClientePessoaFisica.RecordCount <> 0)then
    begin
      MessageDlg('Cidade não pode ser deletada, pois existe um cliente desta cidade.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  //verifica se cidade não está associado a um cliente pessoa juridica
  if(bPodeDeletar)then
  begin
    DM.zQryClientePessoaJuridica.Close;
    DM.zQryClientePessoaJuridica.SQL.Clear;
    DM.zQryClientePessoaJuridica.SQL.Add('SELECT * FROM cliente_pessoa_juridica WHERE cod_fk_cidade=:cod_fk_cid');
    DM.zQryClientePessoaJuridica.ParamByName('cod_fk_cid').AsInteger := Self.FoCidade.getCodigo;
    DM.zQryClientePessoaJuridica.Open;
    if(DM.zQryClientePessoaJuridica.RecordCount <> 0)then
    begin
      MessageDlg('Cidade não pode ser deletada, pois existe um cliente desta cidade.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  //verifica se cidade não está associado a um imovel
  if(bPodeDeletar)then
  begin
    DM.zQryImovel.Close;
    DM.zQryImovel.SQL.Clear;
    DM.zQryImovel.SQL.Add('SELECT * FROM imovel WHERE cod_fk_cidade=:cod_fk_cid');
    DM.zQryImovel.ParamByName('cod_fk_cid').AsInteger := Self.FoCidade.getCodigo;
    DM.zQryImovel.Open;
    if(DM.zQryImovel.RecordCount <> 0)then
    begin
      MessageDlg('Cidade não pode ser deletada, pois existe um imóvel desta cidade.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  //verifica se cidade não está associado a um agenciador pessoa_fisica
  if(bPodeDeletar)then
  begin
    DM.zQryAgencPessoaFisica.Close;
    DM.zQryAgencPessoaFisica.SQL.Clear;
    DM.zQryAgencPessoaFisica.SQL.Add('SELECT * FROM agenc_pessoa_fisica WHERE cod_fk_cidade=:cod_fk_cid');
    DM.zQryAgencPessoaFisica.ParamByName('cod_fk_cid').AsInteger := Self.FoCidade.getCodigo;
    DM.zQryAgencPessoaFisica.Open;
    if(DM.zQryAgencPessoaFisica.RecordCount <> 0)then
    begin
      MessageDlg('Cidade não pode ser deletada, pois existe um agenciador desta cidade.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  //verifica se cidade não está associado a um agenciador pessoa_juridica
  if(bPodeDeletar)then
  begin
    DM.zQryAgencPessoaJuridica.Close;
    DM.zQryAgencPessoaJuridica.SQL.Clear;
    DM.zQryAgencPessoaJuridica.SQL.Add('SELECT * FROM agenc_pessoa_juridica WHERE cod_fk_cidade=:cod_fk_cid');
    DM.zQryAgencPessoaJuridica.ParamByName('cod_fk_cid').AsInteger := Self.FoCidade.getCodigo;
    DM.zQryAgencPessoaJuridica.Open;
    if(DM.zQryAgencPessoaJuridica.RecordCount <> 0)then
    begin
      MessageDlg('Cidade não pode ser deletada, pois existe um agenciador desta cidade.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  Result := bPodeDeletar;
end;

procedure TfrmCadCidade.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       pnlEstado.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsEdCodigo.SetFocus;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Enabled := False;
                       pnlEstado.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsEdEstado.SetFocus;
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       pnlEstado.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsEdEstado.SetFocus;
                     end;
    OPC_SALVAR:      begin

                     end;
    OPC_EXCLUIR:     begin

                     end;
    OPC_CANCELAR:    begin

                     end;
    OPC_PESQUISOU:   begin
                       plsEdCodigo.Enabled := True;
                       pnlEstado.Enabled := False;
                       plsEdNome.Enabled := True;
                     end;
  end; //fim - case

end;

procedure TfrmCadCidade.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadCidade);
  visibilidade(OPC_NOVO);
end;    

function TfrmCadCidade.salvar(): boolean;
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
        zQryDados.SQL.Add('UPDATE cidade SET cod_fk_estado=:cod_fk_est, nome=:nom');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('cod_fk_est').AsInteger := Self.FoEstado.codigo;
        zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
        zQryDados.ParamByName('cod').AsInteger := Self.FoCidade.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO cidade (cod_fk_estado, nome) VALUES (:cod_fk_est,:nom)');
        zQryDados.ParamByName('cod_fk_est').AsInteger := Self.FoEstado.codigo;
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

function TfrmCadCidade.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM cidade WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoCidade.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadCidade.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
begin
  DM.zQryCidade.Close;
  DM.zQryCidade.SQL.Clear;
  DM.zQryCidade.SQL.Add('SELECT * FROM cidade ORDER BY codigo DESC ROWS 1');
  DM.zQryCidade.Open;
  if(DM.zQryCidade.RecordCount = 1)then
    nCodigo := DM.zQryCidadeCODIGO.AsInteger
  else
    nCodigo := NUMERO_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_CIDADE)then
    begin
      frmSelecionaRegistroCidade.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end;
end;

procedure TfrmCadCidade.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

procedure TfrmCadCidade.AbreTelaSelecaoEstado(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  //caiu a ficha de um conjunto de dados
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdEstado.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_ESTADO_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroEstado, frmSelecionaRegistroEstado);
        frmSelecionaRegistroEstado.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CIDADE);
        frmSelecionaRegistroEstado.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);        
        frmSelecionaRegistroEstado.ShowModal;
      finally
        if(Self.FoEstado.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdEstado.Text := Self.FoEstado.nome;
          Self.FoFuncoes.focarComponente(plsEdNome);
        end;
        FreeAndNil(frmSelecionaRegistroEstado);
      end;
    end;

    fnSELECIONAR_ESTADO_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroEstado, frmSelecionaRegistroEstado);
        frmSelecionaRegistroEstado.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CIDADE);
        frmSelecionaRegistroEstado.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroEstado.ShowModal;
      finally
        if(Self.FoEstado.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdEstado.Text := Self.FoEstado.nome;
          Self.FoFuncoes.focarComponente(plsEdNome);
        end
        else
          plsEdEstado.Clear;
        FreeAndNil(frmSelecionaRegistroEstado);
      end;
    end;

  end;

end;

procedure TfrmCadCidade.VerificarEstadoExiste();
begin
  if(plsEdEstado.Text <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosEstado.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdEstado.Text + '%'));
    FoConjuntoDadosEstado.ExecutarFiltrar();

    if(FoConjuntoDadosEstado.TotalRegistros = 1)then
    begin
      FoEstado.codigo := FoConjuntoDadosEstado.GetCodigo;
      FoEstado.nome := FoConjuntoDadosEstado.GetNome;
      plsEdEstado.Text := FoEstado.nome;
    end
    else if(FoConjuntoDadosEstado.TotalRegistros > 1)then
      AbreTelaSelecaoEstado(fnSELECIONAR_ESTADO_DIGITANDO)
    else
    begin
      MessageDlg('Estado não encontrado.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdEstado);
    end;
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadCidade.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoCidade := TObjCidade.Create;
  FoConjuntoDadosEstado := TConjuntoDadosEstado.CriaObjeto;
end;

procedure TfrmCadCidade.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoCidade);
  FreeAndNil(FoConjuntoDadosEstado);
end;

procedure TfrmCadCidade.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadCidade.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadCidade.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadCidade.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadCidade.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  //visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadCidade.plsEdCodigoExit(Sender: TObject);
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

procedure TfrmCadCidade.plsEdNomeExit(Sender: TObject);
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

procedure TfrmCadCidade.spBtnBuscaEstadoClick(Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoEstado(fnSELECIONAR_ESTADO_NORMAL);
end;

procedure TfrmCadCidade.plsEdEstadoClick(Sender: TObject);
begin
  inherited;
//  AbreTelaSelecaoEstado(fnSELECIONAR_ESTADO_NOMRAL);
end;

procedure TfrmCadCidade.plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
          FoPesquisa.Show;
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadCidade.plsEdNomeKeyUp(Sender: TObject; var Key: Word;
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
      if(Self.FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[todas],False))then
      begin
        sValor := plsEdNome.Text;
        if(sValor <> STRING_INDEFINIDO)then
        begin
          FnCampoPesquisou := CAMPO_PESQUISOU_POR_NOME;
          sValor := UpperCase(sValor);
          ActiveControl := nil;
          FoPesquisa.atualizarPesquisando('NOME', 'Nome:', sValor, cdsDados);
          FoPesquisa.Show;
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadCidade.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadCidade.FormShow(Sender: TObject);
begin
  inherited;
  //caso for pra inserir com um estado definido
  if(Self.FoEstadoAux.codigo <> NUMERO_INDEFINIDO)then
  begin
    Self.FoEstado.codigo := Self.FoEstadoAux.codigo;
    Self.FoEstado.nome := Self.FoEstadoAux.nome;
    plsEdEstado.Text := Self.FoEstado.nome;
    pnlEstado.Enabled := False;
    Self.FoFuncoes.focarComponente(plsEdNome);
  end;
end;

procedure TfrmCadCidade.plsEdEstadoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
//  if(Key=#13)then
//    AbreTelaSelecaoEstado(fnSELECIONAR_ESTADO_NOMRAL);
end;

procedure TfrmCadCidade.plsEdEstadoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
//  if(FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[todas],True))then
//    AbreTelaSelecaoEstado(fnSELECIONAR_ESTADO_DIGITANDO);
end;

procedure TfrmCadCidade.plsEdEstadoExit(Sender: TObject);
begin
  inherited;
  VerificarEstadoExiste();
end;

end.
