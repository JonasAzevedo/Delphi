unit unContasReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, AppEvnts, Menus, DB, DBClient, Provider, SqlExpr, Mask,
  ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, ComCtrls, DBXpress;

type
  TfrmContasReceber = class(TForm)
    StatusBar: TStatusBar;
    grpBxContasReceber: TGroupBox;
    dbGrdContasPagar: TDBGrid;
    grpBxPesquisa: TGroupBox;
    rdBtnCodigo: TRadioButton;
    rdBtnCliente: TRadioButton;
    edPesquisa: TEdit;
    btBtnPesquisar: TBitBtn;
    pnlDivisao1: TPanel;
    qryContasReceber: TSQLQuery;
    dspContasReceber: TDataSetProvider;
    cdsContasReceber: TClientDataSet;
    dsContasReceber: TDataSource;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodasContasReceber: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    qryContasReceberCODIGO: TIntegerField;
    qryContasReceberNOME: TStringField;
    qryContasReceberDATA: TDateField;
    qryContasReceberVALOR_TOTAL: TFMTBCDField;
    qryContasReceberVALOR_PAGO: TFMTBCDField;
    cdsContasReceberCODIGO: TIntegerField;
    cdsContasReceberNOME: TStringField;
    cdsContasReceberDATA: TDateField;
    cdsContasReceberVALOR_TOTAL: TFMTBCDField;
    cdsContasReceberVALOR_PAGO: TFMTBCDField;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    lblCodigo: TLabel;
    lblCliente: TLabel;
    lblData: TLabel;
    lblValorTotal: TLabel;
    lblValorPago: TLabel;
    Label8: TLabel;
    bvlDivisao: TBevel;
    Label9: TLabel;
    edValorBaixa: TEdit;
    btBtnPagar: TBitBtn;
    mEdData: TMaskEdit;
    qryItens: TSQLQuery;
    qryItensCODIGO: TIntegerField;
    qryItensNOME: TStringField;
    qryItensQUANTIDADE: TFMTBCDField;
    qryItensVALOR: TFMTBCDField;
    dspItens: TDataSetProvider;
    cdsItens: TClientDataSet;
    cdsItensCODIGO: TIntegerField;
    cdsItensNOME: TStringField;
    cdsItensQUANTIDADE: TFMTBCDField;
    cdsItensVALOR: TFMTBCDField;
    dsItens: TDataSource;
    grpBxItens: TGroupBox;
    dbGrdItens: TDBGrid;
    pblDivisao2: TPanel;
    qryContasReceberVALOR_LIQUIDO: TFMTBCDField;
    cdsContasReceberVALOR_LIQUIDO: TFMTBCDField;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnClienteClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure ppMnMostrarTodasContasReceberClick(Sender: TObject);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure dbGrdContasPagarCellClick(Column: TColumn);
    procedure edValorBaixaEnter(Sender: TObject);
    procedure mEdDataExit(Sender: TObject);
    procedure mEdDataEnter(Sender: TObject);
    procedure edValorBaixaKeyPress(Sender: TObject; var Key: Char);
    procedure edValorBaixaExit(Sender: TObject);
    procedure btBtnPagarClick(Sender: TObject);
  private
    (*VARI�VEIS DE CONTROLE*)
    Transacao: TTransactionDesc;//transa��es - deve-se adicionar a uses DBXpress
    resta: Real;//valor que resta pagar da conta

    (*PROCEDURES DE CONTROLE*)
    procedure iniciaTransacao();//dispara uma transa��o
    procedure limpar();//limpa componentes de apresenta��o
    procedure mostraTodasContas();//exibe todas as Contas � Receber
    procedure carrega();//carrega Conta � Receber nos componentes de apresenta��o
  public

  end;
var
  frmContasReceber: TfrmContasReceber;

implementation

uses unDataModule;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{limpa componentes de apresenta��o}
procedure TfrmContasReceber.limpar();
begin
  rdBtnCodigo.Checked := false;
  rdBtnCliente.Checked := false;
  edPesquisa.Clear;

  lblCodigo.Caption := '';
  lblCliente.Caption := '';
  lblData.Caption := '';
  lblValorTotal.Caption := '';
  lblValorPago.Caption := '';
  edValorBaixa.Clear;
  resta := 0;
end;

procedure TfrmContasReceber.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

