unit unPagamentoPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, plsEdit, Grids, DBGrids, ExtCtrls, ComCtrls, unFrmBasico,
  DB, DBClient, Buttons, unFuncoes;

type
  TfrmPagamentoPedido = class(TFrmBasico)
    pnlTopo: TPanel;
    lblInfCliente: TLabel;
    lblInfValorTotal: TLabel;
    lblCliente: TLabel;
    lblValorTotal: TLabel;
    StatusBar: TStatusBar;
    grpBxPagamento: TGroupBox;
    edValorVista: TPlsEdit;
    edNumeroParcelas: TPlsEdit;
    lblValorPagoVista: TLabel;
    lblParcelas: TLabel;
    btBtnFinalizar: TBitBtn;
    edIntervaloDias: TPlsEdit;
    lblIntervalo: TLabel;
    cdsParcelasPgto: TClientDataSet;
    dsParcelasPgto: TDataSource;
    grParcelas: TDBGrid;
    cdsParcelasPgtonumero: TIntegerField;
    cdsParcelasPgtodata_vcto: TStringField;
    cdsParcelasPgtovalor: TStringField;
    lblJuros: TLabel;
    edTaxaJuros: TPlsEdit;
    procedure edNumeroParcelasExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btBtnFinalizarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure grParcelasColExit(Sender: TObject);
    procedure edIntervaloDiasExit(Sender: TObject);
  private
    FnCodPedido: Integer;
    FoFuncoes: TFuncoes;
    FbFinalizou: Boolean;

    procedure PassaParametro(const psParametro: string; const pvValor: OleVariant); override;
    function ValidouPagamentoPedido: Boolean;
    procedure DefinirLarguraAlturaTela;
    procedure GerarParcelasDoPagamentoDoPedido;
  public
  end;

implementation

uses unConstantes, unDM, dateUtils;

const
  nIDX_VALOR = 1;

{$R *.dfm}

{ TfrmPagamentoPedido }

procedure TfrmPagamentoPedido.PassaParametro(const psParametro: string; const pvValor: OleVariant);
begin
  inherited;

  if (psParametro = sPRM_DADOS_REALIZAR_PAGAMENTO_PEDIDO) then
  begin
    FnCodPedido := pvValor[0];
    lblCliente.Caption := pvValor[1];
    lblValorTotal.Caption := 'R$ ' + pvValor[2];
    edValorVista.Text := pvValor[2];
    edNumeroParcelas.Text := '0';
    edTaxaJuros.Text := '0';
  end;
end;

function TfrmPagamentoPedido.ValidouPagamentoPedido: Boolean;
var
  //valida os valores.
  dVlrTotalReal: Currency;
  dVlrVista: Currency;
  dVlrParcelas: Currency;
  dVlrTotal: Currency;

  bParcelaValida: Boolean;
  bValorValido: Boolean;
  bDataValida: Boolean; //valida a data de vencimento.
  nRecNoRegistroInvalido: Integer;

  procedure ValidarNumeroDaParcela(psNumero: string);
  begin
    //já foi encontrada uma parcela inválida.
    if not bParcelaValida then
      Exit;

    if (FoFuncoes.RetornarValorInteiro(psNumero) = NUMERO_INDEFINIDO) then
    begin
      bParcelaValida := False;
      nRecNoRegistroInvalido := cdsParcelasPgto.RecNo;
    end;
  end;

  procedure ValidarValorDaParcela(psValor: string);
  begin
    //já foi encontrada um valor inválido.
    if not bValorValido then
      Exit;

    if (FoFuncoes.RetornarValorDouble(psValor) = NUMERO_INDEFINIDO)then
    begin
      bValorValido := False;
      nRecNoRegistroInvalido := cdsParcelasPgto.RecNo;
    end;
  end;

  procedure ValidarDataDaParcela(psData: string);
  var
    dDataAtual: TDate;
  begin
    //já foi encontrada uma data inválida.
    if not bDataValida then
      Exit;

    if not(FoFuncoes.validarData(psData))then
    begin
      bDataValida := False;
      nRecNoRegistroInvalido := cdsParcelasPgto.RecNo;
    end
    //a data da parcela deve ser maior que a data de hoje.
    else
    begin
      dDataAtual := Now;
      if not(StrToDate(psData) > dDataAtual) then
      begin
        bDataValida := False;
        nRecNoRegistroInvalido := cdsParcelasPgto.RecNo;
      end;
    end;
  end;

