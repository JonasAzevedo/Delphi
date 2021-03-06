unit unContasPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, FMTBcd, DB, DBClient, Provider, SqlExpr, StdCtrls,
  Buttons, Grids, DBGrids, ExtCtrls, AppEvnts, Menus,DBXpress, Mask;

type
  TfrmContasPagar = class(TForm)
    StatusBar: TStatusBar;
    qryContasPagar: TSQLQuery;
    dspContasPagar: TDataSetProvider;
    cdsContasPagar: TClientDataSet;
    dsContasPagar: TDataSource;
    grpBxContasPagar: TGroupBox;
    dbGrdContasPagar: TDBGrid;
    qryContasPagarCODIGO: TIntegerField;
    qryContasPagarPRODUTO: TStringField;
    qryContasPagarFORNECEDOR: TStringField;
    qryContasPagarDATA: TDateField;
    qryContasPagarQUANTIDADE: TFMTBCDField;
    qryContasPagarVALOR_TOTAL: TFMTBCDField;
    qryContasPagarVALOR_PAGO: TFMTBCDField;
    cdsContasPagarCODIGO: TIntegerField;
    cdsContasPagarPRODUTO: TStringField;
    cdsContasPagarFORNECEDOR: TStringField;
    cdsContasPagarDATA: TDateField;
    cdsContasPagarQUANTIDADE: TFMTBCDField;
    cdsContasPagarVALOR_TOTAL: TFMTBCDField;
    cdsContasPagarVALOR_PAGO: TFMTBCDField;
    grpBxPesquisa: TGroupBox;
    rdBtnCodigo: TRadioButton;
    rdBtnProduto: TRadioButton;
    edPesquisa: TEdit;
    btBtnPesquisar: TBitBtn;
    rdBtnFornecedor: TRadioButton;
    pnlDivisao: TPanel;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodasContasPagar: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblCodigo: TLabel;
    lblProduto: TLabel;
    lblFornecedor: TLabel;
    lblData: TLabel;
    lblQuantidade: TLabel;
    lblValorTotal: TLabel;
    lblValorPago: TLabel;
    Label8: TLabel;
    edValorBaixa: TEdit;
    bvlDivisao: TBevel;
    btBtnPagar: TBitBtn;
    Label9: TLabel;
    mEdData: TMaskEdit;
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnProdutoClick(Sender: TObject);
    procedure rdBtnFornecedorClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure ppMnMostrarTodasContasPagarClick(Sender: TObject);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure dbGrdContasPagarCellClick(Column: TColumn);
    procedure edValorBaixaEnter(Sender: TObject);
    procedure edValorBaixaExit(Sender: TObject);
    procedure edValorBaixaKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnPagarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mEdDataEnter(Sender: TObject);
    procedure mEdDataExit(Sender: TObject);
  private
    (*VARI�VEIS DE CONTROLE*)
    Transacao: TTransactionDesc;//transa��es - deve-se adicionar a uses DBXpress
    resta: Real;//valor que resta pagar da conta

    (*PROCEDURES DE CONTROLE*)
    procedure iniciaTransacao();//dispara uma transa��o
    procedure limpar();//limpa componentes de apresenta��o
    procedure mostraTodasContas();//exibe todas as Contas � Pagar
    procedure carrega();//carrega Conta � Pagar nos componentes de apresenta��o
  public

  end;
var
  frmContasPagar: TfrmContasPagar;

implementation

uses unDataModule;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{limpa componentes de apresenta��o}
procedure TfrmContasPagar.limpar();
begin
  rdBtnCodigo.Checked := false;
  rdBtnProduto.Checked := false;
  rdBtnFornecedor.Checked := false;
  edPesquisa.Clear;

  lblCodigo.Caption := '';
  lblProduto.Caption := '';
  lblFornecedor.Caption := '';
  lblData.Caption := '';
  lblQuantidade.Caption := '';
  lblValorTotal.Caption := '';
  lblValorPago.Caption := '';
  edValorBaixa.Clear;
  resta := 0;
end;

procedure TfrmContasPagar.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

{exibe todas as Contas � Pagar}
procedure TfrmContasPagar.mostraTodasContas();
begin
  qryContasPagar.Close;
  qryContasPagar.SQL.Clear;
  qryContasPagar.SQL.Add('SELECT c.codigo,p.nome AS Produto,f.razao_social AS Fornecedor,c.data,c.quantidade,c.valor_total,c.valor_pago ');
  qryContasPagar.SQL.Add('FROM Compra c, Produto p, Fornecedor f WHERE c.pago = 2 AND c.cod_produto = p.codigo AND c.cod_fornecedor = f.codigo');
  qryContasPagar.Prepared := true;
  qryContasPagar.Open;

  cdsContasPagar.Active := false;
  cdsContasPagar.Active := true;
  cdsContasPagar.Refresh;

  limpar();
  carrega();
