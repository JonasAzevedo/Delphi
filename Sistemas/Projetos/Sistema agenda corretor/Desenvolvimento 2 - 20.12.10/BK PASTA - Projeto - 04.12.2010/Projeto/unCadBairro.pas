unit unCadBairro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, ComCtrls, ToolWin,
  StdCtrls, Buttons, plsEdit, Mask, plsTMaskEdit, unObjBairro, ExtCtrls;

  type
    TCidade = record
      codigo: Integer;
      nome: string[100];
    end;

  type
  TfrmCadBairro = class(TfrmCadastroBasico)
    lblCodigo: TLabel;
    Label1: TLabel;
    plsEdCodigo: TPlsEdit;
    Label2: TLabel;
    plsEdNome: TPlsEdit;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosCOD_FK_CIDADE: TIntegerField;
    zQryDadosNOME: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosCOD_FK_CIDADE: TIntegerField;
    cdsDadosNOME: TStringField;
    pnlCidade: TPanel;
    lblCidade: TLabel;
    plsEdCidade: TPlsEdit;
    spBtnBuscaCidade: TSpeedButton;
    lblCampoObrigatorio2: TLabel;
    lblCampoObrigatorio1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure spBtnBuscaCidadeClick(Sender: TObject);
    procedure plsEdNomeExit(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure plsEdCodigoExit(Sender: TObject);
    procedure plsEdCidadeClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsEdNomeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure plsEdCidadeKeyPress(Sender: TObject; var Key: Char);
  private
    FoBairro: TObjBairro;

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
    FoCidade: TCidade;
    FoCidadeAux: TCidade;

    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadBairro: TfrmCadBairro;

implementation

uses unConstantes, unPesquisandoBairro, unDM, unSelecionaRegistroCidade,
  unSelecionaRegistroBairro;

{$R *.dfm}

{ TfrmCadBairro }

(* procedimentos de controle *)

procedure TfrmCadBairro.iniciarTela(poForm: TForm);
begin
  inherited;
  Application.CreateForm(TfrmPesquisandoBairro, Self.FoPesquisa);
  Self.FoPesquisa.iniciarTela(frmCadBairro);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;

  //objeto auxiliar para armazenar estado da cidade que será inserida - FbChamadaExternaInserirRegistro=True 
  Self.FoCidadeAux.codigo := NUMERO_INDEFINIDO;
  Self.FoCidadeAux.nome := STRING_INDEFINIDO;
end;

procedure TfrmCadBairro.passarParametro(pTipo:String; pValores:OleVariant);
var
  nCodFK_Cidade: Integer;
begin
  inherited;

  if(pTipo = PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.FbChamadaExternaInserirRegistro := True;
    Self.FiTelaExternaChamouInserirRegistro := pValores;
  end

  else if(pTipo = PRM_DEFINE_CIDADE_BAIRRO_INSERINDO)then
  begin
    if(VarIsNumeric(pValores))then
    begin
      nCodFK_Cidade := pValores;
      if(nCodFK_Cidade <> NUMERO_INDEFINIDO)then
      begin
        DM.zQryCidade.Close;
        DM.zQryCidade.SQL.Clear;
        DM.zQryCidade.SQL.Add('SELECT * FROM cidade WHERE codigo = :cid');
        DM.zQryCidade.ParamByName('cid').AsInteger := nCodFK_Cidade;
        DM.zQryCidade.Open;
        if(DM.zQryCidade.RecordCount=1)then
        begin
          Self.FoCidadeAux.codigo := DM.zQryCidadeCODIGO.AsInteger;
          Self.FoCidadeAux.nome := DM.zQryCidadeNOME.AsString;
        end;
      end;
    end;
  end;
end;

procedure TfrmCadBairro.limparObjeto();
begin
  if (Assigned(Self.FoBairro)) then
  begin
    Self.FoBairro.setCodigo(NUMERO_INDEFINIDO);
    Self.FoBairro.setFkCidade(NUMERO_INDEFINIDO);
    Self.FoBairro.setNome(STRING_INDEFINIDO);
  end
end;

procedure TfrmCadBairro.limparTela(poForm: TForm);
begin
  inherited;
  Self.FoCidade.codigo := NUMERO_INDEFINIDO;
  Self.FoCidade.nome := STRING_INDEFINIDO;
end;

procedure TfrmCadBairro.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoBairro))) then
  begin
    Self.FoBairro.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoBairro.setFkCidade(cdsDadosCOD_FK_CIDADE.AsInteger);
    Self.FoBairro.setNome(cdsDadosNOME.AsString);
    Self.FoBairro.setExibeCidade();
  end
  else
  begin
    FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadBairro.carregarObjeto();','Acesso Indisponível');
  end;
