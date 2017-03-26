unit unCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr, AppEvnts, ImgList,
  ExtCtrls, Grids, DBGrids, ComCtrls, StdCtrls, Buttons, Mask, ToolWin, DBXpress, SQLTimSt;

type
  TfrmCompra = class(TForm)
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnCancelar: TToolButton;
    ToolButton1: TToolButton;
    tlBtnFinalizar: TToolButton;
    grpBxDadosCompra: TGroupBox;
    lblCodigo: TLabel;
    lblObservacao: TLabel;
    lblNome: TLabel;
    lblData: TLabel;
    lblInfValorTotal: TLabel;
    lblValorTotal: TLabel;
    edCodigo: TEdit;
    edFornecedor: TEdit;
    mmObservacao: TMemo;
    mEdDataCompra: TMaskEdit;
    btBtnAbreFornecedor: TBitBtn;
    StatusBar: TStatusBar;
    grpBxItensCompra: TGroupBox;
    dbGrdItensCompra: TDBGrid;
    pnlBotoesItensLocacao: TPanel;
    btBtnInserirItem: TBitBtn;
    btBtnExcluirItem: TBitBtn;
    imgLista: TImageList;
    ApplicationEvents: TApplicationEvents;
    qryItens: TSQLQuery;
    dspItens: TDataSetProvider;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    qryValorTotal: TSQLQuery;
    qryValorTotalTotal: TFMTBCDField;
    dspValorTotal: TDataSetProvider;
    cdsValorTotal: TClientDataSet;
    cdsValorTotalTotal: TFMTBCDField;
    dsValorTotal: TDataSource;
    qryItensCODIGO: TIntegerField;
    qryItenscodProduto: TIntegerField;
    qryItensProduto: TStringField;
    qryItensVALOR_TOTAL: TFMTBCDField;
    cdsItensCODIGO: TIntegerField;
    cdsItenscodProduto: TIntegerField;
    cdsItensProduto: TStringField;
    cdsItensVALOR_TOTAL: TFMTBCDField;
    Label1: TLabel;
    mEdVencimento: TMaskEdit;
    btBtnConfirmar: TBitBtn;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure edCodigoEnter(Sender: TObject);
    procedure edFornecedorEnter(Sender: TObject);
    procedure mEdDataCompraEnter(Sender: TObject);
    procedure mmObservacaoEnter(Sender: TObject);
    procedure mmObservacaoExit(Sender: TObject);
    procedure mEdDataCompraExit(Sender: TObject);
    procedure edFornecedorExit(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure tlBtnFinalizarClick(Sender: TObject);
    procedure btBtnInserirItemClick(Sender: TObject);
    procedure btBtnAbreFornecedorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btBtnExcluirItemClick(Sender: TObject);
    procedure mEdVencimentoEnter(Sender: TObject);
    procedure mEdVencimentoExit(Sender: TObject);
    procedure btBtnConfirmarClick(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress
    fechar: boolean; //se pode ou não fechar tela - casos de novo/editar, em que não pode fechar
    valorTotal: Real; //valor total da compra

    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
    function verificaSalva(): boolean; //verifica se os campos obrigatórios foram inseridos antes de salvar
    procedure visibilidade(opc: Integer);//quais componentes exibir/ocultar
    procedure iniciaTransacao();//dispara uma transação

    (*PROCEDURES ESPECÍFICAS*)
    procedure pegaItens(); //pega itens da compra atual
  public
    codFornecedor: Integer; //controle do fornecedor

    operacao: String; //recebe valor para saber em que modo inicia a tela
  end;

var
  frmCompra: TfrmCompra;

implementation

uses unDM, unValorPago, unItemProdutoCompra, unSelecionaFornecedor;

{$R *.dfm}

(*PROCEDURES ESPECÍFICAS*)

//pega itens da venda atual
procedure TfrmCompra.pegaItens();
begin
  //itens da locação
  qryItens.Close;
  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT i.codigo,p.codigo AS "codProduto", p.nome AS "Produto", i.valor_total ');
  qryItens.SQL.Add('FROM produto p, item_compra i ');
  qryItens.SQL.Add('WHERE i.cod_produto=p.codigo ');
  qryItens.SQL.Add('AND i.cod_compra=:codCom');
  qryItens.ParamByName('codCom').AsInteger := StrToInt(edCodigo.Text);
  qryItens.Prepared := true;
  qryItens.Open;
  cdsItens.Open;
  cdsItens.Refresh;
  if (cdsItens.RecordCount=0) then
    btBtnExcluirItem.Enabled := false
  else
    btBtnExcluirItem.Enabled := true;

  //valor total da locação
  qryValorTotal.Close;
  qryValorTotal.SQL.Clear;
  qryValorTotal.SQL.Add('SELECT SUM (i.valor_total) AS "Total" ');
  qryValorTotal.SQL.Add('FROM produto p, item_compra i ');
  qryValorTotal.SQL.Add('WHERE i.cod_produto=p.codigo AND i.cod_compra=:codCom');
  qryValorTotal.ParamByName('codCom').AsInteger := StrToInt(edCodigo.Text);
  qryValorTotal.Prepared := true;
  qryValorTotal.Open;
  cdsValorTotal.Open;
  cdsValorTotal.Refresh;

  lblValorTotal.Caption := FormatFloat('#0.00',cdsValorTotalTotal.AsFloat);
end;

(*FIM PROCEDURES ESPECÍFICAS*)


(*PROCEDURES DE CONTROLE*)

{dispara uma transação}
procedure TfrmCompra.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

{limpar componentes}
procedure TfrmCompra.limpar();
begin
  codFornecedor := 0;
  valorTotal := 0;

  edCodigo.Clear;
  edFornecedor.Clear;
  mEdDataCompra.Clear;
  mmObservacao.Clear;
  lblValorTotal.Caption :=  '0,00';

  qryItens.Close;
  cdsItens.Close;
end;

{verifica se os campos obrigatórios foram inseridos antes de salvar}
function TfrmCompra.verificaSalva(): boolean;
var
  campos: String;
  retorno: boolean;
  dataCompra,dataVencimento: TDate;
begin

  campos := '';
  retorno := true;

  if (codFornecedor = 0)then
    campos := 'Fornecedor';

  if (mEdDataCompra.Text = '  /  /    ') then
    begin
    if (campos = '') then
      campos := 'Data da Compra'
    else
      campos := campos + ', Data da Compra';
    end;

  if (mEdVencimento.Text = '  /  /    ') then
    begin
    if (campos = '') then
      campos := 'Data de Vencimento'
    else
      campos := campos + ', Data de Vencimento';
    end;

  if (campos <> '') then
    begin
    MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
    retorno := false;
    end
  else
    begin
    //verificando se a data do vencimento é maior que a data da compra
    dataCompra := StrToDate(mEdDataCompra.Text);
    dataVencimento := StrToDate(mEdVencimento.Text);
    if (dataCompra > dataVencimento) then
      begin
      MessageDlg('A Data do Vencimento deve ser maior que a Data  da Compra!',mtInformation,[mbOK],0);
      retorno := false;
      end
    end;

  Result := retorno;
end;

{quais componentes exibir/ocultar}
 procedure TfrmCompra.visibilidade(opc: Integer);
begin

  {
  1 = novo
  21 = salvar
  41 = cancelar
  }

  case opc of
    {novo}
    1:  begin
        grpBxDadosCompra.Enabled := true;
        grpBxItensCompra.Enabled := false;
        tlBtnNovo.Enabled := false;
        btBtnConfirmar.Enabled := true;
        tlBtnCancelar.Enabled := true;
        tlBtnFinalizar.Enabled := false;
        mEdDataCompra.Text := DateTimeToStr(Now);
        btBtnAbreFornecedor.SetFocus;
        end;

    {salvar}
    21: begin
        grpBxDadosCompra.Enabled := false;
        grpBxItensCompra.Enabled := true;
        tlBtnNovo.Enabled := false;
        btBtnConfirmar.Enabled := false;
        tlBtnCancelar.Enabled := true;
        tlBtnFinalizar.Enabled := true;
        end;

    {cancelar}
    41: begin
        grpBxDadosCompra.Enabled := false;
        grpBxItensCompra.Enabled := false;
        tlBtnNovo.Enabled := true;
        btBtnConfirmar.Enabled := false;
        tlBtnCancelar.Enabled := false;
        tlBtnFinalizar.Enabled := false;
        end;
  end;//case
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmCompra.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmCompra.edCodigoEnter(Sender: TObject);
begin
  edCodigo.Color := clMoneyGreen;
end;

procedure TfrmCompra.edFornecedorEnter(Sender: TObject);
begin
  edFornecedor.Color := clMoneyGreen;
end;

procedure TfrmCompra.mEdDataCompraEnter(Sender: TObject);
begin
  mEdDataCompra.Color := clMoneyGreen;
end;

procedure TfrmCompra.mmObservacaoEnter(Sender: TObject);
begin
  mmObservacao.Color := clMoneyGreen;
end;

procedure TfrmCompra.mmObservacaoExit(Sender: TObject);
begin
  mmObservacao.Color := clWindow;
end;

procedure TfrmCompra.mEdDataCompraExit(Sender: TObject);
begin
  mEdDataCompra.Color := clWindow;
end;

procedure TfrmCompra.edFornecedorExit(Sender: TObject);
begin
  edFornecedor.Color := clWindow;
end;

procedure TfrmCompra.edCodigoExit(Sender: TObject);
begin
  edCodigo.Color := clWindow;
end;

procedure TfrmCompra.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  fechar := false;
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';
  visibilidade(1);
end;

procedure TfrmCompra.tlBtnCancelarClick(Sender: TObject);
begin
  if (edCodigo.Text <> '') then
    begin
    try
      iniciaTransacao();
      DM.SQLConnection.StartTransaction(transacao);

      //deletando produtos
      DM.qryItemCompra.Close;
      DM.qryItemCompra.SQL.Clear;
      DM.qryItemCompra.SQL.Add('SELECT * FROM Item_Compra WHERE cod_compra=:codCom');
      DM.qryItemCompra.ParamByName('codCom').AsInteger := StrToInt(edCodigo.Text);
      DM.qryItemCompra.Prepared := true;
      DM.qryItemCompra.Open;
      DM.cdsItemCompra.Open;
      DM.cdsItemCompra.Refresh;
      if(DM.cdsItemCompra.RecordCount<>0)then
        begin
        DM.cdsItemCompra.First;
        while(not(DM.cdsItemCompra.Eof))do
          begin
          DM.qryProduto.Close;
          DM.qryProduto.SQL.Clear;
          DM.qryProduto.SQL.Add('DELETE FROM Produto WHERE codigo=:cod');
          DM.qryProduto.ParamByName('cod').AsInteger := DM.cdsItemCompraCOD_PRODUTO.AsInteger;
          DM.qryProduto.Prepared := true;
          DM.qryProduto.ExecSQL();
          DM.cdsItemCompra.Next;
          end;
        end;
{
      //deletando itens da compra
      DM.qryItemCompra.Close;
      DM.qryItemCompra.SQL.Clear;
      DM.qryItemCompra.SQL.Add('DELETE FROM Item_Compra WHERE cod_compra=:codCom');
      DM.qryItemCompra.ParamByName('codCom').AsInteger := StrToInt(edCodigo.Text);
      DM.qryItemCompra.Prepared := true;
      DM.qryItemCompra.ExecSQL();
}
      //deletando compra
      DM.qryCompra.Close;
      DM.qryCompra.SQL.Clear;
      DM.qryCompra.SQL.Add('DELETE FROM Compra WHERE codigo=:cod ');
      DM.qryCompra.ParamByName('cod').AsInteger := StrToInt(edCodigo.Text);
      DM.qryCompra.Prepared := true;
      DM.qryCompra.ExecSQL();

      DM.SQLConnection.Commit(transacao);
      MessageDlg('Compra cancelada com sucesso!',mtInformation,[mbOk],0);
      limpar();
      StatusBar.Panels[1].Text := '';
      fechar := true;
      visibilidade(41);
      Self.Close;
    except
      MessageDlg('Compra não pode ser cancelada!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
      DM.SQLConnection.Rollback(transacao);
    end;
    end
  else
    begin
    limpar();
    StatusBar.Panels[1].Text := '';
    fechar := true;
    visibilidade(41);
    end;
end;

procedure TfrmCompra.tlBtnFinalizarClick(Sender: TObject);
begin
  pegaItens();
  if(cdsItens.RecordCount=0)then
    MessageDlg('Não há nenhum item na Compra!',mtInformation,[mbOK],0)
  else
    begin
    Application.CreateForm(TfrmValorPago,frmValorPago);

    frmValorPago.tela := 'compra';
    //código compra
    frmValorPago.codOperacao := StrToInt(edCodigo.Text);
    frmValorPago.codFornecedor := Self.codFornecedor;
    frmValorPago.lblInfOperacao.Caption := 'COMPRA:';
    frmValorPago.lblOperacao.Caption := edCodigo.Text;
    //valor total compra
    frmValorPago.edValorTotal.Text := lblValorTotal.Caption;
    frmValorPago.vlrTotal := StrToFloat(lblValorTotal.Caption);
    //data de vencimento da compra
    frmValorPago.dtVencimento := StrToDate(mEdVencimento.Text);

    frmValorPago.ShowModal;
    frmValorPago.Free;
    fechar := true;
    visibilidade(41);
    Self.Close;
    end;
end;

procedure TfrmCompra.btBtnInserirItemClick(Sender: TObject);
begin
  Application.CreateForm(TfrmProdutoCompra,frmProdutoCompra);
  frmProdutoCompra.codOperacao := StrToInt(edCodigo.Text);
  frmProdutoCompra.ShowModal;
  frmProdutoCompra.Free;

  pegaItens();
end;

procedure TfrmCompra.btBtnAbreFornecedorClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaFornecedor,frmSelecionaFornecedor);
  frmSelecionaFornecedor.tela := 'compra';
  frmSelecionaFornecedor.ShowModal;
  frmSelecionaFornecedor.Free;
end;

procedure TfrmCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ((fechar = false)or(tlBtnFinalizar.Enabled=true)) then
    begin
    MessageDlg('Finalize ou cancele a compra!',mtInformation,[mbOK],0);
    Action := caNone;
    end

  else
  operacao := '';
end;

procedure TfrmCompra.FormShow(Sender: TObject);
begin
  limpar();

  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);

  if (operacao = 'novo') then
    tlBtnNovoClick(Sender);
end;

procedure TfrmCompra.btBtnExcluirItemClick(Sender: TObject);
var
  produto: String;
begin
  produto := cdsItensProduto.AsString;

  if(cdsItens.RecordCount <> 0)then
    begin
    if (MessageDlg('Deseja deletar o Produto '+produto+' da venda atual?',mtConfirmation,[mbYes,mbNo],0)=mrYes) then
      begin
      try
        iniciaTransacao();
        DM.SQLConnection.StartTransaction(transacao);

        DM.qryItemCompra.Close;
        DM.qryItemCompra.SQL.Clear;
        DM.qryItemCompra.SQL.Add('DELETE FROM Item_Compra i WHERE i.codigo=:cod');
        DM.qryItemCompra.ParamByName('cod').AsInteger := cdsItensCODIGO.AsInteger;
        DM.qryItemCompra.Prepared := true;
        DM.qryItemCompra.ExecSQL();
        
        DM.qryProduto.Close;
        DM.qryProduto.SQL.Clear;
        DM.qryProduto.SQL.Add('DELETE FROM Produto WHERE codigo=:cod');
        DM.qryProduto.ParamByName('cod').AsInteger := cdsItenscodProduto.AsInteger;
        DM.qryProduto.Prepared := true;
        DM.qryProduto.ExecSQL();

        DM.SQLConnection.Commit(transacao);
        MessageDlg('Produto '+produto+' deletado com sucesso!',mtInformation,[mbOK],0);
      except
        DM.SQLConnection.Rollback(transacao);
        MessageDlg('Produto '+produto+' não pode ser deletado!',mtError,[mbOK],0);
      end;
      end;
    end
  else
    MessageDlg('Não há produtos na compra para serem deletados!',mtInformation,[mbOK],0);
  pegaItens();
end;


procedure TfrmCompra.mEdVencimentoEnter(Sender: TObject);
begin
  mEdVencimento.Color := clMoneyGreen;
end;

procedure TfrmCompra.mEdVencimentoExit(Sender: TObject);
begin
  mEdVencimento.Color := clWindow;
end;

procedure TfrmCompra.btBtnConfirmarClick(Sender: TObject);
begin
  if (verificaSalva = true) then
    begin
    try
    iniciaTransacao();
    DM.SQLConnection.StartTransaction(transacao);

    DM.qryCompra.Close;
    DM.qryCompra.SQL.Clear;
    DM.qryCompra.SQL.Add('INSERT INTO Compra (cod_fornecedor,data_compra,observacoes,vencimento) ');
    DM.qryCompra.SQL.Add('VALUES (:codFor,:datCom,:obs,:ven)');

    DM.qryCompra.ParamByName('codFor').AsInteger := codFornecedor;
    DM.qryCompra.ParamByName('datCom').AsDate := StrToDate(mEdDataCompra.Text);
    DM.qryCompra.ParamByName('obs').AsString := mmObservacao.Text;
    DM.qryCompra.ParamByName('ven').AsDate := StrToDate(mEdVencimento.Text);

    DM.qryCompra.Prepared := true;
    DM.qryCompra.ExecSQL();

    DM.SQLConnection.Commit(transacao);
    MessageDlg('Compra salva com sucesso!',mtInformation,[mbOk],0);

    //pegando úlitma compra
    DM.qryCompra.Close;
    DM.qryCompra.SQL.Clear;
    DM.qryCompra.SQL.Add('SELECT * FROM Compra c ORDER BY c.codigo');
    DM.qryCompra.Prepared := true;
    DM.qryCompra.Open;
    DM.cdsCompra.Open;
    DM.cdsCompra.Refresh;
    DM.cdsCompra.Last;
    edCodigo.Text := DM.cdsCompraCODIGO.AsString;
    except
      MessageDlg('Compra não pode ser salva!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
      DM.SQLConnection.Rollback(transacao);
    end;

    StatusBar.Panels[1].Text := 'OPERAÇÃO = Salvar';
    visibilidade(21);
    end;
end;

end.
