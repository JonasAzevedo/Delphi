unit unCadRua;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, ComCtrls, ToolWin,
  StdCtrls, Mask, plsTMaskEdit, Buttons, plsEdit, unObjRua, ExtCtrls,
  unConjuntoDadosBairro;

  type
    TBairro = record
      codigo: Integer;
      nome: string[100];
    end;

type
  TfrmCadRua = class(TfrmCadastroBasico)
    plsEdCodigo: TPlsEdit;
    Label1: TLabel;
    Label2: TLabel;
    plsEdNome: TPlsEdit;
    plsMedCEP: TPlsMaskEdit;
    lblCEP: TLabel;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosCOD_FK_BAIRRO: TIntegerField;
    zQryDadosNOME: TStringField;
    zQryDadosCEP: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosCOD_FK_BAIRRO: TIntegerField;
    cdsDadosNOME: TStringField;
    cdsDadosCEP: TStringField;
    pnlBairro: TPanel;
    plsEdBairro: TPlsEdit;
    spBtnBuscaRua: TSpeedButton;
    lblBairro: TLabel;
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
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsEdNomeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure spBtnBuscaRuaClick(Sender: TObject);
    procedure plsEdBairroExit(Sender: TObject);
  private
    FoRua: TObjRua;
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
    function outrasValidacoesAntesSalvar(): Boolean; override;
    procedure novo(); override;
    function salvar(): Boolean; override;
    function excluir(): Boolean; override;
    procedure verificarInseriuChamadaTelaExterna(); override;
    procedure AbreTelaSelecaoBairro(pnTpSelecao:Word);
    procedure VerificarBairroExiste();
  public
    FoBairro: TBairro;
    FoBairroAux: TBairro;

    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadRua: TfrmCadRua;

implementation

uses unConstantes, unPesquisandoRua, unDM, unSelecionaRegistroBairro, unVariaveis,
  unSelecionaRegistroRua;

const
  fnSELECIONAR_BAIRRO_NORMAL    = 1;
  fnSELECIONAR_BAIRRO_DIGITANDO = 2;

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmCadRua.iniciarTela(poForm: TForm);
begin
  inherited;

  Application.CreateForm(TfrmPesquisandoRua, Self.FoPesquisa);
  Self.FoPesquisa.iniciarTela(frmCadRua);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;

  //objeto auxiliar para armazenar estado da cidade que será inserida - FbChamadaExternaInserirRegistro=True 
  Self.FoBairroAux.codigo := NUMERO_INDEFINIDO;
  Self.FoBairroAux.nome := STRING_INDEFINIDO;
end;

procedure TfrmCadRua.passarParametro(pTipo:String; pValores:OleVariant);
var
  nCodFK_Bairro: Integer;
begin
  inherited;

  if(pTipo = PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.FbChamadaExternaInserirRegistro := True;
    Self.FiTelaExternaChamouInserirRegistro := pValores;
  end

  else if(pTipo = PRM_DEFINE_BAIRRO_RUA_INSERINDO)then
  begin
    if(VarIsNumeric(pValores))then
    begin
      nCodFK_Bairro := pValores;
      if(nCodFK_Bairro <> NUMERO_INDEFINIDO)then
      begin
        DM.zQryBairro.Close;
        DM.zQryBairro.SQL.Clear;
        DM.zQryBairro.SQL.Add('SELECT * FROM bairro WHERE codigo = :bai');
        DM.zQryBairro.ParamByName('bai').AsInteger := nCodFK_Bairro;
        DM.zQryBairro.Open;
        if(DM.zQryBairro.RecordCount=1)then
        begin
          Self.FoBairroAux.codigo := DM.zQryBairroCODIGO.AsInteger;
          Self.FoBairroAux.nome := DM.zQryBairroNOME.AsString;
        end;
      end;
    end;
  end

  else if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS)then
    FoConjuntoDadosBairro.ExecutarSQLSelecao();
end;

