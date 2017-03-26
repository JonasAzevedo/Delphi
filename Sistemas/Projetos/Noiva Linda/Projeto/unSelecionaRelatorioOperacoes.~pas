unit unSelecionaRelatorioOperacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, AppEvnts, ComCtrls, FMTBcd, DBClient,
  Provider, DB, SqlExpr, SqlTimSt, RpBase, RpSystem, RpDefine, RpRave,
  RpCon, RpConDS, ExtCtrls;

type
  TfrmSelecionaRelatorioOperacoes = class(TForm)
    ApplicationEvents: TApplicationEvents;
    StatusBar: TStatusBar;
    RvProject: TRvProject;
    RvSystem: TRvSystem;
    RvDtStConProdutos: TRvDataSetConnection;
    RvDtStConCompras: TRvDataSetConnection;
    pnlReservaLocacao: TPanel;
    Label1: TLabel;
    lblDataInicio: TLabel;
    lblDataFinal: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edCliente: TEdit;
    btBtnAbreCliente: TBitBtn;
    mEdDataInicio1: TMaskEdit;
    mEdDataFinal1: TMaskEdit;
    edValorTotal1: TEdit;
    mEdDataInicio2: TMaskEdit;
    mEdDataFinal2: TMaskEdit;
    edValorTotal2: TEdit;
    btBtnGerar: TBitBtn;
    btBtnNova: TBitBtn;
    BitBtn1: TBitBtn;
    pnlVenda: TPanel;
    Label3: TLabel;
    Label10: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    BitBtn5: TBitBtn;
    edFornecedor: TEdit;
    BitBtn4: TBitBtn;
    edValorTotalCompra1: TEdit;
    mEdDataCompra1: TMaskEdit;
    BitBtn3: TBitBtn;
    edValorTotalCompra2: TEdit;
    mEdDataCompra2: TMaskEdit;
    btBtnAbreFornecedor: TBitBtn;
    Label11: TLabel;
    Bevel1: TBevel;
    rdBtnComprasResumo: TRadioButton;
    rdBtnComprasDetalhado: TRadioButton;
    Label16: TLabel;
    Label17: TLabel;
    mEdDataVencimento1: TMaskEdit;
    Label19: TLabel;
    mEdDataVencimento2: TMaskEdit;
    qryCompraResumo: TSQLQuery;
    dspCompraResumo: TDataSetProvider;
    cdsCompraResumo: TClientDataSet;
    cdsCompraResumoCODIGO: TIntegerField;
    cdsCompraResumoDATA_COMPRA: TDateField;
    cdsCompraResumoVENCIMENTO: TDateField;
    cdsCompraResumoOBSERVACOES: TStringField;
    cdsCompraResumoVALOR_TOTAL: TBCDField;
    cdsCompraResumoVALOR_PAGO: TFMTBCDField;
    cdsCompraResumoValor_Resta: TFMTBCDField;
    cdsCompraResumoRAZAO_SOCIAL: TStringField;
    qryCompraResumoCODIGO: TIntegerField;
    qryCompraResumoDATA_COMPRA: TDateField;
    qryCompraResumoVENCIMENTO: TDateField;
    qryCompraResumoOBSERVACOES: TStringField;
    qryCompraResumoVALOR_TOTAL: TBCDField;
    qryCompraResumoVALOR_PAGO: TFMTBCDField;
    qryCompraResumoValor_Resta: TFMTBCDField;
    qryCompraResumoRAZAO_SOCIAL: TStringField;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure btBtnAbreClienteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBtnNovaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btBtnGerarClick(Sender: TObject);
    procedure edClienteEnter(Sender: TObject);
    procedure mEdDataInicio1Enter(Sender: TObject);
    procedure mEdDataInicio2Enter(Sender: TObject);
    procedure mEdDataFinal1Enter(Sender: TObject);
    procedure mEdDataFinal2Enter(Sender: TObject);
    procedure edValorTotal1Enter(Sender: TObject);
    procedure edValorTotal2Enter(Sender: TObject);
    procedure edClienteExit(Sender: TObject);
    procedure mEdDataInicio1Exit(Sender: TObject);
    procedure mEdDataInicio2Exit(Sender: TObject);
    procedure mEdDataFinal1Exit(Sender: TObject);
    procedure mEdDataFinal2Exit(Sender: TObject);
    procedure edValorTotal1Exit(Sender: TObject);
    procedure edValorTotal2Exit(Sender: TObject);
    procedure edValorTotal1KeyPress(Sender: TObject; var Key: Char);
    procedure edValorTotal2KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure edFornecedorEnter(Sender: TObject);
    procedure mEdDataCompra1Enter(Sender: TObject);
    procedure mEdDataCompra2Enter(Sender: TObject);
    procedure edValorTotalCompra2Enter(Sender: TObject);
    procedure edValorTotalCompra1Enter(Sender: TObject);
    procedure edFornecedorExit(Sender: TObject);
    procedure mEdDataCompra1Exit(Sender: TObject);
    procedure mEdDataCompra2Exit(Sender: TObject);
    procedure edValorTotalCompra1Exit(Sender: TObject);
    procedure edValorTotalCompra2Exit(Sender: TObject);
    procedure edValorTotalCompra2KeyPress(Sender: TObject; var Key: Char);
    procedure edValorTotalCompra1KeyPress(Sender: TObject; var Key: Char);
    procedure mEdDataVencimento1Exit(Sender: TObject);
    procedure mEdDataVencimento2Exit(Sender: TObject);
    procedure mEdDataVencimento1Enter(Sender: TObject);
    procedure mEdDataVencimento2Enter(Sender: TObject);
  private
    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
  public
    codCliente: Integer; //controle do cliente
    codFornecedor: Integer; //controle do Fornecedor

    operacao: String; //saber qual é a operação para o relatório. Locação,Reserva
  end;

