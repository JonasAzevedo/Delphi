unit unFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ExtCtrls, ImgList, ComCtrls, StdCtrls, Mask,
  Grids, DBGrids, Buttons, ToolWin,DBXpress;

type
  TfrmFornecedor = class(TForm)
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
    dbGrdFornecedores: TDBGrid;
    grpBxDadosFornecedor: TGroupBox;
    lblDataFicha: TLabel;
    mEdDataFicha: TMaskEdit;
    StatusBar: TStatusBar;
    imgLista: TImageList;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosFornecedores: TMenuItem;
    lblCodigoJ: TLabel;
    lblNomeFantasiaJ: TLabel;
    edCodigo: TEdit;
    lblRazaoSocialJ: TLabel;
    edRazaoSocial: TEdit;
    edNomeFantasia: TEdit;
    lblEnderecoJ: TLabel;
    edEndereco: TEdit;
    lblBairroJ: TLabel;
    edBairro: TEdit;
    edCidade: TEdit;
    lblCidadeJ: TLabel;
    lblHomePageJ: TLabel;
    lblTelefoneJ: TLabel;
    lblRepresentanteJ: TLabel;
    edRepresentante: TEdit;
    edHomePage: TEdit;
    mEdTelefone: TMaskEdit;
    lblCelularJ: TLabel;
    mEdCelular: TMaskEdit;
    lblEmailJ: TLabel;
    edEmail: TEdit;
    edUF: TEdit;
    lblUFJ: TLabel;
    mEdCNPJ: TMaskEdit;
    lblCNPJJ: TLabel;
    lblInscricaoEstadualJ: TLabel;
    edInscricaoEstadual: TEdit;
    mEdCEP: TMaskEdit;
    lblCEPJ: TLabel;
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure dbGrdFornecedoresCellClick(Column: TColumn);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnNomeClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ppMnMostrarTodosFornecedoresClick(Sender: TObject);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure edCodigoExit(Sender: TObject);
    procedure edCodigoEnter(Sender: TObject);
    procedure edRazaoSocialEnter(Sender: TObject);
    procedure edRazaoSocialExit(Sender: TObject);
    procedure edNomeFantasiaExit(Sender: TObject);
    procedure edNomeFantasiaEnter(Sender: TObject);
    procedure edEnderecoEnter(Sender: TObject);
    procedure edEnderecoExit(Sender: TObject);
    procedure edBairroExit(Sender: TObject);
    procedure edBairroEnter(Sender: TObject);
    procedure edCidadeEnter(Sender: TObject);
    procedure edCidadeExit(Sender: TObject);
    procedure edUFExit(Sender: TObject);
    procedure edUFEnter(Sender: TObject);
    procedure mEdCEPEnter(Sender: TObject);
    procedure mEdCEPExit(Sender: TObject);
    procedure edHomePageExit(Sender: TObject);
    procedure edHomePageEnter(Sender: TObject);
    procedure edEmailEnter(Sender: TObject);
    procedure edEmailExit(Sender: TObject);
    procedure mEdTelefoneExit(Sender: TObject);
    procedure mEdTelefoneEnter(Sender: TObject);
    procedure mEdCelularEnter(Sender: TObject);
    procedure mEdCelularExit(Sender: TObject);
    procedure mEdCNPJExit(Sender: TObject);
    procedure mEdCNPJEnter(Sender: TObject);
    procedure edInscricaoEstadualEnter(Sender: TObject);
    procedure edInscricaoEstadualExit(Sender: TObject);
    procedure edRepresentanteExit(Sender: TObject);
    procedure edRepresentanteEnter(Sender: TObject);
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
    procedure carrega();//carrega dados da tabela Fornecedor para os componentes de apresentação
    procedure mostraTodosFornecedores();//exibe todos os Fornecedores
  public
   (*VARIÁVEIS DE CONTROLE*)
    operacao: String; //recebe valor para saber em que modo inicia a tela
  end;

var
  frmFornecedor: TfrmFornecedor;

implementation

uses Math, unDataModule;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)
                              
