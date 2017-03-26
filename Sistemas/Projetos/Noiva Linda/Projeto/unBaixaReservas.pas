unit unBaixaReservas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, StdCtrls, Buttons, ExtCtrls, DB, DBClient, Provider,
  SqlExpr, AppEvnts, Grids, DBGrids, ComCtrls, DBXpress;

type
  TfrmBaixaReservas = class(TForm)
    StatusBar: TStatusBar;
    dbGrdReservasVencidas: TDBGrid;
    ApplicationEvents: TApplicationEvents;
    Panel1: TPanel;
    btBtnBaixarReserva: TBitBtn;
    qryTmpReserva: TSQLQuery;
    dspTmpReserva: TDataSetProvider;
    cdsTmpReserva: TClientDataSet;
    cdsTmpReservaCODIGO: TIntegerField;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure btBtnBaixarReservaClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    (*VARIÁVEIS DE CONTROLE*)
    transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress

    (*PROCEDURES DE CONTROLE*)
    procedure iniciaTransacao();//dispara uma transação
    
  public
    { Public declarations }
  end;

var
  frmBaixaReservas: TfrmBaixaReservas;

implementation

uses unPrincipal, unDM;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{dispara uma transação}
procedure TfrmBaixaReservas.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmBaixaReservas.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmBaixaReservas.btBtnBaixarReservaClick(Sender: TObject);
begin
  try
    iniciaTransacao();
    DM.SQLConnection.StartTransaction(transacao);

    DM.qryItemReserva.Close;
    DM.qryItemReserva.SQL.Clear;
    DM.qryItemReserva.SQL.Add('SELECT * FROM Item_Reserva i WHERE i.cod_reserva=:cod');
    DM.qryItemReserva.ParamByName('cod').AsInteger := frmPrincipal.cdsBaixaReservaCODIGO.AsInteger;
    DM.qryItemReserva.Prepared := true;
    DM.qryItemReserva.Open;
    DM.cdsItemReserva.Open;
    DM.cdsItemReserva.Refresh;
    if(DM.cdsItemReserva.RecordCount>0)then
      begin
      DM.cdsItemReserva.First;
      while(not(DM.cdsItemReserva.Eof))do
        begin
        //vendo se não existe mais reservas para este produto
        qryTmpReserva.Close;
        qryTmpReserva.SQL.Clear;
        qryTmpReserva.SQL.Add('SELECT i.codigo FROM Item_Reserva i, reserva r ');
        qryTmpReserva.SQL.Add('WHERE i.cod_produto=:codProd ');
        qryTmpReserva.ParamByName('codProd').AsInteger := DM.cdsItemReservaCOD_PRODUTO.AsInteger;
        qryTmpReserva.SQL.Add('AND i.cod_reserva=r.codigo AND r.status=0');
        qryTmpReserva.Prepared := true;
        qryTmpReserva.Open;
        cdsTmpReserva.Open;
        cdsTmpReserva.Refresh;
        if(cdsTmpReserva.RecordCount=1)then
          begin
          DM.qryProduto.Close;
          DM.qryProduto.SQL.Clear;
          DM.qryProduto.SQL.Add('UPDATE PRODUTO SET status=0 WHERE codigo=:cod');
          DM.qryProduto.ParamByName('cod').AsInteger := DM.cdsItemReservaCOD_PRODUTO.AsInteger;
          DM.qryProduto.Prepared := true;
          DM.qryProduto.ExecSQL();
          end;
        DM.cdsItemReserva.Next;
        end;
      end;

    //deletando itens da reserva
    DM.qryItemReserva.Close;
    DM.qryItemReserva.SQL.Clear;
    DM.qryItemReserva.SQL.Add('DELETE FROM Item_Reserva i WHERE i.cod_reserva=:cod');
    DM.qryItemReserva.ParamByName('cod').AsInteger := frmPrincipal.cdsBaixaReservaCODIGO.AsInteger;
    DM.qryItemReserva.Prepared := true;
    DM.qryItemReserva.ExecSQL();

    //deletando reserva
    DM.qryReserva.Close;
    DM.qryReserva.SQL.Clear;
    DM.qryReserva.SQL.Add('DELETE FROM Reserva r WHERE r.codigo=:cod');
    DM.qryReserva.ParamByName('cod').AsInteger := frmPrincipal.cdsBaixaReservaCODIGO.AsInteger;
    DM.qryReserva.Prepared := true;
    DM.qryReserva.ExecSQL();

    frmPrincipal.baixaReservas('jaAbriu');

    DM.SQLConnection.Commit(transacao);
    MessageDlg('Reserva deletada com sucesso!',mtInformation,[mbOK],0);
  except
    DM.SQLConnection.Rollback(transacao);
    MessageDlg('Reserva não pode ser deletada!',mtInformation,[mbOK],0);
  end;    
end;

procedure TfrmBaixaReservas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key=#27)then
    Self.Close;
end;

end.