end;

procedure TfrmCadBairro.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoBairro))then
  begin
    if(Self.FoBairro.getCodigo <> NUMERO_INDEFINIDO)then
      plsEdCodigo.Text := IntToStr(Self.FoBairro.getCodigo)
    else
      plsEdCodigo.Clear;
    plsEdCidade.Text := Self.FoBairro.getExibeCidade;
    Self.FoCidade.codigo := Self.FoBairro.getFkCidade;
    plsEdNome.Text := Self.FoBairro.getNome;
  end;
end;

procedure TfrmCadBairro.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM bairro ');
  zQryDados.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadBairro.verificarHouveAlteracoes(): boolean;
var
  iCidade: Integer;
  sNome: String;
  bAlteracao: Boolean;
begin
  iCidade := Self.FoCidade.codigo;
  sNome := Trim(plsEdNome.Text);
  try
    bAlteracao := Self.FoBairro.verificarDiferencaCadastro(iCidade, sNome);
  except
    bAlteracao := True;
  end;

  Result := bAlteracao;
end;

function TfrmCadBairro.verificarCamposObrigatorios(): boolean;
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

  if(Self.FoCidade.codigo = NUMERO_INDEFINIDO)then
  begin
    campos := 'Cidade';
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
    FoFuncoes.focarComponente(compFoco);

  Result := bRetorno;
end;

function TfrmCadBairro.verificarRegistroJaExiste(): boolean;
begin
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM bairro WHERE cod_fk_cidade=:cod_fk_cid AND nome=:nom');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoBairro.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoBairro.getCodigo;
  end;     
  zQryDados.ParamByName('cod_fk_cid').AsInteger := Self.FoCidade.codigo;
  zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
  zQryDados.Open;
  if(zQryDados.RecordCount <> 0)then
  begin
    Result := True;
    MessageDlg('Bairro já cadastrado.', mtWarning, [mbOK], 0);
  end
  else
    Result := False;
end;