procedure TfrmCadRua.limparObjeto();
begin
  if (Assigned(Self.FoRua)) then
  begin
    Self.FoRua.setCodigo(NUMERO_INDEFINIDO);
    Self.FoRua.setFkBairro(NUMERO_INDEFINIDO);
    Self.FoRua.setNome(STRING_INDEFINIDO);
    Self.FoRua.setCEP(STRING_INDEFINIDO);
  end
end;

procedure TfrmCadRua.limparTela(poForm: TForm);
begin
  inherited;

  Self.FoBairro.codigo := NUMERO_INDEFINIDO;
  Self.FoBairro.nome := STRING_INDEFINIDO;
end;

procedure TfrmCadRua.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoRua))) then
  begin
    Self.FoRua.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoRua.setFkBairro(cdsDadosCOD_FK_BAIRRO.AsInteger);
    Self.FoRua.setNome(cdsDadosNOME.AsString);
    Self.FoRua.setCEP(cdsDadosCEP.AsString);
    Self.FoRua.setExibeBairro();
  end
  else
  begin
    FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadRua.carregarObjeto();','Acesso Indisponível');
  end;
end;

procedure TfrmCadRua.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoRua))then
  begin
    if(Self.FoRua.getCodigo <> 0)then
      plsEdCodigo.Text := IntToStr(Self.FoRua.getCodigo)
    else
      plsEdCodigo.Clear;
    plsEdBairro.Text := Self.FoRua.getExibeBairro;
    Self.FoBairro.codigo := Self.FoRua.getFkBairro;
    Self.FoBairro.nome := Self.FoRua.getExibeBairro;
    plsEdNome.Text := Self.FoRua.getNome;
    plsMedCEP.Text := Self.FoRua.getCEP;
  end;
end;

procedure TfrmCadRua.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM rua ');
  zQryDados.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadRua.verificarHouveAlteracoes(): boolean;
var
  iBairro: Integer;
  sNome: String;
  sCEP: String;
  bAlteracao: Boolean;
begin
  iBairro := Self.FoBairro.codigo;
  sNome := Trim(plsEdNome.Text);
  sCEP := Trim(plsMedCEP.Text);

  try
    bAlteracao := Self.FoRua.verificarDiferencaCadastro(iBairro, sNome, sCEP);
  except
    bAlteracao := True;
  end;

  Result := bAlteracao;
end;

function TfrmCadRua.verificarCamposObrigatorios(): boolean;
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

  (*
  if(Self.FoBairro.codigo = NUMERO_INDEFINIDO)then
  begin
    campos := 'Bairro';
    //compFoco := plsEdEstado;
  end;
  *)
  
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

function TfrmCadRua.verificarRegistroJaExiste(): boolean;
var
  nCodFkBairro: Integer;
begin
  if(Self.FoBairro.codigo = NUMERO_INDEFINIDO)then
    nCodFkBairro := REGISTRO_NULO
  else
    nCodFkBairro := Self.FoBairro.codigo;

  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM rua WHERE cod_fk_bairro=:cod_fk_bai AND nome=:nom AND cep=:cep');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoRua.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoRua.getCodigo;
  end;
  zQryDados.ParamByName('cod_fk_bai').AsInteger := nCodFkBairro;
  zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
  zQryDados.ParamByName('cep').AsString := Trim(plsMedCEP.Text);
  zQryDados.Open;
  if(zQryDados.RecordCount <> 0)then
  begin
    Result := True;
    MessageDlg('Bairro já cadastrado.', mtWarning, [mbOK], 0);
  end
  else
    Result := False;
end;

