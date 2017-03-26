unit unPagamentoParcela;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, plsEdit, Grids, DBGrids, ExtCtrls, ComCtrls, unFrmBasico,
  DB, DBClient, Buttons, unFuncoes, Provider, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, plsMemo;

type
  TfrmPagamentoParcela = class(TForm)
    zQryPedido: TZQuery;
    dspPedido: TDataSetProvider;
    cdsPedido: TClientDataSet;
    zQryPedidoCODIGO: TIntegerField;
    zQryPedidoDESCRICAO: TStringField;
    zQryPedidoVALOR_TOTAL: TFloatField;
    zQryPedidoSTATUS: TIntegerField;
    zQryPedidoCONDICAO_PAGAMENTO: TIntegerField;
    zQryPedidoNOME: TStringField;
    cdsPedidoCODIGO: TIntegerField;
    cdsPedidoDESCRICAO: TStringField;
    cdsPedidoVALOR_TOTAL: TFloatField;
    cdsPedidoSTATUS: TIntegerField;
    cdsPedidoCONDICAO_PAGAMENTO: TIntegerField;
    cdsPedidoNOME: TStringField;
    grpBxPedido: TGroupBox;
    lblInfCliente: TLabel;
    lblCliente: TLabel;
    lblInfValorTotal: TLabel;
    lblValorTotal: TLabel;
    lblInfDescricaoPedido: TLabel;
    lblDescricaoPedido: TLabel;
    zQryParcelasPedido: TZQuery;
    dspParcelasPedido: TDataSetProvider;
    cdsParcelasPedido: TClientDataSet;
    zQryParcelasPedidoCODIGO: TIntegerField;
    zQryParcelasPedidoVALOR_PARCELA: TFloatField;
    zQryParcelasPedidoDATA_VCTO: TDateField;
    zQryParcelasPedidoDATA_PGTO: TDateField;
    zQryParcelasPedidoDESCRICAO: TStringField;
    zQryParcelasPedidoCODIGOPEDIDO: TIntegerField;
    cdsParcelasPedidoCODIGO: TIntegerField;
    cdsParcelasPedidoVALOR_PARCELA: TFloatField;
    cdsParcelasPedidoDATA_VCTO: TDateField;
    cdsParcelasPedidoDATA_PGTO: TDateField;
    cdsParcelasPedidoDESCRICAO: TStringField;
    cdsParcelasPedidoCODIGOPEDIDO: TIntegerField;
    grpBxParcelas: TGroupBox;
    dsParcelasPedido: TDataSource;
    grParcelas: TDBGrid;
    dsDados: TDataSource;
    cdsExibeDados: TClientDataSet;
    pnlPagar: TPanel;
    edValorPago: TPlsEdit;
    btnPagar: TBitBtn;
    ckBxEmitirRecibo: TCheckBox;
    lblValorPago: TLabel;
    lblDescricao: TLabel;
    mmDescricao: TPlsMemo;
    zQryParcelasPedidoCODIGOCLIENTE: TIntegerField;
    cdsParcelasPedidoCODIGOCLIENTE: TIntegerField;
    zQryParcelasPedidoNUMERO_PARCELA: TIntegerField;
    cdsParcelasPedidoNUMERO_PARCELA: TIntegerField;
    grpBxLegenda: TGroupBox;
    shpLegendaParcelaPaga: TShape;
    lblLegendaParcelaPaga: TLabel;
    lblLegendaParcelaVencida: TLabel;
    shpLegendaParcelaVencida: TShape;
    lblLegendaParcelaNoPrazo: TLabel;
    shpLegendaParcelaNoPrazo: TShape;
    lblLegendaParcelaVenceHoje: TLabel;
    shpLegendaParcelaVenceHoje: TShape;
    lblNroPedido: TLabel;
    lblInfNroPedido: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cdsExibeDadosAfterScroll(DataSet: TDataSet);
    procedure btnPagarClick(Sender: TObject);
    procedure grParcelasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    FnCodParcela: Integer;
    FnCodPedido: Integer;
    FoFuncoes: TFuncoes;

    procedure ControlarPainelPagar;
    procedure EmitirRecibo(pnCodCliente: integer; psVlrPago: string; pnCodPedido: integer; pnNumeroParcela: integer;
      psDtVcto: string);
  protected
    FoTelaPai: TWinControl;
    procedure HabilitarTela(pnStatus: Integer);
    procedure PesquisarDados;
    procedure CriarDataSetExibirDados;
    procedure CopiarDadosDataSetExibeDados;
  public
    procedure PassaParametro(const psParametro: string; const pvValor: OleVariant);
  end;

implementation

uses
  unConstantes, unDM, unRecibo;

{$R *.dfm}

{ TfrmPagamentoParcelas }