begin
  Result := True;
  bParcelaValida := True;
  bValorValido := True;
  bDataValida := True;
  nRecNoRegistroInvalido := NUMERO_INDEFINIDO;
  cdsParcelasPgto.DisableControls;
  try
    //validando os valores.
    dVlrTotalReal := FoFuncoes.formatarValorCurrency(lblValorTotal.Caption, True, 'R$');
    dVlrVista := FoFuncoes.formatarValorCurrency(edValorVista.Text);
    dVlrParcelas := 0;

    cdsParcelasPgto.First;
    while not(cdsParcelasPgto.Eof) do
    begin
      dVlrParcelas := dVlrParcelas + FoFuncoes.formatarValorCurrency(cdsParcelasPgto.FieldByName('valor').AsString);
      //aproveita e neste laço já a validação da data.
      ValidarNumeroDaParcela(cdsParcelasPgto.FieldByName('numero').AsString);
      ValidarValorDaParcela(cdsParcelasPgto.FieldByName('valor').AsString);
      ValidarDataDaParcela(cdsParcelasPgto.FieldByName('data_vcto').AsString);
      cdsParcelasPgto.Next;
    end;

    dVlrTotal := dVlrVista + dVlrParcelas;
    if (dVlrTotalReal <> dVlrTotal) then
    begin
      Result := False;
      FoFuncoes.RetornarCaixaMensagem('A soma do valor da condição de pagamento está incorreta.' + #13 +
        '          O valor do pedido é de ' + lblValorTotal.Caption);
    end;

    //há algum número inválido de alguma da parcela.
    if (Result) and (not(bParcelaValida)) then
    begin
      Result := False;
      FoFuncoes.RetornarCaixaMensagem('O número da Parcela é inválido.');
      cdsParcelasPgto.RecNo := nRecNoRegistroInvalido;
    end;

    //há algum valor inválido de alguma da parcela.
    if (Result) and (not(bValorValido)) then
    begin
      Result := False;
      FoFuncoes.RetornarCaixaMensagem('O valor da Parcela é inválido.');
      cdsParcelasPgto.RecNo := nRecNoRegistroInvalido;
    end;

    //há alguma data inválida de alguma parcela.
    if (Result) and (not(bDataValida)) then
    begin
      Result := False;
      FoFuncoes.RetornarCaixaMensagem('A data da Parcela é inválida.');
      cdsParcelasPgto.RecNo := nRecNoRegistroInvalido;
    end;

  finally
    cdsParcelasPgto.EnableControls;
  end;
end;

procedure TfrmPagamentoPedido.DefinirLarguraAlturaTela;
begin
  Self.Constraints.MinWidth := Self.Width;
  Self.Constraints.MinHeight := Self.Height;
  Self.Constraints.MaxWidth := Self.Width;
  Self.Constraints.MaxHeight := Self.Height;
end;

procedure TfrmPagamentoPedido.GerarParcelasDoPagamentoDoPedido;
var
  i, nParcelas: Integer;
  dDataParcela: TDate;
  nIntervaloDiasParcelas: Integer;
  dValorTotal: Currency;
  dValorVista: Currency;
  dValorRestante: Currency;
  dValorCalculoParcela: Currency;
  dValorSomaCalculoParcelas: Currency;
  dTaxaJuros: Currency;
  dValorJuros: Currency;

  procedure CalcularJuros;
  begin
    dTaxaJuros := NUMERO_INDEFINIDO;
    dValorJuros := NUMERO_INDEFINIDO;

    if (FoFuncoes.RetornarValorDouble(edTaxaJuros.Text) <> NUMERO_INDEFINIDO) then
    begin
      dTaxaJuros := (StrToFloat(edTaxaJuros.Text)) / 100;

      dValorJuros := dValorRestante * dTaxaJuros * nParcelas;
    end;
  end;

