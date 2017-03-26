unit unCadDicas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, StdCtrls, plsEdit,
  ExtCtrls, ComCtrls, ToolWin, plsComboBox, plsMemo, unObjDica;

type
  TfrmCadDica = class(TfrmCadastroBasico)
    lblCodigo: TLabel;
    plsEdCodigo: TPlsEdit;
    lblDica: TLabel;
    lblCampoObrigatorio2: TLabel;
    lblUsuario: TLabel;
    lblNomeUsuario: TLabel;
    lblTela: TLabel;
    plsMmDica: TPlsMemo;
    plsCbBxTela: TPlsComboBox;
    lblCampoObrigatorio1: TLabel;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosCOD_FK_USUARIO: TIntegerField;
    zQryDadosTELA: TStringField;
    zQryDadosDICA: TStringField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosCOD_FK_USUARIO: TIntegerField;
    cdsDadosTELA: TStringField;
    cdsDadosDICA: TStringField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure plsEdCodigoExit(Sender: TObject);
    procedure plsCbBxTelaExit(Sender: TObject);
    procedure plsMmDicaExit(Sender: TObject);
    procedure plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsMmDicaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure plsCbBxTelaKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdCodigoEnter(Sender: TObject);
    procedure plsMmDicaEnter(Sender: TObject);
    procedure plsEdCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure plsCbBxTelaEnter(Sender: TObject);
    procedure plsMmDicaKeyPress(Sender: TObject; var Key: Char);
  private
    FoDica: TObjDica;
    FnCdUsuario: Integer;
    FsNomeUsuario: String;

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
    function GetItemIndexTela(psTela:String): Integer;
  public
    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadDica: TfrmCadDica;

implementation

uses unPesquisandoDica, unPrincipal, unDM, unConstantes, unVariaveis, Math;

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmCadDica.iniciarTela(poForm: TForm);
begin
  inherited;

  Application.CreateForm(TfrmPesquisandoDica, FoPesquisa);
  FoPesquisa.iniciarTela(frmCadDica);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;

  FnCdUsuario := frmPrincipal.GetCdUsuario;
  FsNomeUsuario := frmPrincipal.GetNomeUsuario;
end;

procedure TfrmCadDica.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;
end;

procedure TfrmCadDica.limparObjeto();
begin
  if (Assigned(FoDica)) then
  begin
    Self.FoDica.setCodigo(NUMERO_INDEFINIDO);
    Self.FoDica.setFkUsuario(NUMERO_INDEFINIDO);
    Self.FoDica.setTela(STRING_INDEFINIDO);
    Self.FoDica.setDica(STRING_INDEFINIDO);
  end
end;

procedure TfrmCadDica.limparTela(poForm: TForm);
begin
  inherited;
  lblNomeUsuario.Caption := STRING_INDEFINIDO;
end;

procedure TfrmCadDica.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoDica))) then
  begin
    Self.FoDica.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoDica.setFkUsuario(cdsDadosCOD_FK_USUARIO.AsInteger);
    Self.FoDica.setTela(cdsDadosTELA.AsString);
    Self.FoDica.setDica(cdsDadosDICA.AsString);
    Self.FoDica.setExibeUsuario;
  end
  else
  begin
    Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadDica.carregarObjeto();','Acesso Indisponível');
  end;
end;

procedure TfrmCadDica.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoDica))then
  begin
    if(Self.FoDica.getCodigo <> 0)then
      plsEdCodigo.Text := IntToStr(Self.FoDica.getCodigo)
    else
      plsEdCodigo.Clear;
    lblNomeUsuario.Caption := Self.FoDica.getExibeUsuario;
    plsCbBxTela.ItemIndex := GetItemIndexTela(Self.FoDica.getTela);
    plsMmDica.Text := Self.FoDica.getDica;
  end;
end;

