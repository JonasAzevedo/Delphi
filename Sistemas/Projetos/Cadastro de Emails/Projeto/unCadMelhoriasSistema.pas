unit unCadMelhoriasSistema;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ImgList,
  StdCtrls, plsEdit, Grids, DBGrids, ComCtrls, ToolWin, plsComboBox,
  plsMemo;

type
  TfrmCadMelhoriasSistema = class(TForm)
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnEditar: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnExcluir: TToolButton;
    tlBtnCancelar: TToolButton;
    dbGrdDados: TDBGrid;
    grpBxDados: TGroupBox;
    lblCodigo: TLabel;
    lblDataCadastro: TLabel;
    edCodigo: TPlsEdit;
    edDataCadastro: TPlsEdit;
    imgLista: TImageList;
    zQryMelhoriasSistema: TZQuery;
    dsMelhoriasSistema: TDataSource;
    zQryMelhoriasSistemaCODIGO: TIntegerField;
    zQryMelhoriasSistemaDATA_CADASTRO: TDateTimeField;
    zQryMelhoriasSistemaDESCRICAO: TStringField;
    zQryMelhoriasSistemaREPLICA: TStringField;
    zQryMelhoriasSistemaRELEVANCIA: TIntegerField;
    zQryMelhoriasSistemaSITUACAO: TIntegerField;
    zQryMelhoriasSistemaDATA_FINALIZADA: TDateTimeField;
    zQryMelhoriasSistemaINCLUIDO_VERSAO: TStringField;
    lblDescricao: TLabel;
    mmDescricao: TPlsMemo;
    lblReplica: TLabel;
    mmReplica: TPlsMemo;
    cbBxRelevancia: TPlsComboBox;
    lblRelevancia: TLabel;
    lblSituacao: TLabel;
    lblDataFinalizada: TLabel;
    lblVersao: TLabel;
    cbBxSituacao: TPlsComboBox;
    edDataFinalizada: TPlsEdit;
    edVersao: TPlsEdit;
  public

  private
    FnFuncaoRegistro: Integer;

    procedure CarregarDados;
    procedure SelecionarTodosDados;
    procedure LimparTela;
    function VerificarCamposObrigatorios: boolean;
    function VerificarRegistroJaExiste: boolean;
    procedure Visibilidade(pnVisib: Integer);
    procedure Novo;
    function Salvar: Boolean;
    function Excluir: Boolean;
  end;

var
  frmCadMelhoriasSistema: TfrmCadMelhoriasSistema;

implementation

uses unDM, unConstantes;

{$R *.dfm}

{ TfrmCadAreasInteresse }

procedure TfrmCadMelhoriasSistema.LimparTela;
begin
  edCodigo.Clear;
  edDataCadastro.Clear;
  mmDescricao.Clear;
  mmReplica.Clear;
  cbBxRelevancia.ItemIndex := -1;
  cbBxSituacao.ItemIndex := -1;
  edDataFinalizada.Clear;
  edVersao.Clear;
end;

procedure TfrmCadMelhoriasSistema.SelecionarTodosDados;
begin
  zQryMelhoriasSistema.Close;
  zQryMelhoriasSistema.SQL.Clear;
  zQryMelhoriasSistema.SQL.Add('SELECT * FROM melhorias_sistema');
  zQryMelhoriasSistema.Open;
  if(zQryMelhoriasSistema.RecordCount > NUMERO_NULO)then
    zQryMelhoriasSistema.First;
end;

procedure TfrmCadMelhoriasSistema.CarregarDados;

  function GetRelevancia: Integer;
  begin
    Result := 1;
  end;

  function GetSituacao: Integer;
  begin
    Result := 1;
  end;

begin
  if (zQryMelhoriasSistema.RecordCount > NUMERO_NULO)then
  begin
    edCodigo.Text := zQryMelhoriasSistemaCODIGO.AsString;
    edDataCadastro.Text := zQryMelhoriasSistemaDATA_CADASTRO.AsString;
    mmDescricao.Text := zQryMelhoriasSistemaDESCRICAO.AsString;
    mmReplica.Text := zQryMelhoriasSistemaREPLICA.AsString;
    cbBxRelevancia.ItemIndex := GetRelevancia;
    cbBxSituacao.ItemIndex := GetSituacao;
    edDataFinalizada.Text := zQryMelhoriasSistemaDATA_FINALIZADA.AsString;
    edVersao.Text := zQryMelhoriasSistemaINCLUIDO_VERSAO.AsString;
    Visibilidade(OPC_PESQUISOU);
  end
  else
    LimparTela;
