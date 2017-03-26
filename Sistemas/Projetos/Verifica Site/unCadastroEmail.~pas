unit unCadastroEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ImgList, ComCtrls, StdCtrls, Grids, DBGrids,
  Buttons, ExtCtrls, ToolWin, Mask;

type
  TfrmCadastroEmails = class(TForm)
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnEditar: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnExcluir: TToolButton;
    tlBtnCancelar: TToolButton;
    pnlPesquisar: TPanel;
    lblPesquisar: TLabel;
    rdBtnCodigo: TRadioButton;
    rdBtnE_MailPara: TRadioButton;
    btBtnPesquisar: TBitBtn;
    edPesquisa: TEdit;
    dbGrdE_Mail: TDBGrid;
    grpBxDadosEmail: TGroupBox;
    lblCodigo: TLabel;
    lblHost: TLabel;
    edCodigo: TEdit;
    edHost: TEdit;
    StatusBar: TStatusBar;
    imgLista: TImageList;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosE_Mails: TMenuItem;
    lblPorta: TLabel;
    lblEmailPara: TLabel;
    lblEmailDe: TLabel;
    lblNomeDe: TLabel;
    lblSenhaDe: TLabel;
    edPorta: TEdit;
    edEmailPara: TEdit;
    edEmailDe: TEdit;
    edNomeDe: TEdit;
    edSenhaDe: TEdit;
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnE_MailParaClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaEnter(Sender: TObject);
    procedure edPesquisaExit(Sender: TObject);
    procedure edPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure dbGrdE_MailCellClick(Column: TColumn);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure ppMnMostrarTodosE_MailsClick(Sender: TObject);
    procedure edCodigoEnter(Sender: TObject);
    procedure edHostEnter(Sender: TObject);
    procedure edPortaEnter(Sender: TObject);
    procedure edEmailParaEnter(Sender: TObject);
    procedure edEmailDeEnter(Sender: TObject);
    procedure edNomeDeEnter(Sender: TObject);
    procedure edSenhaDeEnter(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure edHostExit(Sender: TObject);
    procedure edPortaExit(Sender: TObject);
    procedure edEmailParaExit(Sender: TObject);
    procedure edEmailDeExit(Sender: TObject);
    procedure edNomeDeExit(Sender: TObject);
    procedure edSenhaDeExit(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    opcaoSalvar: Integer; //modo de salvamento. 1=novo; 2=edição
    fechar: boolean; //se pode ou não fechar tela - casos de novo/editar, em que não pode fechar

    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
    function verificaSalva(): boolean; //verifica se os campos obrigatórios foram inseridos antes de salvar
    procedure visibilidade(opc: Integer);//quais componentes exibir/ocultar
    procedure carrega();//carrega dados da tabela Envia_Email para os componentes de apresentação
    procedure mostraTodosEmails();//exibe todos os E-Mails
  public

  end;

var
  frmCadastroEmails: TfrmCadastroEmails;

implementation

uses unDM;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{carrega dados da tabela Envia_Email para os componentes de apresentação}
procedure TfrmCadastroEmails.carrega();
begin
  Self.limpar();
  edCodigo.Text := DM.zQryEnviaEmailCODIGO.AsString;
  edHost.Text := DM.zQryEnviaEmailHOST.AsString;
  edPorta.Text := DM.zQryEnviaEmailPORTA.AsString;
  edEmailPara.Text := DM.zQryEnviaEmailEMAIL_PARA.AsString;
  edEmailDe.Text := DM.zQryEnviaEmailEMAIL_DE.AsString;
  edNomeDe.Text := DM.zQryEnviaEmailNOME_DE.AsString;
  edSenhaDe.Text := DM.zQryEnviaEmailSENHA_DE.AsString;
end;

{limpar componentes}
procedure TfrmCadastroEmails.limpar();
begin
  edCodigo.Clear;
  edHost.Clear;
  edPorta.Clear;
  edEmailPara.Clear;
  edEmailDe.Clear;
  edNomeDe.Clear;
  edSenhaDe.Clear;
end;

{verifica se os campos obrigatórios foram inseridos antes de salvar}
function TfrmCadastroEmails.verificaSalva(): boolean;
var
  campos: String;
  retorno: boolean;
begin

  campos := '';
  retorno := true;

  if (edHost.Text = '')then
    campos := 'Host';

  if (edPorta.Text = '')then
    begin
    if(campos='')then
      campos := 'Porta'
    else
      campos := campos + ', Porta';
    end;

  if (edEmailPara.Text = '')then
    begin
    if(campos='')then
      campos := 'E-Mail Para'
    else
      campos := campos + ', E-Mail Para';
    end;

  if (edEmailDe.Text = '')then
    begin
    if(campos='')then
      campos := 'E-Mail De'
    else
      campos := campos + ', E-Mail De';
    end;

  if (edNomeDe.Text = '')then
    begin
    if(campos='')then
      campos := 'Nome De'
    else
      campos := campos + ', Nome De';
    end;

  if (edSenhaDe.Text = '')then
    begin
    if(campos='')then
      campos := 'Senha De'
    else
      campos := campos + ', Senha De';
    end;

  if (campos <> '') then
    begin
    MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
    retorno := false;
    end;

  Result := retorno;
end;

{exibe todos os E-Mails}
procedure TfrmCadastroEmails.mostraTodosEmails();
begin
  DM.zQryEnviaEmail.Close;
  DM.zQryEnviaEmail.SQL.Clear;
  DM.zQryEnviaEmail.SQL.Add('SELECT * From Envia_Email e ');
  DM.zQryEnviaEmail.Open;
  DM.zQryEnviaEmail.Refresh;
end;

{quais componentes exibir/ocultar}
 procedure TfrmCadastroEmails.visibilidade(opc: Integer);
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
       grpBxDadosEmail.Enabled := true;
       dbGrdE_Mail.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edHost.SetFocus;
       end;

    {editar}
    11: begin
       grpBxDadosEmail.Enabled := true;
       dbGrdE_Mail.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edHost.SetFocus;
       end;

    {salvar}
    21: begin
       grpBxDadosEmail.Enabled := false;
       dbGrdE_Mail.Enabled := true;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;

       mostraTodosEmails();
       if (DM.zQryEnviaEmail.RecordCount > 0) then
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
        grpBxDadosEmail.Enabled := false;
        pnlPesquisar.Enabled := true;
        tlBtnNovo.Enabled := true;
        tlBtnSalvar.Enabled := false;

        mostraTodosEmails();
        if (DM.zQryEnviaEmail.RecordCount > 0) then
          begin
          dbGrdE_Mail.Enabled := true;
          tlBtnEditar.Enabled := true;
          tlBtnExcluir.Enabled := true;
          end
        else
          begin
          dbGrdE_Mail.Enabled := false;
          tlBtnEditar.Enabled := false;
          tlBtnExcluir.Enabled := false;
          end;
        tlBtnCancelar.Enabled := false;
        end;

    {cancelar}
    41: begin
       grpBxDadosEmail.Enabled := false;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;

       mostraTodosEmails();
       if (DM.zQryEnviaEmail.RecordCount > 0) then
         begin
         dbGrdE_Mail.Enabled := true;
         tlBtnEditar.Enabled := true;
         tlBtnExcluir.Enabled := true;
         end
       else
         begin
         dbGrdE_Mail.Enabled := false;
         tlBtnEditar.Enabled := false;
         tlBtnExcluir.Enabled := false;
         end;
       end;    
  end;//case
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmCadastroEmails.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  fechar := false;
  opcaoSalvar := 1;//novo
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';
  visibilidade(1);
end;

procedure TfrmCadastroEmails.tlBtnEditarClick(Sender: TObject);
begin
  {preparando}
  visibilidade(11);
  edHost.SetFocus;
  opcaoSalvar := 2;//editar
  fechar := false;
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Edição';
end;

procedure TfrmCadastroEmails.tlBtnCancelarClick(Sender: TObject);
begin
  limpar();
  mostraTodosEmails();
  DM.zQryEnviaEmail.Last;
  carrega();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmCadastroEmails.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmCadastroEmails.rdBtnE_MailParaClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmCadastroEmails.edPesquisaChange(Sender: TObject);
begin
  if (edPesquisa.Text = '')then
    btBtnPesquisar.Enabled := false;

  if(edPesquisa.Text <> '')then
    begin
    if((rdBtnCodigo.Checked = true)or(rdBtnE_MailPara.Checked = true))then
      btBtnPesquisar.Enabled := true
    else
      btBtnPesquisar.Enabled := false;
    end;
end;

procedure TfrmCadastroEmails.edPesquisaEnter(Sender: TObject);
begin
  edPesquisa.Color := clMoneyGreen;
end;

procedure TfrmCadastroEmails.edPesquisaExit(Sender: TObject);
begin
  edPesquisa.Color := clWindow;
end;

procedure TfrmCadastroEmails.edPesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=13) then
    btBtnPesquisarClick(Sender);
end;

procedure TfrmCadastroEmails.edPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmCadastroEmails.btBtnPesquisarClick(Sender: TObject);
begin
  {código}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.zQryEnviaEmail.Close;
    DM.zQryEnviaEmail.SQL.Clear;
    DM.zQryEnviaEmail.SQL.Add('SELECT * FROM envia_email WHERE codigo=:cod ');
    DM.zQryEnviaEmail.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.zQryEnviaEmail.Open;
    DM.zQryEnviaEmail.Refresh;

    if (DM.zQryEnviaEmail.RecordCount = 0) then
      begin
      MessageDlg('Nenhum E-mail encontrado com o código '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosEmails();
      end;
    end;

  {nome}
  if (rdBtnE_MailPara.Checked = true) then
    begin
    DM.zQryEnviaEmail.Close;
    DM.zQryEnviaEmail.SQL.Clear;
    DM.zQryEnviaEmail.SQL.Add('SELECT * FROM envia_email WHERE email_para LIKE '+QuotedStr('%'+edPesquisa.Text+'%'));
    DM.zQryEnviaEmail.Open;
    DM.zQryEnviaEmail.Refresh;

    if (DM.zQryEnviaEmail.RecordCount = 0) then
      begin
      MessageDlg('Nenhum E-Mail encontrado com o nome '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosEmails();
      end;
    end;
  DM.zQryEnviaEmail.Last;
  carrega();

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmCadastroEmails.dbGrdE_MailCellClick(Column: TColumn);
begin
  carrega();
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Navegação';

  tlBtnNovo.Enabled := true;
  tlBtnSalvar.Enabled := false;
  tlBtnCancelar.Enabled := false;
end;

procedure TfrmCadastroEmails.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmCadastroEmails.ppMnMostrarTodosE_MailsClick(Sender: TObject);
begin
  limpar();
  rdBtnCodigo.Checked := false;
  rdBtnE_MailPara.Checked := false;
  edPesquisa.Clear;
  mostraTodosEmails();
  DM.zQryEnviaEmail.Last;
  carrega();
end;

procedure TfrmCadastroEmails.edCodigoEnter(Sender: TObject);
begin
  edCodigo.Color := clMoneyGreen;
end;

procedure TfrmCadastroEmails.edHostEnter(Sender: TObject);
begin
  edHost.Color := clMoneyGreen;
end;

procedure TfrmCadastroEmails.edPortaEnter(Sender: TObject);
begin
  edPorta.Color := clMoneyGreen;
end;

procedure TfrmCadastroEmails.edEmailParaEnter(Sender: TObject);
begin
  edEmailPara.Color := clMoneyGreen;
end;

procedure TfrmCadastroEmails.edEmailDeEnter(Sender: TObject);
begin
  edEmailDe.Color := clMoneyGreen;
end;

procedure TfrmCadastroEmails.edNomeDeEnter(Sender: TObject);
begin
  edNomeDe.Color := clMoneyGreen;
end;

procedure TfrmCadastroEmails.edSenhaDeEnter(Sender: TObject);
begin
  edSenhaDe.Color := clMoneyGreen;
end;

procedure TfrmCadastroEmails.edCodigoExit(Sender: TObject);
begin
  edCodigo.Color := clWindow;
end;

procedure TfrmCadastroEmails.edHostExit(Sender: TObject);
begin
  edHost.Color := clWindow;
end;

procedure TfrmCadastroEmails.edPortaExit(Sender: TObject);
begin
  edPorta.Color := clWindow;
end;

procedure TfrmCadastroEmails.edEmailParaExit(Sender: TObject);
begin
  edEmailPara.Color := clWindow;
end;

procedure TfrmCadastroEmails.edEmailDeExit(Sender: TObject);
begin
  edEmailDe.Color := clWindow;
end;

procedure TfrmCadastroEmails.edNomeDeExit(Sender: TObject);
begin
  edNomeDe.Color := clWindow;
end;

procedure TfrmCadastroEmails.edSenhaDeExit(Sender: TObject);
begin
  edSenhaDe.Color := clWindow;
end;

procedure TfrmCadastroEmails.tlBtnExcluirClick(Sender: TObject);
var
  codigo: Integer;
begin
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Excluir';

  if (MessageDlg('Deseja deletar o E-Mail ' +#13 + DM.zQryEnviaEmailEMAIL_PARA.AsString + '?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
    try
      codigo := StrToInt(edCodigo.Text);

      DM.ZConnection.StartTransaction();
      (*deletando*)
      DM.zQryEnviaEmail.Close;
      DM.zQryEnviaEmail.SQL.Clear;
      DM.zQryEnviaEmail.SQL.Add('DELETE FROM envia_email WHERE codigo = :cod');
      DM.zQryEnviaEmail.ParamByName('cod').AsInteger := codigo;
      DM.zQryEnviaEmail.ExecSQL();

      DM.ZConnection.Commit();

      {selecionando todos os E-Mails}
      mostraTodosEmails();
      {atualizando query}
      DM.zQryEnviaEmail.Last;
      carrega();
      StatusBar.Panels[1].Text := '';
      visibilidade(31);

    except
      MessageDlg('E-Mail não pode ser deletado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
      DM.ZConnection.Rollback();
    end;
    end

  else
    begin
    {selecionando todos os emails}
    mostraTodosEmails();
    {atualizando query}
    DM.zQryEnviaEmail.Last;
    carrega();
    StatusBar.Panels[1].Text := '';
    visibilidade(41);
    end;  
end;

procedure TfrmCadastroEmails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (fechar = false) then
    begin
    MessageDlg('Salve ou cancele antes o processo que se encontra em operação!',mtInformation,[mbOK],0);
    Action := caNone;
    end;
end;

procedure TfrmCadastroEmails.FormShow(Sender: TObject);
begin
  limpar();
  rdBtnCodigo.Checked := false;
  rdBtnE_MailPara.Checked := false;
  edPesquisa.Clear;
  try
    mostraTodosEmails();
    DM.zQryEnviaEmail.First;
    carrega();
  except
  end;

  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmCadastroEmails.tlBtnSalvarClick(Sender: TObject);
begin
  if (verificaSalva = true) then
    begin
    case opcaoSalvar of
      1: begin //novo
         try
         DM.ZConnection.StartTransaction();

         DM.zQryEnviaEmail.Close;
         DM.zQryEnviaEmail.SQL.Clear;
         DM.zQryEnviaEmail.SQL.Add('INSERT INTO Envia_Email (host,porta,email_para,email_de,nome_de,senha_de) ');
         DM.zQryEnviaEmail.SQL.Add('VALUES (:hos,:por,:em_pa,:em_de,:no_de,:se_de) ');
         DM.zQryEnviaEmail.ParamByName('hos').AsString := edHost.Text;
         DM.zQryEnviaEmail.ParamByName('por').AsString := edPorta.Text;
         DM.zQryEnviaEmail.ParamByName('em_pa').AsString := edEmailPara.Text;
         DM.zQryEnviaEmail.ParamByName('em_de').AsString := edEmailDe.Text;
         DM.zQryEnviaEmail.ParamByName('no_de').AsString := edNomeDe.Text;
         DM.zQryEnviaEmail.ParamByName('se_de').AsString := edSenhaDe.Text;
         DM.zQryEnviaEmail.ExecSQL();

         DM.ZConnection.Commit();
         MessageDlg('E-Mail cadastrado com sucesso!',mtInformation,[mbOK],0);
         fechar := true;
         except
           MessageDlg('E-Mail não pode ser salvo!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           fechar := true;
           DM.ZConnection.Rollback();
         end;
         end;

       2: begin //editar
         try
         DM.ZConnection.StartTransaction();

         DM.zQryEnviaEmail.Close;
         DM.zQryEnviaEmail.SQL.Clear;
         DM.zQryEnviaEmail.SQL.Add('UPDATE Envia_Email SET host=:hos,porta=:por,email_para=:em_pa,email_de=:em_de, ');
         DM.zQryEnviaEmail.SQL.Add('nome_de=:no_de,senha_de=:se_de WHERE codigo=:cod');
         DM.zQryEnviaEmail.ParamByName('hos').AsString := edHost.Text;
         DM.zQryEnviaEmail.ParamByName('por').AsString := edPorta.Text;
         DM.zQryEnviaEmail.ParamByName('em_pa').AsString := edEmailPara.Text;
         DM.zQryEnviaEmail.ParamByName('em_de').AsString := edEmailDe.Text;
         DM.zQryEnviaEmail.ParamByName('no_de').AsString := edNomeDe.Text;
         DM.zQryEnviaEmail.ParamByName('se_de').AsString := edSenhaDe.Text;
         DM.zQryEnviaEmail.ParamByName('cod').AsInteger := StrToInt(edCodigo.Text);
         DM.zQryEnviaEmail.ExecSQL();
         DM.ZConnection.Commit();
         MessageDlg('E-Mail editado com sucesso!',mtInformation,[mbOK],0);
         fechar := true;
         except
           MessageDlg('E-Mail não pode ser editado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           fechar := true;           
           DM.ZConnection.Rollback();
         end;
         end;

    end;//case
      {selecionando todos os E-Mails}
      mostraTodosEmails();
      {atualizando ClientDataSet}
      DM.zQryEnviaEmail.Last;
      carrega();
      StatusBar.Panels[1].Text := 'OPERAÇÃO = Salvar';
      visibilidade(21);
    end;//if
end;

end.
