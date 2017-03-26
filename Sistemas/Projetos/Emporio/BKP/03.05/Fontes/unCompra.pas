unit unCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, AppEvnts, Menus, StdCtrls, ComCtrls, Buttons, ExtCtrls,
  ToolWin, Grids, DBGrids, Mask, DBXpress;

type
  TfrmCompra = class(TForm)
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnCancelar: TToolButton;
    StatusBar: TStatusBar;
    grpBxDadosCompra: TGroupBox;
    lblCodigo: TLabel;
    edCodigo: TEdit;
    ApplicationEvents: TApplicationEvents;
    imgLista: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edProduto: TEdit;
    edFornecedor: TEdit;
    edValorTotal: TEdit;
    edQuantidade: TEdit;
    edValorUnitario: TEdit;
    mEdData: TMaskEdit;
    cbBxPago: TComboBox;
    btBtnAbreProduto: TBitBtn;
    btBtnAbreFornecedor: TBitBtn;
    procedure edCodigoEnter(Sender: TObject);
    procedure edProdutoEnter(Sender: TObject);
    procedure edFornecedorEnter(Sender: TObject);
    procedure mEdDataEnter(Sender: TObject);
    procedure edQuantidadeEnter(Sender: TObject);
    procedure edValorUnitarioEnter(Sender: TObject);
    procedure edValorTotalEnter(Sender: TObject);
    procedure cbBxPagoEnter(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure edProdutoExit(Sender: TObject);
    procedure edFornecedorExit(Sender: TObject);
    procedure mEdDataExit(Sender: TObject);
    procedure edQuantidadeExit(Sender: TObject);
    procedure edValorUnitarioExit(Sender: TObject);
    procedure edValorTotalExit(Sender: TObject);
    procedure cbBxPagoExit(Sender: TObject);
    procedure edQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure edValorTotalKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure btBtnAbreFornecedorClick(Sender: TObject);
    procedure btBtnAbreProdutoClick(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    Transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress
    fechar: boolean; //se pode ou não fechar tela - casos de novo/editar, em que não pode fechar

    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
    function verificaSalva(): boolean; //verifica se os campos obrigatórios foram inseridos antes de salvar
    procedure visibilidade(opc: Integer);//quais componentes exibir/ocultar
    procedure iniciaTransacao();//dispara uma transação
  public
   (*VARIÁVEIS DE CONTROLE*)
    operacao: String; //recebe valor para saber em que modo inicia a tela
    codProduto,codFornecedor: Integer; //código do produto e fornecedor da compra
    nomeFornecedor,nomeProduto: String; //nome do produto e fornecedor da compra
  end;

var
  frmCompra: TfrmCompra;

implementation

uses unDataModule, unSelecionaFornecedor, unSelecionaProduto;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

procedure TfrmCompra.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

procedure TfrmCompra.limpar();

begin
  grpBxDadosCompra.Enabled := true;
  edCodigo.Clear;
  edProduto.Clear;
  edFornecedor.Clear;
  mEdData.Clear;
  edQuantidade.Clear;
  edValorUnitario.Clear;
  edValorTotal.Clear;
  cbBxPago.ItemIndex := -1;
  codproduto := 0;
  codfornecedor := 0;
  nomeProduto := '';
  nomeFornecedor := '';
end;

{verifica se os campos obrigatórios foram inseridos antes de salvar}
function TfrmCompra.verificaSalva(): boolean;
var
  campos: String;
begin
    campos := '';

    if (codProduto = 0)then
      campos := 'Produto';
    if (codFornecedor = 0)then
      begin
      if (campos = '')then
          campos := 'Fornecedor'
        else
          campos := campos + ', Fornecedor';
      end;
    if (edQuantidade.Text = '')then
      begin
      if (campos = '')then
          campos := 'Quantidade'
        else
          campos := campos + ', Quantidade';
      end;
    if (edValorUnitario.Text = '')then
      begin
      if (campos = '')then
          campos := 'Valor Unitário'
        else
          campos := campos + ', Valor Unitário';
      end;
    if (edValorTotal.Text = '')then
      begin
      if (campos = '')then
          campos := 'Valor Total'
        else
          campos := campos + ', Valor Total';
      end;
    if (cbBxPago.ItemIndex = -1)then
      begin
      if (campos = '')then
          campos := 'Pago ou Não'
        else
          campos := campos + ', Pago ou Não';
      end;

    if (campos <> '') then
      begin
      MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
      Result := false;
      end
    else
      Result := true;
end;

//quais componentes exibir/ocultar
procedure TfrmCompra.visibilidade(opc: Integer);
begin
//cuidar na visibilidade - caso pessoa jurídica e física

  {a seqüência númerica pula de 10 em 10 - 1,2,3....11,12,13...
  1 = novo
  21 = salvar
  41 = cancelar
  }

  case opc of
    {novo inicial}
    1: begin
       grpBxDadosCompra.Enabled := true;
       tlBtnNovo.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnCancelar.Enabled := true;
       end;

    {salvar}
    21: begin
       grpBxDadosCompra.Enabled := false;
       tlBtnNovo.Enabled := true;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;
       end;

    {cancelar}
    41: begin
       grpBxDadosCompra.Enabled := false;
       tlBtnNovo.Enabled := true;                             
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;
       end;

  end;//case


end;          

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmCompra.edCodigoEnter(Sender: TObject);
begin
  edCodigo.Color := clMedGray;
end;

procedure TfrmCompra.edProdutoEnter(Sender: TObject);
begin
  edProduto.Color := clMedGray;
end;

procedure TfrmCompra.edFornecedorEnter(Sender: TObject);
begin
  edFornecedor.Color := clMedGray;
end;

procedure TfrmCompra.mEdDataEnter(Sender: TObject);
begin
  mEdData.Color := clMedGray;
end;

procedure TfrmCompra.edQuantidadeEnter(Sender: TObject);
begin
  edQuantidade.Color := clMedGray;
end;

procedure TfrmCompra.edValorUnitarioEnter(Sender: TObject);
begin
  edValorUnitario.Color := clMedGray;
end;

procedure TfrmCompra.edValorTotalEnter(Sender: TObject);
begin
  edValorTotal.Color := clMedGray;
end;

procedure TfrmCompra.cbBxPagoEnter(Sender: TObject);
begin
  cbBxPago.Color := clMedGray;
end;

procedure TfrmCompra.edCodigoExit(Sender: TObject);
begin
  edCodigo.Color := clWindow;
end;

procedure TfrmCompra.edProdutoExit(Sender: TObject);
begin
  edProduto.Color := clWindow;
end;

procedure TfrmCompra.edFornecedorExit(Sender: TObject);
begin
  edFornecedor.Color := clWindow;
end;

procedure TfrmCompra.mEdDataExit(Sender: TObject);
begin
  mEdData.Color := clWindow;
end;

procedure TfrmCompra.edQuantidadeExit(Sender: TObject);
var
  valor: Real;
begin
  try
    valor := StrToFloat(edQuantidade.Text);
    edQuantidade.Text := FormatFloat('#0.00',valor);
  except
  end;    

  edQuantidade.Color := clWindow;
end;

procedure TfrmCompra.edValorUnitarioExit(Sender: TObject);
var
  valor: Real;
begin
  try
    valor := StrToFloat(edValorUnitario.Text);
    edValorUnitario.Text := FormatFloat('#0.00',valor);
  except
  end;    

  edValorUnitario.Color := clWindow;
end;

procedure TfrmCompra.edValorTotalExit(Sender: TObject);
var
  valor: Real;
begin
  try
    valor := StrToFloat(edValorTotal.Text);
    edValorTotal.Text := FormatFloat('#0.00',valor);
  except
  end;    

  edValorTotal.Color := clWindow;
end;

procedure TfrmCompra.cbBxPagoExit(Sender: TObject);
begin
  cbBxPago.Color := clWindow;
end;

procedure TfrmCompra.edQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmCompra.edValorUnitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmCompra.edValorTotalKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (fechar = false) then
    begin
    MessageDlg('Salve ou cancele antes o processo que se encontra em operação!',mtInformation,[mbOK],0);
    Action := caNone;
    end

  else
  operacao := '';
end;

procedure TfrmCompra.FormShow(Sender: TObject);
begin
  limpar();
  fechar := true;

  StatusBar.Panels[1].Text := '';
  visibilidade(41);

  if (operacao = 'novo') then
    tlBtnNovoClick(Sender);
end;

procedure TfrmCompra.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmCompra.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  visibilidade(1);
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';
  fechar := false;

  btBtnAbreProduto.SetFocus;
end;

procedure TfrmCompra.tlBtnCancelarClick(Sender: TObject);
begin
  limpar();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmCompra.tlBtnSalvarClick(Sender: TObject);
var
  estoqueNovo: Real;
  valorPago: Real;
begin

  btBtnAbreProduto.SetFocus;
  if (verificaSalva() = true) then
    begin
      try
      iniciaTransacao();
      DM.SQLConnection.StartTransaction(transacao);

      //salvando compra
      DM.qryCompra.Close;
      DM.qryCompra.SQL.Clear;
      DM.qryCompra.SQL.Add('INSERT INTO Compra (cod_produto,cod_fornecedor,data,quantidade,pago,valor_unitario,valor_total,estoque,valor_pago) ');
      DM.qryCompra.SQL.Add('VALUES(:codPro,:codFor,:dat,:qua,:pag,:valUni,:valTot,:est,:valPag)');
      DM.qryCompra.ParamByName('codPro').AsInteger := codProduto;
      DM.qryCompra.ParamByName('codFor').AsInteger := codFornecedor;
      DM.qryCompra.ParamByName('dat').AsDate := StrToDate(mEdData.Text);
      DM.qryCompra.ParamByName('qua').AsFloat := StrToFloat(edQuantidade.Text);
      if (cbBxPago.ItemIndex = 0) then
        begin
        DM.qryCompra.ParamByName('pag').AsInteger := 1;
        DM.qryCompra.ParamByName('valPag').AsFloat := StrToFloat(edValorTotal.Text);
        end
      else if (cbBxPago.ItemIndex = 1) then
        begin
        DM.qryCompra.ParamByName('pag').AsInteger := 2;
        DM.qryCompra.ParamByName('valPag').AsFloat := 0;
        end;
      DM.qryCompra.ParamByName('valUni').AsFloat := StrToFloat(edValorUnitario.Text);
      DM.qryCompra.ParamByName('valTot').AsFloat := StrToFloat(edValorTotal.Text);
      DM.qryCompra.ParamByName('est').AsFloat := StrToFloat(edQuantidade.Text);

      DM.qryCompra.Prepared := true;
      DM.qryCompra.ExecSQL();

      //editando estoque do produto
      estoqueNovo := DM.cdsProdutoESTOQUE.AsFloat + StrToFloat(edQuantidade.Text);
      //editando valor pago do produto
      valorPago := (DM.cdsProdutoVALOR_PAGO.AsFloat * DM.cdsProdutoESTOQUE.AsFloat)+(StrToFloat(edValorUnitario.Text)*StrToFloat(edQuantidade.Text)/(DM.cdsProdutoESTOQUE.AsFloat + StrToFloat(edQuantidade.Text)));


      DM.qryProduto.Close;
      DM.qryProduto.SQL.Clear;
      DM.qryProduto.SQL.Add('UPDATE Produto SET estoque=:est, valor_pago=:val WHERE codigo=:cod');
      DM.qryProduto.ParamByName('est').AsFloat := estoqueNovo;
      DM.qryProduto.ParamByName('val').AsFloat := valorPago;
      DM.qryProduto.ParamByName('cod').AsInteger := codProduto;
      DM.qryProduto.Prepared := true;
      DM.qryProduto.ExecSQL();

      DM.SQLConnection.Commit(transacao);
      fechar := true;
      except
        MessageDlg('Compra não pode ser salva!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
        DM.SQLConnection.Rollback(transacao);
      end;

  end;//if

  StatusBar.Panels[1].Text := 'OPERAÇÃO = Salvar';
  visibilidade(21);
end;

procedure TfrmCompra.btBtnAbreFornecedorClick(Sender: TObject);
begin
  frmSelecionaFornecedor.tela := 'compra';
  frmSelecionaFornecedor.ShowModal;
end;

procedure TfrmCompra.btBtnAbreProdutoClick(Sender: TObject);
begin
  frmSelecionaProduto.btBtnSelecionarProduto.Caption := 'Selecionar Produto da Compra';
  frmSelecionaProduto.tela := 'compra';
  frmSelecionaProduto.ShowModal;
end;

end.