end;

function TfrmCadMelhoriasSistema.VerificarCamposObrigatorios: boolean;
var
  sCampos: String;
  bRetorno: Boolean;
begin
  bRetorno := True;
  sCampos := STRING_INDEFINIDO;
  if (Trim(mmDescricao.Text) = STRING_INDEFINIDO)then
  begin
    sCampos := 'Descrição';
    bRetorno := False;
  end;

  if (cbBxRelevancia.ItemIndex = -1)then
  begin
    if (sCampos = STRING_INDEFINIDO)then
      sCampos := 'Relevância'
    else
      sCampos := sCampos + ', Relevância';
    bRetorno := False;
  end;

  if(sCampos <> STRING_INDEFINIDO)then
    MessageDlg('Verifique os campos: ' + sCampos, mtInformation, [mbOK], 0);

  Result := bRetorno;
end;

function TfrmCadAreasInteresse.VerificarRegistroJaExiste: boolean;
begin
  DM.zQryAreasInteresse.Close;
  DM.zQryAreasInteresse.SQL.Clear;
  DM.zQryAreasInteresse.SQL.Add('SELECT * FROM areas_interesse WHERE nome=:nome');
  DM.zQryAreasInteresse.ParamByName('nome').AsString := Trim(edNome.Text);
  DM.zQryAreasInteresse.Open;

  Result := DM.zQryAreasInteresse.RecordCount > NUMERO_NULO;
end;

procedure TfrmCadAreasInteresse.Visibilidade(pnVisib: Integer);
begin

  case pnVisib of
    OPC_TELA_INICIO: begin
                       limparTela;
                       tlBtnNovo.Enabled :=  True;
                       tlBtnEditar.Enabled := False;
                       tlBtnSalvar.Enabled := False;
                       tlBtnExcluir.Enabled := False;
                       tlBtnCancelar.Enabled := False;
                       edNome.Enabled := False;
                       selecionarTodosDados;
                       CarregarDados;
                     end;
    OPC_NOVO:        begin
                       limparTela;
                       tlBtnNovo.Enabled :=  False;
                       tlBtnEditar.Enabled := False;
                       tlBtnSalvar.Enabled := True;
                       tlBtnExcluir.Enabled := False;
                       tlBtnCancelar.Enabled := True;
                       edNome.Enabled := True;
                       edNome.SetFocus;
                     end;
    OPC_EDITAR:      begin
                       limparTela;
                       carregarDados;
                       tlBtnNovo.Enabled :=  False;
                       tlBtnEditar.Enabled := False;
                       tlBtnSalvar.Enabled := True;
                       tlBtnExcluir.Enabled := True;
                       tlBtnCancelar.Enabled := True;
                       edNome.Enabled := True;
                       edNome.SetFocus;
                     end;
    OPC_SALVAR:      begin
                       Visibilidade(OPC_TELA_INICIO);
                     end;
    OPC_EXCLUIR:     begin
                       Visibilidade(OPC_TELA_INICIO);
                     end;
    OPC_CANCELAR:    begin
                       Visibilidade(OPC_TELA_INICIO);
                     end;
    OPC_PESQUISOU:   begin
                       tlBtnNovo.Enabled :=  True;
                       tlBtnEditar.Enabled := True;
                       tlBtnSalvar.Enabled := False;
                       tlBtnExcluir.Enabled := True;
                       tlBtnCancelar.Enabled := True;
                     end;
  end; //fim - case
end;


procedure TfrmCadAreasInteresse.Novo;
begin
  LimparTela;
  Visibilidade(OPC_NOVO);
  FnFuncaoRegistro := FUNCAO_REGISTRO_NOVO;
end;

function TfrmCadAreasInteresse.Salvar: Boolean;
var
  bSalvou: boolean;