{exibe todas as Contas � Receber}
procedure TfrmContasReceber.mostraTodasContas();
begin
  qryContasReceber.Close;
  qryContasReceber.SQL.Clear;
  qryContasReceber.SQL.Add('SELECT v.codigo, c.nome, v.data, v.valor_total,v.valor_pago,v.valor_liquido ');
  qryContasReceber.SQL.Add('FROM venda v, cliente c WHERE v.pago = 2 AND v.cod_cliente = c.codigo');
  qryContasReceber.Prepared := true;
  qryContasReceber.Open;

  cdsContasReceber.Active := false;
  cdsContasReceber.Active := true;
  cdsContasReceber.Refresh;

  limpar();
  carrega();
end;

{carrega Conta � Receber nos componentes de apresenta��o}
procedure TfrmContasReceber.carrega();
begin
  lblCodigo.Caption := cdsContasReceberCODIGO.AsString;
  lblCliente.Caption := cdsContasReceberNOME.AsString;
  lblData.Caption := cdsContasReceberDATA.AsString;
  lblValorTotal.Caption := FormatFloat('#0.00',cdsContasReceberVALOR_TOTAL.AsFloat);
  lblValorPago.Caption := FormatFloat('#0.00',cdsContasReceberVALOR_PAGO.AsFloat);
  resta := cdsContasReceberVALOR_TOTAL.AsFloat - cdsContasReceberVALOR_PAGO.AsFloat;
  edValorBaixa.Text := FormatFloat('#0.00',resta);

  //pegando itens
  qryItens.Close;
  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT i.codigo,p.nome,i.quantidade,i.valor FROM item_venda i,produto p ');
  qryItens.SQL.Add('WHERE i.cod_venda = :cod AND i.cod_produto = p.codigo');
  qryItens.ParamByName('cod').AsInteger := cdsContasReceberCODIGO.AsInteger;
  qryItens.Prepared := true;
  qryItens.Open;
  cdsItens.Active := false;
  cdsItens.Active := true;
  cdsItens.Refresh;
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmContasReceber.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmContasReceber.FormShow(Sender: TObject);
begin
  mostraTodasContas();
  mEdData.Text := DateToStr(Date);
end;

procedure TfrmContasReceber.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmContasReceber.rdBtnClienteClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmContasReceber.edPesquisaChange(Sender: TObject);
begin
  if (edPesquisa.Text = '')then
    btBtnPesquisar.Enabled := false;

  if(edPesquisa.Text <> '')then
    begin
    if((rdBtnCodigo.Checked = true)or(rdBtnCliente.Checked = true))then
      btBtnPesquisar.Enabled := true
    else
      btBtnPesquisar.Enabled := false;
    end;
end;

procedure TfrmContasReceber.edPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmContasReceber.ppMnMostrarTodasContasReceberClick(
  Sender: TObject);
begin
  mostraTodasContas();
end;