procedure TfrmCadDica.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM dicas ');
  zQryDados.SQL.Add(Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY tela');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadDica.verificarHouveAlteracoes(): boolean;
var
  sTela: string;
  sDica: string;
  bAlteracao: boolean;
begin
  sTela := Trim(plsCbBxTela.Text);
  sDica := Trim(plsMmDica.Text);

  try
    bAlteracao := Self.FoDica.verificarDiferencaCadastro(sTela,sDica);
  except
    bAlteracao := True;
  end;

  Result := bAlteracao;
end;

function TfrmCadDica.verificarCamposObrigatorios(): boolean;
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

  if(plsCbBxTela.ItemIndex = -1)then
  begin
    campos := 'Tela';
    compFoco := plsCbBxTela;
  end;

  if(Trim(plsMmDica.Text) = STRING_INDEFINIDO)then
  begin
    if(campos <> '')then
      campos := campos + ', Dica'
    else
    begin
      campos := 'Dica';
      compFoco := plsMmDica;
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

function TfrmCadDica.verificarRegistroJaExiste(): boolean;
begin
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM dicas WHERE tela=:tel AND dica=:dic');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoDica.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoDica.getCodigo;
  end;
  zQryDados.ParamByName('tel').AsString := Trim(plsCbBxTela.Text);
  zQryDados.ParamByName('dic').AsString := Trim(plsMmDica.Text);
  zQryDados.Open;
  if(zQryDados.RecordCount <> 0)then
  begin
    Result := True;
    MessageDlg('Dica já cadastrada.', mtWarning, [mbOK], 0);
  end
  else
    Result := False;
end;

function TfrmCadDica.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;
  Result := bPodeDeletar;
end;

procedure TfrmCadDica.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       plsCbBxTela.Enabled := False;
                       plsMmDica.Enabled := True;
                       plsEdCodigo.SetFocus;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_DICAS,True));
                       plsEdCodigo.Enabled := False;
                       plsCbBxTela.Enabled := True;
                       plsMmDica.Enabled := True;
                       plsCbBxTela.SetFocus;
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       plsCbBxTela.Enabled := True;
                       plsMmDica.Enabled := True;
                       plsCbBxTela.SetFocus;
                     end;
    OPC_SALVAR:      begin
                     end;
    OPC_EXCLUIR:     begin
                     end;
    OPC_CANCELAR:    begin
                     end;
    OPC_PESQUISOU:   begin
                       plsEdCodigo.Enabled := True;
                       plsCbBxTela.Enabled := False;
                       plsMmDica.Enabled := True;
                     end;
  end; //fim - case

end;

procedure TfrmCadDica.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadDica);
  visibilidade(OPC_NOVO);
  lblNomeUsuario.Caption := FsNomeUsuario;
end;

function TfrmCadDica.salvar(): boolean;
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
        zQryDados.SQL.Add('UPDATE dicas SET cod_fk_usuario=:cod_fk_usu, tela=:tel,dica=:dic ');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('cod_fk_usu').AsInteger := Self.FnCdUsuario;
        zQryDados.ParamByName('tel').AsString := Trim(plsCbBxTela.Text);
        zQryDados.ParamByName('dic').AsString := Trim(plsMmDica.Text);
        zQryDados.ParamByName('cod').AsInteger := Self.FoDica.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO dicas (cod_fk_usuario,tela,dica) VALUES (:cod_fk_usu,:tel,:dic)');
        zQryDados.ParamByName('cod_fk_usu').AsInteger := Self.FnCdUsuario;
        zQryDados.ParamByName('tel').AsString := Trim(plsCbBxTela.Text);
        zQryDados.ParamByName('dic').AsString := Trim(plsMmDica.Text);
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

function TfrmCadDica.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM dicas WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoDica.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadDica.verificarInseriuChamadaTelaExterna();
begin
end;

procedure TfrmCadDica.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

function TfrmCadDica.GetItemIndexTela(psTela:String): Integer;
var
  nRetorno: Integer;
begin
  nRetorno := -1;
  if(psTela = 'ESTADO')then
    nRetorno := 0
  else if(psTela = 'CIDADE')then
    nRetorno := 1
  else if(psTela = 'BAIRRO')then
    nRetorno := 2
  else if(psTela = 'RUA')then
    nRetorno := 3
  else if(psTela = 'CONSTRUTORA')then
    nRetorno := 4
  else if(psTela = 'PROFISSÕES')then
    nRetorno := 5
  else if(psTela = 'MEIO DE CAPTAÇÃO')then
    nRetorno := 6
  else if(psTela = 'GRUPO DE CONFIGURAÇÃO DO IMÓVEL')then
    nRetorno := 7
  else if(psTela = 'SUB-GRUPO DE CONFIGURAÇÃO DO IMÓVEL')then
    nRetorno := 8;

  Result := nRetorno;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadDica.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoDica := TObjDica.Create;