begin
  bSalvou := False;

  if(FnFuncaoRegistro in [FUNCAO_REGISTRO_NOVO, FUNCAO_REGISTRO_EDITAR]) then
  begin
    if (FnFuncaoRegistro = FUNCAO_REGISTRO_EDITAR) then
    begin
      try
        DM.ZConnection.StartTransaction;
        zQryAreasInteresse.Close;
        zQryAreasInteresse.SQL.Clear;
        zQryAreasInteresse.SQL.Add('UPDATE areas_interesse SET nome=:nome ');
        zQryAreasInteresse.SQL.Add('WHERE codigo=:codigo');
        zQryAreasInteresse.ParamByName('nome').AsString := Trim(edNome.Text);
        zQryAreasInteresse.ParamByName('codigo').AsInteger := StrToInt(edCodigo.Text);
        zQryAreasInteresse.ExecSQL();
        DM.ZConnection.Commit;
        bSalvou := True;
      except
        DM.ZConnection.Rollback;
      end;

    end
    else if (FnFuncaoRegistro = FUNCAO_REGISTRO_NOVO) then
    begin
      try
        DM.ZConnection.StartTransaction;
        zQryAreasInteresse.Close;
        zQryAreasInteresse.SQL.Clear;
        zQryAreasInteresse.SQL.Add('INSERT INTO areas_interesse (nome) ');
        zQryAreasInteresse.SQL.Add('VALUES (:nome)');
        zQryAreasInteresse.ParamByName('nome').AsString := Trim(edNome.Text);
        zQryAreasInteresse.ExecSQL();
        DM.ZConnection.Commit;
        bSalvou := True;
      except
        DM.ZConnection.Rollback;
      end;
    end;
  end;

  Result := bSalvou;
end;

function TfrmCadAreasInteresse.Excluir: Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryAreasInteresse.Close;
    zQryAreasInteresse.SQL.Clear;
    zQryAreasInteresse.SQL.Add('DELETE FROM areas_interesse WHERE codigo=:codigo');
    zQryAreasInteresse.ParamByName('codigo').AsInteger := StrToInt(edCodigo.Text);
    zQryAreasInteresse.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadAreasInteresse.FormCreate(Sender: TObject);
begin
  Visibilidade(OPC_TELA_INICIO);
  FnFuncaoRegistro := FUNCAO_REGISTRO_NENHUM;
  SelecionarTodosDados;
  CarregarDados;
end;

procedure TfrmCadAreasInteresse.dbGrdDadosCellClick(Column: TColumn);
begin
  CarregarDados;
end;

procedure TfrmCadAreasInteresse.tlBtnNovoClick(Sender: TObject);
begin
  Novo;
  FnFuncaoRegistro := FUNCAO_REGISTRO_NOVO;
  Visibilidade(OPC_NOVO);
end;

procedure TfrmCadAreasInteresse.tlBtnEditarClick(Sender: TObject);
begin
  if zQryAreasInteresse.RecordCount > NUMERO_NULO then
  begin
    FnFuncaoRegistro := FUNCAO_REGISTRO_EDITAR;
    Visibilidade(OPC_EDITAR);
  end;
end;

procedure TfrmCadAreasInteresse.tlBtnSalvarClick(Sender: TObject);
begin
  if Salvar then
  begin
    MessageDlg('Registro foi salvo com sucesso.', mtInformation, [mbOk], 0);
    Visibilidade(OPC_SALVAR);
  end
  else
    MessageDlg('Registro não pode ser salvo.', mtInformation, [mbOk], 0);
end;

procedure TfrmCadAreasInteresse.tlBtnExcluirClick(Sender: TObject);
begin
  if zQryAreasInteresse.RecordCount > NUMERO_NULO then
  begin
    if Excluir then
    begin
      MessageDlg('Registro deletado com sucesso.', mtInformation, [mbOk], 0);
      Visibilidade(OPC_EXCLUIR);
    end
    else
      MessageDlg('Registro não pode ser deletado.', mtInformation, [mbOk], 0);
  end;
end;

procedure TfrmCadAreasInteresse.tlBtnCancelarClick(Sender: TObject);
begin
  FnFuncaoRegistro := FUNCAO_REGISTRO_NENHUM;
  Visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadAreasInteresse.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if(FnFuncaoRegistro IN[FUNCAO_REGISTRO_NOVO, FUNCAO_REGISTRO_EDITAR])then
  begin
    if(MessageDlg('Deseja fechar a tela?', mtConfirmation, [mbYes, mbNo], 0)=mrNo)then
    Action := caNone;
  end;
end;

end.
