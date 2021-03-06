unit unCadastroSite;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, SqlExpr, Provider, DB, DBClient, Menus, AppEvnts,
  ImgList, ComCtrls, Mask, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls,
  ToolWin;

type
  TfrmCadastroSite = class(TForm)
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnEditar: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnExcluir: TToolButton;
    tlBtnCancelar: TToolButton;
    pnlPesquisar: TPanel;
    lblPesquisar: TLabel;
    rdBtnCodigo: TRadioButton;
    rdBtnNome: TRadioButton;
    btBtnPesquisar: TBitBtn;
    edPesquisa: TEdit;
    dbGrdSites: TDBGrid;
    grpBxDadosSite: TGroupBox;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    lblSite: TLabel;
    lblStatus: TLabel;
    lblDtAtivacao: TLabel;
    edCodigo: TEdit;
    edSite: TEdit;
    StatusBar: TStatusBar;
    imgLista: TImageList;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosClientes: TMenuItem;
    mmDescricao: TMemo;
    cbBxStatus: TComboBox;
    lblDataAtivacao: TLabel;
    AdicionarEnvioEMail1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnNomeClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaEnter(Sender: TObject);
    procedure edPesquisaExit(Sender: TObject);
    procedure edPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure dbGrdSitesCellClick(Column: TColumn);
    procedure edCodigoEnter(Sender: TObject);
    procedure edSiteEnter(Sender: TObject);
    procedure mmDescricaoEnter(Sender: TObject);
    procedure cbBxStatusEnter(Sender: TObject);
    procedure cbBxStatusExit(Sender: TObject);
    procedure mmDescricaoExit(Sender: TObject);
    procedure edSiteExit(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure ppMnMostrarTodosClientesClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure AdicionarEnvioEMail1Click(Sender: TObject);
  private
    (*VARI�VEIS DE CONTROLE*)
    opcaoSalvar: Integer; //modo de salvamento. 1=novo; 2=edi��o
    fechar: boolean; //se pode ou n�o fechar tela - casos de novo/editar, em que n�o pode fechar

    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
    function verificaSalva(): boolean; //verifica se os campos obrigat�rios foram inseridos antes de salvar
    procedure visibilidade(opc: Integer);//quais componentes exibir/ocultar
    procedure carrega();//carrega dados da tabela Site para os componentes de apresenta��o
    procedure mostraTodosSites();//exibe todos os Sites
  public

  end;

var
  frmCadastroSite: TfrmCadastroSite;

implementation

uses unDM, unSelecionaEmailParaSite, unSelecionaEmailEnviar;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{carrega dados da tabela Site para os componentes de apresenta��o}
procedure TfrmCadastroSite.carrega();
begin
  Self.limpar();
  edCodigo.Text := DM.zQrySiteCODIGO.AsString;
  edSite.Text := DM.zQrySiteSITE.AsString;
  mmDescricao.Text := DM.zQrySiteDESCRICAO.AsString;
  if(DM.zQrySiteSTATUS.AsInteger=0)then
    cbBxStatus.ItemIndex := 0
  else if(DM.zQrySiteSTATUS.AsInteger=1)then
    cbBxStatus.ItemIndex := 1
  else
    cbBxStatus.ItemIndex := -1;
  lblDataAtivacao.Caption := DM.zQrySiteDATA_ATIVACAO.AsString;
end;

{limpar componentes}
procedure TfrmCadastroSite.limpar();
begin
  edCodigo.Clear;
  edSite.Clear;
  mmDescricao.Clear;
  cbBxStatus.ItemIndex := -1;
  lblDataAtivacao.Caption := '';
end;

{verifica se os campos obrigat�rios foram inseridos antes de salvar}
function TfrmCadastroSite.verificaSalva(): boolean;
var
  campos: String;
  retorno: boolean;
begin

  campos := '';
  retorno := true;

  if (edSite.Text = '')then
    campos := 'Site';

  if (campos <> '') then
    begin
    MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
    retorno := false;
    end

  else
    begin
    (*verificando se existe site com o nome j� cadastrado*)
      DM.zQrySite.Close;
      DM.zQrySite.SQL.Clear;
      DM.zQrySite.SQL.Add('SELECT * FROM site WHERE site=:sit AND status=0');
      DM.zQrySite.ParamByName('sit').AsString := edSite.Text;
      DM.zQrySite.Open;
      DM.zQrySite.Refresh;
      if (DM.zQrySite.RecordCount <> 0) then
        begin
        retorno := false;
        if (MessageDlg('Site com este nome j� cadastrado, deseja continuar?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
          retorno := true;
        end;
    end;

    Result := retorno;
end;

{exibe todos os Sites}
procedure TfrmCadastroSite.mostraTodosSites();
begin
  DM.zQrySite.Close;
  DM.zQrySite.SQL.Clear;
  DM.zQrySite.SQL.Add('SELECT * From Site s ');
  DM.zQrySite.Open;
  DM.zQrySite.Refresh;
end;

{quais componentes exibir/ocultar}
 procedure TfrmCadastroSite.visibilidade(opc: Integer);
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
       grpBxDadosSite.Enabled := true;
       dbGrdSites.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edSite.SetFocus;
       end;

    {editar}
    11: begin
       grpBxDadosSite.Enabled := true;
       dbGrdSites.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edSite.SetFocus;       
       end;

    {salvar}
    21: begin
       grpBxDadosSite.Enabled := false;
       dbGrdSites.Enabled := true;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;

       mostraTodosSites();
       if (DM.zQrySite.RecordCount > 0) then
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
        grpBxDadosSite.Enabled := false;
        pnlPesquisar.Enabled := true;
        tlBtnNovo.Enabled := true;
        tlBtnSalvar.Enabled := false;

        mostraTodosSites();
        if (DM.zQrySite.RecordCount > 0) then
          begin
          dbGrdSites.Enabled := true;
          tlBtnEditar.Enabled := true;
          tlBtnExcluir.Enabled := true;
          end
        else
          begin
          dbGrdSites.Enabled := false;
          tlBtnEditar.Enabled := false;
          tlBtnExcluir.Enabled := false;
          end;
        tlBtnCancelar.Enabled := false;
        end;

    {cancelar}
    41: begin
       grpBxDadosSite.Enabled := false;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;

       mostraTodosSites();
       if (DM.zQrySite.RecordCount > 0) then
         begin
         dbGrdSites.Enabled := true;
         tlBtnEditar.Enabled := true;
         tlBtnExcluir.Enabled := true;
         end
       else
         begin
         dbGrdSites.Enabled := false;
         tlBtnEditar.Enabled := false;
         tlBtnExcluir.Enabled := false;
         end;
       end;

  end;//case
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmCadastroSite.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (fechar = false) then
    begin
    MessageDlg('Salve ou cancele antes o processo que se encontra em opera��o!',mtInformation,[mbOK],0);
    Action := caNone;
    end;
end;

procedure TfrmCadastroSite.FormShow(Sender: TObject);
begin
  limpar();
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;  
  try
    mostraTodosSites();
    DM.zQrySite.First;
    carrega();
  except
  end;

  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmCadastroSite.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  fechar := false;
  opcaoSalvar := 1;//novo
  StatusBar.Panels[1].Text := 'OPERA��O = Novo';
  visibilidade(1);
end;

procedure TfrmCadastroSite.tlBtnEditarClick(Sender: TObject);
begin
  {preparando}
  visibilidade(11);
  edSite.SetFocus;
  opcaoSalvar := 2;//editar
  fechar := false;
  StatusBar.Panels[1].Text := 'OPERA��O = Edi��o';
end;

procedure TfrmCadastroSite.tlBtnCancelarClick(Sender: TObject);
begin
  limpar();
  mostraTodosSites();
  DM.zQrySite.Last;
  carrega();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmCadastroSite.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmCadastroSite.rdBtnNomeClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmCadastroSite.edPesquisaChange(Sender: TObject);
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

procedure TfrmCadastroSite.edPesquisaEnter(Sender: TObject);
begin
  edPesquisa.Color := clMoneyGreen;
end;

procedure TfrmCadastroSite.edPesquisaExit(Sender: TObject);
begin
  edPesquisa.Color := clWindow;
end;

procedure TfrmCadastroSite.edPesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=13) then
    btBtnPesquisarClick(Sender);
end;

procedure TfrmCadastroSite.edPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmCadastroSite.dbGrdSitesCellClick(Column: TColumn);
begin
  carrega();
  StatusBar.Panels[1].Text := 'OPERA��O = Navega��o';

  tlBtnNovo.Enabled := true;
  tlBtnSalvar.Enabled := false;
  tlBtnCancelar.Enabled := false;
end;

procedure TfrmCadastroSite.edCodigoEnter(Sender: TObject);
begin
  edCodigo.Color := clMoneyGreen;
end;

procedure TfrmCadastroSite.edSiteEnter(Sender: TObject);
begin
  edSite.Color := clMoneyGreen;
end;

procedure TfrmCadastroSite.mmDescricaoEnter(Sender: TObject);
begin
  mmDescricao.Color := clMoneyGreen;
end;

procedure TfrmCadastroSite.cbBxStatusEnter(Sender: TObject);
begin
  cbBxStatus.Color := clMoneyGreen;
end;

procedure TfrmCadastroSite.cbBxStatusExit(Sender: TObject);
begin
  cbBxStatus.Color := clWindow;
end;

procedure TfrmCadastroSite.mmDescricaoExit(Sender: TObject);
begin
  mmDescricao.Color := clWindow;
end;

procedure TfrmCadastroSite.edSiteExit(Sender: TObject);
begin
  edSite.Color := clWindow;
end;

procedure TfrmCadastroSite.edCodigoExit(Sender: TObject);
begin
  edCodigo.Color := clWindow;
end;

procedure TfrmCadastroSite.btBtnPesquisarClick(Sender: TObject);
begin
  {c�digo}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.zQrySite.Close;
    DM.zQrySite.SQL.Clear;
    DM.zQrySite.SQL.Add('SELECT * FROM site WHERE codigo=:cod ');
    DM.zQrySite.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.zQrySite.Open;
    DM.zQrySite.Refresh;

    if (DM.zQrySite.RecordCount = 0) then
      begin
      MessageDlg('Nenhum Site encontrado com o c�digo '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosSites();
      end;
    end;

  {nome}
  if (rdBtnNome.Checked = true) then
    begin
    DM.zQrySite.Close;
    DM.zQrySite.SQL.Clear;
    DM.zQrySite.SQL.Add('SELECT * FROM site WHERE site LIKE '+QuotedStr('%'+edPesquisa.Text+'%'));
    DM.zQrySite.Open;
    DM.zQrySite.Refresh;

    if (DM.zQrySite.RecordCount = 0) then
      begin
      MessageDlg('Nenhum Site encontrado com o nome '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosSites();
      end;
    end;

  DM.zQrySite.Last;
  carrega();

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmCadastroSite.tlBtnExcluirClick(Sender: TObject);
var
  codigo: Integer;
begin
  StatusBar.Panels[1].Text := 'OPERA��O = Excluir';

  if (MessageDlg('Deseja deletar o Site ' +#13 + DM.zQrySiteSITE.AsString + '?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
    try
      codigo := StrToInt(edCodigo.Text);

      DM.ZConnection.StartTransaction();
      (*deletando*)
      DM.zQrySite.Close;
      DM.zQrySite.SQL.Clear;
      DM.zQrySite.SQL.Add('DELETE FROM site WHERE codigo = :cod');
      DM.zQrySite.ParamByName('cod').AsInteger := codigo;
      DM.zQrySite.ExecSQL();

      DM.ZConnection.Commit();

      {selecionando todos os Sites}
      mostraTodosSites();
      {atualizando query}
      DM.zQrySite.Last;
      carrega();
      StatusBar.Panels[1].Text := '';
      visibilidade(31);

    except
      MessageDlg('Site n�o pode ser deletado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
      DM.ZConnection.Rollback();
    end;
    end

  else
    begin
    {selecionando todos os sites}
    mostraTodosSites();
    {atualizando query}
    DM.zQrySite.Last;
    carrega();
    StatusBar.Panels[1].Text := '';
    visibilidade(41);
    end;  
end;

procedure TfrmCadastroSite.tlBtnSalvarClick(Sender: TObject);
begin
  if (verificaSalva = true) then
    begin
    case opcaoSalvar of
      1: begin //novo
         try
         DM.ZConnection.StartTransaction();

         DM.zQrySite.Close;
         DM.zQrySite.SQL.Clear;
         DM.zQrySite.SQL.Add('INSERT INTO Site (site,descricao,status) ');
         DM.zQrySite.SQL.Add('VALUES (:sit,:des,:sta) ');
         DM.zQrySite.ParamByName('sit').AsString := edSite.Text;
         DM.zQrySite.ParamByName('des').AsString := mmDescricao.Text;
         if(cbBxStatus.ItemIndex=0)then
           DM.zQrySite.ParamByName('sta').AsInteger := 0
         else if(cbBxStatus.ItemIndex=1)then
           DM.zQrySite.ParamByName('sta').AsInteger := 1
         else
           DM.zQrySite.ParamByName('sta').AsInteger := -1;
         DM.zQrySite.ExecSQL();

         DM.ZConnection.Commit();
         MessageDlg('Site cadastrado com sucesso!',mtInformation,[mbOK],0);
         fechar := true;
         except
           MessageDlg('Site n�o pode ser salvo!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           fechar := true;
           DM.ZConnection.Rollback();
         end;
         end;

       2: begin //editar
         try
         DM.ZConnection.StartTransaction();

         DM.zQrySite.Close;
         DM.zQrySite.SQL.Clear;
         DM.zQrySite.SQL.Add('UPDATE site SET site=:sit,descricao=:des,status=:sta WHERE codigo=:cod');
         DM.zQrySite.ParamByName('sit').AsString := edSite.Text;
         DM.zQrySite.ParamByName('des').AsString := mmDescricao.Text;
         if(cbBxStatus.ItemIndex=0)then
           DM.zQrySite.ParamByName('sta').AsInteger := 0
         else if(cbBxStatus.ItemIndex=1)then
           DM.zQrySite.ParamByName('sta').AsInteger := 1
         else
           DM.zQrySite.ParamByName('sta').AsInteger := -1;
         DM.zQrySite.ParamByName('cod').AsInteger := StrToInt(edCodigo.Text);
         DM.zQrySite.ExecSQL();

         DM.ZConnection.Commit();
         MessageDlg('Site editado com sucesso!',mtInformation,[mbOK],0);
         fechar := true;
         except
           MessageDlg('Site n�o pode ser editado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           fechar := true;           
           DM.ZConnection.Rollback();
         end;
         end;

    end;//case
      {selecionando todos os Sites}
      mostraTodosSites();
      {atualizando ClientDataSet}
      DM.zQrySite.Last;
      carrega();
      StatusBar.Panels[1].Text := 'OPERA��O = Salvar';
      visibilidade(21);
    end;//if
end;

procedure TfrmCadastroSite.ppMnMostrarTodosClientesClick(Sender: TObject);
begin
  limpar();
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;
  mostraTodosSites();
  DM.zQrySite.Last;
  carrega();
end;

procedure TfrmCadastroSite.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmCadastroSite.AdicionarEnvioEMail1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaEmailEnviar,frmSelecionaEmailEnviar);
  frmSelecionaEmailEnviar.codSite := DM.zQrySiteCODIGO.AsInteger;
   frmSelecionaEmailEnviar.nomeSite := DM.zQrySiteSITE.AsString;
  frmSelecionaEmailEnviar.ShowModal;
  frmSelecionaEmailEnviar.Free;
end;

end.