end;

{carrega Conta � Pagar nos componentes de apresenta��o}
procedure TfrmContasPagar.carrega();
begin
  lblCodigo.Caption := cdsContasPagarCODIGO.AsString;
  lblProduto.Caption := cdsContasPagarPRODUTO.AsString;
  lblFornecedor.Caption := cdsContasPagarFORNECEDOR.AsString;
  lblData.Caption := cdsContasPagarDATA.AsString;
  lblQuantidade.Caption := FormatFloat('#0.00',cdsContasPagarQUANTIDADE.AsFloat);
  lblValorTotal.Caption := FormatFloat('#0.00',cdsContasPagarVALOR_TOTAL.AsFloat);
  lblValorPago.Caption := FormatFloat('#0.00',cdsContasPagarVALOR_PAGO.AsFloat);
  resta := cdsContasPagarVALOR_TOTAL.AsFloat - cdsContasPagarVALOR_PAGO.AsFloat;
  edValorBaixa.Text := FormatFloat('#0.00',resta);
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmContasPagar.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmContasPagar.rdBtnProdutoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';  
end;

procedure TfrmContasPagar.rdBtnFornecedorClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';  
end;

procedure TfrmContasPagar.edPesquisaChange(Sender: TObject);
begin
  if (edPesquisa.Text = '')then
    btBtnPesquisar.Enabled := false;

  if(edPesquisa.Text <> '')then
    begin
    if((rdBtnCodigo.Checked = true)or(rdBtnProduto.Checked = true)or(rdBtnFornecedor.Checked = true))then
      btBtnPesquisar.Enabled := true
    else
      btBtnPesquisar.Enabled := false;
    end;
end;

procedure TfrmContasPagar.edPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmContasPagar.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmContasPagar.ppMnMostrarTodasContasPagarClick(
  Sender: TObject);
begin
  mostraTodasContas();
end;