procedure TfrmPagamentoParcela.PassaParametro(const psParametro: string; const pvValor: OleVariant);
begin
  if (psParametro = sPRM_TELA_PAI) and (not VarIsNull(pvValor)) then
    integer(FoTelaPai) := pvValor

  else if (psParametro = sPRM_CODIGO_PARCELA) then
  begin
    FnCodParcela := pvValor;
    PesquisarDados;
  end;
end;

procedure TfrmPagamentoParcela.CriarDataSetExibirDados;
begin
  if cdsExibeDados.Active then
     cdsExibeDados.EmptyDataSet;

  cdsExibeDados.FieldDefs.Add('CODIGO', ftInteger, 0, True);
  cdsExibeDados.FieldDefs.Add('VALOR_PARCELA', ftString, 20, False);
  cdsExibeDados.FieldDefs.Add('DATA_VCTO', ftString, 10, False);
  cdsExibeDados.FieldDefs.Add('DATA_PGTO', ftString, 10, False);
  cdsExibeDados.FieldDefs.Add('DESCRICAO', ftString, 500, False);
  cdsExibeDados.CreateDataSet;
end;

procedure TfrmPagamentoParcela.CopiarDadosDataSetExibeDados;
begin
  cdsExibeDados.EmptyDataSet;
  cdsParcelasPedido.DisableControls;
  cdsExibeDados.DisableControls;
  try
    cdsParcelasPedido.First;
    while not(cdsParcelasPedido.Eof) do
    begin
      cdsExibeDados.Append;
      cdsExibeDados.FieldByName('CODIGO').AsInteger := cdsParcelasPedido.FieldByName('CODIGO').AsInteger;
      cdsExibeDados.FieldByName('VALOR_PARCELA').AsString :=
        FoFuncoes.FormatarValorMonetario(cdsParcelasPedido.FieldByName('VALOR_PARCELA').AsString);
      cdsExibeDados.FieldByName('DATA_VCTO').AsString := cdsParcelasPedido.FieldByName('DATA_VCTO').AsString;
      cdsExibeDados.FieldByName('DATA_PGTO').AsString := cdsParcelasPedido.FieldByName('DATA_PGTO').AsString;
      cdsExibeDados.FieldByName('DESCRICAO').AsString := cdsParcelasPedido.FieldByName('DESCRICAO').AsString;
      cdsExibeDados.Post;
      cdsParcelasPedido.Next;
    end;
  finally
    cdsParcelasPedido.EnableControls;
    cdsExibeDados.EnableControls;
  end;
end;

procedure TfrmPagamentoParcela.ControlarPainelPagar;
begin
  if (Trim(cdsExibeDados.FieldByName('DATA_PGTO').AsString) = STRING_INDEFINIDO) then
  begin
    edValorPago.Text := cdsExibeDados.FieldByName('VALOR_PARCELA').AsString;
    mmDescricao.Lines.Text := cdsExibeDados.FieldByName('DESCRICAO').AsString;
    edValorPago.Enabled := True;
    mmDescricao.Enabled := True;
    btnPagar.Enabled := True;
    ckBxEmitirRecibo.Checked := True;
    ckBxEmitirRecibo.Enabled := True;
  end
  else
  begin
    edValorPago.Text := STRING_INDEFINIDO;
    mmDescricao.Lines.Text := STRING_INDEFINIDO;
    edValorPago.Enabled := False;
    mmDescricao.Enabled := False;
    btnPagar.Enabled := False;
    ckBxEmitirRecibo.Checked := False;
    ckBxEmitirRecibo.Enabled := False;
  end;
end;

procedure TfrmPagamentoParcela.EmitirRecibo(pnCodCliente: integer; psVlrPago: string; pnCodPedido: integer;
  pnNumeroParcela: integer; psDtVcto: string);
var
  frmRelRecibo: TfrmRelRecibo;
begin
  Application.CreateForm(TfrmRelRecibo, frmRelRecibo);
  frmRelRecibo.PassaParametro(sPRM_TIPO_RECIBO, nTP_RECIBO_PARCELA);
  frmRelRecibo.PassaParametro(sPRM_CLIENTE_RECIBO, pnCodCliente);
  frmRelRecibo.PassaParametro(sPRM_VALOR_RECIBO, psVlrPago);
  frmRelRecibo.PassaParametro(sPRM_CODIGO_PEDIDO, pnCodPedido);
  frmRelRecibo.PassaParametro(sPRM_NUMERO_PARCELA, pnNumeroParcela);
  frmRelRecibo.PassaParametro(sPRM_DATA_VENCIMENTO, psDtVcto);
  frmRelRecibo.PassaParametro(sPRM_BUSCAR_DADOS_RECIBO, null);
  frmRelRecibo.relRecibo.Preview;
