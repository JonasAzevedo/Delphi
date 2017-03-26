unit unProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, AppEvnts, Menus, StdCtrls, ComCtrls, Buttons,
  ToolWin, Grids, DBGrids,DBXpress;

type
  TfrmProduto = class(TForm)
    dbGrdProduto: TDBGrid;
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
    StatusBar: TStatusBar;
    grpBxDadosProduto: TGroupBox;
    lblCodigo: TLabel;
    lblNome: TLabel;
    lblDescricao: TLabel;
    lblValor: TLabel;
    edCodigo: TEdit;
    edNome: TEdit;
    edValorPago: TEdit;
    mmDescricao: TMemo;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosProdutos: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    imgLista: TImageList;
    Label1: TLabel;
    edValorVenda: TEdit;
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnNomeClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure dbGrdProdutoCellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure ppMnMostrarTodosProdutosClick(Sender: TObject);
    procedure edValorPagoKeyPress(Sender: TObject; var Key: Char);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure edValorPagoExit(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure edCodigoEnter(Sender: TObject);
    procedure edNomeEnter(Sender: TObject);
    procedure edNomeExit(Sender: TObject);
    procedure edValorPagoEnter(Sender: TObject);
    procedure mmDescricaoEnter(Sender: TObject);
    procedure mmDescricaoExit(Sender: TObject);
    procedure edValorVendaEnter(Sender: TObject);
    procedure edValorVendaExit(Sender: TObject);
    procedure edValorVendaKeyPress(Sender: TObject; var Key: Char);
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
    procedure carrega();//carrega dados da tabela Produto para os componentes de apresentação
    procedure mostraTodosProdutos();//exibe todos os Produtos
  public
   (*VARIÁVEIS DE CONTROLE*)
    operacao: String; //recebe valor para saber em que modo inicia a tela
  end;

var
  frmProduto: TfrmProduto;

implementation

uses unDataModule;


{$R *.dfm}


(*PROCEDURES DE CONTROLE*)

{carrega dados da tabela Produto para os componentes de apresentação}
procedure TfrmProduto.carrega();
var
  achou: boolean;
  item: integer;
begin
  Self.limpar();

  DM.cdsProduto.Refresh;

  //dados gerais
  edCodigo.Text := DM.cdsProdutoCODIGO.AsString;
  edNome.Text := DM.cdsProdutoNOME.AsString;
  edValorPago.Text := FormatFloat('###,##0.00',DM.cdsProdutoVALOR_PAGO.AsFloat);
  edValorVenda.Text := FormatFloat('###,##0.00',DM.cdsProdutoVALOR_VENDA.AsFloat);
  mmDescricao.Text := DM.cdsProdutoDESCRICAO.AsString;
end;

procedure TfrmProduto.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

procedure TfrmProduto.limpar();

begin
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;

  grpBxDadosProduto.Enabled := true;
  edCodigo.Clear;
  edNome.Clear;
  edValorPago.Clear;
  edValorVenda.Clear;
  mmDescricao.Clear;
  grpBxDadosProduto.Enabled := false;
end;

//exibe todos os Produtos
procedure TfrmProduto.mostraTodosProdutos();
begin
  DM.qryProduto.Close;
  DM.qryProduto.SQL.Clear;
  DM.qryProduto.SQL.Add('SELECT * From Produto p ORDER BY p.codigo');
  DM.qryProduto.Prepared := true;
  DM.qryProduto.Open;

  DM.cdsProduto.Active := false;
  DM.cdsProduto.Active := true;
  DM.cdsProduto.Refresh;
end;

{verifica se os campos obrigatórios foram inseridos antes de salvar}
function TfrmProduto.verificaSalva(): boolean;
var
  campos: String;
  continua: boolean;
begin
  //verificando se haverá lucro
  continua := true;
  if (StrToFloat(edValorPago.Text) >= StrToFloat(edValorVenda.Text))then
    begin
    if (MessageDlg('Esse produto não haverá lucro nao sua venda.'+#13+'Deseja continuar assim mesmo?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
      continua := true
    else
      continua := false;
    end;

  if (continua = true) then
    begin
    campos := '';

    if (edNome.Text = '')then
      campos := 'Nome';
    if (edValorPago.Text = '')then
      begin
      if (campos = '')then
          campos := 'Valor Pago'
        else
          campos := campos + ', Valor Pago';
      end;
    if (edValorVenda.Text = '')then
      begin
      if (campos = '')then
          campos := 'Valor Venda'
        else
          campos := campos + ', Valor Venda';
      end;

    if (campos <> '') then
      begin
      MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
      Result := false;
      end
    else
      Result := true;
    end;

end;

//quais componentes exibir/ocultar
procedure TfrmProduto.visibilidade(opc: Integer);
begin
//cuidar na visibilidade - caso pessoa jurídica e física

  {a seqüência númerica pula de 10 em 10 - 1,2,3....11,12,13...
  1 = novo
  11 = editar
  21 = salvar
  31 = excluir
  41 = cancelar
  }

  case opc of
    {novo inicial}
    1: begin
       grpBxDadosProduto.Enabled := true;
       dbGrdProduto.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       end;

    {editar}
    11: begin
        grpBxDadosProduto.Enabled := true;
        dbGrdProduto.Enabled := false;
        pnlPesquisar.Enabled := false;
        tlBtnNovo.Enabled := false;
        tlBtnEditar.Enabled := false;
        tlBtnSalvar.Enabled := true;
        tlBtnExcluir.Enabled := false;
        tlBtnCancelar.Enabled := true;
        end;

    {salvar}
    21: begin
       grpBxDadosProduto.Enabled := false;
       dbGrdProduto.Enabled := true;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;

       mostraTodosProdutos();
       if (DM.cdsProduto.RecordCount > 0) then
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
       grpBxDadosProduto.Enabled := false;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;

       mostraTodosProdutos();
       if (DM.cdsProduto.RecordCount > 0) then
         begin
         dbGrdProduto.Enabled := true;
         tlBtnEditar.Enabled := true;
         tlBtnExcluir.Enabled := true;
         end
       else
         begin
         dbGrdProduto.Enabled := false;
         tlBtnEditar.Enabled := false;
         tlBtnExcluir.Enabled := false;
         end;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;
       end;

    {cancelar}
    41: begin
       grpBxDadosProduto.Enabled := false;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;

       mostraTodosProdutos();
       if (DM.cdsProduto.RecordCount > 0) then
         begin
         dbGrdProduto.Enabled := true;
         tlBtnEditar.Enabled := true;
         tlBtnExcluir.Enabled := true;
         end
       else
         begin
         dbGrdProduto.Enabled := false;
         tlBtnEditar.Enabled := false;
         tlBtnExcluir.Enabled := false;
         end;
       end;

  end;//case


end;          

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmProduto.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  visibilidade(1);
  opcaoSalvar := 1;//novo
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';
  fechar := false;

  edNome.SetFocus;   
end;

procedure TfrmProduto.tlBtnEditarClick(Sender: TObject);
begin
  {preparando}
  visibilidade(11);
  edNome.SetFocus;
  opcaoSalvar := 2;//editar
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Edição';
  fechar := false;
end;

procedure TfrmProduto.tlBtnSalvarClick(Sender: TObject);
var
  salvar: boolean;
begin
  salvar := true;
  mmDescricao.SetFocus;

  if (verificaSalva() = true) then
  begin
  (*verificando se existe produto com o nome já cadastrado*)
  if (opcaoSalvar = 1)then
    begin
    DM.qryProduto.Close;
    DM.qryProduto.SQL.Clear;
    DM.qryProduto.SQL.Add('SELECT * FROM Produto WHERE nome=:nom');
    DM.qryProduto.ParamByName('nom').AsString := edNome.Text;
    DM.qryProduto.Prepared := true;
    DM.qryProduto.Open;

    DM.cdsProduto.Refresh;
    if (DM.cdsProduto.RecordCount <> 0) then
      begin
      salvar := false;
        if (MessageDlg('Produto com este nome já cadastrado, deseja continuar?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
          salvar := true;
      end;
      end;

  if (salvar=true)then
    begin
    case opcaoSalvar of
      1: begin //novo
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryProduto.Close;
         DM.qryProduto.SQL.Clear;
         DM.qryProduto.SQL.Add('INSERT INTO Produto (nome,descricao,valor_pago,valor_venda) ');
         DM.qryProduto.SQL.Add('VALUES(:nom,:des,:val_pag,:val_ven)');
         DM.qryProduto.ParamByName('nom').AsString := edNome.Text;
         DM.qryProduto.ParamByName('des').AsString := mmDescricao.Text;
         DM.qryProduto.ParamByName('val_pag').AsFloat := StrToFloat(edValorPago.Text);
         DM.qryProduto.ParamByName('val_ven').AsFloat := StrToFloat(edValorVenda.Text);

         DM.qryProduto.Prepared := true;
         DM.qryProduto.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         fechar := true;
         except
           MessageDlg('Produto não pode ser salvo!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           DM.SQLConnection.Rollback(transacao);
         end;

         end;

       2: begin //editar
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryProduto.Close;
         DM.qryProduto.SQL.Clear;
         DM.qryProduto.SQL.Add('UPDATE Produto SET nome=:nom,descricao=:des,valor_pago=:val_pag,valor_venda=:val_ven ');
         DM.qryProduto.SQL.Add('WHERE codigo=:cod');
         DM.qryProduto.ParamByName('nom').AsString := edNome.Text;
         DM.qryProduto.ParamByName('des').AsString := mmDescricao.Text;
         DM.qryProduto.ParamByName('val_pag').AsFloat := StrToFloat(edValorPago.Text);
         DM.qryProduto.ParamByName('val_ven').AsFloat := StrToFloat(edValorVenda.Text);
         DM.qryProduto.ParamByName('cod').AsInteger := StrToInt(edCodigo.Text);

         DM.qryProduto.Prepared := true;
         DM.qryProduto.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         fechar := true;
         except
           MessageDlg('Produto não pode ser editado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           DM.SQLConnection.Rollback(transacao);
         end;

       end;


    end;//case
  end;//if

  {selecionando todos os Produtos}
  mostraTodosProdutos();
  {atualizando ClientDataSet}
  DM.cdsProduto.Last;
  carrega();
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Salvar';
  visibilidade(21);
  end;

end;

procedure TfrmProduto.tlBtnExcluirClick(Sender: TObject);
var
  codigo: Integer;
begin
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Excluir';

  if (MessageDlg('Deseja deletar o Produto ' +#13 + DM.cdsProdutoNOME.AsString + '?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
    try
    codigo := StrToInt(edCodigo.Text);
    iniciaTransacao();
    DM.SQLConnection.StartTransaction(transacao);
    (*deletando*)
    DM.qryProduto.Close;
    DM.qryProduto.SQL.Clear;
    DM.qryProduto.SQL.Add('DELETE FROM Produto WHERE codigo = :cod');
    DM.qryProduto.ParamByName('cod').AsInteger := codigo;
    DM.qryProduto.Prepared := true;
    DM.qryProduto.ExecSQL();

    DM.SQLConnection.Commit(transacao);

    {selecionando todos os Produtos}
    mostraTodosProdutos();
    {atualizando ClientDataSet}
    DM.cdsProduto.Refresh;
    DM.cdsProduto.Last;
    carrega();
    StatusBar.Panels[1].Text := '';
    visibilidade(31);
    except
      MessageDlg('Produto não pode ser deletado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
      DM.SQLConnection.Rollback(transacao);
    end;

    end

  else
    begin
    {selecionando todos os Produtos}
    mostraTodosProdutos();
    {atualizando ClientDataSet}
    DM.cdsProduto.Refresh;
    DM.cdsProduto.Last;
    carrega();
    StatusBar.Panels[1].Text := '';
    visibilidade(41);
    end;

end;

procedure TfrmProduto.tlBtnCancelarClick(Sender: TObject);
begin
  limpar();
  mostraTodosProdutos();
  DM.cdsProduto.Refresh;
  DM.cdsProduto.Last;
  carrega();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmProduto.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';  
end;

procedure TfrmProduto.rdBtnNomeClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';  
end;

procedure TfrmProduto.edPesquisaChange(Sender: TObject);
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

procedure TfrmProduto.btBtnPesquisarClick(Sender: TObject);
begin
 {código}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.qryProduto.Close;
    DM.qryProduto.SQL.Clear;
    DM.qryProduto.SQL.Add('SELECT * FROM Produto WHERE codigo = :cod');
    DM.qryProduto.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.qryProduto.Prepared := true;
    DM.qryProduto.Open;

    DM.cdsProduto.Refresh;

    if(DM.cdsProduto.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Produto encontrado com o código ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosProdutos();
      end;

    DM.cdsProduto.Refresh;
    DM.cdsProduto.Last;
    carrega();
    end;

  {nome}
  if (rdBtnNome.Checked = true) then
    begin
    DM.qryProduto.Close;
    DM.qryProduto.SQL.Clear;
    DM.qryProduto.SQL.Add('SELECT * FROM Produto WHERE nome LIKE  ' + QuotedStr('%' + edPesquisa.Text + '%'));
    DM.qryProduto.Prepared := true;
    DM.qryProduto.Open;

    DM.cdsProduto.Refresh;

    if(DM.cdsProduto.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Produto encontrado com os caracteres ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosProdutos();
      end;

    DM.cdsProduto.Refresh;
    DM.cdsProduto.Last;
    carrega();
    end;

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmProduto.dbGrdProdutoCellClick(Column: TColumn);
begin
  carrega();
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Navegação';
end;

procedure TfrmProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (fechar = false) then
    begin
    MessageDlg('Salve ou cancele antes o processo que se encontra em operação!',mtInformation,[mbOK],0);
    Action := caNone;
    end

  else
  operacao := '';
end;

procedure TfrmProduto.FormShow(Sender: TObject);
var
  i: Integer;
begin
  limpar();
  fechar := true;
  try
    mostraTodosProdutos();
    DM.cdsProduto.First;
    carrega();
  except
  end;


  StatusBar.Panels[1].Text := '';
  visibilidade(41);

  if (operacao = 'novo') then
    tlBtnNovoClick(Sender);  
end;

procedure TfrmProduto.edPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  //aceitar apenas números
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmProduto.ppMnMostrarTodosProdutosClick(Sender: TObject);
begin
  mostraTodosProdutos();
end;

procedure TfrmProduto.edValorPagoKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmProduto.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmProduto.edValorPagoExit(Sender: TObject);
var
  valor: Real;
begin
  try
    valor := StrToFloat(edValorPago.Text);
    edValorPago.Text := FormatFloat('#0.00',valor);
  except
  end;    

  edValorPago.Color := clWindow;
end;        

procedure TfrmProduto.edCodigoExit(Sender: TObject);
begin
  edCodigo.Color := clWindow;
end;

procedure TfrmProduto.edCodigoEnter(Sender: TObject);
begin
  edCodigo.Color := clMedGray;
end;

procedure TfrmProduto.edNomeEnter(Sender: TObject);
begin
  edNome.Color := clMedGray;
end;

procedure TfrmProduto.edNomeExit(Sender: TObject);
begin
  edNome.Color := clWindow;
end;

procedure TfrmProduto.edValorPagoEnter(Sender: TObject);
begin
  edValorPago.Color := clMedGray;
end;

procedure TfrmProduto.mmDescricaoEnter(Sender: TObject);
begin
  mmDescricao.Color := clMedGray;
end;

procedure TfrmProduto.mmDescricaoExit(Sender: TObject);
begin
  mmDescricao.Color := clWindow;
end;

procedure TfrmProduto.edValorVendaEnter(Sender: TObject);
begin
  edValorVenda.Color := clMedGray;
end;

procedure TfrmProduto.edValorVendaExit(Sender: TObject);
var
  valor: Real;
begin
  try
    valor := StrToFloat(edValorVenda.Text);
    edValorVenda.Text := FormatFloat('#0.00',valor);
  except
  end;

  edValorVenda.Color := clWindow;
end;

procedure TfrmProduto.edValorVendaKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

end.

