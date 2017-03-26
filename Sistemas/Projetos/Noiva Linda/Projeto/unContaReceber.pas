unit unContaReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, ComCtrls, DBXpress, Grids, DBGrids, StdCtrls, FMTBcd,
  DB, DBClient, Provider, SqlExpr, ExtCtrls, Buttons, SQLTimSt, Menus;

type
  TfrmContaReceber = class(TForm)
    grpBxPesquisa: TGroupBox;
    StatusBar: TStatusBar;
    grpBxContasReceber: TGroupBox;
    dbGrdContasRecber: TDBGrid;
    pnlDivisao: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblTipoConta: TLabel;
    lblCliente: TLabel;
    lblCPF: TLabel;
    lblValorTotal: TLabel;
    lblValorPago: TLabel;
    Label7: TLabel;
    bvlDivisao: TBevel;
    Label8: TLabel;
    Label9: TLabel;
    edPagar: TEdit;
    BitBtn1: TBitBtn;
    lstBxHistorico: TListBox;
    grpBxItensContaReceber: TGroupBox;
    dbGrdItensLocacao: TDBGrid;
    dbGrdItensVenda: TDBGrid;
    ApplicationEvents: TApplicationEvents;
    qryContasReceber: TSQLQuery;
    qryContasReceberCODIGO: TIntegerField;
    qryContasReceberCOD_LOCACAO: TIntegerField;
    qryContasReceberCOD_VENDA: TIntegerField;
    qryContasReceberCOD_CLIENTE: TIntegerField;
    qryContasReceberVALOR_TOTAL: TFMTBCDField;
    qryContasReceberVALOR_PAGO: TFMTBCDField;
    qryContasReceberPAGO: TIntegerField;
    qryContasReceberTIPO: TStringField;
    qryContasReceberNOME: TStringField;
    qryContasReceberCPF: TStringField;
    dspContasReceber: TDataSetProvider;
    cdsContasReceber: TClientDataSet;
    cdsContasReceberCODIGO: TIntegerField;
    cdsContasReceberCOD_LOCACAO: TIntegerField;
    cdsContasReceberCOD_VENDA: TIntegerField;
    cdsContasReceberCOD_CLIENTE: TIntegerField;
    cdsContasReceberVALOR_TOTAL: TFMTBCDField;
    cdsContasReceberVALOR_PAGO: TFMTBCDField;
    cdsContasReceberPAGO: TIntegerField;
    cdsContasReceberTIPO: TStringField;
    cdsContasReceberNOME: TStringField;
    cdsContasReceberCPF: TStringField;
    dsContasReceber: TDataSource;
    qryItensLocacao: TSQLQuery;
    qryItensLocacaoCODIGO: TIntegerField;
    qryItensLocacaoCOD_LOCACAO: TIntegerField;
    qryItensLocacaoCOD_PRODUTO: TIntegerField;
    qryItensLocacaoQUANTIDADE: TIntegerField;
    qryItensLocacaoVALOR_UNITARIO: TFMTBCDField;
    qryItensLocacaoVALOR_TOTAL: TFMTBCDField;
    qryItensLocacaoDATA_DEVOLUCAO: TSQLTimeStampField;
    qryItensLocacaoNOME: TStringField;
    qryItensLocacaoMARCA: TStringField;
    qryItensLocacaoTAMANHO: TIntegerField;
    dspItensLocacao: TDataSetProvider;
    cdsItensLocacao: TClientDataSet;
    cdsItensLocacaoCODIGO: TIntegerField;
    cdsItensLocacaoCOD_LOCACAO: TIntegerField;
    cdsItensLocacaoCOD_PRODUTO: TIntegerField;
    cdsItensLocacaoQUANTIDADE: TIntegerField;
    cdsItensLocacaoVALOR_UNITARIO: TFMTBCDField;
    cdsItensLocacaoVALOR_TOTAL: TFMTBCDField;
    cdsItensLocacaoDATA_DEVOLUCAO: TSQLTimeStampField;
    cdsItensLocacaoNOME: TStringField;
    cdsItensLocacaoMARCA: TStringField;
    cdsItensLocacaoTAMANHO: TIntegerField;
    dsItensLocacao: TDataSource;
    qryItensVenda: TSQLQuery;
    qryItensVendaCODIGO: TIntegerField;
    qryItensVendaCOD_VENDA: TIntegerField;
    qryItensVendaCOD_PRODUTO: TIntegerField;
    qryItensVendaQUANTIDADE: TIntegerField;
    qryItensVendaVALOR_UNITARIO: TFMTBCDField;
    qryItensVendaVALOR_TOTAL: TFMTBCDField;
    qryItensVendaNOME: TStringField;
    qryItensVendaMARCA: TStringField;
    qryItensVendaTAMANHO: TIntegerField;
    dspItensVenda: TDataSetProvider;
    cdsItensVenda: TClientDataSet;
    cdsItensVendaCODIGO: TIntegerField;
    cdsItensVendaCOD_VENDA: TIntegerField;
    cdsItensVendaCOD_PRODUTO: TIntegerField;
    cdsItensVendaQUANTIDADE: TIntegerField;
    cdsItensVendaVALOR_UNITARIO: TFMTBCDField;
    cdsItensVendaVALOR_TOTAL: TFMTBCDField;
    cdsItensVendaNOME: TStringField;
    cdsItensVendaMARCA: TStringField;
    cdsItensVendaTAMANHO: TIntegerField;
    dsItensVenda: TDataSource;
    Label10: TLabel;
    edCliente: TEdit;
    btBtnSelecionarCliente: TBitBtn;
    btBtnPesquisar: TBitBtn;
    PopupMenu: TPopupMenu;
    MostrarTodasasContasReceber1: TMenuItem;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbGrdContasRecberCellClick(Column: TColumn);
    procedure edPagarEnter(Sender: TObject);
    procedure edPagarKeyPress(Sender: TObject; var Key: Char);
    procedure edPagarExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btBtnSelecionarClienteClick(Sender: TObject);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure MostrarTodasasContasReceber1Click(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress
    vResta: Real;

    (*PROCEDURES ESPECÍFICAS*)
    procedure mostraContasReceber();
    procedure itensContaReceber();
    procedure carrega();
    procedure historico();

    (*PROCEDURES DE CONTROLE*)
    procedure iniciaTransacao();//dispara uma transação
  public
    codCliente: Integer;

  end;

var
  frmContaReceber: TfrmContaReceber;

implementation

uses unDM, unSelecionaCliente;

{$R *.dfm}

(*PROCEDURES ESPECÍFICAS*)

procedure TfrmContaReceber.historico();
var
  cod: Integer;
begin
  lstBxHistorico.Clear;

  //LOCAÇÃO
  try
    cod := cdsContasReceberCOD_LOCACAO.AsInteger;
  except
    cod := 0;
  end;

  if (cod<>0)then
    begin
    DM.qryEntradaFinanceira.Close;
    DM.qryEntradaFinanceira.SQL.Clear;
    DM.qryEntradaFinanceira.SQL.Add('SELECT * FROM Entrada_Financeira WHERE cod_locacao=:codLoc');
    DM.qryEntradaFinanceira.ParamByName('codLoc').AsInteger := cod;
    DM.qryEntradaFinanceira.Prepared := true;
    DM.qryEntradaFinanceira.Open;

    DM.cdsEntradaFinanceira.Open;
    DM.cdsEntradaFinanceira.Refresh;
    DM.cdsEntradaFinanceira.First;
    end;

  //VENDA
  try
    cod := cdsContasReceberCOD_VENDA.AsInteger;
  except
    cod := 0;
  end;

  if (cod<>0)then
    begin
    DM.qryEntradaFinanceira.Close;
    DM.qryEntradaFinanceira.SQL.Clear;
    DM.qryEntradaFinanceira.SQL.Add('SELECT * FROM Entrada_Financeira WHERE cod_venda=:codVen');
    DM.qryEntradaFinanceira.ParamByName('codVen').AsInteger := cod;
    DM.qryEntradaFinanceira.Prepared := true;
    DM.qryEntradaFinanceira.Open;

    DM.cdsEntradaFinanceira.Open;
    DM.cdsEntradaFinanceira.Refresh;
    DM.cdsEntradaFinanceira.First;
    end;


  if(DM.cdsEntradaFinanceira.RecordCount<>0)then
    begin
    while(not(DM.cdsEntradaFinanceira.Eof))do
      begin
      lstBxHistorico.Items.Add(DM.cdsEntradaFinanceiraDATA.AsString + '   -   R$ ' + FormatFloat('#0.00',DM.cdsEntradaFinanceiraVALOR.AsFloat));
      DM.cdsEntradaFinanceira.Next;
      end;
    end;
end;

procedure TfrmContaReceber.carrega();
begin
  lblTipoConta.Caption := cdsContasReceberTIPO.AsString;
  lblCliente.Caption := cdsContasReceberNOME.AsString;
  lblCPF.Caption := cdsContasReceberCPF.AsString;
  lblValorTotal.Caption := FormatFloat('#0.00',cdsContasReceberVALOR_TOTAL.AsFloat);
  lblValorPago.Caption := FormatFloat('#0.00',cdsContasReceberVALOR_PAGO.AsFloat);
  vResta := ((StrToFloat(lblValorTotal.Caption))-(StrToFloat(lblValorPago.Caption)));
  edPagar.Text := FormatFloat('#0.00',vResta);
end;

procedure TfrmContaReceber.itensContaReceber();
var
  cod:Integer;
begin
  dbGrdItensLocacao.Visible := false;
  dbGrdItensVenda.Visible := false;

  //LOCAÇÃO
  try
    cod := cdsContasReceberCOD_LOCACAO.AsInteger;
  except
    cod := 0;
  end;

  if (cod<>0)then
    begin
    qryItensLocacao.Close;
    qryItensLocacao.SQL.Clear;
    qryItensLocacao.SQL.Add('SELECT i.*,p.nome,p.marca,p.tamanho ');
    qryItensLocacao.SQL.Add('FROM Item_Locacao i,produto p ');
    qryItensLocacao.SQL.Add('WHERE i.cod_locacao=:cod ');
    qryItensLocacao.SQL.Add('AND i.cod_produto=p.codigo');
    qryItensLocacao.ParamByName('cod').AsInteger := cod;
    qryItensLocacao.Prepared := true;
    qryItensLocacao.Open;
    cdsItensLocacao.Open;
    cdsItensLocacao.Refresh;
    dbGrdItensLocacao.Visible := true;
    dbGrdItensVenda.Visible := false;
    end;

  //VENDA
  try
    cod := cdsContasReceberCOD_VENDA.AsInteger;
  except
    cod := 0;
  end;

  if (cod<>0)then
    begin
    qryItensVenda.Close;
    qryItensVenda.SQL.Clear;
    qryItensVenda.SQL.Add('SELECT i.*,p.nome,p.marca,p.tamanho ');
    qryItensVenda.SQL.Add('FROM item_venda i,produto p ');
    qryItensVenda.SQL.Add('WHERE i.cod_venda=:cod ');
    qryItensVenda.SQL.Add('AND i.cod_produto=p.codigo');
    qryItensVenda.ParamByName('cod').AsInteger := cod;
    qryItensVenda.Prepared := true;
    qryItensVenda.Open;
    cdsItensVenda.Open;
    cdsItensVenda.Refresh;
    dbGrdItensLocacao.Visible := true;
    dbGrdItensLocacao.Visible := false;
    dbGrdItensVenda.Visible := true;
    end;              
end;


procedure TfrmContaReceber.mostraContasReceber();
begin
  qryContasReceber.Close;
  qryContasReceber.SQL.Clear;
  qryContasReceber.SQL.Add('SELECT con.*, cli.nome,cli.cpf ');
  qryContasReceber.SQL.Add('FROM conta_receber con, cliente cli ');
  qryContasReceber.SQL.Add('WHERE con.pago=0 ');
  qryContasReceber.SQL.Add('AND con.cod_cliente=cli.codigo');
  qryContasReceber.Prepared := true;
  qryContasReceber.Open;
  cdsContasReceber.Open;
  cdsContasReceber.Refresh;
  cdsContasReceber.First;

  itensContaReceber();
end;

(*FIM PROCEDURES ESPECÍFICAS*)

(*PROCEDURES DE CONTROLE*)

{dispara uma transação}
procedure TfrmContaReceber.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

(*FIM PROCEDURES DE CONTROLE*)     

procedure TfrmContaReceber.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmContaReceber.FormShow(Sender: TObject);
begin
  mostraContasReceber();
  carrega();
  itensContaReceber();
  historico();
end;

procedure TfrmContaReceber.dbGrdContasRecberCellClick(Column: TColumn);
begin
  itensContaReceber();
  carrega();
  historico();  
end;

procedure TfrmContaReceber.edPagarEnter(Sender: TObject);
begin
  edPagar.Color := clMoneyGreen;
end;

procedure TfrmContaReceber.edPagarKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmContaReceber.edPagarExit(Sender: TObject);
begin
  if (edPagar.Text = '') then
    edPagar.Text := '0,00'
  else
    begin
    try
      edPagar.Text := FormatFloat('#0.00',StrToFloat(edPagar.Text));
    except
    end;
    end;
  edPagar.Color := clWindow;
end;

procedure TfrmContaReceber.BitBtn1Click(Sender: TObject);
var
  vPagar: Real;
  vJaPago: Real;
begin
  vPagar := StrToFloat(edPagar.Text);
  if((vPagar > 0)and(vResta>0))then
    begin
    //pode pagar
    if (vPagar <= vResta) then
      begin
      try
        iniciaTransacao();
        DM.SQLConnection.StartTransaction(transacao);
        vJaPago := vPagar+StrToFloat(lblValorPago.Caption);//valor já pago pela locação

        //locação
        if(cdsContasReceberTIPO.AsString='Locação')then
          begin
          DM.qryLocacao.Close;
          DM.qryLocacao.SQL.Clear;
          DM.qryLocacao.SQL.Add('UPDATE Locacao SET valor_pago=:valPag,pago=:pag WHERE codigo=:cod');
          DM.qryLocacao.ParamByName('valPag').AsFloat := vJaPago;
          if (vPagar=vResta) then
            DM.qryLocacao.ParamByName('pag').AsInteger := 1
          else
            DM.qryLocacao.ParamByName('pag').AsInteger := 0;
          DM.qryLocacao.ParamByName('cod').AsInteger := cdsContasReceberCOD_LOCACAO.AsInteger;
          DM.qryLocacao.Prepared := true;
          DM.qryLocacao.ExecSQL();

          //entrada financeira
          DM.qryEntradaFinanceira.Close;
          DM.qryEntradaFinanceira.SQL.Clear;
          DM.qryEntradaFinanceira.SQL.Add('INSERT INTO Entrada_Financeira(cod_locacao,cod_cliente,tipo,valor,data)VALUES(:codLoc,:codCli,:tip,:val,:dat)');
          DM.qryEntradaFinanceira.ParamByName('codLoc').AsInteger := cdsContasReceberCOD_LOCACAO.AsInteger;
          DM.qryEntradaFinanceira.ParamByName('codCli').AsInteger := cdsContasReceberCOD_CLIENTE.AsInteger;
          DM.qryEntradaFinanceira.ParamByName('tip').AsString := 'Locação';
          DM.qryEntradaFinanceira.ParamByName('val').AsFloat := vPagar;
          DM.qryEntradaFinanceira.ParamByName('dat').AsSQLTimeStamp := DateTimeToSQLTimeStamp(Now);
          DM.qryEntradaFinanceira.Prepared := true;
          DM.qryEntradaFinanceira.ExecSQL();
          end

        //venda
        else if(cdsContasReceberTIPO.AsString='Venda')then
          begin
          DM.qryVenda.Close;
          DM.qryVenda.SQL.Clear;
          DM.qryVenda.SQL.Add('UPDATE Venda SET valor_pago=:valPag,pago=:pag WHERE codigo=:cod');
          DM.qryVenda.ParamByName('valPag').AsFloat := vJaPago;
          if (vPagar=vResta) then
            DM.qryVenda.ParamByName('pag').AsInteger := 1
          else
            DM.qryVenda.ParamByName('pag').AsInteger := 0;
          DM.qryVenda.ParamByName('cod').AsInteger := cdsContasReceberCOD_VENDA.AsInteger;
          DM.qryVenda.Prepared := true;
          DM.qryVenda.ExecSQL();

          //entrada financeira
          DM.qryEntradaFinanceira.Close;
          DM.qryEntradaFinanceira.SQL.Clear;
          DM.qryEntradaFinanceira.SQL.Add('INSERT INTO Entrada_Financeira(cod_venda,cod_cliente,tipo,valor,data)VALUES(:codVen,:codCli,:tip,:val,:dat)');
          DM.qryEntradaFinanceira.ParamByName('codVen').AsInteger := cdsContasReceberCOD_VENDA.AsInteger;
          DM.qryEntradaFinanceira.ParamByName('codCli').AsInteger := cdsContasReceberCOD_CLIENTE.AsInteger;
          DM.qryEntradaFinanceira.ParamByName('tip').AsString := 'Venda';
          DM.qryEntradaFinanceira.ParamByName('val').AsFloat := vPagar;
          DM.qryEntradaFinanceira.ParamByName('dat').AsSQLTimeStamp := DateTimeToSQLTimeStamp(Now);
          DM.qryEntradaFinanceira.Prepared := true;
          DM.qryEntradaFinanceira.ExecSQL();
          end;

        //conta à receber
        DM.qryContaReceber.Close;
        DM.qryContaReceber.SQL.Clear;
        DM.qryContaReceber.SQL.Add('UPDATE Conta_Receber SET valor_pago=:valPag,pago=:pag WHERE codigo=:cod');
        DM.qryContaReceber.ParamByName('valPag').AsFloat := vJaPago;
        if (vPagar=vResta) then
          DM.qryContaReceber.ParamByName('pag').AsInteger := 1
        else
          DM.qryContaReceber.ParamByName('pag').AsInteger := 0;
        DM.qryContaReceber.ParamByName('cod').AsInteger := cdsContasReceberCODIGO.AsInteger;
        DM.qryContaReceber.Prepared := true;
        DM.qryContaReceber.ExecSQL();

        DM.SQLConnection.Commit(transacao);
        MessageDlg('Conta Paga com sucesso!',mtInformation,[mbOK],0);

        mostraContasReceber();
        itensContaReceber();
        carrega();
        historico();
      except
        DM.SQLConnection.Rollback(transacao);
        MessageDlg('Conta não pode ser paga!',mtError,[mbOK],0);
      end;
      end

    //valor pago é maior do que o que falta ser pago
    else
      begin
      MessageDlg('Resta Somente R$'+FormatFloat('#0.00',vResta)+' a serem pagos!',mtInformation,[mbOK],0);
      edPagar.Text := FormatFloat('#0.00',vResta);
      edPagar.SetFocus;
      end;
    end;
end;

procedure TfrmContaReceber.btBtnSelecionarClienteClick(Sender: TObject);
begin
  Self.codCliente := 0;

  Application.CreateForm(TfrmSelecionaCliente,frmSelecionaCliente);
  frmSelecionaCliente.tela := 'contaReceber';
  frmSelecionaCliente.ShowModal;
  frmSelecionaCliente.Free;

  if(self.codCliente<>0)then
    btBtnPesquisarClick(Sender);
end;

procedure TfrmContaReceber.btBtnPesquisarClick(Sender: TObject);
begin
  if(Self.codCliente<>0)then
    begin
    qryContasReceber.Close;
    qryContasReceber.SQL.Clear;
    qryContasReceber.SQL.Add('SELECT con.*, cli.nome,cli.cpf ');
    qryContasReceber.SQL.Add('FROM conta_receber con, cliente cli ');
    qryContasReceber.SQL.Add('WHERE con.pago=0 ');
    qryContasReceber.SQL.Add('AND con.cod_cliente=cli.codigo ');
    qryContasReceber.SQL.Add('AND cli.codigo=:cod');
    qryContasReceber.ParamByName('cod').AsInteger := Self.codCliente;
    qryContasReceber.Prepared := true;
    qryContasReceber.Open;
    cdsContasReceber.Open;
    cdsContasReceber.Refresh;
    if(cdsContasReceber.RecordCount=0)then
      begin
      MessageDlg('Nenhuma Conta a Receber encontrada para o Cliente '+edCliente.Text,mtInformation,[mbOK],0);
      mostraContasReceber();
      carrega();
      itensContaReceber();
      historico();
      edCliente.Clear;
      Self.codCliente := 0;
      end;
    end;
end;

procedure TfrmContaReceber.MostrarTodasasContasReceber1Click(
  Sender: TObject);
begin
  mostraContasReceber();
  carrega();
  itensContaReceber();
  historico();
end;

end.