function TfrmCadBairro.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;

  //verifica se bairro não está associado a uma rua
  DM.zQryRua.Close;
  DM.zQryRua.SQL.Clear;
  DM.zQryRua.SQL.Add('SELECT * FROM rua WHERE cod_fk_bairro=:cod_fk_bai');
  DM.zQryRua.ParamByName('cod_fk_bai').AsInteger := Self.FoBairro.getCodigo;
  DM.zQryRua.Open;
  if(DM.zQryRua.RecordCount <> 0)then
  begin
    MessageDlg('Bairro não pode ser deletado, pois existe uma rua deste bairro.',
      mtInformation, [mbOK], 0);
    bPodeDeletar := False;
  end;

  //verifica se bairro não está associado a um cliente
  if(bPodeDeletar)then
  begin
    DM.zQryCliente.Close;
    DM.zQryCliente.SQL.Clear;
    DM.zQryCliente.SQL.Add('SELECT * FROM cliente WHERE cod_fk_bairro=:cod_fk_bai');
    DM.zQryCliente.ParamByName('cod_fk_bai').AsInteger := Self.FoBairro.getCodigo;
    DM.zQryCliente.Open;
    if(DM.zQryCliente.RecordCount <> 0)then
    begin
      MessageDlg('Bairro não pode ser deletado, pois existe um cliente deste bairro.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  //verifica se bairro não está associado a um imovel
  if(bPodeDeletar)then
  begin
    DM.zQryImovel.Close;
    DM.zQryImovel.SQL.Clear;
    DM.zQryImovel.SQL.Add('SELECT * FROM imovel WHERE cod_fk_bairro=:cod_fk_bai');
    DM.zQryImovel.ParamByName('cod_fk_bai').AsInteger := Self.FoBairro.getCodigo;
    DM.zQryImovel.Open;
    if(DM.zQryImovel.RecordCount <> 0)then
    begin
      MessageDlg('Bairro não pode ser deletado, pois existe um imóvel deste bairro.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  //verifica se bairro não está associado a uma pessoa_fisica
  if(bPodeDeletar)then
  begin
    DM.zQryPessoaFisica.Close;
    DM.zQryPessoaFisica.SQL.Clear;
    DM.zQryPessoaFisica.SQL.Add('SELECT * FROM pessoa_fisica WHERE cod_fk_bairro=:cod_fk_bai');
    DM.zQryPessoaFisica.ParamByName('cod_fk_bai').AsInteger := Self.FoBairro.getCodigo;
    DM.zQryPessoaFisica.Open;
    if(DM.zQryPessoaFisica.RecordCount <> 0)then
    begin
      MessageDlg('Bairro não pode ser deletado, pois existe uma pessoa física deste bairro.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  //verifica se cidade não está associado a uma pessoa_juridica
  if(bPodeDeletar)then
  begin
    DM.zQryPessoaJuridica.Close;
    DM.zQryPessoaJuridica.SQL.Clear;
    DM.zQryPessoaJuridica.SQL.Add('SELECT * FROM pessoa_juridica WHERE cod_fk_bairro=:cod_fk_bai');
    DM.zQryPessoaJuridica.ParamByName('cod_fk_bai').AsInteger := Self.FoBairro.getCodigo;
    DM.zQryPessoaJuridica.Open;
    if(DM.zQryPessoaJuridica.RecordCount <> 0)then
    begin
      MessageDlg('Bairro não pode ser deletado, pois existe uma pessoa jurídica deste bairro.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  Result := bPodeDeletar;
end;

procedure TfrmCadBairro.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       pnlCidade.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsEdCodigo.SetFocus;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Enabled := False;
                       pnlCidade.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsEdCidade.SetFocus;
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       pnlCidade.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsEdCidade.SetFocus;
                     end;
    OPC_SALVAR:      begin

                     end;
    OPC_EXCLUIR:     begin

                     end;
    OPC_CANCELAR:    begin

                     end;
    OPC_PESQUISOU:   begin
                       plsEdCodigo.Enabled := True;
                       pnlCidade.Enabled := False;
                       plsEdNome.Enabled := True;
                     end;
  end; //fim - case

end;

procedure TfrmCadBairro.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadBairro);
  visibilidade(OPC_NOVO);
end;  

function TfrmCadBairro.salvar(): boolean;
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
        zQryDados.SQL.Add('UPDATE bairro SET cod_fk_cidade=:cod_fk_cid,nome=:nom ');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('cod_fk_cid').AsInteger := Self.FoCidade.codigo;
        zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
        zQryDados.ParamByName('cod').AsInteger := Self.FoBairro.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO bairro (cod_fk_cidade, nome) ');
        zQryDados.SQL.Add('VALUES (:cod_fk_cid, :nom)');
        zQryDados.ParamByName('cod_fk_cid').AsInteger := Self.FoCidade.codigo;
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

function TfrmCadBairro.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM bairro WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoBairro.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadBairro.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
begin
  DM.zQryBairro.Close;
  DM.zQryBairro.SQL.Clear;
  DM.zQryBairro.SQL.Add('SELECT * FROM bairro ORDER BY codigo DESC ROWS 1');
  DM.zQryBairro.Open;
  if(DM.zQryBairro.RecordCount = 1)then
    nCodigo := DM.zQryBairroCODIGO.AsInteger
  else
    nCodigo := NUMERO_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_BAIRRO)then
    begin
      frmSelecionaRegistroBairro.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end;
end;

procedure TfrmCadBairro.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadBairro.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoBairro := TObjBairro.Create;
end;

procedure TfrmCadBairro.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoBairro);
end;

procedure TfrmCadBairro.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadBairro.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadBairro.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadBairro.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadBairro.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadBairro.plsEdCodigoExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadBairro.plsEdNomeExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadBairro.spBtnBuscaCidadeClick(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TfrmSelecionaRegistroCidade, frmSelecionaRegistroCidade);
    frmSelecionaRegistroCidade.passarParametro(PRM_TELA_CHAMOU,FORM_CAD_BAIRRO);
    frmSelecionaRegistroCidade.ShowModal;
  finally
    if(Self.FoCidade.codigo <> NUMERO_INDEFINIDO)then
    begin
      plsEdCidade.Text := Self.FoCidade.nome;
      Self.FoFuncoes.focarComponente(plsEdNome);
    end;
    FreeAndNil(frmSelecionaRegistroCidade);
  end;
end;

procedure TfrmCadBairro.plsEdCidadeClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaCidadeClick(Self);
end;

procedure TfrmCadBairro.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadBairro.plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
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

procedure TfrmCadBairro.plsEdNomeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sValor: string;
begin
  inherited;

  if (Self.FbPodePesquisar) then
  begin
    if(Key=27)then
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

procedure TfrmCadBairro.FormShow(Sender: TObject);
begin
  inherited;
  //caso for pra inserir com uma cidade definida
  if(Self.FoCidadeAux.codigo <> NUMERO_INDEFINIDO)then
  begin
    Self.FoCidade.codigo := Self.FoCidadeAux.codigo;
    Self.FoCidade.nome := Self.FoCidadeAux.nome;
    plsEdCidade.Text := Self.FoCidade.nome;
    pnlCidade.Enabled := False;
    Self.FoFuncoes.focarComponente(plsEdNome);
  end;
end;

procedure TfrmCadBairro.plsEdCidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaCidadeClick(Self);
end;

end.
