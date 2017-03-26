unit unUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ImgList, ComCtrls, StdCtrls, Grids, DBGrids,
  Buttons, ExtCtrls, ToolWin, DBXpress;

type
  TfrmUsuario = class(TForm)
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnEditar: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnExcluir: TToolButton;
    tlBtnCancelar: TToolButton;
    pnlPesquisar: TPanel;
    rdBtnCodigo: TRadioButton;
    rdBtnNome: TRadioButton;
    btBtnPesquisar: TBitBtn;
    edPesquisa: TEdit;
    dbGrdUsuarios: TDBGrid;
    grpBxDadosUsuario: TGroupBox;
    lblCodigo: TLabel;
    lblNome: TLabel;
    lblSenha: TLabel;
    lblLogin: TLabel;
    edCodigo: TEdit;
    edNome: TEdit;
    edSenha: TEdit;
    edLogin: TEdit;
    StatusBar: TStatusBar;
    imgLista: TImageList;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosProdutos: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnNomeClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaEnter(Sender: TObject);
    procedure edPesquisaExit(Sender: TObject);
    procedure edPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure dbGrdUsuariosCellClick(Column: TColumn);
    procedure edCodigoEnter(Sender: TObject);
    procedure edNomeEnter(Sender: TObject);
    procedure edLoginEnter(Sender: TObject);
    procedure edSenhaEnter(Sender: TObject);
    procedure edSenhaExit(Sender: TObject);
    procedure edLoginExit(Sender: TObject);
    procedure edNomeExit(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure ppMnMostrarTodosProdutosClick(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    Transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress
    opcaoSalvar: Integer; //modo de salvamento. 1=novo; 2=edição
    fechar: boolean; //se pode ou não fechar tela - casos de novo/editar, em que não pode fechar

    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
    function verificaSalva(): boolean; //verifica se os campos obrigatórios foram inseridos antes de salvar
    procedure visibilidade(opc: Integer);//quais componentes exibir/ocultar
    procedure iniciaTransacao();//dispara uma transação
    procedure carrega();//carrega dados da tabela Usuário para os componentes de apresentação
    procedure mostraTodosUsuarios();//exibe todos os Usuários
  public
   (*VARIÁVEIS DE CONTROLE*)
    operacao: String; //recebe valor para saber em que modo inicia a tela
  end;


var
  frmUsuario: TfrmUsuario;

implementation

uses unDM;

{$R *.dfm}         
            
(*PROCEDURES DE CONTROLE*)

{carrega dados da tabela Usuário para os componentes de apresentação}
procedure TfrmUsuario.carrega();
begin
  Self.limpar();

  edCodigo.Text := DM.cdsUsuarioCODIGO.AsString;
  edNome.Text := DM.cdsUsuarioNOME.AsString;
  edLogin.Text := DM.cdsUsuarioLOGIN.AsString;
  edSenha.Text := DM.cdsUsuarioSENHA.AsString;
end;

{dispara uma transação}
procedure TfrmUsuario.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

{limpar componentes}
procedure TfrmUsuario.limpar();
begin
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;

  edCodigo.Clear;
  edNome.Clear;
  edLogin.Clear;
  edSenha.Clear;
end;

{verifica se os campos obrigatórios foram inseridos antes de salvar}
function TfrmUsuario.verificaSalva(): boolean;
var
  campos: String;
  retorno: boolean;
begin

  campos := '';
  retorno := true;

  if (edNome.Text = '')then
    campos := 'Nome';

  if (edLogin.Text = '')then
    begin
    if (campos = '') then
      campos := 'Login'
    else
      campos := campos + ', Login';
    end;

  if (edSenha.Text = '') then
    begin
    if (campos = '') then
      campos := 'Senha'
    else
      campos := campos + ', Senha';
    end;

  if (campos <> '') then
    begin
    MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
    retorno := false;
    end;

    Result := retorno;
end;

{exibe todos os Usuários}
procedure TfrmUsuario.mostraTodosUsuarios();
begin
  DM.qryUsuario.Close;
  DM.qryUsuario.SQL.Clear;
  DM.qryUsuario.SQL.Add('SELECT * From Usuario u ORDER BY u.codigo');
  DM.qryUsuario.Prepared := true;
  DM.qryUsuario.Open;

  DM.cdsUsuario.Open;
  DM.cdsUsuario.Refresh;
end;

{quais componentes exibir/ocultar}
 procedure TfrmUsuario.visibilidade(opc: Integer);
begin

  {
  1 = novo
  11 = editar
  21 = salvar
  31 = excluir
  41 = cancelar
  }

  case opc of
    {novo}
    1: begin
       grpBxDadosUsuario.Enabled := true;
       dbGrdUsuarios.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edNome.SetFocus;
       end;

    {editar}
    11: begin
       grpBxDadosUsuario.Enabled := true;
       dbGrdUsuarios.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edNome.SetFocus;
       end;

    {salvar}
    21: begin
       grpBxDadosUsuario.Enabled := false;
       dbGrdUsuarios.Enabled := true;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;

       mostraTodosUsuarios();
       if (DM.cdsUsuario.RecordCount > 0) then
         begin
         tlBtnEditar.Enabled := true;
         tlBtnExcluir.Enabled := true;
         end
       else
         begin
         tlBtnEditar.Enabled := false;
         tlBtnExcluir.Enabled := false;
         end;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;
       end;

    {excluir}
    31: begin
        grpBxDadosUsuario.Enabled := false;
        pnlPesquisar.Enabled := true;
        tlBtnNovo.Enabled := true;
        tlBtnSalvar.Enabled := false;

        mostraTodosUsuarios();
        if (DM.cdsUsuario.RecordCount > 0) then
          begin
          dbGrdUsuarios.Enabled := true;
          tlBtnEditar.Enabled := true;
          tlBtnExcluir.Enabled := true;
          end
        else
          begin
          dbGrdUsuarios.Enabled := false;
          tlBtnEditar.Enabled := false;
          tlBtnExcluir.Enabled := false;
          end;
        tlBtnCancelar.Enabled := false;
        end;

    {cancelar}
    41: begin
       grpBxDadosUsuario.Enabled := false;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;

       mostraTodosUsuarios();
       if (DM.cdsUsuario.RecordCount > 0) then
         begin
         dbGrdUsuarios.Enabled := true;
         tlBtnEditar.Enabled := true;
         tlBtnExcluir.Enabled := true;
         end
       else
         begin
         dbGrdUsuarios.Enabled := false;
         tlBtnEditar.Enabled := false;
         tlBtnExcluir.Enabled := false;
         end;
       end;

  end;//case


end;

(*FIM PROCEDURES DE CONTROLE*)


procedure TfrmUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (fechar = false) then
    begin
    MessageDlg('Salve ou cancele antes o processo que se encontra em operação!',mtInformation,[mbOK],0);
    Action := caNone;
    end

  else
  operacao := '';

end;

procedure TfrmUsuario.FormShow(Sender: TObject);
begin
  limpar();
  try
    mostraTodosUsuarios();
    DM.cdsUsuario.First;
    carrega();
  except
  end;

  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);

  if (operacao = 'novo') then
    tlBtnNovoClick(Sender);
end;

procedure TfrmUsuario.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  fechar := false;
  opcaoSalvar := 1;//novo
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';
  visibilidade(1);
end;

procedure TfrmUsuario.tlBtnEditarClick(Sender: TObject);
begin
  {preparando}
  visibilidade(11);
  edNome.SetFocus;
  opcaoSalvar := 2;//editar
  fechar := false;
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Edição';
end;

procedure TfrmUsuario.tlBtnExcluirClick(Sender: TObject);
var
  codigo: Integer;
begin
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Excluir';

  codigo := StrToInt(edCodigo.Text);
  if (codigo<>1)then
    begin
    if (MessageDlg('Deseja deletar o Usuário ' +#13 + DM.cdsUsuarioNOME.AsString + '?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
      begin
      try
        iniciaTransacao();
        DM.SQLConnection.StartTransaction(transacao);
        (*deletando*)
        DM.qryUsuario.Close;
        DM.qryUsuario.SQL.Clear;
        DM.qryUsuario.SQL.Add('DELETE FROM Usuario WHERE codigo = :cod');
        DM.qryUsuario.ParamByName('cod').AsInteger := codigo;
        DM.qryUsuario.Prepared := true;
        DM.qryUsuario.ExecSQL();

        DM.SQLConnection.Commit(transacao);

        {selecionando todos os Usuários}
        mostraTodosUsuarios();
        {atualizando ClientDataSet}
        DM.cdsUsuario.Last;
        carrega();
        StatusBar.Panels[1].Text := '';
        visibilidade(31);

      except
        MessageDlg('Usuário não pode ser deletado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
        DM.SQLConnection.Rollback(transacao);
      end;

      end
    else
      begin
      {selecionando todos os Usuários}
      mostraTodosUsuarios();
      {atualizando ClientDataSet}
      DM.cdsUsuario.Last;
      carrega();
      StatusBar.Panels[1].Text := '';
      visibilidade(41);
      end;
    end

  else//<>1
    begin
    MessageDlg('Usuário administrador não pode ser deletado!',mtInformation,[mbOK],0);
    {selecionando todos os Usuários}
    mostraTodosUsuarios();
    {atualizando ClientDataSet}
    DM.cdsUsuario.Last;
    carrega();
    StatusBar.Panels[1].Text := '';
    visibilidade(41);
    end;
end;


procedure TfrmUsuario.tlBtnCancelarClick(Sender: TObject);
begin
  limpar();
  mostraTodosUsuarios();
  DM.cdsUsuario.Last;
  carrega();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmUsuario.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmUsuario.rdBtnNomeClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmUsuario.edPesquisaChange(Sender: TObject);
begin
  if (edPesquisa.Text = '')then
    btBtnPesquisar.Enabled := false;

  if(edPesquisa.Text <> '')then
    begin
    if((rdBtnCodigo.Checked = true)or(rdBtnNome.Checked = true))then
      btBtnPesquisar.Enabled := true
    else
      btBtnPesquisar.Enabled := false;
    end;
end;

procedure TfrmUsuario.edPesquisaEnter(Sender: TObject);
begin
  edPesquisa.Color := clMoneyGreen;
end;

procedure TfrmUsuario.edPesquisaExit(Sender: TObject);
begin
  edPesquisa.Color := clWindow;
end;

procedure TfrmUsuario.edPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=13) then
    btBtnPesquisarClick(Sender);
end;

procedure TfrmUsuario.edPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmUsuario.btBtnPesquisarClick(Sender: TObject);
begin
  {código}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.qryUsuario.Close;
    DM.qryUsuario.SQL.Clear;
    DM.qryUsuario.SQL.Add('SELECT * FROM Usuario u WHERE u.codigo=:cod ');
    DM.qryUsuario.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.qryUsuario.Prepared := true;
    DM.qryUsuario.Open;

    DM.cdsUsuario.Refresh;

    if (DM.cdsUsuario.RecordCount = 0) then
      begin
      MessageDlg('Nenhum Usuário encontrado com o código '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosUsuarios();
      end;
    end;

  {nome}
  if (rdBtnNome.Checked = true) then
    begin
    DM.qryUsuario.Close;
    DM.qryUsuario.SQL.Clear;
    DM.qryUsuario.SQL.Add('SELECT * FROM Usuario u WHERE u.nome LIKE '+QuotedStr('%'+edPesquisa.Text+'% '));
    DM.qryUsuario.Prepared := true;
    DM.qryUsuario.Open;

    DM.cdsUsuario.Refresh;

    if (DM.cdsUsuario.RecordCount = 0) then
      begin
      MessageDlg('Nenhum Usuário encontrado com o nome '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosUsuarios();
      end;
    end;

  DM.cdsUsuario.Last;
  carrega();

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmUsuario.dbGrdUsuariosCellClick(Column: TColumn);
begin
  carrega();
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Navegação';

  tlBtnNovo.Enabled := true;
  tlBtnSalvar.Enabled := false;
  tlBtnCancelar.Enabled := false;
end;

procedure TfrmUsuario.edCodigoEnter(Sender: TObject);
begin
  edCodigo.Color := clMoneyGreen;
end;

procedure TfrmUsuario.edNomeEnter(Sender: TObject);
begin
  edNome.Color := clMoneyGreen;
end;

procedure TfrmUsuario.edLoginEnter(Sender: TObject);
begin
  edLogin.Color := clMoneyGreen;
end;

procedure TfrmUsuario.edSenhaEnter(Sender: TObject);
begin
  edSenha.Color := clMoneyGreen;
end;

procedure TfrmUsuario.edSenhaExit(Sender: TObject);
begin
  edSenha.Color := clWindow;
end;

procedure TfrmUsuario.edLoginExit(Sender: TObject);
begin
  edLogin.Color := clWindow;
end;

procedure TfrmUsuario.edNomeExit(Sender: TObject);
begin
  edNome.Color := clWindow;
end;

procedure TfrmUsuario.edCodigoExit(Sender: TObject);
begin
  edCodigo.Color := clWindow;
end;

procedure TfrmUsuario.tlBtnSalvarClick(Sender: TObject);
begin
  if (verificaSalva = true) then
    begin
    case opcaoSalvar of
      1: begin //novo
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryUsuario.Close;
         DM.qryUsuario.SQL.Clear;
         DM.qryUsuario.SQL.Add('INSERT INTO Usuario (nome,login,senha) ');
         DM.qryUsuario.SQL.Add('VALUES (:nom,:log,:sen)');
         DM.qryUsuario.ParamByName('nom').AsString := edNome.Text;
         DM.qryUsuario.ParamByName('log').AsString := edLogin.Text;
         DM.qryUsuario.ParamByName('sen').AsString := edSenha.Text;
         DM.qryUsuario.Prepared := true;
         DM.qryUsuario.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         MessageDlg('Usuário salvo com sucesso!',mtInformation,[mbOk],0);
         fechar := true;
         except
           MessageDlg('Usuário não pode ser salvo!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           DM.SQLConnection.Rollback(transacao);
         end;

         end;

      2: begin //editar
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryUsuario.Close;
         DM.qryUsuario.SQL.Clear;
         DM.qryUsuario.SQL.Add('UPDATE Usuario SET nome=:nom,login=:log,senha=:sen ');
         DM.qryUsuario.SQL.Add('WHERE codigo=:cod');
         DM.qryUsuario.ParamByName('nom').AsString := edNome.Text;
         DM.qryUsuario.ParamByName('log').AsString := edLogin.Text;
         DM.qryUsuario.ParamByName('sen').AsString := edSenha.Text;
         DM.qryUsuario.ParamByName('cod').AsInteger := StrToInt(edCodigo.Text);
         DM.qryUsuario.Prepared := true;
         DM.qryUsuario.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         MessageDlg('Usuário editado com sucesso!',mtInformation,[mbOk],0);
         fechar := true;
         except
           MessageDlg('Usuário não pode ser editado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           DM.SQLConnection.Rollback(transacao);
         end;

         end;

    end;//case
    {selecionando todos os Usuários}
    mostraTodosUsuarios();
    {atualizando ClientDataSet}
    DM.cdsUsuario.Last;
    carrega();
    StatusBar.Panels[1].Text := 'OPERAÇÃO = Salvar';
    visibilidade(21);
  end;//if
end;


procedure TfrmUsuario.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmUsuario.ppMnMostrarTodosProdutosClick(Sender: TObject);
begin
  limpar();
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;
  mostraTodosUsuarios();
  DM.cdsUsuario.Last;
  carrega();
end;

end.
