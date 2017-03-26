unit unTipoProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ImgList, ComCtrls, StdCtrls, Grids, DBGrids,
  Buttons, ExtCtrls, ToolWin, DBXpress;

type
  TfrmTipoProduto = class(TForm)
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnEditar: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnExcluir: TToolButton;
    tlBtnCancelar: TToolButton;
    pnlPesquisar: TPanel;
    lblPesquisar: TLabel;
    rdBtnCodigo: TRadioButton;
    rdBtnTipo: TRadioButton;
    btBtnPesquisar: TBitBtn;
    edPesquisa: TEdit;
    dbGrdTipoProduto: TDBGrid;
    grpBxDadosTipoProduto: TGroupBox;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    lblTipo: TLabel;
    edCodigo: TEdit;
    edTipo: TEdit;
    mmDescricao: TMemo;
    StatusBar: TStatusBar;
    imgLista: TImageList;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosProdutos: TMenuItem;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ppMnMostrarTodosProdutosClick(Sender: TObject);
    procedure edCodigoEnter(Sender: TObject);
    procedure edTipoEnter(Sender: TObject);
    procedure mmDescricaoEnter(Sender: TObject);
    procedure edTipoExit(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure mmDescricaoExit(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnTipoClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaEnter(Sender: TObject);
    procedure edPesquisaExit(Sender: TObject);
    procedure edPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure dbGrdTipoProdutoCellClick(Column: TColumn);
    procedure dbGrdTipoProdutoTitleClick(Column: TColumn);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    Transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress
    opcaoSalvar: Integer; //modo de salvamento. 1=novo; 2=edição
    fechar: boolean; //se pode ou não fechar tela - casos de novo/editar, em que não pode fechar
    campoOrdenado: String; //campo que irá ordenar os produtos no dbGrid

    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
    function verificaSalva(): boolean; //verifica se os campos obrigatórios foram inseridos antes de salvar
    procedure visibilidade(opc: Integer);//quais componentes exibir/ocultar
    procedure iniciaTransacao();//dispara uma transação
    procedure carrega();//carrega dados da tabela Tipo de Produto para os componentes de apresentação
    procedure mostraTodosTipoProduto();//exibe todos os Tipo de Produto
  public
   (*VARIÁVEIS DE CONTROLE*)
    operacao: String; //recebe valor para saber em que modo inicia a tela
  end;

var
  frmTipoProduto: TfrmTipoProduto;

implementation

uses unDM;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{carrega dados da tabela Tipo de Produto para os componentes de apresentação}
procedure TfrmTipoProduto.carrega();
begin
  Self.limpar();

  edCodigo.Text := DM.cdsTipoProdutoCODIGO.AsString;
  edTipo.Text := DM.cdsTipoProdutoTIPO.AsString;
  mmDescricao.Text := DM.cdsTipoProdutoDESCRICAO.AsString;
end;

{dispara uma transação}
procedure TfrmTipoProduto.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

{limpar componentes}
procedure TfrmTipoProduto.limpar();
begin
  edCodigo.Clear;
  edTipo.Clear;
  mmDescricao.Clear;
end;

{verifica se os campos obrigatórios foram inseridos antes de salvar}
function TfrmTipoProduto.verificaSalva(): boolean;
var
  campos: String;
  retorno: boolean;
begin

  campos := '';
  retorno := true;

  if (edTipo.Text = '')then
    campos := 'Tipo';

  if (campos <> '') then
    begin
    MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
    retorno := false;
    end;

  if(retorno=true)then
    begin
    DM.qryPesquisaTipoProduto.Close;
    DM.qryPesquisaTipoProduto.SQL.Clear;
    DM.qryPesquisaTipoProduto.SQL.Add('SELECT * FROM Tipo_Produto t WHERE t.tipo=:tip');
    DM.qryPesquisaTipoProduto.ParamByName('tip').AsString := edTipo.Text;
    DM.qryPesquisaTipoProduto.Prepared := true;
    DM.qryPesquisaTipoProduto.Open;
    DM.cdsPesquisaTipoProduto.Open;
    DM.cdsPesquisaTipoProduto.Refresh;
    if(DM.cdsPesquisaTipoProduto.RecordCount>0)then
      begin
      MessageDlg('Tipo de Produto já cadastrado!',mtInformation,[mbOK],0);
      retorno := false;
      end;
    end;

    Result := retorno;
end;

{exibe todos os Tipo de Produto}
procedure TfrmTipoProduto.mostraTodosTipoProduto();
begin
  DM.qryTipoProduto.Close;
  DM.qryTipoProduto.SQL.Clear;
  DM.qryTipoProduto.SQL.Add('SELECT * From Tipo_Produto t ');
  if(campoOrdenado<>'')then
    DM.qryTipoProduto.SQL.Add('ORDER BY '+campoOrdenado);
  DM.qryTipoProduto.Prepared := true;
  DM.qryTipoProduto.Open;

  DM.cdsTipoProduto.Open;
  DM.cdsTipoProduto.Refresh;
end;

{quais componentes exibir/ocultar}
 procedure TfrmTipoProduto.visibilidade(opc: Integer);
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
       grpBxDadosTipoProduto.Enabled := true;
       dbGrdTipoProduto.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edTipo.SetFocus;
       end;

    {editar}
    11: begin
       grpBxDadosTipoProduto.Enabled := true;
       dbGrdTipoProduto.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edTipo.SetFocus;
       end;

    {salvar}
    21: begin
       grpBxDadosTipoProduto.Enabled := false;
       dbGrdTipoProduto.Enabled := true;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;

       mostraTodosTipoProduto();
       if (DM.cdsTipoProduto.RecordCount > 0) then
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
        grpBxDadosTipoProduto.Enabled := false;
        pnlPesquisar.Enabled := true;
        tlBtnNovo.Enabled := true;
        tlBtnSalvar.Enabled := false;

        mostraTodosTipoProduto();
        if (DM.cdsTipoProduto.RecordCount > 0) then
          begin
          dbGrdTipoProduto.Enabled := true;
          tlBtnEditar.Enabled := true;
          tlBtnExcluir.Enabled := true;
          end
        else
          begin
          dbGrdTipoProduto.Enabled := false;
          tlBtnEditar.Enabled := false;
          tlBtnExcluir.Enabled := false;
          end;
        tlBtnCancelar.Enabled := false;
        end;

    {cancelar}
    41: begin
       grpBxDadosTipoProduto.Enabled := false;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;

       mostraTodosTipoProduto();
       if (DM.cdsTipoProduto.RecordCount > 0) then
         begin
         dbGrdTipoProduto.Enabled := true;
         tlBtnEditar.Enabled := true;
         tlBtnExcluir.Enabled := true;
         end
       else
         begin
         dbGrdTipoProduto.Enabled := false;
         tlBtnEditar.Enabled := false;
         tlBtnExcluir.Enabled := false;
         end;
       end;

  end;//case
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmTipoProduto.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmTipoProduto.FormClose(Sender: TObject;
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

procedure TfrmTipoProduto.FormShow(Sender: TObject);
begin
  limpar();
  rdBtnCodigo.Checked := false;
  rdBtnTipo.Checked := false;
  edPesquisa.Clear;
  try
    mostraTodosTipoProduto();
    DM.cdsTipoProduto.First;
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

procedure TfrmTipoProduto.ppMnMostrarTodosProdutosClick(Sender: TObject);
begin
  limpar();
  rdBtnCodigo.Checked := false;
  rdBtnTipo.Checked := false;
  edPesquisa.Clear;
  mostraTodosTipoProduto();
  DM.cdsTipoProduto.Last;
  carrega();
end;

procedure TfrmTipoProduto.edCodigoEnter(Sender: TObject);
begin
  edCodigo.Color := clMoneyGreen;
end;

procedure TfrmTipoProduto.edTipoEnter(Sender: TObject);
begin
  edTipo.Color := clMoneyGreen;
end;

procedure TfrmTipoProduto.mmDescricaoEnter(Sender: TObject);
begin
  mmDescricao.Color := clMoneyGreen;
end;

procedure TfrmTipoProduto.edTipoExit(Sender: TObject);
begin
  edTipo.Color := clWindow;
end;

procedure TfrmTipoProduto.edCodigoExit(Sender: TObject);
begin
  edCodigo.Color := clWindow;
end;

procedure TfrmTipoProduto.mmDescricaoExit(Sender: TObject);
begin
  mmDescricao.Color := clWindow;
end;

procedure TfrmTipoProduto.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  fechar := false;
  opcaoSalvar := 1;//novo
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';
  visibilidade(1);
end;

procedure TfrmTipoProduto.tlBtnEditarClick(Sender: TObject);
begin
  {preparando}
  visibilidade(11);
  edTipo.SetFocus;
  opcaoSalvar := 2;//editar
  fechar := false;
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Edição';
end;

procedure TfrmTipoProduto.tlBtnCancelarClick(Sender: TObject);
begin
  limpar();
  mostraTodosTipoProduto();
  DM.cdsTipoProduto.Last;
  carrega();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
  //caso tela auxiliar chamou tipo de produto para fazer novo cadastro
  if (Self.operacao = 'novo') then
    Self.Close;

end;

procedure TfrmTipoProduto.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmTipoProduto.rdBtnTipoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmTipoProduto.edPesquisaChange(Sender: TObject);
begin
  if (edPesquisa.Text = '')then
    btBtnPesquisar.Enabled := false;

  if(edPesquisa.Text <> '')then
    begin
    if((rdBtnCodigo.Checked = true)or(rdBtnTipo.Checked = true))then
      btBtnPesquisar.Enabled := true
    else
      btBtnPesquisar.Enabled := false;
    end;
end;

procedure TfrmTipoProduto.edPesquisaEnter(Sender: TObject);
begin
  edPesquisa.Color := clMoneyGreen;
end;

procedure TfrmTipoProduto.edPesquisaExit(Sender: TObject);
begin
  edPesquisa.Color := clWindow;
end;

procedure TfrmTipoProduto.edPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=13) then
    btBtnPesquisarClick(Sender);
end;

procedure TfrmTipoProduto.edPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmTipoProduto.btBtnPesquisarClick(Sender: TObject);
begin
  {código}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.qryTipoProduto.Close;
    DM.qryTipoProduto.SQL.Clear;
    DM.qryTipoProduto.SQL.Add('SELECT * FROM Tipo_Produto p WHERE p.codigo=:cod ');
    DM.qryTipoProduto.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.qryTipoProduto.Prepared := true;
    DM.qryTipoProduto.Open;

    DM.cdsTipoProduto.Open;
    DM.cdsTipoProduto.Refresh;

    if (DM.cdsTipoProduto.RecordCount = 0) then
      begin
      MessageDlg('Nenhum Tipo de Produto encontrado com o código '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosTipoProduto();
      end;
    end;

  {tipo}
  if (rdBtnTipo.Checked = true) then
    begin
    DM.qryTipoProduto.Close;
    DM.qryTipoProduto.SQL.Clear;
    DM.qryTipoProduto.SQL.Add('SELECT * FROM Tipo_Produto p WHERE p.tipo LIKE '+QuotedStr('%'+edPesquisa.Text+'%'));
    if(campoOrdenado<>'')then
      DM.qryTipoProduto.SQL.Add('ORDER BY '+campoOrdenado);
    DM.qryTipoProduto.Prepared := true;
    DM.qryTipoProduto.Open;

    DM.cdsTipoProduto.Open;
    DM.cdsTipoProduto.Refresh;

    if (DM.cdsTipoProduto.RecordCount = 0) then
      begin
      MessageDlg('Nenhum Tipo de Produto encontrado com '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosTipoProduto();
      end;
    end;

  DM.cdsTipoProduto.Last;
  carrega();

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmTipoProduto.dbGrdTipoProdutoCellClick(Column: TColumn);
begin
  carrega();
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Navegação';

  tlBtnNovo.Enabled := true;
  tlBtnSalvar.Enabled := false;
  tlBtnCancelar.Enabled := false;
end;

procedure TfrmTipoProduto.dbGrdTipoProdutoTitleClick(Column: TColumn);
var
  campo: string;
begin
  campo:=column.fieldname; // campo recebe o nome da coluna clicada
  application.processmessages; // para considerar algo que aconteça no dbgrid durante a entrada nesta procedure
  DM.qryTipoProduto.Close;
  DM.qryTipoProduto.SQL.Clear;
  DM.qryTipoProduto.SQL.Add('SELECT * FROM Tipo_Produto ORDER BY '+campo);
  DM.qryTipoProduto.Prepared := true;
  DM.qryTipoProduto.Open;
  DM.cdsTipoProduto.Open;
  DM.cdsTipoProduto.Refresh;

  //column.Font.color:=clblue; // COLOCAR A COLUNA NA COR DESEJADA
  campoOrdenado := campo;
end;

procedure TfrmTipoProduto.tlBtnExcluirClick(Sender: TObject);
var
  codigo: Integer;
begin
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Excluir';

  if (MessageDlg('Deseja deletar o Tipo de Produto ' +#13 + DM.cdsTipoProdutoTIPO.AsString + '?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
    try
      codigo := StrToInt(edCodigo.Text);

      iniciaTransacao();
      DM.SQLConnection.StartTransaction(transacao);
      (*deletando*)
      DM.qryTipoProduto.Close;
      DM.qryTipoProduto.SQL.Clear;
      DM.qryTipoProduto.SQL.Add('DELETE FROM Tipo_Produto WHERE codigo = :cod');
      DM.qryTipoProduto.ParamByName('cod').AsInteger := codigo;
      DM.qryTipoProduto.Prepared := true;
      DM.qryTipoProduto.ExecSQL();

      DM.SQLConnection.Commit(transacao);

      {selecionando todos os Tipo de Produtos}
      mostraTodosTipoProduto();
      {atualizando ClientDataSet}
      DM.cdsTipoProduto.Last;
      carrega();
      StatusBar.Panels[1].Text := '';
      visibilidade(31);

    except
      MessageDlg('Tipo de Produto não pode ser deletado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
      DM.SQLConnection.Rollback(transacao);
    end;
    end
  else
    begin
    {selecionando todos os Tipo de Produtos}
    mostraTodosTipoProduto();
    {atualizando ClientDataSet}
    DM.cdsTipoProduto.Last;
    carrega();
    StatusBar.Panels[1].Text := '';
    visibilidade(41);
    end;
end;

procedure TfrmTipoProduto.tlBtnSalvarClick(Sender: TObject);
begin
  if (verificaSalva = true) then
    begin
    case opcaoSalvar of
      1: begin //novo
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryTipoProduto.Close;
         DM.qryTipoProduto.SQL.Clear;
         DM.qryTipoProduto.SQL.Add('INSERT INTO Tipo_Produto (tipo,descricao) ');
         DM.qryTipoProduto.SQL.Add('VALUES (:tip,:des)');
         DM.qryTipoProduto.ParamByName('tip').AsString := edTipo.Text;
         DM.qryTipoProduto.ParamByName('des').AsString := mmDescricao.Text;
         DM.qryTipoProduto.Prepared := true;
         DM.qryTipoProduto.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         MessageDlg('Tipo de Produto salvo com sucesso!',mtInformation,[mbOk],0);
         fechar := true;
         except
           MessageDlg('Tipo de Produto não pode ser salvo!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           fechar := true;
           DM.SQLConnection.Rollback(transacao);
         end;
         end;

      2: begin //editar
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryTipoProduto.Close;
         DM.qryTipoProduto.SQL.Clear;
         DM.qryTipoProduto.SQL.Add('UPDATE Tipo_Produto SET tipo=:tip,descricao=:des WHERE codigo=:cod');
         DM.qryTipoProduto.ParamByName('tip').AsString := edTipo.Text;
         DM.qryTipoProduto.ParamByName('des').AsString := mmDescricao.Text;
         DM.qryTipoProduto.ParamByName('cod').AsInteger := StrToInt(edCodigo.Text);
         DM.qryTipoProduto.Prepared := true;
         DM.qryTipoProduto.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         MessageDlg('Tipo de Produto editado com sucesso!',mtInformation,[mbOk],0);
         fechar := true;
         except
           MessageDlg('Tipo de Produto não pode ser editado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           fechar := true;           
           DM.SQLConnection.Rollback(transacao);
         end;

         end;

    end;//case
    {selecionando todos os Tipo de Produto}
    mostraTodosTipoProduto();
    {atualizando ClientDataSet}
    DM.cdsTipoProduto.Last;
    carrega();
    StatusBar.Panels[1].Text := 'OPERAÇÃO = Salvar';
    visibilidade(21);
    //caso tela auxiliar chamou tipo de produto para fazer novo cadastro
    if (Self.operacao = 'novo') then
        Self.Close;
  end;//if
end;

end.