procedure TfrmContasReceber.btBtnPesquisarClick(Sender: TObject);
begin
  limpar();

 {c�digo}
  if (rdBtnCodigo.Checked = true) then
    begin
    qryContasReceber.Close;
    qryContasReceber.SQL.Clear;
    qryContasReceber.SQL.Add('SELECT v.codigo, c.nome, v.data, v.valor_total,v.valor_pago,,v.valor_liquido ');
    qryContasReceber.SQL.Add('FROM venda v, cliente c ');
    qryContasReceber.SQL.Add('WHERE v.pago = 2 AND v.cod_cliente = c.codigo AND v.codigo=:cod ');
    qryContasReceber.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    qryContasReceber.Prepared := true;
    qryContasReceber.Open;

    cdsContasReceber.Refresh;

    if(cdsContasReceber.RecordCount = 0)then
      begin
      MessageDlg('Nenhuma Conta encontrada com o c�digo ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodasContas();
      end;

    cdsContasReceber.Refresh;
    cdsContasReceber.Last;
    carrega();
    end;

  {cliente}
  if (rdBtnCliente.Checked = true) then
    begin
    qryContasReceber.Close;
    qryContasReceber.SQL.Clear;
    qryContasReceber.SQL.Add('SELECT v.codigo, c.nome, v.data, v.valor_total,v.valor_pago,v.valor_liquido ');
    qryContasReceber.SQL.Add('FROM venda v, cliente c ');
    qryContasReceber.SQL.Add('WHERE v.pago = 2 AND v.cod_cliente = c.codigo ');
    qryContasReceber.SQL.Add('AND c.nome=:nom');
    qryContasReceber.ParamByName('nom').AsString := edPesquisa.Text;
    qryContasReceber.Prepared := true;
    qryContasReceber.Open;

    cdsContasReceber.Refresh;

    if(cdsContasReceber.RecordCount = 0)then
      begin
      MessageDlg('Nenhuma Conta encontrada com o Cliente ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodasContas();
      end;

    cdsContasReceber.Refresh;
    cdsContasReceber.Last;
    carrega();
    end;

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmContasReceber.dbGrdContasPagarCellClick(Column: TColumn);
begin
  carrega();
end;

procedure TfrmContasReceber.edValorBaixaEnter(Sender: TObject);
begin
  edValorBaixa.Color := clMedGray;
end;

procedure TfrmContasReceber.mEdDataExit(Sender: TObject);
begin
  edValorBaixa.Color := clWindow;
end;

procedure TfrmContasReceber.mEdDataEnter(Sender: TObject);
begin
  edValorBaixa.Color := clMedGray;
end;

procedure TfrmContasReceber.edValorBaixaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmContasReceber.edValorBaixaExit(Sender: TObject);
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


procedure TfrmContasReceber.btBtnPagarClick(Sender: TObject);
var
  valorReceber: Real;
  valorPago: Real;
  total: Real;

  vTotal,vLiquido: Real; //valores para c�lculo de entrada
  porcLucro: Real; //valores para c�lculo de entrada
begin
  if ((mEdData.Text = '  /  /    ')or(edValorBaixa.Text = ''))then
    MessageDlg('Complete os campos antes de realizar o pagamento!',mtInformation,[mbOK],0)
  else
    begin
    valorReceber := StrToFloat(edValorBaixa.Text);
    valorPago := StrToFloat(lblValorPago.Caption);
    total := valorReceber + valorPago;

    //valor a receber � maior que o restante da conta
    if (valorReceber > resta)then
      begin
      MessageDlg('Resta apenas R$'+FormatFloat('#0.00',resta)+' a serem recebidos!',mtInformation,[mbOK],0);
      edValorBaixa.Text := FormatFloat('#0.00',resta);
      end
    else

    //realizar pagamento
      begin
      if (MessageDlg('Descontar R$'+FormatFloat('#0.00',valorReceber)+ ' na referida conta?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
        begin
        iniciaTransacao();
        DM.SQLConnection.StartTransaction(transacao);

        DM.qryVenda.Close;
        DM.qryVenda.SQL.Clear;
        DM.qryVenda.SQL.Add('UPDATE Venda v SET v.valor_pago=:val WHERE v.codigo=:cod');
        DM.qryVenda.ParamByName('val').AsFloat := total;
        DM.qryVenda.ParamByName('cod').AsInteger := StrToInt(lblCodigo.Caption);
        DM.qryVenda.Prepared := true;
        DM.qryVenda.ExecSQL();

        //calculando valores corretos para entrada
        vTotal := cdsContasReceberVALOR_TOTAL.AsFloat;
        vLiquido := cdsContasReceberVALOR_LIQUIDO.AsFloat;
        porcLucro := (100/vTotal)*vLiquido;

        vLiquido := (StrToFloat(edValorBaixa.Text)*porcLucro)/100;

        DM.qryEntrada.Close;
        DM.qryEntrada.SQL.Clear;
        DM.qryEntrada.SQL.Add('INSERT INTO Entrada (cod_venda,data,valor_bruto,valor_liquido) ');
        DM.qryEntrada.SQL.Add('VALUES (:codVen,:dat,:valBru,:valLiq)');
        DM.qryEntrada.ParamByName('codVen').AsInteger := StrToInt(lblCodigo.Caption);
        DM.qryEntrada.ParamByName('dat').AsDate := StrToDate(mEdData.Text);
        DM.qryEntrada.ParamByName('valBru').AsFloat := StrToFloat(edValorBaixa.Text);
        DM.qryEntrada.ParamByName('valLiq').AsFloat := vLiquido;
        DM.qryEntrada.Prepared := true;
        DM.qryEntrada.ExecSQL();

        //toda a conta j� foi paga, realizar baixa total
        if (valorReceber = resta)then
          begin
          DM.qryVenda.Close;
          DM.qryVenda.SQL.Clear;
          DM.qryVenda.SQL.Add('UPDATE Venda v SET v.pago=:pag WHERE v.codigo=:cod');
          DM.qryVenda.ParamByName('pag').AsInteger := 1;
          DM.qryVenda.ParamByName('cod').AsInteger := StrToInt(lblCodigo.Caption);
          DM.qryVenda.Prepared := true;
          DM.qryVenda.ExecSQL();
          end;

        DM.SQLConnection.Commit(transacao);
        mostraTodasContas();
        end;
      end;

    end;
end;

end.
8