procedure TfrmContasPagar.btBtnPesquisarClick(Sender: TObject);
begin
  limpar();

 {c�digo}
  if (rdBtnCodigo.Checked = true) then
    begin
    qryContasPagar.Close;
    qryContasPagar.SQL.Clear;
    qryContasPagar.SQL.Add('SELECT c.codigo,p.nome AS Produto,f.razao_social AS Fornecedor,c.data,c.quantidade,c.valor_total,c.valor_pago ');
    qryContasPagar.SQL.Add('FROM Compra c, Produto p, Fornecedor f ');
    qryContasPagar.SQL.Add('WHERE c.pago = 2 AND c.cod_produto = p.codigo AND c.cod_fornecedor = f.codigo ');
    qryContasPagar.SQL.Add('AND c.codigo=:cod');
    qryContasPagar.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    qryContasPagar.Prepared := true;
    qryContasPagar.Open;

    cdsContasPagar.Refresh;

    if(cdsContasPagar.RecordCount = 0)then
      begin
      MessageDlg('Nenhuma Conta encontrada com o c�digo ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodasContas();
      end;

    cdsContasPagar.Refresh;
    cdsContasPagar.Last;
    carrega();
    end;

  {produto}
  if (rdBtnProduto.Checked = true) then
    begin
    qryContasPagar.Close;
    qryContasPagar.SQL.Clear;
    qryContasPagar.SQL.Add('SELECT c.codigo,p.nome AS Produto,f.razao_social AS Fornecedor,c.data,c.quantidade,c.valor_total,c.valor_pago ');
    qryContasPagar.SQL.Add('FROM Compra c, Produto p, Fornecedor f ');
    qryContasPagar.SQL.Add('WHERE c.pago = 2 AND c.cod_produto = p.codigo AND c.cod_fornecedor = f.codigo ');
    qryContasPagar.SQL.Add('AND p.nome=:nom');
    qryContasPagar.ParamByName('nom').AsString := edPesquisa.Text;
    qryContasPagar.Prepared := true;
    qryContasPagar.Open;

    cdsContasPagar.Refresh;

    if(cdsContasPagar.RecordCount = 0)then
      begin
      MessageDlg('Nenhuma Conta encontrada com o Produto ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodasContas();
      end;

    cdsContasPagar.Refresh;
    cdsContasPagar.Last;
    carrega();
    end;

  {fornecedor}
  if (rdBtnFornecedor.Checked = true) then
    begin
    qryContasPagar.Close;
    qryContasPagar.SQL.Clear;
    qryContasPagar.SQL.Add('SELECT c.codigo,p.nome AS Produto,f.razao_social AS Fornecedor,c.data,c.quantidade,c.valor_total,c.valor_pago ');
    qryContasPagar.SQL.Add('FROM Compra c, Produto p, Fornecedor f ');
    qryContasPagar.SQL.Add('WHERE c.pago = 2 AND c.cod_produto = p.codigo AND c.cod_fornecedor = f.codigo ');
    qryContasPagar.SQL.Add('AND f.razao_social=:raz');
    qryContasPagar.ParamByName('raz').AsString := edPesquisa.Text;
    qryContasPagar.Prepared := true;
    qryContasPagar.Open;

    cdsContasPagar.Refresh;

    if(cdsContasPagar.RecordCount = 0)then
      begin
      MessageDlg('Nenhuma Conta encontrada com o Fornecedor ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodasContas();
      end;

    cdsContasPagar.Refresh;
    cdsContasPagar.Last;
    carrega();
    end;

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmContasPagar.dbGrdContasPagarCellClick(Column: TColumn);
begin
  carrega();
end;

procedure TfrmContasPagar.edValorBaixaEnter(Sender: TObject);
begin
  edValorBaixa.Color := clMedGray;
end;

procedure TfrmContasPagar.edValorBaixaExit(Sender: TObject);
var
  valor: Real;
begin
  try
    valor := StrToFloat(edValorBaixa.Text);
    edValorBaixa.Text := FormatFloat('#0.00',valor);
  except
  end;

  edValorBaixa.Color := clWindow;
end;

procedure TfrmContasPagar.edValorBaixaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmContasPagar.btBtnPagarClick(Sender: TObject);
var
  valorPagar: Real;
  valorPago: Real;
  total: Real;
begin
  if ((mEdData.Text = '  /  /    ')or(edValorBaixa.Text = ''))then
    MessageDlg('Complete os campos antes de realizar o pagamento!',mtInformation,[mbOK],0)
  else
    begin
    valorPagar := StrToFloat(edValorBaixa.Text);
    valorPago := StrToFloat(lblValorPago.Caption);
    total := valorPagar + valorPago;

    //valor a ser pago � maior que o restante da conta
    if (valorPagar > resta)then
      begin
      MessageDlg('Resta apenas R$'+FormatFloat('#0.00',resta)+' a serem pagos!',mtInformation,[mbOK],0);
      edValorBaixa.Text := FormatFloat('#0.00',resta);
      end
    else

    //realizar pagamento
      begin
      if (MessageDlg('Deseja Pagar R$'+FormatFloat('#0.00',valorPagar)+ ' na referida conta?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
        begin
        iniciaTransacao();
        DM.SQLConnection.StartTransaction(transacao);

        DM.qryCompra.Close;
        DM.qryCompra.SQL.Clear;
        DM.qryCompra.SQL.Add('UPDATE Compra c SET c.valor_pago=:val WHERE c.codigo=:cod');
        DM.qryCompra.ParamByName('val').AsFloat := total;
        DM.qryCompra.ParamByName('cod').AsInteger := StrToInt(lblCodigo.Caption);
        DM.qryCompra.Prepared := true;
        DM.qryCompra.ExecSQL();

        DM.qrySaida.Close;
        DM.qrySaida.SQL.Clear;
        DM.qrySaida.SQL.Add('INSERT INTO Saida (cod_compra,data,valor) ');
        DM.qrySaida.SQL.Add('VALUES (:codCom,:dat,:val)');
        DM.qrySaida.ParamByName('codCom').AsInteger := StrToInt(lblCodigo.Caption);
        DM.qrySaida.ParamByName('dat').AsDate := StrToDate(mEdData.Text);
        DM.qrySaida.ParamByName('val').AsFloat := StrToFloat(edValorBaixa.Text);
        DM.qrySaida.Prepared := true;
        DM.qrySaida.ExecSQL();

        //toda a conta j� foi paga, realizar baixa total
        if (valorPagar = resta)then
          begin
          DM.qryCompra.Close;
          DM.qryCompra.SQL.Clear;
          DM.qryCompra.SQL.Add('UPDATE Compra c SET c.pago=:pag WHERE c.codigo=:cod');
          DM.qryCompra.ParamByName('pag').AsInteger := 1;
          DM.qryCompra.ParamByName('cod').AsInteger := StrToInt(lblCodigo.Caption);
          DM.qryCompra.Prepared := true;
          DM.qryCompra.ExecSQL();
          end;

        DM.SQLConnection.Commit(transacao);
        mostraTodasContas();
        end;
      end;

    end;
end;

procedure TfrmContasPagar.FormShow(Sender: TObject);
begin
  mostraTodasContas();
  mEdData.Text := DateToStr(Date);
end;

procedure TfrmContasPagar.mEdDataEnter(Sender: TObject);
begin
  edValorBaixa.Color := clMedGray;
end;

procedure TfrmContasPagar.mEdDataExit(Sender: TObject);
begin
  edValorBaixa.Color := clWindow;
end;

end.
