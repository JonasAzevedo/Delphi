unit unContaPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr, AppEvnts, StdCtrls,
  Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, DBXpress, SQLTimSt, Menus;

type
  TfrmContaPagar = class(TForm)
    grpBxPesquisar: TGroupBox;
    StatusBar: TStatusBar;
    grpBxContasPagar: TGroupBox;
    dbGrdContasPagar: TDBGrid;
    grpBxItensCompra: TGroupBox;
    dbGrdItensCompra: TDBGrid;
    ApplicationEvents: TApplicationEvents;
    qryContasPagar: TSQLQuery;
    qryContasPagarCODIGO: TIntegerField;
    qryContasPagarCOD_COMPRA: TIntegerField;
    qryContasPagarCOD_FORNECEDOR: TIntegerField;
    qryContasPagarVALOR_TOTAL: TFMTBCDField;
    qryContasPagarVALOR_PAGO: TFMTBCDField;
    qryContasPagarPAGO: TIntegerField;
    qryContasPagarOBSERVACOES: TStringField;
    qryContasPagarTIPO: TStringField;
    qryContasPagarRAZAO_SOCIAL: TStringField;
    dspContasPagar: TDataSetProvider;
    cdsContasPagar: TClientDataSet;
    cdsContasPagarCODIGO: TIntegerField;
    cdsContasPagarCOD_COMPRA: TIntegerField;
    cdsContasPagarCOD_FORNECEDOR: TIntegerField;
    cdsContasPagarVALOR_TOTAL: TFMTBCDField;
    cdsContasPagarVALOR_PAGO: TFMTBCDField;
    cdsContasPagarPAGO: TIntegerField;
    cdsContasPagarOBSERVACOES: TStringField;
    cdsContasPagarTIPO: TStringField;
    cdsContasPagarRAZAO_SOCIAL: TStringField;
    dsContasPagar: TDataSource;
    qryItensCompra: TSQLQuery;
    qryItensCompraCODIGO: TIntegerField;
    qryItensCompraCOD_COMPRA: TIntegerField;
    qryItensCompraCOD_PRODUTO: TIntegerField;
    qryItensCompraVALOR_TOTAL: TFMTBCDField;
    qryItensCompraNOME: TStringField;
    qryItensCompraMARCA: TStringField;
    qryItensCompraTAMANHO: TIntegerField;
    dspItensCompra: TDataSetProvider;
    cdsItensCompra: TClientDataSet;
    cdsItensCompraCODIGO: TIntegerField;
    cdsItensCompraCOD_COMPRA: TIntegerField;
    cdsItensCompraCOD_PRODUTO: TIntegerField;
    cdsItensCompraVALOR_TOTAL: TFMTBCDField;
    cdsItensCompraNOME: TStringField;
    cdsItensCompraMARCA: TStringField;
    cdsItensCompraTAMANHO: TIntegerField;
    dsItensCompra: TDataSource;
    Label10: TLabel;
    edFornecedor: TEdit;
    btBtnSelecionarFornecedor: TBitBtn;
    btBtnPesquisar: TBitBtn;
    PopupMenu: TPopupMenu;
    MostrarTodasasContasPagar: TMenuItem;
    qryContasPagarVENCIMENTO: TDateField;
    cdsContasPagarVENCIMENTO: TDateField;
    pnlDivisao: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblTipoConta: TLabel;
    lblFornecedor: TLabel;
    lblObservacoes: TLabel;
    lblValorTotal: TLabel;
    lblValorPago: TLabel;
    Label7: TLabel;
    bvlDivisao: TBevel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblVencimento: TLabel;
    edPagar: TEdit;
    btBtnPagar: TBitBtn;
    lstBxHistorico: TListBox;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbGrdContasPagarCellClick(Column: TColumn);
    procedure edPagarEnter(Sender: TObject);
    procedure edPagarExit(Sender: TObject);
    procedure edPagarKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnPagarClick(Sender: TObject);
    procedure btBtnSelecionarFornecedorClick(Sender: TObject);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure MostrarTodasasContasPagarClick(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress
    vResta: Real;

    (*PROCEDURES ESPECÍFICAS*)
    procedure mostraContasPagar();
    procedure itensContaPagar();
    procedure carrega();
    procedure historico();

    (*PROCEDURES DE CONTROLE*)
    procedure iniciaTransacao();//dispara uma transação
  public
    codFornecedor: Integer;

  end;

var
  frmContaPagar: TfrmContaPagar;

implementation

uses unDM, unSelecionaFornecedor;

{$R *.dfm}

(*PROCEDURES ESPECÍFICAS*)
procedure TfrmContaPagar.historico();
begin
  lstBxHistorico.Clear;

  DM.qrySaidaFinanceira.Close;
  DM.qrySaidaFinanceira.SQL.Clear;
  DM.qrySaidaFinanceira.SQL.Add('SELECT * FROM Saida_Financeira WHERE cod_compra=:codCom');
  DM.qrySaidaFinanceira.ParamByName('codCom').AsInteger := cdsContasPagarCOD_COMPRA.AsInteger;
  DM.qrySaidaFinanceira.Prepared := true;
  DM.qrySaidaFinanceira.Open;

  DM.cdsSaidaFinanceira.Open;
  DM.cdsSaidaFinanceira.Refresh;
  DM.cdsSaidaFinanceira.First;

  if(DM.cdsSaidaFinanceira.RecordCount<>0)then
    begin
      while(not(DM.cdsSaidaFinanceira.Eof))do
        begin
        lstBxHistorico.Items.Add(DM.cdsSaidaFinanceiraDATA.AsString + '   -   R$ ' + FormatFloat('#0.00',DM.cdsSaidaFinanceiraVALOR.AsFloat));
        DM.cdsSaidaFinanceira.Next;
        end;
    end;
end;


procedure TfrmContaPagar.carrega();
begin
  lblTipoConta.Caption := cdsContasPagarTIPO.AsString;
  lblVencimento.Caption := cdsContasPagarVENCIMENTO.AsString;
  lblFornecedor.Caption := cdsContasPagarRAZAO_SOCIAL.AsString;
  lblObservacoes.Caption := cdsContasPagarOBSERVACOES.AsString;
  lblValorTotal.Caption := FormatFloat('#0.00',cdsContasPagarVALOR_TOTAL.AsFloat);
  lblValorPago.Caption := FormatFloat('#0.00',cdsContasPagarVALOR_PAGO.AsFloat);
  vResta := ((StrToFloat(lblValorTotal.Caption))-(StrToFloat(lblValorPago.Caption)));
  edPagar.Text := FormatFloat('#0.00',vResta);
end;

procedure TfrmContaPagar.itensContaPagar();
var
  cod:Integer;
begin
  dbGrdItensCompra.Visible := false;
  //COMPRA
  try
    cod := cdsContasPagarCOD_COMPRA.AsInteger;
  except
    cod := 0;
  end;

  if (cod<>0)then
    begin
    qryItensCompra.Close;
    qryItensCompra.SQL.Clear;
    qryItensCompra.SQL.Add('SELECT i.*,p.nome,p.marca,p.tamanho ');
    qryItensCompra.SQL.Add('FROM item_compra i,produto p ');
    qryItensCompra.SQL.Add('WHERE i.cod_compra=:codCom ');
    qryItensCompra.SQL.Add('AND i.cod_produto=p.codigo');
    qryItensCompra.ParamByName('codCom').AsInteger := cod;
    qryItensCompra.Prepared := true;
    qryItensCompra.Open;
    cdsItensCompra.Open;
    cdsItensCompra.Refresh;

    dbGrdItensCompra.Visible := true;
    end;
end;

procedure TfrmContaPagar.mostraContasPagar();
begin
  qryContasPagar.Close;
  qryContasPagar.SQL.Clear;
  qryContasPagar.SQL.Add('SELECT c.*, f.razao_social ');
  qryContasPagar.SQL.Add('FROM conta_pagar c, fornecedor f ');
  qryContasPagar.SQL.Add('WHERE c.pago=0 ');
  qryContasPagar.SQL.Add('AND c.cod_fornecedor=f.codigo');
  qryContasPagar.SQL.Add('ORDER BY c.vencimento');
  qryContasPagar.Prepared := true;
  qryContasPagar.Open;
  cdsContasPagar.Open;
  cdsContasPagar.Refresh;
  cdsContasPagar.First;

  itensContaPagar();
end;

(*FIM PROCEDURES ESPECÍFICAS*)

(*PROCEDURES DE CONTROLE*)

{dispara uma transação}
procedure TfrmContaPagar.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

(*FIM PROCEDURES DE CONTROLE*)


procedure TfrmContaPagar.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmContaPagar.FormShow(Sender: TObject);
begin
  mostraContasPagar();
  itensContaPagar();
  carrega();
  historico();
end;

procedure TfrmContaPagar.dbGrdContasPagarCellClick(Column: TColumn);
begin
  itensContaPagar();
  carrega();
  historico();
end;

procedure TfrmContaPagar.edPagarEnter(Sender: TObject);
begin
  edPagar.Color := clMoneyGreen;
end;

procedure TfrmContaPagar.edPagarExit(Sender: TObject);
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

procedure TfrmContaPagar.edPagarKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmContaPagar.btBtnPagarClick(Sender: TObject);
var
  vPagar: Real;
  vJaPago: Real;
begin
  if(MessageDlg('Deseja pagar R$ '+edPagar.Text+' ?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
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
          vJaPago := vPagar+StrToFloat(lblValorPago.Caption);//valor já pago pela compra

          //compra
          if(cdsContasPagarTIPO.AsString='Compra')then
            begin
            DM.qryCompra.Close;
            DM.qryCompra.SQL.Clear;
            DM.qryCompra.SQL.Add('UPDATE Compra SET valor_pago=:valPag,pago=:pag WHERE codigo=:cod');
            DM.qryCompra.ParamByName('valPag').AsFloat := vJaPago;
            if (vPagar=vResta) then
              DM.qryCompra.ParamByName('pag').AsInteger := 1
            else
              DM.qryCompra.ParamByName('pag').AsInteger := 0;
            DM.qryCompra.ParamByName('cod').AsInteger := cdsContasPagarCOD_COMPRA.AsInteger;
            DM.qryCompra.Prepared := true;
            DM.qryCompra.ExecSQL();

            //saída financeira
            DM.qrySaidaFinanceira.Close;
            DM.qrySaidaFinanceira.SQL.Clear;
            DM.qrySaidaFinanceira.SQL.Add('INSERT INTO Saida_Financeira(cod_compra,cod_fornecedor,tipo,valor,data)VALUES(:codCom,:codFor,:tip,:val,:dat)');
            DM.qrySaidaFinanceira.ParamByName('codCom').AsInteger := cdsContasPagarCOD_COMPRA.AsInteger;
            DM.qrySaidaFinanceira.ParamByName('codFor').AsInteger := cdsContasPagarCOD_FORNECEDOR.AsInteger;
            DM.qrySaidaFinanceira.ParamByName('tip').AsString := 'Compra';
            DM.qrySaidaFinanceira.ParamByName('val').AsFloat := vPagar;
            DM.qrySaidaFinanceira.ParamByName('dat').AsSQLTimeStamp := DateTimeToSQLTimeStamp(Now);
            DM.qrySaidaFinanceira.Prepared := true;
            DM.qrySaidaFinanceira.ExecSQL();

            //conta à pagar
            DM.qryContaPagar.Close;
            DM.qryContaPagar.SQL.Clear;
            DM.qryContaPagar.SQL.Add('UPDATE Conta_Pagar SET valor_pago=:valPag,pago=:pag WHERE codigo=:cod');
            DM.qryContaPagar.ParamByName('valPag').AsFloat := vJaPago;
            if (vPagar=vResta) then
              DM.qryContaPagar.ParamByName('pag').AsInteger := 1
            else
              DM.qryContaPagar.ParamByName('pag').AsInteger := 0;
            DM.qryContaPagar.ParamByName('cod').AsInteger := cdsContasPagarCODIGO.AsInteger;
            DM.qryContaPagar.Prepared := true;
            DM.qryContaPagar.ExecSQL();

            DM.SQLConnection.Commit(transacao);
            MessageDlg('Conta Paga com sucesso!',mtInformation,[mbOK],0);

            mostraContasPagar();
            itensContaPagar();
            carrega();
            historico();
            end;
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
end;

procedure TfrmContaPagar.btBtnSelecionarFornecedorClick(Sender: TObject);
begin
  Self.codFornecedor := 0;

  Application.CreateForm(TfrmSelecionaFornecedor,frmSelecionaFornecedor);
  frmSelecionaFornecedor.tela := 'contaPagar';
  frmSelecionaFornecedor.ShowModal;
  frmSelecionaFornecedor.Free;

  if(self.codFornecedor<>0)then
    btBtnPesquisarClick(Sender);
end;

procedure TfrmContaPagar.btBtnPesquisarClick(Sender: TObject);
begin
  if(Self.codFornecedor<>0)then
    begin
    qryContasPagar.Close;
    qryContasPagar.SQL.Clear;
    qryContasPagar.SQL.Add('SELECT c.*, f.razao_social ');
    qryContasPagar.SQL.Add('FROM conta_pagar c, fornecedor f ');
    qryContasPagar.SQL.Add('WHERE c.pago=0 ');
    qryContasPagar.SQL.Add('AND c.cod_fornecedor=f.codigo ');
    qryContasPagar.SQL.Add('AND f.codigo=:cod');
    qryContasPagar.SQL.Add('ORDER BY c.vencimento');    
    qryContasPagar.ParamByName('cod').AsInteger := Self.codFornecedor;
    qryContasPagar.Prepared := true;
    qryContasPagar.Open;
    cdsContasPagar.Open;
    cdsContasPagar.Refresh;
    if(cdsContasPagar.RecordCount=0)then
      begin
      MessageDlg('Nenhuma Conta a Pagar encontrada para o Fornecedor '+edFornecedor.Text,mtInformation,[mbOK],0);
      mostraContasPagar();
      carrega();
      itensContaPagar();
      historico();
      edFornecedor.Clear;
      Self.codFornecedor := 0;
      end;
    end;
end;

procedure TfrmContaPagar.MostrarTodasasContasPagarClick(Sender: TObject);
begin
  mostraContasPagar();
  carrega();
  itensContaPagar();
  historico();
end;

end.