begin
  if (cdsParcelasPgto.Active) then
    cdsParcelasPgto.EmptyDataSet;

  //número de parcelas.
  if (FoFuncoes.RetornarValorInteiro(edNumeroParcelas.Text) <> NUMERO_INDEFINIDO) then
  begin
    //valor total do pedido.
    dValorTotal := FoFuncoes.formatarValorCurrency(lblValorTotal.Caption, True, 'R$');
    dValorVista := FoFuncoes.formatarValorCurrency(edValorVista.Text);
    dValorRestante := dValorTotal - dValorVista;
    if (dValorRestante <= 0) then
      Exit;

    //total de parcelas.
    nParcelas := FoFuncoes.RetornarValorInteiro(edNumeroParcelas.Text);
    if (nParcelas = NUMERO_INDEFINIDO) then
      Exit;

    //intervalo de dias entre uma parcela e outra.
    if (FoFuncoes.RetornarValorInteiro(edIntervaloDias.Text) = NUMERO_INDEFINIDO) then
    begin
      nIntervaloDiasParcelas := 30;
      edIntervaloDias.Text := IntToStr(nIntervaloDiasParcelas);
    end
    else
      nIntervaloDiasParcelas := StrToInt(edIntervaloDias.Text);

    //calculando taxa de juros.
    CalcularJuros;
    dValorRestante := dValorRestante + dValorJuros;

    //cálculo automático da parcela.
    dValorCalculoParcela := dValorRestante / nParcelas;
    dValorSomaCalculoParcelas := 0;

    //lançando parcelas.
    dDataParcela := IncDay(Now,nIntervaloDiasParcelas);
    for i :=1 to nParcelas do
    begin
      //recalcula o valor da parcela (dValorCalculoParcela), para fechar certo o total do pedido.
      if (i = nParcelas) and (nParcelas > 1) then
        dValorCalculoParcela := dValorRestante - dValorSomaCalculoParcelas;

      cdsParcelasPgto.Append;
      cdsParcelasPgto.FieldByName('numero').AsString := IntToStr(i);
      cdsParcelasPgto.FieldByName('valor').AsString :=  FormatFloat('#.00', dValorCalculoParcela);
      cdsParcelasPgto.FieldByName('data_vcto').AsString := DateToStr(dDataParcela);
      cdsParcelasPgto.Post;
      dDataParcela := IncDay(dDataParcela,nIntervaloDiasParcelas);
      dValorSomaCalculoParcelas := dValorSomaCalculoParcelas + cdsParcelasPgto.FieldByName('valor').AsFloat;
    end;
    cdsParcelasPgto.Active := True;
  end;
end;

procedure TfrmPagamentoPedido.edNumeroParcelasExit(Sender: TObject);
begin
  GerarParcelasDoPagamentoDoPedido;
end;

procedure TfrmPagamentoPedido.FormCreate(Sender: TObject);
begin
  FoFuncoes := TFuncoes.Create;
  FbFinalizou := False;
  DefinirLarguraAlturaTela;
end;

procedure TfrmPagamentoPedido.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoFuncoes);
end;

procedure TfrmPagamentoPedido.btBtnFinalizarClick(Sender: TObject);

  procedure GerarSqlInsert;
  begin
    DM.zQryPagamentoPedido.SQL.Add('INSERT INTO pagamento_pedido (cod_pedido, valor_total, valor_parcela, data_vcto, data_pgto, descricao) ');
    DM.zQryPagamentoPedido.SQL.Add('VALUES (:cod_pedido, :valor_total, :valor_parcela, :data_vcto, :data_pgto, :descricao) ');
  end;

