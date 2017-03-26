unit unVerReservasPendentes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, Grids, DBGrids, ComCtrls, FMTBcd, DB, DBClient,
  Provider, SqlExpr, ExtCtrls, Menus, DBXpress;

type
  TfrmReservasPendentes = class(TForm)
    StatusBar: TStatusBar;
    dbGrdLocacoesPendentesVencendo: TDBGrid;
    ApplicationEvents: TApplicationEvents;
    pnlDivisao: TPanel;
    dbGrdItensReserva: TDBGrid;
    qryItens: TSQLQuery;
    dspItens: TDataSetProvider;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    ppMnRealizarReserva: TPopupMenu;
    ppMnDeletarReserva: TMenuItem;
    qryItensCODIGO: TIntegerField;
    qryItensNOME: TStringField;
    qryItensMARCA: TStringField;
    qryItensTAMANHO: TIntegerField;
    qryItensQUANTIDADE: TIntegerField;
    qryItensVALOR_UNITARIO: TFMTBCDField;
    qryItensVALOR_TOTAL: TFMTBCDField;
    cdsItensCODIGO: TIntegerField;
    cdsItensNOME: TStringField;
    cdsItensMARCA: TStringField;
    cdsItensTAMANHO: TIntegerField;
    cdsItensQUANTIDADE: TIntegerField;
    cdsItensVALOR_UNITARIO: TFMTBCDField;
    cdsItensVALOR_TOTAL: TFMTBCDField;
    cdsTmpReserva: TClientDataSet;
    cdsTmpReservaCODIGO: TIntegerField;
    dspTmpReserva: TDataSetProvider;
    qryTmpReserva: TSQLQuery;
    RealizarReserva1: TMenuItem;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dbGrdLocacoesPendentesVencendoCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure ppMnDeletarReservaClick(Sender: TObject);
    procedure dbGrdLocacoesPendentesVencendoDblClick(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress

    (*PROCEDURES DE CONTROLE*)
    procedure iniciaTransacao();//dispara uma transação

    (*PROCEDURES ESPECÍFICAS*)
    procedure pegaItens();
  public
    tela: String; //quem chamou a tela

  end;

var
  frmReservasPendentes: TfrmReservasPendentes;

implementation

uses unPrincipal, unDM, unLocacao;

{$R *.dfm}

(*PROCEDURES ESPECÍFICAS*)
procedure TfrmReservasPendentes.pegaItens();
begin
  qryItens.Close;
  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT p.codigo, p.nome,p.marca,p.tamanho,i.quantidade,i.valor_unitario,i.valor_total ');
  qryItens.SQL.Add('FROM item_reserva i,produto p ');
  qryItens.SQL.Add('WHERE i.cod_reserva=:codRes');
  qryItens.SQL.Add('AND i.cod_produto=p.codigo');
  qryItens.ParamByName('codRes').AsInteger := frmPrincipal.cdsReservasPendentesCODIGO.AsInteger;  
  qryItens.Prepared := true;
  qryItens.Open;
  cdsItens.Open;
  cdsItens.Refresh;
end;
(*FIM PROCEDURES ESPECÍFICAS*)


(*PROCEDURES DE CONTROLE*)

{dispara uma transação}
procedure TfrmReservasPendentes.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

(*FIM PROCEDURES DE CONTROLE*)


procedure TfrmReservasPendentes.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmReservasPendentes.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key=#27) then
    Self.Close;
end;

procedure TfrmReservasPendentes.dbGrdLocacoesPendentesVencendoCellClick(
  Column: TColumn);
begin
  pegaItens();
end;

procedure TfrmReservasPendentes.FormShow(Sender: TObject);
begin
  frmPrincipal.cdsReservasPendentes.First;
  pegaItens(); 
end;

procedure TfrmReservasPendentes.ppMnDeletarReservaClick(Sender: TObject);
begin
  if (frmPrincipal.cdsReservasPendentes.RecordCount=0) then
    MessageDlg('Não há reserva para ser deletada!',mtInformation,[mbOK],0)
  else
    begin
    try
      iniciaTransacao();
      DM.SQLConnection.StartTransaction(transacao);
      DM.qryItemReserva.Close;
      DM.qryItemReserva.SQL.Clear;
      DM.qryItemReserva.SQL.Add('SELECT * FROM Item_Reserva i WHERE i.cod_reserva=:cod');
      DM.qryItemReserva.ParamByName('cod').AsInteger := frmPrincipal.cdsReservasPendentesCODIGO.AsInteger;
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
      DM.qryItemReserva.ParamByName('cod').AsInteger := frmPrincipal.cdsReservasPendentesCODIGO.AsInteger;
      DM.qryItemReserva.Prepared := true;
      DM.qryItemReserva.ExecSQL();

      //deletando reserva
      DM.qryReserva.Close;
      DM.qryReserva.SQL.Clear;
      DM.qryReserva.SQL.Add('DELETE FROM Reserva r WHERE r.codigo=:cod');
      DM.qryReserva.ParamByName('cod').AsInteger := frmPrincipal.cdsReservasPendentesCODIGO.AsInteger;
      DM.qryReserva.Prepared := true;
      DM.qryReserva.ExecSQL();

      //abrindo reservas pendentes
      frmPrincipal.qryReservasPendentes.Close;
      frmPrincipal.qryReservasPendentes.SQL.Clear;
      frmPrincipal.qryReservasPendentes.SQL.Add('SELECT r.codigo,r.sexo, c.codigo AS codCliente,c.nome AS Cliente,r.data_inicio,r.data_final,r.valor_total, r.observacoes ');
      frmPrincipal.qryReservasPendentes.SQL.Add('FROM reserva r,cliente c ');
      frmPrincipal.qryReservasPendentes.SQL.Add('WHERE r.cod_cliente=c.codigo ');
      frmPrincipal.qryReservasPendentes.SQL.Add('AND r.status=0 ');
      frmPrincipal.qryReservasPendentes.SQL.Add('AND r.data_inicio >= current_timestamp ');
      frmPrincipal.qryReservasPendentes.SQL.Add('ORDER BY r.data_inicio');
      frmPrincipal.qryReservasPendentes.Prepared := true;
      frmPrincipal.qryReservasPendentes.Open;
      frmPrincipal.cdsReservasPendentes.Open;
      frmPrincipal.cdsReservasPendentes.Refresh;

      DM.SQLConnection.Commit(transacao);
      MessageDlg('Reserva deletada com sucesso!',mtInformation,[mbOK],0);
    except
      DM.SQLConnection.Rollback(transacao);
      MessageDlg('Reserva não pode ser deletada!',mtInformation,[mbOK],0);
    end;
    end;
end;

procedure TfrmReservasPendentes.dbGrdLocacoesPendentesVencendoDblClick(
  Sender: TObject);
var
  codProd: Integer;
  codLocacao: Integer;
begin
  if (frmPrincipal.cdsReservasPendentes.RecordCount=0) then
    MessageDlg('Não há reserva para ser realizada!',mtInformation,[mbOK],0)
  else
    begin
    if(MessageDlg('Deseja realizar a reserva de Código: '+frmPrincipal.cdsReservasPendentesCODIGO.AsString+#13+
                  'Cliente: '+frmPrincipal.cdsReservasPendentesCLIENTE.AsString+' ?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
      begin
      pegaItens();

      Application.CreateForm(TfrmLocacao,frmLocacao);

      frmLocacao.limpar();
      //dados da locação
      frmLocacao.operacao := 'reserva';
      frmLocacao.codCliente := frmPrincipal.cdsReservasPendentesCODCLIENTE.AsInteger;
      if (frmPrincipal.cdsReservasPendentesCOD_FUNCIONARIO.AsInteger <>0)then
        begin
        frmLocacao.codFuncionario := frmPrincipal.cdsReservasPendentesCOD_FUNCIONARIO.AsInteger;
        DM.qryUsuario.Close;
        DM.qryUsuario.SQL.Clear;
        DM.qryUsuario.SQL.Add('SELECT * FROM Usuario u WHERE u.codigo=:cod');
        DM.qryUsuario.ParamByName('cod').AsInteger := frmPrincipal.cdsReservasPendentesCOD_FUNCIONARIO.AsInteger;
        DM.qryUsuario.Prepared := true;
        DM.qryUsuario.Open;
        DM.cdsUsuario.Open;
        DM.cdsUsuario.Refresh;
        frmLocacao.edFuncionario.Text := DM.cdsUsuarioNOME.AsString;
        end;
      frmLocacao.edCliente.Text := frmPrincipal.cdsReservasPendentesCLIENTE.AsString;
      if(frmPrincipal.cdsReservasPendentesSEXO.AsString = 'Masculino')then
        frmLocacao.rdGrpSexo.ItemIndex := 0
      else if(frmPrincipal.cdsReservasPendentesSEXO.AsString = 'Feminino')then
        frmLocacao.rdGrpSexo.ItemIndex := 1
      else
        frmLocacao.rdGrpSexo.ItemIndex := -1;
      frmLocacao.mEdDataInicio.Text := frmPrincipal.cdsReservasPendentesDATA_INICIO.AsString;
      frmLocacao.mEdDataFinal.Text := frmPrincipal.cdsReservasPendentesDATA_FINAL.AsString;
      frmLocacao.mmObservacao.Text := frmPrincipal.cdsReservasPendentesOBSERVACOES.AsString;
      frmLocacao.lblValorTotal.Caption := FormatFloat('#0.00',frmPrincipal.cdsReservasPendentesVALOR_TOTAL.AsFloat);

      frmLocacao.btBtnConfirmarClick(Sender);

      codLocacao := StrToInt(frmLocacao.edCodigo.Text);

      //produtos da locação
      try
        iniciaTransacao();
        DM.SQLConnection.StartTransaction(transacao);
        cdsItens.First;
        while(not(cdsItens.Eof))do
          begin
          codProd := cdsItensCODIGO.AsInteger;
          DM.cdsProdutoCODIGO.AsInteger;

          DM.qryProduto.Close;
          DM.qryProduto.SQL.Clear;
          DM.qryProduto.SQL.Add('SELECT * FROM Produto p WHERE p.codigo=:cod');
          DM.qryProduto.ParamByName('cod').AsInteger := codProd;
          DM.qryProduto.Prepared := true;
          DM.qryProduto.Open;
          DM.cdsProduto.Open;
          DM.cdsProduto.Refresh;

          if(DM.cdsProdutoSTATUS.AsInteger=1)then
            begin
            MessageDlg('Não foi realizada a devolução do Produto '+DM.cdsProdutoNOME.AsString+#13+'Realize a Devolução antes de uma nova Locação!',mtInformation,[mbOK],0);
            end
          else
            begin
            //alterando status do produto
            DM.qryProduto.Close;
            DM.qryProduto.SQL.Clear;
            DM.qryProduto.SQL.Add('UPDATE Produto p SET p.status =:sta WHERE p.codigo=:cod');
            DM.qryProduto.ParamByName('sta').AsInteger := 1; //alugado
            DM.qryProduto.ParamByName('cod').AsInteger := codProd;
            DM.qryProduto.Prepared := true;
            DM.qryProduto.ExecSQL();

            //inserindo item da locação
            DM.qryItemLocacao.Close;
            DM.qryItemLocacao.SQL.Clear;
            DM.qryItemLocacao.SQL.Add('INSERT INTO Item_Locacao(cod_locacao,cod_produto,quantidade,valor_unitario,valor_total) ');
            DM.qryItemLocacao.SQL.Add('VALUES (:codLoc,:codPro,:qua,:valUni,:valTot)');
            DM.qryItemLocacao.ParamByName('codLoc').AsInteger := codLocacao;
            DM.qryItemLocacao.ParamByName('codPro').AsInteger := codProd;
            DM.qryItemLocacao.ParamByName('qua').AsInteger := cdsItensQUANTIDADE.AsInteger;
            DM.qryItemLocacao.ParamByName('valUni').AsFloat := cdsItensVALOR_UNITARIO.AsFloat;
            DM.qryItemLocacao.ParamByName('valTot').AsFloat := cdsItensVALOR_TOTAL.AsFloat;
            DM.qryItemLocacao.Prepared := true;
            DM.qryItemLocacao.ExecSQL();
            end;

          cdsItens.Next;
          end;
        //status da reserva
        DM.qryReserva.Close;
        DM.qryReserva.SQL.Clear;
        DM.qryReserva.SQL.Add('UPDATE Reserva SET status=:sta WHERE codigo=:cod');
        DM.qryReserva.ParamByName('sta').AsInteger := 1;
        DM.qryReserva.ParamByName('cod').AsInteger := frmPrincipal.cdsReservasPendentesCODIGO.AsInteger;
        DM.qryReserva.Prepared := true;
        DM.qryReserva.ExecSQL();

        DM.SQLConnection.Commit(transacao);
      except
        DM.SQLConnection.Rollback(transacao);
        MessageDlg('Produto não pode ser inserido!',mtInformation,[mbOK],0);
      end;

      frmLocacao.ShowModal;
      frmLocacao.Free;

      frmPrincipal.reservasPendentes('jaAbriu');
      frmPrincipal.cdsReservasPendentes.First;
      pegaItens();
    end;
    end;
end;


end.