{carrega dados da tabela Fornecedor para os componentes de apresentação}
procedure TfrmFornecedor.carrega();
begin
  limpar();
  DM.cdsFornecedor.Refresh;

  mEdDataFicha.Text := DM.cdsFornecedorDATA_FICHA.AsString;
  edCodigo.Text := DM.cdsFornecedorCODIGO.AsString;
  edRazaoSocial.Text := DM.cdsFornecedorRAZAO_SOCIAL.AsString;
  edNomeFantasia.Text := DM.cdsFornecedorNOME_FANTASIA.AsString;
  edEndereco.Text := DM.cdsFornecedorENDERECO.AsString;
  edBairro.Text := DM.cdsFornecedorBAIRRO.AsString;
  edCidade.Text := DM.cdsFornecedorCIDADE.AsString;
  edUF.Text := DM.cdsFornecedorUF.AsString;
  mEdCEP.Text := DM.cdsFornecedorCEP.AsString;
  edHomePage.Text := DM.cdsFornecedorHOME_PAGE.AsString;
  edEmail.Text := DM.cdsFornecedorE_MAIL.AsString;
  mEdTelefone.Text := DM.cdsFornecedorTELEFONE.AsString;
  mEdCelular.Text := DM.cdsFornecedorCELULAR.AsString;
  mEdCNPJ.Text := DM.cdsFornecedorCNPJ.AsString;
  edInscricaoEstadual.Text := DM.cdsFornecedorINSCRICAO_ESTADUAL.AsString;
  edRepresentante.Text := DM.cdsFornecedorREPRESENTANTE.AsString;
end;

procedure TfrmFornecedor.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;


{limpar componentes} 
procedure TfrmFornecedor.limpar();
begin
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;
  grpBxDadosFornecedor.Enabled := true;

  mEdDataFicha.Clear;
  edCodigo.Clear;
  edRazaoSocial.Clear;
  edNomeFantasia.Clear;
  edEndereco.Clear;
  edBairro.Clear;
  edCidade.Clear;
  edUF.Clear;
  mEdCEP.Clear;
  edEmail.Clear;
  edHomePage.Clear;
  mEdTelefone.Clear;
  mEdCelular.Clear;
  mEdCNPJ.Clear;
  edInscricaoEstadual.Clear;
  edRepresentante.Clear;
end;
              

{verifica se os campos obrigatórios foram inseridos antes de salvar}
function TfrmFornecedor.verificaSalva(): boolean;
var
  campos: String;
begin

  campos := '';

  if (edRazaoSocial.Text = '')then
    campos := 'Razão Social';
    if (edNomeFantasia.Text = '')then
      begin
      if (campos = '')then
        campos := 'Nome Fantasia'
      else
        campos := campos + ', Nome Fantasia';
      end;
    if (edRepresentante.Text = '')then
      begin
      if (campos = '')then
        campos := 'Representante'
      else
        campos := campos + ', Representante';
      end;

    if (campos <> '') then
      begin
      MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
      Result := false;
      end
    else
      Result := true;
end;


//exibe todos os Fornecedores
procedure TfrmFornecedor.mostraTodosFornecedores();
begin
  DM.qryFornecedor.Close;
  DM.qryFornecedor.SQL.Clear;
  DM.qryFornecedor.SQL.Add('SELECT * From Fornecedor f ORDER BY f.codigo');
  DM.qryFornecedor.Prepared := true;
  DM.qryFornecedor.Open;

  DM.cdsFornecedor.Refresh;
end;           

//quais componentes exibir/ocultar
procedure TfrmFornecedor.visibilidade(opc: Integer);
begin
//cuidar na visibilidade - caso pessoa jurídica e física

  {a seqüência númerica pula de 10 em 10 - 1,2,3....11,12,13...
  1 = novo inicial
  11 = editar
  21 = salvar
  31 = excluir
  41 = cancelar
  }

  case opc of
    {novo inicial}
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
       tlBtnSalvar.Enabled := false;
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

procedure TfrmFornecedor.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  opcaoSalvar := 1;//novo
  edRazaoSocial.SetFocus;
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';
  fechar := false;

  visibilidade(1);
end;

procedure TfrmFornecedor.tlBtnEditarClick(Sender: TObject);
begin
  {preparando}
  visibilidade(11);
  edRazaoSocial.SetFocus;
  opcaoSalvar := 2;//editar
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Edição';
  fechar := false;     
end;