begin
  if not(ValidouPagamentoPedido) then
    Exit;

  //salvando os pagamento.
  try
    DM.ZConnection.StartTransaction;

    //inserindo valor vista.
    if (FoFuncoes.validarValorMonetario(edValorVista.Text, False)) then
    begin
      DM.zQryPagamentoPedido.Close;
      DM.zQryPagamentoPedido.SQL.Clear;
      GerarSqlInsert;
      DM.zQryPagamentoPedido.ParamByName('cod_pedido').AsInteger := FnCodPedido;
      DM.zQryPagamentoPedido.ParamByName('valor_total').AsCurrency := StrToFloat(edValorVista.Text);
      DM.zQryPagamentoPedido.ParamByName('valor_parcela').AsCurrency := StrToFloat(edValorVista.Text);
      DM.zQryPagamentoPedido.ParamByName('data_vcto').AsDate := Now;
      DM.zQryPagamentoPedido.ParamByName('data_pgto').AsDate := Now;
      DM.zQryPagamentoPedido.ParamByName('descricao').AsString := STRING_INDEFINIDO;
      DM.zQryPagamentoPedido.ExecSQL;
    end;

    if not(cdsParcelasPgto.IsEmpty) then
    begin
      //inserindo parcelas (à prazo).
      cdsParcelasPgto.First;
      while not(cdsParcelasPgto.Eof) do
      begin
        DM.zQryPagamentoPedido.Close;
        DM.zQryPagamentoPedido.SQL.Clear;
        GerarSqlInsert;
        DM.zQryPagamentoPedido.ParamByName('cod_pedido').AsInteger := FnCodPedido;
        DM.zQryPagamentoPedido.ParamByName('valor_total').AsCurrency := StrToFloat(edValorVista.Text);
        DM.zQryPagamentoPedido.ParamByName('valor_parcela').AsCurrency := cdsParcelasPgto.FieldByName('valor').AsCurrency;
        DM.zQryPagamentoPedido.ParamByName('data_vcto').AsDate := cdsParcelasPgto.FieldByName('data_vcto').AsDateTime;
        DM.zQryPagamentoPedido.ParamByName('data_pgto').Clear;
        DM.zQryPagamentoPedido.ParamByName('descricao').AsString := STRING_INDEFINIDO;
        DM.zQryPagamentoPedido.ExecSQL;
        cdsParcelasPgto.Next;
      end;
    end;

    DM.ZConnection.Commit;
    MessageDlg('Condições de Pagamento gerada com sucesso.', mtInformation, [mbOK], 0);
    FbFinalizou := True;    
    Self.Close;
  except
    MessageDlg('Condição de Pagamento não pode ser salva.', mtInformation, [mbOK], 0);
    DM.ZConnection.Rollback;
  end;
end;

procedure TfrmPagamentoPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not(FbFinalizou) then
  begin
    if (MessageDlg('Deseja fechar a tela sem realizar o pagamento do Pedido?', mtConfirmation, [mbYes,mbNo],0)=mrNone)then
      Action := caNone;
  end;
end;

procedure TfrmPagamentoPedido.grParcelasKeyPress(Sender: TObject;
  var Key: Char);
begin
  //coluna do valor unitário ou valor total
  if (grParcelas.SelectedIndex = nIDX_VALOR) then
  begin
    if not(Key in['0'..'9',',',Chr(8)])then
      Key:= #0
  end;
end;

procedure TfrmPagamentoPedido.grParcelasColExit(Sender: TObject);
begin
  if (grParcelas.SelectedIndex = nIDX_VALOR) then
      grParcelas.Columns.Grid.Fields[nIDX_VALOR].Text := FoFuncoes.formatarValorMonetario(grParcelas.Columns.Grid.Fields[nIDX_VALOR].Text);
end;

procedure TfrmPagamentoPedido.edIntervaloDiasExit(Sender: TObject);
begin
  GerarParcelasDoPagamentoDoPedido;
end;

end.

