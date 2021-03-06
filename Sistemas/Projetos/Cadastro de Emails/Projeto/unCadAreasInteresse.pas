unit unCadAreasInteresse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, plsEdit, Grids, DBGrids;

type
  TfrmCadAreasInteresse = class(TForm)
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnEditar: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnExcluir: TToolButton;
    tlBtnCancelar: TToolButton;
    imgLista: TImageList;
    dbGrdDados: TDBGrid;
    grpBxDados: TGroupBox;
    lblCodigo: TLabel;
    lblNome: TLabel;
    edCodigo: TPlsEdit;
    edNome: TPlsEdit;
    zQryAreasInteresse: TZQuery;
    dsAreasInteresse: TDataSource;
    zQryAreasInteresseCODIGO: TIntegerField;
    zQryAreasInteresseNOME: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure dbGrdDadosCellClick(Column: TColumn);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  frmCadAreasInteresse: TfrmCadAreasInteresse;

implementation

uses unDM, unConstantes;

{$R *.dfm}

{ TfrmCadAreasInteresse }

procedure TfrmCadAreasInteresse.LimparTela;
begin
  edCodigo.Clear;
  edNome.Clear;
end;

procedure TfrmCadAreasInteresse.SelecionarTodosDados;
begin
  zQryAreasInteresse.Close;
  zQryAreasInteresse.SQL.Clear;
  zQryAreasInteresse.SQL.Add('SELECT * FROM areas_interesse');
  zQryAreasInteresse.Open;
  if(zQryAreasInteresse.RecordCount > NUMERO_NULO)then
    zQryAreasInteresse.First;
end;

procedure TfrmCadAreasInteresse.CarregarDados;
begin
  if (zQryAreasInteresse.RecordCount > NUMERO_NULO)then
  begin
    edCodigo.Text := zQryAreasInteresseCODIGO.AsString;
    edNome.Text := zQryAreasInteresseNOME.AsString;
    Visibilidade(OPC_PESQUISOU);
  end
  else
    LimparTela;
end;

function TfrmCadAreasInteresse.VerificarCamposObrigatorios: boolean;
begin
  Result := False;
  if (Trim(edNome.Text) = STRING_INDEFINIDO)then
  begin
    MessageDlg('Campo obrigat�rio: nome', mtInformation, [mbOK], 0);
    Result := True;
  end;
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
    MessageDlg('Registro n�o pode ser salvo.', mtInformation, [mbOk], 0);
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
      MessageDlg('Registro n�o pode ser deletado.', mtInformation, [mbOk], 0);
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