end;

procedure TfrmCadDica.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoDica);
end;

procedure TfrmCadDica.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadDica.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
  lblNomeUsuario.Caption := FsNomeUsuario;
end;

procedure TfrmCadDica.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadDica.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadDica.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  //visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadDica.plsEdCodigoExit(Sender: TObject);
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

procedure TfrmCadDica.plsCbBxTelaExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;

  if(FiFuncaoRegistro = FUNCAO_REGISTRO_NENHUM)and(plsCbBxTela.Text = STRING_INDEFINIDO)then
  begin
    limparObjeto();
    limparTela(Self);
    visibilidade(OPC_CANCELAR);
  end;
end;

procedure TfrmCadDica.plsMmDicaExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;

  if(FiFuncaoRegistro = FUNCAO_REGISTRO_NENHUM)and(plsMmDica.Text = STRING_INDEFINIDO)
  and(FnCampoPesquisou = CAMPO_PESQUISOU_POR_NOME)then
  begin
    limparObjeto();
    limparTela(Self);
    visibilidade(OPC_CANCELAR);
  end;
end;

procedure TfrmCadDica.plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
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
          if(FoPesquisa.PodeAbrirTelaPesquisandoRegistro)then
            FoPesquisa.Show;
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadDica.plsMmDicaKeyUp(Sender: TObject; var Key: Word;
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
        sValor := plsMmDica.Text;
        if(sValor <> STRING_INDEFINIDO)then
        begin
          FnCampoPesquisou := CAMPO_PESQUISOU_POR_NOME;
          sValor := UpperCase(sValor);
          ActiveControl := nil;
          FoPesquisa.atualizarPesquisando('DICA', 'Dica:', sValor, cdsDados);
          if(FoPesquisa.PodeAbrirTelaPesquisandoRegistro)then
            FoPesquisa.Show;
        end;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadDica.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadDica.plsCbBxTelaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Self.FiFuncaoRegistro = FUNCAO_REGISTRO_NOVO)then
    StatusBar.Panels[0].Text := 'Selecione a Tela da Dica que está cadastrando'
  else if(Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR)then
    StatusBar.Panels[0].Text := 'Selecione a Tela da Dica que está editando';
end;

procedure TfrmCadDica.plsEdCodigoEnter(Sender: TObject);
begin
  inherited;
  if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter)) then
    StatusBar.Panels[0].Text := 'Pesquisando Dica pelo Código';
end;

procedure TfrmCadDica.plsMmDicaEnter(Sender: TObject);
begin
  inherited;
  if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter)) then
    StatusBar.Panels[0].Text := 'Pesquisando pela Dica'
  else if(Self.FiFuncaoRegistro = FUNCAO_REGISTRO_NOVO)then
    StatusBar.Panels[0].Text := 'Digite a Dica que está cadastrando'
  else if(Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR)then
    StatusBar.Panels[0].Text := 'Digite a Dica que está editando';
end;

procedure TfrmCadDica.plsEdCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter)) then
    StatusBar.Panels[0].Text := 'Pesquisando Dica pelo Código';
end;

procedure TfrmCadDica.plsCbBxTelaEnter(Sender: TObject);
begin
  inherited;
  if(Self.FiFuncaoRegistro = FUNCAO_REGISTRO_NOVO)then
    StatusBar.Panels[0].Text := 'Selecione a Tela da Dica que está cadastrando'
  else if(Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR)then
    StatusBar.Panels[0].Text := 'Selecione a Tela da Dica que está editando';
end;

procedure TfrmCadDica.plsMmDicaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter)) then
    StatusBar.Panels[0].Text := 'Pesquisando pela Dica'
  else if(Self.FiFuncaoRegistro = FUNCAO_REGISTRO_NOVO)then
    StatusBar.Panels[0].Text := 'Digite a Dica que está cadastrando'
  else if(Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR)then
    StatusBar.Panels[0].Text := 'Digite a Dica que está editando';
end;

end.