var
  frmSelecionaRelatorioOperacoes: TfrmSelecionaRelatorioOperacoes;

implementation

uses unSelecionaCliente, unDM,
  unSelecionaFornecedor;

{$R *.dfm}
(*PROCEDURES DE CONTROLE*)
procedure TfrmSelecionaRelatorioOperacoes.limpar();
begin
  Self.codCliente := 0;
  edCliente.Clear;
  mEdDataInicio1.Clear;
  mEdDataInicio2.Clear;
  mEdDataFinal1.Clear;
  mEdDataFinal2.Clear;
  edValorTotal1.Clear;
  edValorTotal2.Clear;
end;
(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaRelatorioOperacoes.ApplicationEventsHint(
  Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaRelatorioOperacoes.btBtnAbreClienteClick(
  Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaFornecedor,frmSelecionaFornecedor);
  frmSelecionaFornecedor.tela := 'relatorioCompra';
  frmSelecionaFornecedor.ShowModal;
  frmSelecionaFornecedor.Free;
end;

procedure TfrmSelecionaRelatorioOperacoes.FormShow(Sender: TObject);
begin
  limpar();
end;

procedure TfrmSelecionaRelatorioOperacoes.btBtnNovaClick(Sender: TObject);
begin
  limpar();
end;

procedure TfrmSelecionaRelatorioOperacoes.FormCreate(Sender: TObject);
begin
  close;
end;

procedure TfrmSelecionaRelatorioOperacoes.btBtnGerarClick(Sender: TObject);
begin
{  if (Self.operacao='locacao')then
    begin
    //selecionando dados
    qryRelatorioLocacao.Close;
    qryRelatorioLocacao.SQL.Clear;
    qryRelatorioLocacao.SQL.Add('SELECT l.codigo,l.sexo,c.nome AS Cliente,l.data_inicio,l.data_final,l.valor_total ');
    qryRelatorioLocacao.SQL.Add('FROM locacao l,cliente c ');
    qryRelatorioLocacao.SQL.Add('WHERE l.cod_cliente=c.codigo ');
    //cliente
    if (Self.codCliente<>0) then
      begin
      qryRelatorioLocacao.SQL.Add('AND l.cod_cliente=:codCli ');
      qryRelatorioLocacao.ParamByName('codCli').AsInteger := Self.codCliente;
      end;
    //data de início
    if ((mEdDataInicio1.Text <> '  /  /       :  ')and(mEdDataInicio2.Text <> '  /  /       :  ')) then
      begin
      qryRelatorioLocacao.SQL.Add('AND l.data_inicio BETWEEN :dtIni1 AND :dtIni2 ');
      qryRelatorioLocacao.ParamByName('dtIni1').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataInicio1.Text);
      qryRelatorioLocacao.ParamByName('dtIni2').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataInicio2.Text);
      end;
    //data final
    if ((mEdDataFinal1.Text <> '  /  /       :  ')and(mEdDataFinal2.Text <> '  /  /       :  ')) then
      begin
      qryRelatorioLocacao.SQL.Add('AND l.data_final BETWEEN :dtFin1 AND :dtFin2 ');
      qryRelatorioLocacao.ParamByName('dtFin1').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataFinal1.Text);
      qryRelatorioLocacao.ParamByName('dtFin2').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataFinal2.Text);
      end;
    //valor total
    if ((edValorTotal1.Text <> '')and(edValorTotal2.Text <> '')) then
      begin
      qryRelatorioLocacao.SQL.Add('AND l.valor_total BETWEEN :val1 AND :val2 ');
      qryRelatorioLocacao.ParamByName('val1').AsFloat := StrToFloat(edValorTotal1.Text);
      qryRelatorioLocacao.ParamByName('val2').AsFloat := StrToFloat(edValorTotal2.Text);
      end;

    qryRelatorioLocacao.Prepared := true;
    qryRelatorioLocacao.Open;
    cdsRelatorioLocacao.Open;
    cdsRelatorioLocacao.Refresh;

    if(cdsRelatorioLocacao.RecordCount<>0) then
      begin
      //chamando relatório
      Application.CreateForm(TqckRepOperacoes,qckRepOperacoes);
      qckRepOperacoes.Prepare;
      qckRepOperacoes.qrLblOperacao.Caption := 'Locação';
      qckRepOperacoes.qrLblTotalRegistros.Caption := IntToStr(cdsRelatorioLocacao.RecordCount);
      qckRepOperacoes.Preview;
      qckRepOperacoes.Free;
      end
    else
      begin
      MessageDlg('Nenhuma Locação encontrada!',mtInformation,[mbOK],0);
      btBtnNova.SetFocus;
      end;
    end //locação

  else if (Self.operacao='reserva')then
    begin
    //selecionando dados
    qryRelatorioReserva.Close;
    qryRelatorioReserva.SQL.Clear;
    qryRelatorioReserva.SQL.Add('SELECT r.codigo,r.sexo,c.nome AS Cliente,r.data_inicio,r.data_final,r.valor_total ');
    qryRelatorioReserva.SQL.Add('FROM reserva r,cliente c ');
    qryRelatorioReserva.SQL.Add('WHERE r.cod_cliente=c.codigo ');
    qryRelatorioReserva.SQL.Add('AND r.status = 0 AND r.data_inicio > CURRENT_TIMESTAMP ');
    //cliente
    if (Self.codCliente<>0) then
      begin
      qryRelatorioReserva.SQL.Add('AND r.cod_cliente=:codCli ');
      qryRelatorioReserva.ParamByName('codCli').AsInteger := Self.codCliente;
      end;
    //data de início
    if ((mEdDataInicio1.Text <> '  /  /       :  ')and(mEdDataInicio2.Text <> '  /  /       :  ')) then
      begin
      qryRelatorioReserva.SQL.Add('AND r.data_inicio BETWEEN :dtIni1 AND :dtIni2 ');
      qryRelatorioReserva.ParamByName('dtIni1').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataInicio1.Text);
      qryRelatorioReserva.ParamByName('dtIni2').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataInicio2.Text);
      end;
    //data final
    if ((mEdDataFinal1.Text <> '  /  /       :  ')and(mEdDataFinal2.Text <> '  /  /       :  ')) then
      begin
      qryRelatorioReserva.SQL.Add('AND r.data_final BETWEEN :dtFin1 AND :dtFin2 ');
      qryRelatorioReserva.ParamByName('dtFin1').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataFinal1.Text);
      qryRelatorioReserva.ParamByName('dtFin2').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataFinal2.Text);
      end;
    //valor total
    if ((edValorTotal1.Text <> '')and(edValorTotal2.Text <> '')) then
      begin
      qryRelatorioReserva.SQL.Add('AND r.valor_total BETWEEN :val1 AND :val2 ');
      qryRelatorioReserva.ParamByName('val1').AsFloat := StrToFloat(edValorTotal1.Text);
      qryRelatorioReserva.ParamByName('val2').AsFloat := StrToFloat(edValorTotal2.Text);
      end;

    qryRelatorioReserva.Prepared := true;
    qryRelatorioReserva.Open;
    cdsRelatorioReserva.Open;
    cdsRelatorioReserva.Refresh;

    if(cdsRelatorioReserva.RecordCount<>0) then
      begin    
      //chamando relatório
      Application.CreateForm(TqckRepOperacoesReserva,qckRepOperacoesReserva);
      qckRepOperacoesReserva.Prepare;
      qckRepOperacoesReserva.qrLblOperacao.Caption := 'Reserva';
      qckRepOperacoesReserva.qrLblTotalRegistros.Caption := IntToStr(cdsRelatorioReserva.RecordCount);
      qckRepOperacoesReserva.Preview;
      qckRepOperacoesReserva.Free;
      end
    else
      begin
      MessageDlg('Nenhuma Reserva encontrada!',mtInformation,[mbOK],0);
      btBtnNova.SetFocus;
      end;
    end; //reserva
}end;