end;

procedure TfrmPagamentoParcela.HabilitarTela(pnStatus: Integer);
begin
  inherited;
end;

procedure TfrmPagamentoParcela.PesquisarDados;
begin
  if (FnCodParcela = NUMERO_INDEFINIDO) then
    Exit;
     
  //dados do pedido.
  cdsPedido.Close;
  zQryPedido.Close;
  zQryPedido.SQL.Clear;
  zQryPedido.SQL.Add('SELECT ped.codigo, ped.descricao, ped.valor_total, ped.status, ped.condicao_pagamento, c.nome ');
  zQryPedido.SQL.Add('FROM pedido ped ');
  zQryPedido.SQL.Add('JOIN cliente c ON ped.cod_cliente = c.codigo ');
  zQryPedido.SQL.Add('JOIN pagamento_pedido pp ON ped.codigo = pp.cod_pedido');
  zQryPedido.SQL.Add('WHERE pp.codigo = :cod_parcela');
  zQryPedido.ParamByName('cod_parcela').AsInteger := FnCodParcela;
  zQryPedido.Open;
  cdsPedido.Open;

  if (cdsPedido.RecordCount = 1) then
  begin
    FnCodPedido := cdsPedido.FieldbyName('codigo').AsInteger;
    lblNroPedido.Caption := IntToStr(FnCodPedido);
    lblCliente.Caption := cdsPedido.FieldbyName('nome').AsString;
    lblValorTotal.Caption := FoFuncoes.FormatarValorMonetario(cdsPedido.FieldbyName('valor_total').AsString);
    lblDescricaoPedido.Caption := cdsPedido.FieldByName('descricao').AsString;
  end;

  if (FnCodPedido = NUMERO_INDEFINIDO) then     
    Exit;

  //parcelas do pedido.
  cdsParcelasPedido.Close;
  zQryParcelasPedido.Close;
  zQryParcelasPedido.SQL.Clear;
  zQryParcelasPedido.SQL.Add('SELECT pp.codigo, pp.valor_parcela, pp.data_vcto, pp.data_pgto, pp.descricao,');
  zQryParcelasPedido.SQL.Add('ped.codigo AS codigoPedido,');
  zQryParcelasPedido.SQL.Add('pp.numero_parcela,');
  zQryParcelasPedido.SQL.Add('ped.cod_cliente AS codigoCliente ');
  zQryParcelasPedido.SQL.Add('FROM pagamento_pedido pp ');
  zQryParcelasPedido.SQL.Add('JOIN pedido ped ON pp.cod_pedido = ped.codigo ');
  zQryParcelasPedido.SQL.Add('WHERE ped.codigo = :cod_pedido');
  zQryParcelasPedido.SQL.Add('ORDER BY pp.data_pgto, pp.data_vcto');
  zQryParcelasPedido.ParamByName('cod_pedido').AsInteger := FnCodPedido;
  zQryParcelasPedido.Open;
  cdsParcelasPedido.Open;

  if not(cdsParcelasPedido.IsEmpty) then
  begin
    CopiarDadosDataSetExibeDados;
    //FoFuncoes.FormatarValorMonetarioEmBloco(cdsExibeDados, 'VALOR_PARCELA', STRING_INDEFINIDO);
    ControlarPainelPagar;
    cdsExibeDados.Locate('CODIGO', FnCodParcela, []);
  end;
end;

procedure TfrmPagamentoParcela.FormCreate(Sender: TObject);
begin
  inherited;
  FnCodParcela := NUMERO_INDEFINIDO;
  FnCodPedido := NUMERO_INDEFINIDO;
  FoFuncoes := TFuncoes.Create;
  CriarDataSetExibirDados;
  FoFuncoes.AjustarLarguraColunasTDBGrid(grParcelas);  
end;

procedure TfrmPagamentoParcela.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoFuncoes);
end;

procedure TfrmPagamentoParcela.cdsExibeDadosAfterScroll(DataSet: TDataSet);
begin
  ControlarPainelPagar;
end;

procedure TfrmPagamentoParcela.btnPagarClick(Sender: TObject);
var
  nCodParcela: Integer;
  sVlrParcela: String;
  sVlrPago: String;
  dVlrParcela: Double;
  dVlrPago: Double;
  nCodCliente: integer;
  nNumeroParcela: integer;
  sDtVcto: string;
