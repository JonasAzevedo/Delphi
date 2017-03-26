unit unFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ImgList, ComCtrls, StdCtrls, Mask, Grids,
  DBGrids, Buttons, ExtCtrls, ToolWin, DBXpress;

type
  TfrmFornecedor = class(TForm)
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnEditar: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnExcluir: TToolButton;
    tlBtnCancelar: TToolButton;
    dbGrdFornecedores: TDBGrid;
    grpBxDadosFornecedor: TGroupBox;
    lblDataFicha: TLabel;
    lblCodigo: TLabel;
    lblNomeFantasia: TLabel;
    lblRazaoSocial: TLabel;
    lblCidade: TLabel;
    lblBairro: TLabel;
    lblUF: TLabel;
    lblEndereco: TLabel;
    lblCEP: TLabel;
    lblCelular: TLabel;
    lblTelefone: TLabel;
    mEdDataFicha: TMaskEdit;
    edCodigo: TEdit;
    edNomeFantasia: TEdit;
    edRazaoSocial: TEdit;
    edCidade: TEdit;
    edBairro: TEdit;
    edUF: TEdit;
    edEndereco: TEdit;
    mEdCEP: TMaskEdit;
    mEdCelular: TMaskEdit;
    mEdTelefone: TMaskEdit;
    StatusBar: TStatusBar;
    imgLista: TImageList;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosFornecedores: TMenuItem;
    lblEmail: TLabel;
    edEmail: TEdit;
    lblHomePage: TLabel;
    edHomePage: TEdit;
    lblRepresentante: TLabel;
    edRepresentante: TEdit;
    pnlPesquisar: TPanel;
    lblPesquisar: TLabel;
    rdBtnCodigo: TRadioButton;
    rdBtnRazaoSocial: TRadioButton;
    btBtnPesquisar: TBitBtn;
    edPesquisa: TEdit;
    rdBtnNomeFantasia: TRadioButton;
    lblCNPJ: TLabel;
    lblInscricaoEstadual: TLabel;
    mEdCNPJ: TMaskEdit;
    edInscricaoEstadual: TEdit;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure edPesquisaEnter(Sender: TObject);
    procedure edCodigoEnter(Sender: TObject);
    procedure edRazaoSocialEnter(Sender: TObject);
    procedure edNomeFantasiaEnter(Sender: TObject);
    procedure edEnderecoEnter(Sender: TObject);
    procedure edBairroEnter(Sender: TObject);
    procedure edCidadeEnter(Sender: TObject);
    procedure edUFEnter(Sender: TObject);
    procedure mEdCEPEnter(Sender: TObject);
    procedure edEmailEnter(Sender: TObject);
    procedure edHomePageEnter(Sender: TObject);
    procedure mEdTelefoneEnter(Sender: TObject);
    procedure mEdCelularEnter(Sender: TObject);
    procedure edRepresentanteEnter(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure edRazaoSocialExit(Sender: TObject);
    procedure edNomeFantasiaExit(Sender: TObject);
    procedure edEnderecoExit(Sender: TObject);
    procedure edBairroExit(Sender: TObject);
    procedure edCidadeExit(Sender: TObject);
    procedure edUFExit(Sender: TObject);
    procedure mEdCEPExit(Sender: TObject);
    procedure edEmailExit(Sender: TObject);
    procedure edHomePageExit(Sender: TObject);
    procedure mEdTelefoneExit(Sender: TObject);
    procedure mEdCelularExit(Sender: TObject);
    procedure edRepresentanteExit(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnRazaoSocialClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaExit(Sender: TObject);
    procedure edPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure dbGrdFornecedoresCellClick(Column: TColumn);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ppMnMostrarTodosFornecedoresClick(Sender: TObject);
    procedure dbGrdFornecedoresTitleClick(Column: TColumn);
    procedure mEdCNPJEnter(Sender: TObject);
    procedure mEdCNPJExit(Sender: TObject);
    procedure edInscricaoEstadualEnter(Sender: TObject);
    procedure edInscricaoEstadualExit(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    Transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress
    opcaoSalvar: Integer; //modo de salvamento. 1=novo; 2=edição
    fechar: boolean; //se pode ou não fechar tela - casos de novo/editar, em que não pode fechar
    campoOrdenado: String; //campo que irá ordenar os fornecedores no dbGrid

    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
    function verificaSalva(): boolean; //verifica se os campos obrigatórios foram inseridos antes de salvar
    procedure visibilidade(opc: Integer);//quais componentes exibir/ocultar
    procedure iniciaTransacao();//dispara uma transação
    procedure carrega();//carrega dados da tabela Fornecedor para os componentes de apresentação
    procedure mostraTodosFornecedores();//exibe todos os Fornecedores
  public
   (*VARIÁVEIS DE CONTROLE*)
    operacao: String; //recebe valor para saber em que modo inicia a tela
  end;

var
  frmFornecedor: TfrmFornecedor;

implementation

uses unDM;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{carrega dados da tabela Fornecedor para os componentes de apresentação}
procedure TfrmFornecedor.carrega();
begin
  Self.limpar();

  mEdDataFicha.Text := DM.cdsFornecedorDATA_FICHA.AsString;

  edCodigo.Text := DM.cdsFornecedorCODIGO.AsString;
  edNomeFantasia.Text := DM.cdsFornecedorNOME_FANTASIA.AsString;
  edRazaoSocial.Text := DM.cdsFornecedorRAZAO_SOCIAL.AsString;
  edNomeFantasia.Text := DM.cdsFornecedorNOME_FANTASIA.AsString;
  mEdCNPJ.Text := DM.cdsFornecedorCNPJ.AsString;
  edInscricaoEstadual.Text := DM.cdsFornecedorINSCRICAO_ESTADUAL.AsString;
  edEndereco.Text := DM.cdsFornecedorENDERECO.AsString;
  edBairro.Text := DM.cdsFornecedorBAIRRO.AsString;
  edCidade.Text := DM.cdsFornecedorCIDADE.AsString;
  edUF.Text := DM.cdsFornecedorUF.AsString;
  mEdCEP.Text := DM.cdsFornecedorCEP.AsString;
  edEmail.Text := DM.cdsFornecedorE_MAIL.AsString;
  edHomePage.Text := DM.cdsFornecedorHOME_PAGE.AsString;
  mEdTelefone.Text := DM.cdsFornecedorTELEFONE.AsString;
  mEdCelular.Text := DM.cdsFornecedorCELULAR.AsString;
  edRepresentante.Text := DM.cdsFornecedorREPRESENTANTE.AsString;
end;

{dispara uma transação}
procedure TfrmFornecedor.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

{limpar componentes}
procedure TfrmFornecedor.limpar();
begin
  mEdDataFicha.Clear;
  edCodigo.Clear;
  edRazaoSocial.Clear;
  edNomeFantasia.Clear;
  mEdCNPJ.Clear;
  edInscricaoEstadual.Clear;
  edEndereco.Clear;
  edBairro.Clear;
  edCidade.Clear;
  edUF.Clear;
  mEdCEP.Clear;
  edEmail.Clear;
  edHomePage.Clear;
  mEdTelefone.Clear;
  mEdCelular.Clear;
  edRepresentante.Clear;
end;

{verifica se os campos obrigatórios foram inseridos antes de salvar}
function TfrmFornecedor.verificaSalva(): boolean;
var
  campos: String;
  retorno: boolean;
begin

  campos := '';
  retorno := true;

  if (edRazaoSocial.Text = '')then
    campos := 'Razão Social';

  if (campos <> '') then
    begin
    MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
    retorno := false;
    end

  else
    begin
    (*verificando se existe fornecedor com esta razão social já cadastrada*)
    if (opcaoSalvar = 1)then
      begin
      DM.qryPesquisaFornecedor.Close;
      DM.qryPesquisaFornecedor.SQL.Clear;
      DM.qryPesquisaFornecedor.SQL.Add('SELECT * FROM Fornecedor WHERE razao_social =:raz');
      DM.qryPesquisaFornecedor.ParamByName('raz').AsString := edRazaoSocial.Text;
      DM.qryPesquisaFornecedor.Prepared := true;
      DM.qryPesquisaFornecedor.Open;
      DM.cdsPesquisaFornecedor.Open;
      DM.cdsPesquisaFornecedor.Refresh;
      if (DM.cdsPesquisaFornecedor.RecordCount <> 0) then
        begin
        retorno := false;
        if (MessageDlg('Fornecedor com esta razão social já cadastrada, deseja continuar?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
          retorno := true;
        end;
      end;
    end;

    Result := retorno;
end;

{exibe todos os Fornecedores}
procedure TfrmFornecedor.mostraTodosFornecedores();
begin
  DM.qryFornecedor.Close;
  DM.qryFornecedor.SQL.Clear;
  DM.qryFornecedor.SQL.Add('SELECT * From Fornecedor f ');
  if(campoOrdenado<>'')then
    DM.qryFornecedor.SQL.Add('ORDER BY '+campoOrdenado);
  DM.qryFornecedor.Prepared := true;
  DM.qryFornecedor.Open;

  DM.cdsFornecedor.Open;
  DM.cdsFornecedor.Refresh;
end;

{quais componentes exibir/ocultar}
 procedure TfrmFornecedor.visibilidade(opc: Integer);
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
       grpBxDadosFornecedor.Enabled := true;
       dbGrdFornecedores.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       mEdDataFicha.Text := DateToStr(Date);
       edRazaoSocial.SetFocus;
       end;

    {editar}
    11: begin
       grpBxDadosFornecedor.Enabled := true;
       dbGrdFornecedores.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edRazaoSocial.SetFocus;
       end;

    {salvar}     
    21: begin
       grpBxDadosFornecedor.Enabled := false;
       dbGrdFornecedores.Enabled := true;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;

       mostraTodosFornecedores();
       if (DM.cdsFornecedor.RecordCount > 0) then
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
        grpBxDadosFornecedor.Enabled := false;
        pnlPesquisar.Enabled := true;
        tlBtnNovo.Enabled := true;
        tlBtnSalvar.Enabled := false;

        mostraTodosFornecedores();
        if (DM.cdsFornecedor.RecordCount > 0) then
          begin
          dbGrdFornecedores.Enabled := true;
          tlBtnEditar.Enabled := true;
          tlBtnExcluir.Enabled := true;
          end
        else
          begin
          dbGrdFornecedores.Enabled := false;
          tlBtnEditar.Enabled := false;
          tlBtnExcluir.Enabled := false;
          end;
        tlBtnCancelar.Enabled := false;
        end;

    {cancelar}
    41: begin
       grpBxDadosFornecedor.Enabled := false;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;

       mostraTodosFornecedores();
       if (DM.cdsFornecedor.RecordCount > 0) then
         begin
         dbGrdFornecedores.Enabled := true;
         tlBtnEditar.Enabled := true;
         tlBtnExcluir.Enabled := true;
         end
       else
         begin
         dbGrdFornecedores.Enabled := false;
         tlBtnEditar.Enabled := false;
         tlBtnExcluir.Enabled := false;
         end;
       end;

  end;//case


end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmFornecedor.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmFornecedor.edPesquisaEnter(Sender: TObject);
begin
  edPesquisa.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.edCodigoEnter(Sender: TObject);
begin
  edCodigo.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.edRazaoSocialEnter(Sender: TObject);
begin
  edRazaoSocial.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.edNomeFantasiaEnter(Sender: TObject);
begin
  edNomeFantasia.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.edEnderecoEnter(Sender: TObject);
begin
  edEndereco.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.edBairroEnter(Sender: TObject);
begin
  edBairro.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.edCidadeEnter(Sender: TObject);
begin
  edCidade.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.edUFEnter(Sender: TObject);
begin
  edUF.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.mEdCEPEnter(Sender: TObject);
begin
  mEdCEP.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.edEmailEnter(Sender: TObject);
begin
  edEmail.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.edHomePageEnter(Sender: TObject);
begin
  edHomePage.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.mEdTelefoneEnter(Sender: TObject);
begin
  mEdTelefone.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.mEdCelularEnter(Sender: TObject);
begin
  mEdCelular.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.edRepresentanteEnter(Sender: TObject);
begin
  edRepresentante.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.edCodigoExit(Sender: TObject);
begin
  edCodigo.Color := clWindow;
end;

procedure TfrmFornecedor.edRazaoSocialExit(Sender: TObject);
begin
  edRazaoSocial.Color := clWindow;
end;

procedure TfrmFornecedor.edNomeFantasiaExit(Sender: TObject);
begin
  edNomeFantasia.Color := clWindow;
end;

procedure TfrmFornecedor.edEnderecoExit(Sender: TObject);
begin
  edEndereco.Color := clWindow;
end;

procedure TfrmFornecedor.edBairroExit(Sender: TObject);
begin
  edBairro.Color := clWindow;
end;

procedure TfrmFornecedor.edCidadeExit(Sender: TObject);
begin
  edCidade.Color := clWindow;
end;

procedure TfrmFornecedor.edUFExit(Sender: TObject);
begin
  edUF.Color := clWindow;
end;

procedure TfrmFornecedor.mEdCEPExit(Sender: TObject);
begin
  mEdCEP.Color := clWindow;
end;

procedure TfrmFornecedor.edEmailExit(Sender: TObject);
begin
  edEmail.Color := clWindow;
end;

procedure TfrmFornecedor.edHomePageExit(Sender: TObject);
begin
  edHomePage.Color := clWindow;
end;

procedure TfrmFornecedor.mEdTelefoneExit(Sender: TObject);
begin
  mEdTelefone.Color := clWindow;
end;

procedure TfrmFornecedor.mEdCelularExit(Sender: TObject);
begin
  mEdCelular.Color := clWindow;
end;

procedure TfrmFornecedor.edRepresentanteExit(Sender: TObject);
begin
  edRepresentante.Color := clWindow;
end;

procedure TfrmFornecedor.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  fechar := false;
  opcaoSalvar := 1;//novo
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';
  visibilidade(1);
end;

procedure TfrmFornecedor.tlBtnEditarClick(Sender: TObject);
begin
  {preparando}
  visibilidade(11);
  edRazaoSocial.SetFocus;
  opcaoSalvar := 2;//editar
  fechar := false;
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Edição';
end;

procedure TfrmFornecedor.tlBtnCancelarClick(Sender: TObject);
begin
  limpar();
  mostraTodosFornecedores();
  DM.cdsFornecedor.Last;
  carrega();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
  //caso tela auxiliar chamou fornecedor para fazer novo cadastro
  if (Self.operacao = 'novo') then
    Self.Close;
end;

procedure TfrmFornecedor.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmFornecedor.rdBtnRazaoSocialClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmFornecedor.edPesquisaChange(Sender: TObject);
begin
  if (edPesquisa.Text = '')then
    btBtnPesquisar.Enabled := false;

  if(edPesquisa.Text <> '')then
    begin
    if((rdBtnCodigo.Checked = true)or(rdBtnRazaoSocial.Checked = true))then
      btBtnPesquisar.Enabled := true
    else
      btBtnPesquisar.Enabled := false;
    end;
end;

procedure TfrmFornecedor.edPesquisaExit(Sender: TObject);
begin
  edPesquisa.Color := clWindow;
end;

procedure TfrmFornecedor.edPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=13) then
    btBtnPesquisarClick(Sender);
end;

procedure TfrmFornecedor.edPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmFornecedor.btBtnPesquisarClick(Sender: TObject);
begin
  {código}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.qryFornecedor.Close;
    DM.qryFornecedor.SQL.Clear;
    DM.qryFornecedor.SQL.Add('SELECT * FROM Fornecedor WHERE codigo=:cod');
    DM.qryFornecedor.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.qryFornecedor.Prepared := true;
    DM.qryFornecedor.Open;

    DM.cdsFornecedor.Open;
    DM.cdsFornecedor.Refresh;

    if (DM.cdsFornecedor.RecordCount = 0) then
      begin
      MessageDlg('Nenhum Fornecedor encontrado com o código '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosFornecedores();
      end;
    end;

  {razão social}
  if (rdBtnRazaoSocial.Checked = true) then
    begin
    DM.qryFornecedor.Close;
    DM.qryFornecedor.SQL.Clear;
    DM.qryFornecedor.SQL.Add('SELECT * FROM Fornecedor WHERE razao_social LIKE '+QuotedStr('%'+edPesquisa.Text+'%'));
    if(campoOrdenado<>'')then
      DM.qryFornecedor.SQL.Add('ORDER BY '+campoOrdenado);
    DM.qryFornecedor.Prepared := true;
    DM.qryFornecedor.Open;

    DM.cdsFornecedor.Open;
    DM.cdsFornecedor.Refresh;

    if (DM.cdsFornecedor.RecordCount = 0) then
      begin
      MessageDlg('Nenhum Fornecedor encontrado com a razão social '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosFornecedores();
      end;
    end;

  {nome fantasia}
  if (rdBtnNomeFantasia.Checked = true) then
    begin
    DM.qryFornecedor.Close;
    DM.qryFornecedor.SQL.Clear;
    DM.qryFornecedor.SQL.Add('SELECT * FROM Fornecedor WHERE nome_fantasia LIKE '+QuotedStr('%'+edPesquisa.Text+'%'));
    if(campoOrdenado<>'')then
      DM.qryFornecedor.SQL.Add('ORDER BY '+campoOrdenado);
    DM.qryFornecedor.Prepared := true;
    DM.qryFornecedor.Open;

    DM.cdsFornecedor.Open;
    DM.cdsFornecedor.Refresh;

    if (DM.cdsFornecedor.RecordCount = 0) then
      begin
      MessageDlg('Nenhum Fornecedor encontrado com o nome fantasia '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosFornecedores();
      end;
    end;

  DM.cdsFornecedor.Last;
  carrega();

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmFornecedor.tlBtnExcluirClick(Sender: TObject);
var
  codigo: Integer;
begin
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Excluir';

  if (MessageDlg('Deseja deletar o Fornecedor ' +#13 + DM.cdsFornecedorRAZAO_SOCIAL.AsString + '?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
    try
      codigo := StrToInt(edCodigo.Text);

      iniciaTransacao();
      DM.SQLConnection.StartTransaction(transacao);
      (*deletando*)
      DM.qryFornecedor.Close;
      DM.qryFornecedor.SQL.Clear;
      DM.qryFornecedor.SQL.Add('DELETE FROM Fornecedor WHERE codigo = :cod');
      DM.qryFornecedor.ParamByName('cod').AsInteger := codigo;
      DM.qryFornecedor.Prepared := true;
      DM.qryFornecedor.ExecSQL();

      DM.SQLConnection.Commit(transacao);

      {selecionando todos os Fornecedores}
      mostraTodosFornecedores();
      {atualizando ClientDataSet}
      DM.cdsFornecedor.Last;
      carrega();
      StatusBar.Panels[1].Text := '';
      visibilidade(31);

    except
      MessageDlg('Fornecedor não pode ser deletado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
      DM.SQLConnection.Rollback(transacao);
    end;

    end

  else
    begin
    {selecionando todos os Fornecedores}
    mostraTodosFornecedores();
    {atualizando ClientDataSet}
    DM.cdsFornecedor.Last;
    carrega();
    StatusBar.Panels[1].Text := '';
    visibilidade(41);
    end;

end;


procedure TfrmFornecedor.dbGrdFornecedoresCellClick(Column: TColumn);
begin
  carrega();
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Navegação';

  tlBtnNovo.Enabled := true;
  tlBtnSalvar.Enabled := false;
  tlBtnCancelar.Enabled := false;
end;

procedure TfrmFornecedor.tlBtnSalvarClick(Sender: TObject);
begin
  if (verificaSalva = true) then
    begin
    case opcaoSalvar of
      1: begin //novo
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryFornecedor.Close;
         DM.qryFornecedor.SQL.Clear;
         DM.qryFornecedor.SQL.Add('INSERT INTO Fornecedor (razao_social,nome_fantasia,cnpj,inscricao_estadual,endereco,bairro,cidade,uf,cep,e_mail,home_page,telefone,celular,representante,data_ficha) ');
         DM.qryFornecedor.SQL.Add('VALUES (:razSoc,:nomFan,:cnp,:in_es,:end,:bai,:cid,:uf,:cep,:ema,:hom,:tel,:cel,:rep,:datFic)');

         DM.qryFornecedor.ParamByName('razSoc').AsString := edRazaoSocial.Text;
         DM.qryFornecedor.ParamByName('nomFan').AsString := edNomeFantasia.Text;
         DM.qryFornecedor.ParamByName('cnp').AsString := mEdCNPJ.Text;
         DM.qryFornecedor.ParamByName('in_es').AsString := edInscricaoEstadual.Text;
         DM.qryFornecedor.ParamByName('end').AsString := edEndereco.Text;
         DM.qryFornecedor.ParamByName('bai').AsString := edBairro.Text;
         DM.qryFornecedor.ParamByName('cid').AsString := edCidade.Text;
         DM.qryFornecedor.ParamByName('uf').AsString := edUF.Text;
         DM.qryFornecedor.ParamByName('cep').AsString := mEdCEP.Text;
         DM.qryFornecedor.ParamByName('ema').AsString := edEmail.Text;
         DM.qryFornecedor.ParamByName('hom').AsString := edHomePage.Text;
         DM.qryFornecedor.ParamByName('tel').AsString := mEdTelefone.Text;
         DM.qryFornecedor.ParamByName('cel').AsString := mEdCelular.Text;
         DM.qryFornecedor.ParamByName('rep').AsString := edRepresentante.Text;
         DM.qryFornecedor.ParamByName('datFic').AsDate := StrToDate(mEdDataFicha.Text);

         DM.qryFornecedor.Prepared := true;
         DM.qryFornecedor.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         MessageDlg('Fornecedor salvo com sucesso!',mtInformation,[mbOk],0);
         fechar := true;
         except
           MessageDlg('Fornecedor não pode ser salvo!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           fechar := true;
           DM.SQLConnection.Rollback(transacao);
         end;

         end;

       2: begin //editar
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryFornecedor.Close;
         DM.qryFornecedor.SQL.Clear;
         DM.qryFornecedor.SQL.Add('UPDATE Fornecedor SET razao_social=:razSoc,nome_fantasia=:nomFan,cnpj=:cnp,inscricao_estadual=:in_es, ');
         DM.qryFornecedor.SQL.Add('endereco=:end,bairro=:bai,cidade=:cid,uf=:uf,cep=:cep,e_mail=:ema,home_page=:hom,telefone=:tel, ');
         DM.qryFornecedor.SQL.Add('celular=:cel,representante=:rep WHERE codigo=:cod');

         DM.qryFornecedor.ParamByName('razSoc').AsString := edRazaoSocial.Text;
         DM.qryFornecedor.ParamByName('nomFan').AsString := edNomeFantasia.Text;
         DM.qryFornecedor.ParamByName('cnp').AsString := mEdCNPJ.Text;
         DM.qryFornecedor.ParamByName('in_es').AsString := edInscricaoEstadual.Text;
         DM.qryFornecedor.ParamByName('end').AsString := edEndereco.Text;
         DM.qryFornecedor.ParamByName('bai').AsString := edBairro.Text;
         DM.qryFornecedor.ParamByName('cid').AsString := edCidade.Text;
         DM.qryFornecedor.ParamByName('uf').AsString := edUF.Text;
         DM.qryFornecedor.ParamByName('cep').AsString := mEdCEP.Text;
         DM.qryFornecedor.ParamByName('ema').AsString := edEmail.Text;
         DM.qryFornecedor.ParamByName('hom').AsString := edHomePage.Text;
         DM.qryFornecedor.ParamByName('tel').AsString := mEdTelefone.Text;
         DM.qryFornecedor.ParamByName('cel').AsString := mEdCelular.Text;
         DM.qryFornecedor.ParamByName('rep').AsString := edRepresentante.Text;
         DM.qryFornecedor.ParamByName('cod').AsInteger := StrToInt(edCodigo.Text);

         DM.qryFornecedor.Prepared := true;
         DM.qryFornecedor.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         MessageDlg('Fornecedor editado com sucesso!',mtInformation,[mbOk],0);
         fechar := true;
         except
           MessageDlg('Fornecedor não pode ser editado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           fechar := true;           
           DM.SQLConnection.Rollback(transacao);
         end;

         end;

    end;//case
    {selecionando todos os Fornecedores}
    mostraTodosFornecedores();
    {atualizando ClientDataSet}
    DM.cdsFornecedor.Last;
    carrega();
    StatusBar.Panels[1].Text := 'OPERAÇÃO = Salvar';
    visibilidade(21);
    //caso tela auxiliar chamou cliente para fazer novo cadastro
    if (Self.operacao = 'novo') then
      Self.Close;    
  end;//if
end;

procedure TfrmFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (fechar = false) then
    begin
    MessageDlg('Salve ou cancele antes o processo que se encontra em operação!',mtInformation,[mbOK],0);
    Action := caNone;
    end

  else
  operacao := '';

end;

procedure TfrmFornecedor.FormShow(Sender: TObject);
begin
  limpar();
  rdBtnCodigo.Checked := false;
  rdBtnRazaoSocial.Checked := false;
  edPesquisa.Clear;  
  try
    mostraTodosFornecedores();
    DM.cdsFornecedor.First;
    carrega();
  except
  end;

  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
  Self.campoOrdenado := '';  

  if (operacao = 'novo') then
    tlBtnNovoClick(Sender);
end;


procedure TfrmFornecedor.ppMnMostrarTodosFornecedoresClick(
  Sender: TObject);
begin
  limpar();
  rdBtnCodigo.Checked := false;
  rdBtnRazaoSocial.Checked := false;
  edPesquisa.Clear;
  mostraTodosFornecedores();
  DM.cdsFornecedor.Last;
  carrega();
end;

procedure TfrmFornecedor.dbGrdFornecedoresTitleClick(Column: TColumn);
var
  campo: string;
begin
  campo:=column.fieldname; // campo recebe o nome da coluna clic-ada
  application.processmessages; // para considerar algo que aconteça no dbgrid durante a entrada nesta procedure
  DM.qryFornecedor.Close;
  DM.qryFornecedor.SQL.Clear;
  DM.qryFornecedor.SQL.Add('SELECT * FROM Fornecedor ORDER BY '+campo);
  DM.qryFornecedor.Prepared := true;
  DM.qryFornecedor.Open;
  DM.cdsFornecedor.Open;
  DM.cdsFornecedor.Refresh;

  //column.Font.color:=clblue; // COLOCAR A COLUNA NA COR DESEJADA
  campoOrdenado := campo;
end;

procedure TfrmFornecedor.mEdCNPJEnter(Sender: TObject);
begin
  mEdCNPJ.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.mEdCNPJExit(Sender: TObject);
begin
  mEdCNPJ.Color := clWindow;
end;

procedure TfrmFornecedor.edInscricaoEstadualEnter(Sender: TObject);
begin
  edInscricaoEstadual.Color := clMoneyGreen;
end;

procedure TfrmFornecedor.edInscricaoEstadualExit(Sender: TObject);
begin
  edInscricaoEstadual.Color := clWindow;
end;

end.