procedure TfrmSelecionaRelatorioOperacoes.edClienteEnter(Sender: TObject);
begin
  edCliente.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataInicio1Enter(
  Sender: TObject);
begin
  mEdDataInicio1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataInicio2Enter(
  Sender: TObject);
begin
  mEdDataInicio2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataFinal1Enter(
  Sender: TObject);
begin
  mEdDataFinal1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataFinal2Enter(
  Sender: TObject);
begin
  mEdDataFinal2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioOperacoes.edValorTotal1Enter(
  Sender: TObject);
begin
  edValorTotal1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioOperacoes.edValorTotal2Enter(
  Sender: TObject);
begin
  edValorTotal2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioOperacoes.edClienteExit(Sender: TObject);
begin
  edCliente.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataInicio1Exit(
  Sender: TObject);
begin
  mEdDataInicio1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataInicio2Exit(
  Sender: TObject);
begin
  mEdDataInicio2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataFinal1Exit(
  Sender: TObject);
begin
  mEdDataFinal1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataFinal2Exit(
  Sender: TObject);
begin
  mEdDataFinal2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.edValorTotal1Exit(
  Sender: TObject);
begin
  if (edValorTotal1.Text <> '') then
    begin
    try
      edValorTotal1.Text := FormatFloat('#0.00',StrToFloat(edValorTotal1.Text));
    except
    end;
    end;

  edValorTotal1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.edValorTotal2Exit(
  Sender: TObject);