begin
  if (FoFuncoes.RetornarCaixaMensagem('Após pagar a parcela a mesma não pode ser revertida.' +#13+
    '                        Deseja continuar?', [mbYes,mbNo], 'Confirmação', mtConfirmation) = mrYes) then

  begin
    nCodParcela := cdsExibeDados.fieldByName('codigo').AsInteger;

    cdsParcelasPedido.Locate('codigo', cdsExibeDados.fieldByName('codigo').AsInteger, []);
    nCodCliente := cdsParcelasPedido.FieldByName('codigoCliente').AsInteger;
    nNumeroParcela := cdsParcelasPedido.FieldByName('numero_parcela').AsInteger;
    sDtVcto := cdsParcelasPedido.FieldByName('data_vcto').AsString;
    sVlrParcela := FoFuncoes.retirarCaracteres(cdsParcelasPedido.fieldByName('valor_parcela').AsString, '.');
    sVlrPago := FoFuncoes.retirarCaracteres(edValorPago.Text, '.');
    dVlrParcela := StrToFloat(sVlrParcela);
    dVlrPago := StrToFloat(sVlrPago);

    //foi pago valor da parcela.
    if (dVlrParcela = dVlrPago) then
    begin
      DM.ZConnection.StartTransaction;
      try
        DM.zQryPagamentoPedido.Close;
        DM.zQryPagamentoPedido.SQL.Clear;
        DM.zQryPagamentoPedido.SQL.Add('UPDATE pagamento_pedido SET data_pgto = :data_pgto, descricao = :descricao ');
        DM.zQryPagamentoPedido.SQL.Add('WHERE codigo = :codigo');
        DM.zQryPagamentoPedido.ParamByName('data_pgto').AsDate := Date;
        DM.zQryPagamentoPedido.ParamByName('descricao').AsString := mmDescricao.Lines.Text;
        DM.zQryPagamentoPedido.ParamByName('codigo').AsInteger := nCodParcela;
        DM.zQryPagamentoPedido.ExecSQL;

        DM.ZConnection.Commit;
        FoFuncoes.RetornarCaixaMensagem('Parcela paga com sucesso.',[mbOK], 'Informação', mtInformation);
        //emitir recibo.
        if ckBxEmitirRecibo.Checked then
          EmitirRecibo(nCodCliente, sVlrPago, FnCodPedido, nNumeroParcela, sDtVcto);

        PesquisarDados;
      except
        FoFuncoes.RetornarCaixaMensagem('Parcela não pode ser paga.',[mbOK], 'Informação', mtInformation);
        DM.ZConnection.Rollback;
        Exit;
      end;
    end

    //foi pago menos do que o valor da parcela.


    //foi pago mais do que o valor da parcela.
  end;
end;



procedure TfrmPagamentoParcela.grParcelasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);

  procedure VerificarLinhaSelecionada;
  begin
    //a linha selecionada no grid fica com a fonte em negrito.
    if (gdSelected in State) then
      grParcelas.Canvas.Font.Style := grParcelas.Canvas.Font.Style + [fsBold];
  end;

begin
  //parcela já paga.
  if not(cdsExibeDados.FieldByName('DATA_PGTO').AsString = STRING_INDEFINIDO) then
  begin
    VerificarLinhaSelecionada;
    grParcelas.Canvas.Brush.Color := clAqua; //cor da célula.
    grParcelas.Canvas.Font.Color := clBlack; //cor da fonte.
    grParcelas.Canvas.FillRect(Rect); //pinta a célula.
    grParcelas.DefaultDrawDataCell(Rect,Column.Field,State); //reescreve o valor que vem do banco.
  end

  //parcela ainda não paga.
  else
  begin
     //parcela vencida.
    if (StrToDate(cdsExibeDados.FieldByName('DATA_VCTO').AsString) < Date) then
    begin
      VerificarLinhaSelecionada;
      grParcelas.Canvas.Brush.Color := clRed;
      grParcelas.Canvas.Font.Color := clBlack;
      grParcelas.Canvas.FillRect(Rect);
    grParcelas.DefaultDrawDataCell(Rect,Column.Field,State);
    end
    //parcela no prazo.
    else
    if (StrToDate(cdsExibeDados.FieldByName('DATA_VCTO').AsString) > Date) then
    begin
      VerificarLinhaSelecionada;
      grParcelas.Canvas.Brush.Color := clSilver;
      grParcelas.Canvas.Font.Color := clBlack;
      grParcelas.Canvas.FillRect(Rect);
    grParcelas.DefaultDrawDataCell(Rect,Column.Field,State);
    end
    //parcela vence hoje.
    else
    if (StrToDate(cdsExibeDados.FieldByName('DATA_VCTO').AsString) = Date) then
    begin
      VerificarLinhaSelecionada;
      grParcelas.Canvas.Brush.Color := clYellow;
      grParcelas.Canvas.Font.Color := clBlack;
      grParcelas.Canvas.FillRect(Rect);
      grParcelas.DefaultDrawDataCell(Rect,Column.Field,State);
    end;
  end;
end;

end.
