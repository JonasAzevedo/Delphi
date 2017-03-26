unit unProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ImgList, ComCtrls, Mask, StdCtrls, Grids,
  DBGrids, Buttons, ExtCtrls, ToolWin, DBXpress;

type
  TfrmProduto = class(TForm)
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
    dbGrdProdutos: TDBGrid;
    grpBxDadosProduto: TGroupBox;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    lblNome: TLabel;
    lblValorVenda: TLabel;
    lblValorLocacao: TLabel;
    edCodigo: TEdit;
    edNome: TEdit;
    edValorVenda: TEdit;
    edValorLocacao: TEdit;
    StatusBar: TStatusBar;
    imgLista: TImageList;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosProdutos: TMenuItem;
    mmDescricao: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    edMarca: TEdit;
    edTamanho: TEdit;
    Label4: TLabel;
    edValorPago: TEdit;
    Label1: TLabel;
    edTipoProduto: TEdit;
    btBtnAbreTipoProduto: TBitBtn;
    Label5: TLabel;
    edCodigo2: TEdit;
    cbBxTipoProduto: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblStatus: TLabel;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnNomeClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure dbGrdProdutosCellClick(Column: TColumn);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaEnter(Sender: TObject);
    procedure edCodigoEnter(Sender: TObject);
    procedure edNomeEnter(Sender: TObject);
    procedure mmDescricaoEnter(Sender: TObject);
    procedure edValorLocacaoEnter(Sender: TObject);
    procedure edValorVendaEnter(Sender: TObject);
    procedure edValorVendaExit(Sender: TObject);
    procedure edValorLocacaoExit(Sender: TObject);
    procedure mmDescricaoExit(Sender: TObject);
    procedure edNomeExit(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure edPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPesquisaExit(Sender: TObject);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure edValorLocacaoKeyPress(Sender: TObject; var Key: Char);
    procedure edValorVendaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ppMnMostrarTodosProdutosClick(Sender: TObject);
    procedure cbBxStatusSelect(Sender: TObject);
    procedure edMarcaEnter(Sender: TObject);
    procedure edTamanhoEnter(Sender: TObject);
    procedure edMarcaExit(Sender: TObject);
    procedure edTamanhoExit(Sender: TObject);
    procedure edTamanhoKeyPress(Sender: TObject; var Key: Char);
    procedure edValorPagoEnter(Sender: TObject);
    procedure edValorPagoKeyPress(Sender: TObject; var Key: Char);
    procedure edValorPagoExit(Sender: TObject);
    procedure dbGrdProdutosDblClick(Sender: TObject);
    procedure dbGrdProdutosTitleClick(Column: TColumn);
    procedure edTipoProdutoEnter(Sender: TObject);
    procedure edTipoProdutoExit(Sender: TObject);
    procedure btBtnAbreTipoProdutoClick(Sender: TObject);
    procedure edCodigo2Enter(Sender: TObject);
    procedure edCodigo2Exit(Sender: TObject);
    procedure cbBxTipoProdutoChange(Sender: TObject);
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
    procedure carrega();//carrega dados da tabela Produto para os componentes de apresentação
    procedure mostraTodosProdutos();//exibe todos os Produtos

    (*PROCEDURES ESPECÍFICAS*)
    function pegaCodigo(): Integer;//pega código do Produto, conforme letra
    procedure pegaTipoProdutos();//pega tipo de produtos
  public
   (*VARIÁVEIS DE CONTROLE*)
    codTipoProduto: Integer; //controle do tipo de produto

    operacao: String; //recebe valor para saber em que modo inicia a tela
  end;

var
  frmProduto: TfrmProduto;

implementation

uses unDM, unRelatorioHistoricoProduto, unSelecionaTipoProduto;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{pega tipo de produtos}
procedure TfrmProduto.pegaTipoProdutos();
begin
  DM.qryTipoProduto.Close;
  DM.qryTipoProduto.SQL.Clear;
  DM.qryTipoProduto.SQL.Add('SELECT * FROM Tipo_Produto t ORDER BY t.tipo');
  DM.qryTipoProduto.Prepared := true;
  DM.qryTipoProduto.Open;
  DM.cdsTipoProduto.Open;
  DM.cdsTipoProduto.Refresh;

  cbBxTipoProduto.Clear;
  cbBxTipoProduto.Items.Add('TODAS');
  DM.cdsTipoProduto.First;
  while(not(DM.cdsTipoProduto.Eof))do
    begin
    cbBxTipoProduto.Items.Add(DM.cdsTipoProdutoTIPO.AsString);
    DM.cdsTipoProduto.Next;
    end;
  cbBxTipoProduto.ItemIndex := 0;
end;

{pega código do Produto, conforme letra}
function TfrmProduto.pegaCodigo(): Integer;
var
  letra: Integer;
  cod: Integer;
begin
{  DM.qryCodigoProduto.Close;
  DM.qryCodigoProduto.SQL.Clear;
  DM.qryCodigoProduto.SQL.Add('SELECT * FROM Codigo_Produto c WHERE c.codigo=1');
  DM.qryCodigoProduto.Prepared := true;
  DM.qryCodigoProduto.Open;
  DM.cdsCodigoProduto.Open;
  DM.cdsCodigoProduto.Refresh;

  letra := cbBxLetraCodigo.ItemIndex;
  case letra of
    0: cod := DM.cdsCodigoProdutoA.AsInteger;
    1: cod := DM.cdsCodigoProdutoB.AsInteger;
    2: cod := DM.cdsCodigoProdutoC.AsInteger;
    3: cod := DM.cdsCodigoProdutoD.AsInteger;
    4: cod := DM.cdsCodigoProdutoE.AsInteger;
    5: cod := DM.cdsCodigoProdutoF.AsInteger;
    6: cod := DM.cdsCodigoProdutoG.AsInteger;
    7: cod := DM.cdsCodigoProdutoH.AsInteger;
    8: cod := DM.cdsCodigoProdutoI.AsInteger;
    9: cod := DM.cdsCodigoProdutoJ.AsInteger;
    10: cod := DM.cdsCodigoProdutoL.AsInteger;
    11: cod := DM.cdsCodigoProdutoM.AsInteger;
    12: cod := DM.cdsCodigoProdutoN.AsInteger;
    13: cod := DM.cdsCodigoProdutoO.AsInteger;
    14: cod := DM.cdsCodigoProdutoP.AsInteger;
    15: cod := DM.cdsCodigoProdutoQ.AsInteger;
    16: cod := DM.cdsCodigoProdutoR.AsInteger;
    17: cod := DM.cdsCodigoProdutoS.AsInteger;
    18: cod := DM.cdsCodigoProdutoT.AsInteger;
    19: cod := DM.cdsCodigoProdutoU.AsInteger;
    20: cod := DM.cdsCodigoProdutoV.AsInteger;
    21: cod := DM.cdsCodigoProdutoX.AsInteger;
    22: cod := DM.cdsCodigoProdutoZ.AsInteger;
    23: cod := DM.cdsCodigoProdutoY.AsInteger;
    24: cod := DM.cdsCodigoProdutoW.AsInteger;
    25: cod := DM.cdsCodigoProdutoK.AsInteger;
  end;

  inc(cod);

  Result := cod;
}end;

{carrega dados da tabela Produto para os componentes de apresentação}
procedure TfrmProduto.carrega();
begin
  //Self.limpar();

  //tipo do produto
  DM.qryTipoProduto.Close;
  DM.qryTipoProduto.SQL.Clear;
  DM.qryTipoProduto.SQL.Add('SELECT * FROM Tipo_Produto t WHERE t.codigo=:cod');
  DM.qryTipoProduto.ParamByName('cod').AsInteger := DM.cdsProdutoCOD_TIPO_PRODUTO.AsInteger;
  DM.qryTipoProduto.Prepared := true;
  DM.qryTipoProduto.Open;

  DM.cdsTipoProduto.Open;
  DM.cdsTipoProduto.Refresh;

  edTipoProduto.Text := DM.cdsTipoProdutoTIPO.AsString;
  Self.codTipoProduto := DM.cdsProdutoCOD_TIPO_PRODUTO.AsInteger;

  edCodigo.Text := DM.cdsProdutoCODIGO.AsString;
  edCodigo2.Text := DM.cdsProdutoCODIGO2.AsString;
  edNome.Text := DM.cdsProdutoNOME.AsString;
  edMarca.Text := DM.cdsProdutoMARCA.AsString;
  edTamanho.Text := DM.cdsProdutoTAMANHO.AsString;
  mmDescricao.Text := DM.cdsProdutoDESCRICAO.AsString;
  edValorLocacao.Text := FormatFloat('#0.00',DM.cdsProdutoVALOR_LOCACAO.AsFloat);
  edValorVenda.Text := FormatFloat('#0.00',DM.cdsProdutoVALOR_VENDA.AsFloat);
  edValorPago.Text := FormatFloat('#0.00',DM.cdsProdutoVALOR_PAGO.AsFloat);
  if(DM.cdsProdutoDATA_VENDA.AsString = '')then
    lblStatus.Caption := 'ESTOQUE'
  else
    lblStatus.Caption := 'VENDIDO';

end;

{dispara uma transação}
procedure TfrmProduto.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

{limpar componentes}
procedure TfrmProduto.limpar();
begin
  edCodigo.Clear;
  edCodigo2.Clear;
  edTipoProduto.Clear;
  Self.codTipoProduto := 0;
  edNome.Clear;
  edMarca.Clear;
  edTamanho.Clear;
  mmDescricao.Clear;
  edValorLocacao.Clear;
  edValorVenda.Clear;
  edValorPago.Clear;
  lblStatus.Caption := '';

  cbBxTipoProduto.ItemIndex := 0;
  edPesquisa.Clear;
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
end;

{verifica se os campos obrigatórios foram inseridos antes de salvar}
function TfrmProduto.verificaSalva(): boolean;
var
  campos: String;
  retorno: boolean;
begin

  campos := '';
  retorno := true;

  if (edNome.Text = '')then
    campos := 'Nome';

  if (edCodigo2.Text = '')then
    begin
    if (campos='')then
      campos := 'Código (usado no cadastro)'
    else
      campos := campos + ', Código (usado no cadastro)';
    end;

  if (Self.codTipoProduto=0) then
    begin
    if (campos='') then
      campos := 'Tipo de Produto'
    else
      campos := campos + ', Tipo de Produto';
    end;

  if (campos <> '') then
    begin
    MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
    retorno := false;
    end;

  //verificando código2
  if (retorno=true)then
    begin
    DM.qryPesquisaProduto.Close;
    DM.qryPesquisaProduto.SQL.Clear;
    DM.qryPesquisaProduto.SQL.Add('SELECT * FROM Produto p WHERE p.codigo2=:cod2');
    DM.qryPesquisaProduto.ParamByName('cod2').AsString := edCodigo2.Text;
    DM.qryPesquisaProduto.Prepared := true;
    DM.qryPesquisaProduto.Open;
    DM.cdsPesquisaProduto.Open;
    DM.cdsPesquisaProduto.Refresh;
    if(DM.cdsPesquisaProduto.RecordCount > 0)then
      begin
      MessageDlg('Código 2 já cadastrado para o Produto '+DM.cdsProdutoNOME.AsString,mtInformation,[mbOK],0);
      retorno := false;
      end;
    end;

  Result := retorno;
end;

{exibe todos os Produtos}
procedure TfrmProduto.mostraTodosProdutos();
begin
  cbBxTipoProduto.ItemIndex := 0;
  DM.cdsProduto.Filter := '';
  DM.cdsProduto.Filtered := false;

  DM.qryProduto.Close;
  DM.qryProduto.SQL.Clear;
  DM.qryProduto.SQL.Add('SELECT * From Produto p ');
  if(campoOrdenado<>'')then
    DM.qryProduto.SQL.Add('ORDER BY '+campoOrdenado);
  DM.qryProduto.Prepared := true;
  DM.qryProduto.Open;

  DM.cdsProduto.Open;
  DM.cdsProduto.Refresh;

  pegaTipoProdutos();
end;

{quais componentes exibir/ocultar}
 procedure TfrmProduto.visibilidade(opc: Integer);
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
       grpBxDadosProduto.Enabled := true;
       dbGrdProdutos.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edCodigo2.SetFocus;
       end;

    {editar}
    11: begin
       grpBxDadosProduto.Enabled := true;
       //edCodigo2.Enabled := true;
       dbGrdProdutos.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edCodigo2.SetFocus;
       end;

    {salvar}
    21: begin
       grpBxDadosProduto.Enabled := false;
       dbGrdProdutos.Enabled := true;
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
        tlBtnSalvar.Enabled := false;

        mostraTodosProdutos();
        if (DM.cdsProduto.RecordCount > 0) then
          begin
          dbGrdProdutos.Enabled := true;
          tlBtnEditar.Enabled := true;
          tlBtnExcluir.Enabled := true;
          end
        else
          begin
          dbGrdProdutos.Enabled := false;
          tlBtnEditar.Enabled := false;
          tlBtnExcluir.Enabled := false;
          end;
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
         dbGrdProdutos.Enabled := true;
         tlBtnEditar.Enabled := true;
         tlBtnExcluir.Enabled := true;
         end
       else
         begin
         dbGrdProdutos.Enabled := false;
         tlBtnEditar.Enabled := false;
         tlBtnExcluir.Enabled := false;
         end;
       end;

  end;//case


end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmProduto.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmProduto.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  fechar := false;
  opcaoSalvar := 1;//novo
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';
  visibilidade(1);
end;

procedure TfrmProduto.tlBtnEditarClick(Sender: TObject);
begin
  {preparando}
  visibilidade(11);
  opcaoSalvar := 2;//editar
  fechar := false;
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Edição';
end;

procedure TfrmProduto.tlBtnCancelarClick(Sender: TObject);
begin
  limpar();
  mostraTodosProdutos();
  DM.cdsProduto.Last;
  carrega();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
  //caso tela auxiliar chamou produto para fazer novo cadastro
  if (Self.operacao = 'novo') then
    Self.Close;
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
    DM.cdsProduto.Last;
    carrega();
    StatusBar.Panels[1].Text := '';
    visibilidade(41);
    end;

end;

procedure TfrmProduto.dbGrdProdutosCellClick(Column: TColumn);
begin
  carrega();
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Navegação';

  tlBtnNovo.Enabled := true;
  tlBtnSalvar.Enabled := false;
  tlBtnCancelar.Enabled := false;
end;

procedure TfrmProduto.tlBtnSalvarClick(Sender: TObject);
var
  sql: String;
  codLetra: Integer;
begin
  if (verificaSalva = true) then
    begin
    case opcaoSalvar of
      1: begin //novo
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryProduto.Close;
         DM.qryProduto.SQL.Clear;
         DM.qryProduto.SQL.Add('INSERT INTO Produto (codigo2,cod_tipo_produto,nome,marca,tamanho,descricao,valor_locacao,valor_venda,valor_pago,status) ');
         DM.qryProduto.SQL.Add('VALUES (:cod2,:co_ti_pr,:nom,:mar,:tam,:des,:valLoc,:valVen,:valPag,:sta)');

         codLetra := pegaCodigo();
         DM.qryProduto.ParamByName('cod2').AsString :=  edCodigo2.Text;
         DM.qryProduto.ParamByName('co_ti_pr').AsInteger := Self.codTipoProduto;
         DM.qryProduto.ParamByName('nom').AsString := edNome.Text;
         DM.qryProduto.ParamByName('mar').AsString := edMarca.Text;
         if (edTamanho.Text <> '') then
           DM.qryProduto.ParamByName('tam').AsInteger := StrToInt(edTamanho.Text)
         else
           DM.qryProduto.ParamByName('tam').AsInteger := 0;
         DM.qryProduto.ParamByName('des').AsString := mmDescricao.Text;
         if (edValorLocacao.Text <> '') then
           DM.qryProduto.ParamByName('valLoc').AsFloat := StrToFloat(edValorLocacao.Text)
         else
           DM.qryProduto.ParamByName('valLoc').AsFloat := 0;
         if (edValorVenda.Text <> '') then
           DM.qryProduto.ParamByName('valVen').AsFloat := StrToFloat(edValorVenda.Text)
         else
           DM.qryProduto.ParamByName('valVen').AsFloat := 0;
         if (edValorPago.Text <> '') then
           DM.qryProduto.ParamByName('valPag').AsFloat := StrToFloat(edValorPago.Text)
         else
           DM.qryProduto.ParamByName('valPag').AsFloat := 0;
         DM.qryProduto.ParamByName('sta').AsInteger := 0;

         DM.qryProduto.Prepared := true;
         DM.qryProduto.ExecSQL();

         //acrescentando mais um no código da letra
{         sql := 'UPDATE codigo_produto c SET ' + cbBxLetraCodigo.Text + '=' + IntToStr(codLetra) + ' WHERE codigo=1';
         DM.qryCodigoProduto.Close;
         DM.qryCodigoProduto.SQL.Clear;
         DM.qryCodigoProduto.SQL.Add(sql);
         DM.qryCodigoProduto.Prepared := true;
         DM.qryCodigoProduto.ExecSQL();
 }
         DM.SQLConnection.Commit(transacao);
         MessageDlg('Produto salvo com sucesso!',mtInformation,[mbOk],0);
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
         DM.qryProduto.SQL.Add('UPDATE Produto SET cod_tipo_produto=:co_ti_pr,nome=:nom,marca=:mar,tamanho=:tam,descricao=:des,valor_locacao=:valLoc,valor_venda=:valVen,valor_pago=:valPag ');
         DM.qryProduto.SQL.Add('WHERE codigo=:cod');

         DM.qryProduto.ParamByName('co_ti_pr').AsInteger := Self.codTipoProduto;
         DM.qryProduto.ParamByName('nom').AsString := edNome.Text;
         DM.qryProduto.ParamByName('mar').AsString := edMarca.Text;
         if(edTamanho.Text <> '') then
           DM.qryProduto.ParamByName('tam').AsInteger := StrToInt(edTamanho.Text)
         else
           DM.qryProduto.ParamByName('tam').AsInteger := 0;
         DM.qryProduto.ParamByName('des').AsString := mmDescricao.Text;
         if (edValorLocacao.Text <> '') then
           DM.qryProduto.ParamByName('valLoc').AsFloat := StrToFloat(edValorLocacao.Text)
         else
           DM.qryProduto.ParamByName('valLoc').AsFloat := 0;
         if (edValorVenda.Text <> '') then
           DM.qryProduto.ParamByName('valVen').AsFloat := StrToFloat(edValorVenda.Text)
         else
           DM.qryProduto.ParamByName('valVen').AsFloat := 0;
         if (edValorPago.Text <> '') then
           DM.qryProduto.ParamByName('valPag').AsFloat := StrToFloat(edValorPago.Text)
         else
           DM.qryProduto.ParamByName('valPag').AsFloat := 0;
         DM.qryProduto.ParamByName('cod').AsInteger := StrToInt(edCodigo.Text);

         DM.qryProduto.Prepared := true;
         DM.qryProduto.ExecSQL();



         DM.SQLConnection.Commit(transacao);
         MessageDlg('Produto editado com sucesso!',mtInformation,[mbOk],0);
         fechar := true;
         except
           MessageDlg('Produto não pode ser editado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           DM.SQLConnection.Rollback(transacao);
         end;

         end;

    end;//case
    {selecionando todos os Produtos}
    mostraTodosProdutos();
    {atualizando ClientDataSet}
    DM.cdsProduto.Last;
    carrega();
    StatusBar.Panels[1].Text := 'OPERAÇÃO = Salvar';
    visibilidade(21);
    //caso tela auxiliar chamou cliente para fazer novo cadastro
    if (Self.operacao = 'novo') then
        Self.Close;
  end;//if
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

procedure TfrmProduto.edPesquisaEnter(Sender: TObject);
begin
  edPesquisa.Color := clMoneyGreen;
end;

procedure TfrmProduto.edCodigoEnter(Sender: TObject);
begin
  edCodigo.Color := clMoneyGreen;
end;

procedure TfrmProduto.edNomeEnter(Sender: TObject);
begin
  edNome.Color := clMoneyGreen;
end;

procedure TfrmProduto.mmDescricaoEnter(Sender: TObject);
begin
  mmDescricao.Color := clMoneyGreen;
end;

procedure TfrmProduto.edValorLocacaoEnter(Sender: TObject);
begin
  edValorLocacao.Color := clMoneyGreen;
end;

procedure TfrmProduto.edValorVendaEnter(Sender: TObject);
begin
  edValorVenda.Color := clMoneyGreen;
end;

procedure TfrmProduto.edValorVendaExit(Sender: TObject);
begin
  try
    edValorVenda.Text := FormatFloat('#0.00',StrToFloat(edValorVenda.Text));
  except
  end;

  edValorVenda.Color := clWindow;
end;

procedure TfrmProduto.edValorLocacaoExit(Sender: TObject);
begin
  try
    edValorLocacao.Text := FormatFloat('#0.00',StrToFloat(edValorLocacao.Text));
  except
  end;

  edValorLocacao.Color := clWindow;
end;

procedure TfrmProduto.mmDescricaoExit(Sender: TObject);
begin
  mmDescricao.Color := clWindow;
end;

procedure TfrmProduto.edNomeExit(Sender: TObject);
begin
  edNome.Color := clWindow;
end;

procedure TfrmProduto.edCodigoExit(Sender: TObject);
begin
  edCodigo.Color := clWindow;
end;

procedure TfrmProduto.edPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=13) then
    btBtnPesquisarClick(Sender);
end;

procedure TfrmProduto.edPesquisaExit(Sender: TObject);
begin
  edPesquisa.Color := clWindow;
end;

procedure TfrmProduto.edPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmProduto.btBtnPesquisarClick(Sender: TObject);
var
  codTipPro: Integer;
begin
  {código}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.qryProduto.Close;
    DM.qryProduto.SQL.Clear;
    DM.qryProduto.SQL.Add('SELECT * FROM Produto p WHERE p.codigo=:cod ');
    if(cbBxTipoProduto.ItemIndex <> 0)then
      begin
      DM.qryTipoProduto.Close;
      DM.qryTipoProduto.SQL.Clear;
      DM.qryTipoProduto.SQL.Add('SELECT * FROM Tipo_Produto t WHERE t.tipo=:tip');
      DM.qryTipoProduto.ParamByName('tip').AsString := cbBxTipoProduto.Text;
      DM.qryTipoProduto.Prepared := true;
      DM.qryTipoProduto.Open;
      DM.cdsTipoProduto.Open;
      DM.cdsTipoProduto.Refresh;
      if(DM.cdsTipoProduto.RecordCount<>0)then
        begin
        codTipPro := DM.cdsTipoProdutoCODIGO.AsInteger;
        DM.qryProduto.SQL.Add('AND p.cod_tipo_produto=:codTipPro');
        DM.qryProduto.ParamByName('codTipPro').AsInteger := codTipPro;
        end;
      end;
    DM.qryProduto.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.qryProduto.Open;

    DM.cdsProduto.Open;
    DM.cdsProduto.Refresh;

    if (DM.cdsProduto.RecordCount = 0) then
      begin
      MessageDlg('Nenhum Produto encontrado com o código '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosProdutos();
      end;
    end;

  {nome}
  if (rdBtnNome.Checked = true) then
    begin
    DM.qryProduto.Close;
    DM.qryProduto.SQL.Clear;
    DM.qryProduto.SQL.Add('SELECT * FROM Produto p WHERE p.nome LIKE '+QuotedStr('%'+edPesquisa.Text+'%'));
    if(cbBxTipoProduto.ItemIndex <> 0)then
      begin
      DM.qryTipoProduto.Close;
      DM.qryTipoProduto.SQL.Clear;
      DM.qryTipoProduto.SQL.Add('SELECT * FROM Tipo_Produto t WHERE t.tipo=:tip');
      DM.qryTipoProduto.ParamByName('tip').AsString := cbBxTipoProduto.Text;
      DM.qryTipoProduto.Prepared := true;
      DM.qryTipoProduto.Open;
      DM.cdsTipoProduto.Open;
      DM.cdsTipoProduto.Refresh;
      if(DM.cdsTipoProduto.RecordCount<>0)then
        begin
        codTipPro := DM.cdsTipoProdutoCODIGO.AsInteger;
        DM.qryProduto.SQL.Add('AND p.cod_tipo_produto=:codTipPro');
        DM.qryProduto.ParamByName('codTipPro').AsInteger := codTipPro;
        end;
      end;
    if(campoOrdenado<>'')then
      DM.qryProduto.SQL.Add('ORDER BY '+campoOrdenado);
    DM.qryProduto.Prepared := true;
    DM.qryProduto.Open;

    DM.cdsProduto.Open;
    DM.cdsProduto.Refresh;

    if (DM.cdsProduto.RecordCount = 0) then
      begin
      MessageDlg('Nenhum Produto encontrado com o nome '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosProdutos();
      end;
    end;

  DM.cdsProduto.Last;
  carrega();

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmProduto.edValorLocacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmProduto.edValorVendaKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
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
begin
  limpar();
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;
  try
    mostraTodosProdutos();
    DM.cdsProduto.First;
    if(DM.cdsProduto.RecordCount>0)then
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

procedure TfrmProduto.ppMnMostrarTodosProdutosClick(Sender: TObject);
begin
  limpar();
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;
  cbBxTipoProduto.ItemIndex := 0;
  mostraTodosProdutos();
  DM.cdsProduto.Last;
  carrega();
end;

procedure TfrmProduto.cbBxStatusSelect(Sender: TObject);
begin
  btBtnPesquisarClick(Sender);
end;

procedure TfrmProduto.edMarcaEnter(Sender: TObject);
begin
  edMarca.Color := clMoneyGreen;
end;

procedure TfrmProduto.edTamanhoEnter(Sender: TObject);
begin
  edTamanho.Color := clMoneyGreen;
end;

procedure TfrmProduto.edMarcaExit(Sender: TObject);
begin
  edMarca.Color := clWindow;
end;

procedure TfrmProduto.edTamanhoExit(Sender: TObject);
begin
  edTamanho.Color := clWindow;
end;

procedure TfrmProduto.edTamanhoKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',Chr(8)])then
    Key:= #0;
end;

procedure TfrmProduto.edValorPagoEnter(Sender: TObject);
begin
  edValorPago.Color := clMoneyGreen;
end;

procedure TfrmProduto.edValorPagoKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmProduto.edValorPagoExit(Sender: TObject);
begin
  try
    edValorPago.Text := FormatFloat('#0.00',StrToFloat(edValorPago.Text));
  except
  end;

  edValorPago.Color := clWindow;
end;

procedure TfrmProduto.dbGrdProdutosDblClick(Sender: TObject);
begin
  Application.CreateForm(TqckRepHistoricoProduto,qckRepHistoricoProduto);

  //abrindo query
  qckRepHistoricoProduto.qryHistorico.Close;
  qckRepHistoricoProduto.qryHistorico.SQL.Clear;
  qckRepHistoricoProduto.qryHistorico.SQL.Add('SELECT r.data_inicio,r.data_final,ir.valor_total,c.nome, '+''''+'Reserva Pendente'+''''+' AS Operacao ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('FROM reserva r,item_reserva ir,cliente c ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('WHERE r.codigo=ir.cod_reserva ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('AND r.cod_cliente=c.codigo ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('AND r.status=0 ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('AND r.data_inicio>current_timestamp ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('AND ir.cod_produto=:codPro ');

  qckRepHistoricoProduto.qryHistorico.SQL.Add('UNION ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('SELECT l.data_inicio,l.data_final,il.valor_total,c.nome, '+''''+'Locação'+''''+' AS Operacao ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('FROM locacao l,item_locacao il,cliente c ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('WHERE l.codigo=il.cod_locacao ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('AND l.cod_cliente=c.codigo ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('AND il.cod_produto=:codPro ');

  qckRepHistoricoProduto.qryHistorico.SQL.Add('UNION ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('SELECT v.data_venda,v.data_venda,iv.valor_total,c.nome, '+''''+'Venda'+''''+' AS Operacao ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('FROM venda v,item_venda iv,cliente c ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('WHERE v.codigo=iv.cod_venda ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('AND v.cod_cliente=c.codigo ');
  qckRepHistoricoProduto.qryHistorico.SQL.Add('AND iv.cod_produto=:codPro ');

  qckRepHistoricoProduto.qryHistorico.ParamByName('codPro').AsInteger := DM.cdsProdutoCODIGO.AsInteger;
  qckRepHistoricoProduto.qryHistorico.Prepared := true;
  qckRepHistoricoProduto.qryHistorico.Open;
  qckRepHistoricoProduto.cdsHistorico.Open;
  qckRepHistoricoProduto.cdsHistorico.Refresh;

  qckRepHistoricoProduto.qrLblCodigo.Caption := DM.cdsProdutoCODIGO.AsString;
  qckRepHistoricoProduto.qrLblCodigo2.Caption := DM.cdsProdutoCODIGO2.AsString;
  DM.qryTipoProduto.Close;
  DM.qryTipoProduto.SQL.Clear;
  DM.qryTipoProduto.SQL.Add('SELECT * FROM Tipo_Produto p WHERE p.codigo=:cod');
  DM.qryTipoProduto.ParamByName('cod').AsInteger := DM.cdsProdutoCOD_TIPO_PRODUTO.AsInteger;
  DM.qryTipoProduto.Prepared := true;
  DM.qryTipoProduto.Open;
  DM.cdsTipoProduto.Open;
  DM.cdsTipoProduto.Refresh;
  if(DM.cdsTipoProduto.RecordCount=0)then
    qckRepHistoricoProduto.qrLblTipoProduto.Caption := 'NÃO POSSUI'
  else
    qckRepHistoricoProduto.qrLblTipoProduto.Caption := DM.cdsTipoProdutoTIPO.AsString;
  qckRepHistoricoProduto.qrLblProduto.Caption := DM.cdsProdutoNOME.AsString;
  qckRepHistoricoProduto.qrMmDescricao.Caption := DM.cdsProdutoDESCRICAO.AsString;
  qckRepHistoricoProduto.qrLblMarca.Caption := DM.cdsProdutoMARCA.AsString;
  qckRepHistoricoProduto.qrLblTamanho.Caption := DM.cdsProdutoTAMANHO.AsString;
  qckRepHistoricoProduto.qrLblVlrCompra.Caption := FormatFloat('#0.00',DM.cdsProdutoVALOR_PAGO.AsFloat);

  qckRepHistoricoProduto.Prepare;
  qckRepHistoricoProduto.Preview;
  qckRepHistoricoProduto.Free;
end;

procedure TfrmProduto.dbGrdProdutosTitleClick(Column: TColumn);
var
  campo: string;
begin
  campo:=column.fieldname; // campo recebe o nome da coluna clicada
  application.processmessages; // para considerar algo que aconteça no dbgrid durante a entrada nesta procedure
  DM.qryProduto.Close;
  DM.qryProduto.SQL.Clear;
  DM.qryProduto.SQL.Add('SELECT * FROM Produto ORDER BY '+campo);
  DM.qryProduto.Prepared := true;
  DM.qryProduto.Open;
  DM.cdsProduto.Open;
  DM.cdsProduto.Refresh;

  //column.Font.color:=clblue; // COLOCAR A COLUNA NA COR DESEJADA
  campoOrdenado := campo;
end;

procedure TfrmProduto.edTipoProdutoEnter(Sender: TObject);
begin
  edTipoProduto.Color := clMoneyGreen;
end;

procedure TfrmProduto.edTipoProdutoExit(Sender: TObject);
begin
  edTipoProduto.Color := clWindow;
end;

procedure TfrmProduto.btBtnAbreTipoProdutoClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaTipoProduto,frmSelecionaTipoProduto);
  frmSelecionaTipoProduto.tela := 'produto';
  frmSelecionaTipoProduto.ShowModal;
  frmSelecionaTipoProduto.Free;
end;

procedure TfrmProduto.edCodigo2Enter(Sender: TObject);
begin
  edCodigo2.Color := clMoneyGreen;
end;


procedure TfrmProduto.edCodigo2Exit(Sender: TObject);
begin
  edCodigo2.Color := clWindow;
end;

procedure TfrmProduto.cbBxTipoProdutoChange(Sender: TObject);
var
  codTipPro: Integer;
begin
  if(cbBxTipoProduto.ItemIndex <> 0)then
    begin
    DM.qryTipoProduto.Close;
    DM.qryTipoProduto.SQL.Clear;
    DM.qryTipoProduto.SQL.Add('SELECT * FROM Tipo_Produto t WHERE t.tipo=:tip');
    DM.qryTipoProduto.ParamByName('tip').AsString := cbBxTipoProduto.Text;
    DM.qryTipoProduto.Prepared := true;
    DM.qryTipoProduto.Open;
    DM.cdsTipoProduto.Open;
    DM.cdsTipoProduto.Refresh;
    if(DM.cdsTipoProduto.RecordCount<>0)then
      begin
      codTipPro := DM.cdsTipoProdutoCODIGO.AsInteger;
      {tipo produto}
      if(cbBxTipoProduto.ItemIndex<>0)then
        begin
        DM.cdsProduto.Filter := 'cod_tipo_produto='+QuotedStr(IntToStr(codTipPro));
        DM.cdsProduto.Filtered := true;
        end
      else
        begin
        DM.cdsProduto.Filter := '';
        DM.cdsProduto.Filtered := false;
        limpar();
        mostraTodosProdutos();
        end;
      DM.cdsCliente.First;
      carrega();
      end
    else
      MessageDlg('Tipo de Produto não encontrado!',mtInformation,[mbOK],0);
    end

  else
    begin
    DM.cdsProduto.Filter := '';
    DM.cdsProduto.Filtered := false;
    limpar();
    mostraTodosProdutos();
    end;

  DM.cdsProduto.First;
  carrega();
end;

end.