begin
  if (edValorTotal2.Text <> '') then
    begin
    try
      edValorTotal2.Text := FormatFloat('#0.00',StrToFloat(edValorTotal2.Text));
    except
    end;
    end;

  edValorTotal2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.edValorTotal1KeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmSelecionaRelatorioOperacoes.edValorTotal2KeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmSelecionaRelatorioOperacoes.BitBtn1Click(Sender: TObject);
begin
  RvProject.ProjectFile := 'C:\Noiva Linda\Projeto\Relatórios\rave_compras_com_itens.rav';
  RvProject.Execute;

end;

procedure TfrmSelecionaRelatorioOperacoes.BitBtn3Click(Sender: TObject);
begin
{  if (Self.operacao='venda')then
    begin
    //selecionando dados
    qryRelatorioVenda.Close;
    qryRelatorioVenda.SQL.Clear;
    qryRelatorioVenda.SQL.Add('SELECT v.codigo,c.nome AS Cliente,v.data_venda,v.valor_total ');
    qryRelatorioVenda.SQL.Add('FROM venda v,cliente c ');
    qryRelatorioVenda.SQL.Add('WHERE v.cod_cliente=c.codigo ');
    //cliente
    if (Self.codCliente<>0) then
      begin
      qryRelatorioVenda.SQL.Add('AND v.cod_cliente=:codCli ');
      qryRelatorioVenda.ParamByName('codCli').AsInteger := Self.codCliente;
      end;
    //data da venda
    if ((mEdDataVenda1.Text <> '  /  /       :  ')and(mEdDataVenda2.Text <> '  /  /       :  ')) then
      begin
      qryRelatorioVenda.SQL.Add('AND v.data_venda BETWEEN :dtIni1 AND :dtIni2 ');
      qryRelatorioVenda.ParamByName('dtIni1').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataVenda1.Text);
      qryRelatorioVenda.ParamByName('dtIni2').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataVenda2.Text);
      end;
    //valor total
    if ((edValorTotalVenda1.Text <> '')and(edValorTotalVenda2.Text <> '')) then
      begin
      qryRelatorioVenda.SQL.Add('AND v.valor_total BETWEEN :val1 AND :val2 ');
      qryRelatorioVenda.ParamByName('val1').AsFloat := StrToFloat(edValorTotal1.Text);
      qryRelatorioVenda.ParamByName('val2').AsFloat := StrToFloat(edValorTotal2.Text);
      end;

    qryRelatorioVenda.Prepared := true;
    qryRelatorioVenda.Open;
    cdsRelatorioVenda.Open;
    cdsRelatorioVenda.Refresh;

    if(cdsRelatorioVenda.RecordCount<>0) then
      begin      
      //chamando relatório
      Application.CreateForm(TqckRepOperacoesVenda,qckRepOperacoesVenda);
      qckRepOperacoesVenda.Prepare;
      qckRepOperacoesVenda.qrLblOperacao.Caption := 'Venda';
      qckRepOperacoesVenda.qrLblTotalRegistros.Caption := IntToStr(cdsRelatorioVenda.RecordCount);
      qckRepOperacoesVenda.Preview;
      qckRepOperacoesVenda.Free;
      end
    else
      begin
      MessageDlg('Nenhuma Venda encontrada!',mtInformation,[mbOK],0);
      btBtnNova.SetFocus;
      end;
    end //venda
}end;