function TfrmCadRua.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;

  //verifica se rua não está associada a um cliente pessoa física
  if(bPodeDeletar)then
  begin
    DM.zQryClientePessoaFisica.Close;
    DM.zQryClientePessoaFisica.SQL.Clear;
    DM.zQryClientePessoaFisica.SQL.Add('SELECT * FROM cliente_pessoa_fisica WHERE cod_fk_rua=:cod_fk_rua');
    DM.zQryClientePessoaFisica.ParamByName('cod_fk_rua').AsInteger := Self.FoRua.getCodigo;
    DM.zQryClientePessoaFisica.Open;
    if(DM.zQryClientePessoaFisica.RecordCount <> 0)then
    begin
      MessageDlg('Rua não pode ser deletada, pois existe um cliente desta rua.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  //verifica se rua não está associada a um cliente pessoa jurídica
  if(bPodeDeletar)then
  begin
    DM.zQryClientePessoaJuridica.Close;
    DM.zQryClientePessoaJuridica.SQL.Clear;
    DM.zQryClientePessoaJuridica.SQL.Add('SELECT * FROM cliente_pessoa_juridica WHERE cod_fk_rua=:cod_fk_rua');
    DM.zQryClientePessoaJuridica.ParamByName('cod_fk_rua').AsInteger := Self.FoRua.getCodigo;
    DM.zQryClientePessoaJuridica.Open;
    if(DM.zQryClientePessoaJuridica.RecordCount <> 0)then
    begin
      MessageDlg('Rua não pode ser deletada, pois existe um cliente desta rua.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  //verifica se rua não está associada a um imovel
  if(bPodeDeletar)then
  begin
    DM.zQryImovel.Close;
    DM.zQryImovel.SQL.Clear;
    DM.zQryImovel.SQL.Add('SELECT * FROM imovel WHERE cod_fk_rua=:cod_fk_rua');
    DM.zQryImovel.ParamByName('cod_fk_rua').AsInteger := Self.FoRua.getCodigo;
    DM.zQryImovel.Open;
    if(DM.zQryImovel.RecordCount <> 0)then
    begin
      MessageDlg('Rua não pode ser deletada, pois existe um imóvel desta rua.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  //verifica se rua não está associada a um agenc pessoa_fisica
  if(bPodeDeletar)then
  begin
    DM.zQryAgencPessoaFisica.Close;
    DM.zQryAgencPessoaFisica.SQL.Clear;
    DM.zQryAgencPessoaFisica.SQL.Add('SELECT * FROM agenc_pessoa_fisica WHERE cod_fk_rua=:cod_fk_rua');
    DM.zQryAgencPessoaFisica.ParamByName('cod_fk_rua').AsInteger := Self.FoRua.getCodigo;
    DM.zQryAgencPessoaFisica.Open;
    if(DM.zQryAgencPessoaFisica.RecordCount <> 0)then
    begin
      MessageDlg('Rua não pode ser deletada, pois existe um agenciador desta rua.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  //verifica se rua não está associada a uma pessoa_juridica
  if(bPodeDeletar)then
  begin
    DM.zQryAgencPessoaJuridica.Close;
    DM.zQryAgencPessoaJuridica.SQL.Clear;
    DM.zQryAgencPessoaJuridica.SQL.Add('SELECT * FROM agenc_pessoa_juridica WHERE cod_fk_rua=:cod_fk_rua');
    DM.zQryAgencPessoaJuridica.ParamByName('cod_fk_rua').AsInteger := Self.FoRua.getCodigo;
    DM.zQryAgencPessoaJuridica.Open;
    if(DM.zQryAgencPessoaJuridica.RecordCount <> 0)then
    begin
      MessageDlg('Rua não pode ser deletada, pois existe um agenciador desta rua.',
        mtInformation, [mbOK], 0);
      bPodeDeletar := False;
    end;
  end;

  Result := bPodeDeletar;
end;


procedure TfrmCadRua.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       pnlBairro.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsMedCEP.Enabled := False;
                       plsEdCodigo.SetFocus;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Enabled := False;
                       pnlBairro.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsMedCEP.Enabled := True;
                       plsEdBairro.SetFocus;
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       pnlBairro.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsMedCEP.Enabled := True;
                       plsEdBairro.SetFocus;
                     end;
    OPC_SALVAR:      begin

                     end;
    OPC_EXCLUIR:     begin

                     end;
    OPC_CANCELAR:    begin

                     end;
    OPC_PESQUISOU:   begin
                       plsEdCodigo.Enabled := True;
                       pnlBairro.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsMedCEP.Enabled := False;
                     end;
  end; //fim - case
end;

function TfrmCadRua.outrasValidacoesAntesSalvar(): Boolean;
var
  compFoco: TWinControl;
  sCEP: String;
  bRetorno: Boolean;
begin
  compFoco := nil;
  bRetorno := True;

  sCEP := Self.FoFuncoes.retirarCaracteres(plsMedCEP.Text,'-');
  sCEP := Trim(sCEP);
  if(not(sCEP=STRING_INDEFINIDO))then
  begin
    if(not(Self.FoFuncoes.validarCEP(Trim(plsMedCEP.Text))))then
    begin
      MessageDlg('CEP inválido.',mtWarning,[mbOK],0);
      compFoco := plsMedCEP;
      bRetorno := False;
    end;
  end;

  //setar foco no componente que não foi validado
  if((not(bRetorno))and(compFoco is TWinControl))then
    Self.FoFuncoes.focarComponente(compFoco);

  Result := bRetorno;
end;

procedure TfrmCadRua.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadRua);
  visibilidade(OPC_NOVO);
end;    

function TfrmCadRua.salvar(): boolean;
var
  nCodFkBairro: Integer;
  sNome,sCEP: String;
  bSalvou: boolean;

  procedure carregarValores();
  begin
    //uma rua pode ser cadastrada sem um bairro
    if(Self.FoBairro.codigo = NUMERO_INDEFINIDO)then
      nCodFkBairro := REGISTRO_NULO
    else
      nCodFkBairro := Self.FoBairro.codigo;

    sNome := Trim(plsEdNome.Text);
    sCEP := Trim(plsMedCEP.Text);
    if(Self.FoFuncoes.verificaCPF_EhVazio(sCEP))then
      sCEP := STRING_INDEFINIDO;
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
        zQryDados.SQL.Add('UPDATE rua SET cod_fk_bairro=:cod_fk_bai,nome=:nom,cep=:cep ');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('cod_fk_bai').AsInteger := nCodFkBairro;//Self.FoBairro.codigo;
        zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
        zQryDados.ParamByName('cep').AsString := Trim(plsMedCEP.Text);
        zQryDados.ParamByName('cod').AsInteger := Self.FoRua.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO rua (cod_fk_bairro, nome, cep) ');
        zQryDados.SQL.Add('VALUES (:cod_fk_bai, :nom, :cep)');
        zQryDados.ParamByName('cod_fk_bai').AsInteger := nCodFkBairro;//Self.FoBairro.codigo;
        zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
        zQryDados.ParamByName('cep').AsString := Trim(plsMedCEP.Text);
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

function TfrmCadRua.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM rua WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoRua.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadRua.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

procedure TfrmCadRua.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
begin
  DM.zQryRua.Close;
  DM.zQryRua.SQL.Clear;
  DM.zQryRua.SQL.Add('SELECT * FROM rua ORDER BY codigo DESC ROWS 1');
  DM.zQryRua.Open;
  if(DM.zQryRua.RecordCount = 1)then
    nCodigo := DM.zQryRuaCODIGO.AsInteger
  else
    nCodigo := NUMERO_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_RUA)then
    begin
      frmSelecionaRegistroRua.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end;
end;


procedure TfrmCadRua.AbreTelaSelecaoBairro(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  case pnTpSelecao of

    fnSELECIONAR_BAIRRO_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroBairro, frmSelecionaRegistroBairro);
        frmSelecionaRegistroBairro.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_RUA);
        frmSelecionaRegistroBairro.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroBairro.ShowModal;
      finally
        if(Self.FoBairro.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdBairro.Text := Self.FoBairro.nome;
          Self.FoFuncoes.focarComponente(plsEdNome);
        end;
        FreeAndNil(frmSelecionaRegistroBairro);
      end;
    end;

    fnSELECIONAR_BAIRRO_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroBairro, frmSelecionaRegistroBairro);
        frmSelecionaRegistroBairro.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_RUA);
        frmSelecionaRegistroBairro.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        vParametros := VarArrayCreate([0,2],varVariant);
        vParametros[0] := PRM_PESQUISA_NOME;
        vParametros[1] := plsEdBairro.Text;
        vParametros[2] := False;
        frmSelecionaRegistroBairro.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroBairro.ShowModal;
      finally
        if(Self.FoBairro.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdBairro.Text := Self.FoBairro.nome;
          Self.FoFuncoes.focarComponente(plsEdNome);
        end
        else
          plsEdBairro.Clear;
        FreeAndNil(frmSelecionaRegistroBairro);
      end;
    end;

  end;

end;

procedure TfrmCadRua.VerificarBairroExiste();
begin
  if(plsEdBairro.Text <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosBairro.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdBairro.Text + '%'));
    FoConjuntoDadosBairro.ExecutarFiltrar();

    if(FoConjuntoDadosBairro.TotalRegistros = 1)then
    begin
      FoBairro.codigo := FoConjuntoDadosBairro.GetCodigo;
      FoBairro.nome := FoConjuntoDadosBairro.GetNome;
      plsEdBairro.Text := FoBairro.nome;
    end
    else if(FoConjuntoDadosBairro.TotalRegistros > 1)then
      AbreTelaSelecaoBairro(fnSELECIONAR_BAIRRO_DIGITANDO)
    else
    begin
      MessageDlg('Bairro não encontrado.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdBairro);
    end;
  end;
end;

(* fim - procedimentos de controle *)


procedure TfrmCadRua.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoRua := TObjRua.Create;
  FoConjuntoDadosBairro := TConjuntoDadosBairro.CriaObjeto;
end;

procedure TfrmCadRua.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoRua);
  FreeAndNil(FoConjuntoDadosBairro);