procedure TfrmFornecedor.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmFornecedor.dbGrdFornecedoresCellClick(Column: TColumn);
begin
  carrega();
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Navegação';
  visibilidade(41); 
end;

procedure TfrmFornecedor.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';  
end;

procedure TfrmFornecedor.rdBtnNomeClick(Sender: TObject);
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
    if((rdBtnCodigo.Checked = true)or(rdBtnNome.Checked = true))then
      btBtnPesquisar.Enabled := true
    else
      btBtnPesquisar.Enabled := false;
    end;
end;

procedure TfrmFornecedor.tlBtnSalvarClick(Sender: TObject);
var
  salvar: boolean;
begin
  salvar := true;


  if (verificaSalva = true) then
  begin
  (*verificando se existe Fornecedor com o nome já cadastrado*)
  if (opcaoSalvar = 1)then
    begin
    DM.qryFornecedor.Close;
    DM.qryFornecedor.SQL.Clear;
    DM.qryFornecedor.SQL.Add('SELECT * FROM Fornecedor WHERE razao_social =:raz');
    DM.qryFornecedor.ParamByName('raz').AsString := edRazaoSocial.Text;
    DM.qryFornecedor.Prepared := true;
    DM.qryFornecedor.Open;

    DM.cdsFornecedor.Refresh;
    if (DM.cdsFornecedor.RecordCount <> 0) then
      begin
      salvar := false;
        if (MessageDlg('Fornecedor com esta razão social já cadastrado, deseja continuar?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
          salvar := true;
      end;
      end;

  if (salvar = false) then
    begin
    mostraTodosFornecedores();
    {atualizando ClientDataSet}
    DM.cdsFornecedor.Last;
    carrega();
    visibilidade(41);
    end;

  if (salvar=true)then
    begin
    case opcaoSalvar of
      1: begin //novo
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryFornecedor.Close;
         DM.qryFornecedor.SQL.Clear;
         DM.qryFornecedor.SQL.Add('INSERT INTO Fornecedor (razao_social,nome_fantasia,endereco,bairro,cidade,uf,cep,e_mail,home_page,telefone,celular,cnpj,inscricao_estadual,representante,data_ficha) ');
         DM.qryFornecedor.SQL.Add('VALUES (:raz,:nom,:end,:bai,:cid,:uf,:cep,:ema,:hom,:tel,:cel,:cnp,:ins_est,:rep,:dat) ');
         DM.qryFornecedor.ParamByName('raz').AsString := edRazaoSocial.Text;
         DM.qryFornecedor.ParamByName('nom').AsString := edNomeFantasia.Text;
         DM.qryFornecedor.ParamByName('end').AsString := edEndereco.Text;
         DM.qryFornecedor.ParamByName('bai').AsString := edBairro.Text;
         DM.qryFornecedor.ParamByName('cid').AsString := edCidade.Text;
         DM.qryFornecedor.ParamByName('uf').AsString := edUF.Text;
         DM.qryFornecedor.ParamByName('cep').AsString := mEdCEP.Text;
         DM.qryFornecedor.ParamByName('ema').AsString := edEmail.Text;
         DM.qryFornecedor.ParamByName('hom').AsString := edHomePage.Text;
         DM.qryFornecedor.ParamByName('tel').AsString := mEdTelefone.Text;
         DM.qryFornecedor.ParamByName('cel').AsString := mEdCelular.Text;
         DM.qryFornecedor.ParamByName('cnp').AsString := mEdCNPJ.Text;
         DM.qryFornecedor.ParamByName('ins_est').AsString := edInscricaoEstadual.Text;
         DM.qryFornecedor.ParamByName('rep').AsString := edRepresentante.Text;
         DM.qryFornecedor.ParamByName('dat').AsDate := StrToDate(mEdDataFicha.Text);
         DM.qryFornecedor.Prepared := true;
         DM.qryFornecedor.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         fechar := true;
         except
           MessageDlg('Fornecedor não pode ser salvo!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           DM.SQLConnection.Rollback(transacao);
         end;

         end;

       2: begin //editar
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryFornecedor.Close;
         DM.qryFornecedor.SQL.Clear;
         DM.qryFornecedor.SQL.Add('UPDATE Fornecedor SET razao_social=:raz,nome_fantasia=:nom,endereco=:end,bairro=:bai,cidade=:cid,uf=:uf, ');
         DM.qryFornecedor.SQL.Add('cep=:cep,e_mail=:ema,home_page=:hom,telefone=:tel,celular=:cel,cnpj=:cnp,inscricao_estadual=:ins_est,representante=:rep ');
         DM.qryFornecedor.SQL.Add('WHERE codigo=:cod');
         DM.qryFornecedor.ParamByName('raz').AsString := edRazaoSocial.Text;
         DM.qryFornecedor.ParamByName('nom').AsString := edNomeFantasia.Text;
         DM.qryFornecedor.ParamByName('end').AsString := edEndereco.Text;
         DM.qryFornecedor.ParamByName('bai').AsString := edBairro.Text;
         DM.qryFornecedor.ParamByName('cid').AsString := edCidade.Text;
         DM.qryFornecedor.ParamByName('uf').AsString := edUF.Text;
         DM.qryFornecedor.ParamByName('cep').AsString := mEdCEP.Text;
         DM.qryFornecedor.ParamByName('ema').AsString := edEmail.Text;
         DM.qryFornecedor.ParamByName('hom').AsString := edHomePage.Text;
         DM.qryFornecedor.ParamByName('tel').AsString := mEdTelefone.Text;
         DM.qryFornecedor.ParamByName('cel').AsString := mEdCelular.Text;
         DM.qryFornecedor.ParamByName('cnp').AsString := mEdCNPJ.Text;
         DM.qryFornecedor.ParamByName('ins_est').AsString := edInscricaoEstadual.Text;
         DM.qryFornecedor.ParamByName('rep').AsString := edRepresentante.Text;
         DM.qryFornecedor.ParamByName('cod').AsInteger := StrToInt(edCodigo.Text);
         DM.qryFornecedor.Prepared := true;
         DM.qryFornecedor.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         fechar := true;
         except
           MessageDlg('Fornecedor não pode ser editado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
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
  end;//if

  end;

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
    DM.cdsFornecedor.Refresh;
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
    DM.cdsFornecedor.Refresh;
    DM.cdsFornecedor.Last;
    carrega();
    StatusBar.Panels[1].Text := '';
    visibilidade(41);
    end;    

end;

procedure TfrmFornecedor.tlBtnCancelarClick(Sender: TObject);
begin
  limpar();
  mostraTodosFornecedores();
  DM.cdsFornecedor.Refresh;
  DM.cdsFornecedor.Last;
  carrega();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmFornecedor.btBtnPesquisarClick(Sender: TObject);
begin
  {código}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.qryFornecedor.Close;
    DM.qryFornecedor.SQL.Clear;
    DM.qryFornecedor.SQL.Add('SELECT * FROM Fornecedor WHERE codigo = :cod');
    DM.qryFornecedor.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.qryFornecedor.Prepared := true;
    DM.qryFornecedor.Open;

    DM.cdsFornecedor.Refresh;

    if(DM.cdsFornecedor.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Fornecedor encontrado com o código ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosFornecedores();
      end;

    end;

  {nome}
  if (rdBtnNome.Checked = true) then
    begin
    DM.qryFornecedor.Close;
    DM.qryFornecedor.SQL.Clear;
    DM.qryFornecedor.SQL.Add('SELECT * FROM Fornecedor WHERE razao_social LIKE  ' + QuotedStr('%' + edPesquisa.Text + '%'));
    DM.qryFornecedor.Prepared := true;
    DM.qryFornecedor.Open;

    DM.cdsFornecedor.Refresh;

    if(DM.cdsFornecedor.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Fornecedor encontrado com os caracteres ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosFornecedores();
      end;

    end;

  DM.cdsFornecedor.Refresh;
  DM.cdsFornecedor.Last;
  carrega();

  StatusBar.Panels[1].Text := '';
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
  try
    mostraTodosFornecedores();
    DM.cdsFornecedor.First;
    carrega();
  except
  end;
  visibilidade(41);
  StatusBar.Panels[1].Text := '';
  fechar := true;

  if (operacao = 'novo') then
    tlBtnNovoClick(Sender);
end;


procedure TfrmFornecedor.ppMnMostrarTodosFornecedoresClick(
  Sender: TObject);
begin
  limpar();
  mostraTodosFornecedores();
  carrega();
end;

procedure TfrmFornecedor.edPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  //aceitar apenas números
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmFornecedor.edCodigoExit(Sender: TObject);
begin
  edCodigo.Color := clWindow;
end;

procedure TfrmFornecedor.edCodigoEnter(Sender: TObject);
begin
  edCodigo.Color := clMedGray;
end;

procedure TfrmFornecedor.edRazaoSocialEnter(Sender: TObject);
begin
  edRazaoSocial.Color := clMedGray;
end;

procedure TfrmFornecedor.edRazaoSocialExit(Sender: TObject);
begin
  edRazaoSocial.Color := clWindow;
end;

procedure TfrmFornecedor.edNomeFantasiaExit(Sender: TObject);
begin
  edNomeFantasia.Color := clWindow;
end;

procedure TfrmFornecedor.edNomeFantasiaEnter(Sender: TObject);
begin
  edNomeFantasia.Color := clMedGray;
end;

procedure TfrmFornecedor.edEnderecoEnter(Sender: TObject);
begin
  edEndereco.Color := clMedGray;
end;

procedure TfrmFornecedor.edEnderecoExit(Sender: TObject);
begin
  edEndereco.Color := clWindow;
end;

procedure TfrmFornecedor.edBairroExit(Sender: TObject);
begin
  edBairro.Color := clWindow;
end;

procedure TfrmFornecedor.edBairroEnter(Sender: TObject);
begin
  edBairro.Color := clMedGray;
end;

procedure TfrmFornecedor.edCidadeEnter(Sender: TObject);
begin
  edCidade.Color := clMedGray;
end;

procedure TfrmFornecedor.edCidadeExit(Sender: TObject);
begin
  edCidade.Color := clWindow;
end;

procedure TfrmFornecedor.edUFExit(Sender: TObject);
begin
  edUF.Color := clWindow;
end;

procedure TfrmFornecedor.edUFEnter(Sender: TObject);
begin
  edUF.Color := clMedGray;
end;

procedure TfrmFornecedor.mEdCEPEnter(Sender: TObject);
begin
  mEdCEP.Color := clMedGray;
end;

procedure TfrmFornecedor.mEdCEPExit(Sender: TObject);
begin
  mEdCEP.Color := clWindow;
end;

procedure TfrmFornecedor.edHomePageExit(Sender: TObject);
begin
  edHomePage.Color := clWindow;
end;

procedure TfrmFornecedor.edHomePageEnter(Sender: TObject);
begin
  edHomePage.Color := clMedGray;
end;

procedure TfrmFornecedor.edEmailEnter(Sender: TObject);
begin
  edEmail.Color := clMedGray;
end;

procedure TfrmFornecedor.edEmailExit(Sender: TObject);
begin
  edEmail.Color := clWindow;
end;

procedure TfrmFornecedor.mEdTelefoneExit(Sender: TObject);
begin
  mEdTelefone.Color := clWindow;
end;

procedure TfrmFornecedor.mEdTelefoneEnter(Sender: TObject);
begin
  mEdTelefone.Color := clMedGray;
end;

procedure TfrmFornecedor.mEdCelularEnter(Sender: TObject);
begin
  mEdCelular.Color := clMedGray;
end;

procedure TfrmFornecedor.mEdCelularExit(Sender: TObject);
begin
  mEdCelular.Color := clWindow;
end;

procedure TfrmFornecedor.mEdCNPJExit(Sender: TObject);
begin
  mEdCNPJ.Color := clWindow;
end;

procedure TfrmFornecedor.mEdCNPJEnter(Sender: TObject);
begin
  mEdCNPJ.Color := clMedGray;
end;

procedure TfrmFornecedor.edInscricaoEstadualEnter(Sender: TObject);
begin
  edInscricaoEstadual.Color := clMedGray;
end;

procedure TfrmFornecedor.edInscricaoEstadualExit(Sender: TObject);
begin
  edInscricaoEstadual.Color := clWindow;
end;

procedure TfrmFornecedor.edRepresentanteExit(Sender: TObject);
begin
  edRepresentante.Color := clWindow;
end;

procedure TfrmFornecedor.edRepresentanteEnter(Sender: TObject);
begin
  edRepresentante.Color := clMedGray;
end;

end.