procedure TfrmSelecionaRelatorioOperacoes.edFornecedorEnter(Sender: TObject);
begin
  edFornecedor.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataCompra1Enter(
  Sender: TObject);
begin
  mEdDataCompra1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataCompra2Enter(
  Sender: TObject);
begin
  mEdDataCompra2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioOperacoes.edValorTotalCompra2Enter(
  Sender: TObject);
begin
  edValorTotalCompra2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioOperacoes.edValorTotalCompra1Enter(
  Sender: TObject);
begin
  edValorTotalCompra1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioOperacoes.edFornecedorExit(Sender: TObject);
begin
  edFornecedor.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataCompra1Exit(
  Sender: TObject);
begin
  mEdDataCompra1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataCompra2Exit(
  Sender: TObject);
begin
  mEdDataCompra2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.edValorTotalCompra1Exit(
  Sender: TObject);
begin
  if (edValorTotalCompra1.Text <> '') then
    begin
    try
      edValorTotalCompra1.Text := FormatFloat('#0.00',StrToFloat(edValorTotalCompra1.Text));
    except
    end;
    end;

  edValorTotalCompra1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.edValorTotalCompra2Exit(
  Sender: TObject);
begin
  if (edValorTotalCompra2.Text <> '') then
    begin
    try
      edValorTotalCompra2.Text := FormatFloat('#0.00',StrToFloat(edValorTotalCompra2.Text));
    except
    end;
    end;

  edValorTotalCompra2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.edValorTotalCompra2KeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmSelecionaRelatorioOperacoes.edValorTotalCompra1KeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataVencimento1Exit(
  Sender: TObject);
begin
  mEdDataVencimento1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataVencimento2Exit(
  Sender: TObject);
begin
  mEdDataVencimento2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataVencimento1Enter(
  Sender: TObject);
begin
  mEdDataVencimento1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioOperacoes.mEdDataVencimento2Enter(
  Sender: TObject);
begin
  mEdDataVencimento2.Color := clMoneyGreen;
end;

end.