end;

procedure TfrmCadRua.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadRua.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadRua.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadRua.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadRua.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  //visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadRua.plsEdCodigoExit(Sender: TObject);
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

procedure TfrmCadRua.plsEdNomeExit(Sender: TObject);
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

procedure TfrmCadRua.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadRua.plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sValor: string;
begin
  inherited;
  if(FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[numeros],False))then
  begin
    if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter)) then
    begin
      if(Key=27)then
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

procedure TfrmCadRua.plsEdNomeKeyUp(Sender: TObject; var Key: Word;
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
        sValor := plsEdNome.Text;
        if(sValor <> STRING_INDEFINIDO)then
        begin
          FnCampoPesquisou := CAMPO_PESQUISOU_POR_NOME;
          sValor := UpperCase(sValor);
          ActiveControl := nil;
          Self.FoPesquisa.atualizarPesquisando('NOME', 'Nome:', sValor, cdsDados);
          Self.FoPesquisa.Show;
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadRua.FormShow(Sender: TObject);
begin
  inherited;
  //caso for pra inserir com um estado definido
  if(Self.FoBairroAux.codigo <> NUMERO_INDEFINIDO)then
  begin
    Self.FoBairro.codigo := Self.FoBairroAux.codigo;
    Self.FoBairro.nome := Self.FoBairroAux.nome;
    plsEdBairro.Text := Self.FoBairro.nome;
    pnlBairro.Enabled := False;
    Self.FoFuncoes.focarComponente(plsEdNome);
  end;
end;

procedure TfrmCadRua.spBtnBuscaRuaClick(Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoBairro(fnSELECIONAR_BAIRRO_NORMAL);
end;

procedure TfrmCadRua.plsEdBairroExit(Sender: TObject);
begin
  inherited;
  VerificarBairroExiste();
end;

end.
