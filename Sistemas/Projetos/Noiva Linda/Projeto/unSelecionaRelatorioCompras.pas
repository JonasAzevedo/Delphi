unit unSelecionaRelatorioCompras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DBClient, Provider, DB, SqlExpr, AppEvnts, StdCtrls,
  Mask, Buttons, ExtCtrls, RpCon, RpConDS, RpBase, RpSystem, RpDefine,
  RpRave, ComCtrls;

type
  TfrmSelecionaRelatorioCompras = class(TForm)
    pnlVenda: TPanel;
    Label3: TLabel;
    Label10: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label11: TLabel;
    Bevel1: TBevel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    edFornecedor: TEdit;
    btBtnNova: TBitBtn;
    edValorTotalCompra1: TEdit;
    mEdDataCompra1: TMaskEdit;
    btBtnGerar: TBitBtn;
    edValorTotalCompra2: TEdit;
    mEdDataCompra2: TMaskEdit;
    btBtnAbreFornecedor: TBitBtn;
    rdBtnComprasResumo: TRadioButton;
    rdBtnComprasDetalhado: TRadioButton;
    mEdDataVencimento1: TMaskEdit;
    mEdDataVencimento2: TMaskEdit;
    ApplicationEvents: TApplicationEvents;
    qryCompraResumo: TSQLQuery;
    qryCompraResumoCODIGO: TIntegerField;
    qryCompraResumoDATA_COMPRA: TDateField;
    qryCompraResumoVENCIMENTO: TDateField;
    qryCompraResumoOBSERVACOES: TStringField;
    qryCompraResumoVALOR_TOTAL: TBCDField;
    qryCompraResumoVALOR_PAGO: TFMTBCDField;
    qryCompraResumoValor_Resta: TFMTBCDField;
    qryCompraResumoRAZAO_SOCIAL: TStringField;
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
    RvProject: TRvProject;
    RvSystem: TRvSystem;
    rvDtStConQryCompraResumo: TRvDataSetConnection;
    rvDtStConQryProdutosCom: TRvDataSetConnection;
    qryProduto: TSQLQuery;
    dspProduto: TDataSetProvider;
    cdsProduto: TClientDataSet;
    qryProdutocod_Item: TIntegerField;
    qryProdutoCOD_COMPRA: TIntegerField;
    qryProdutoVALOR_TOTAL: TFMTBCDField;
    qryProdutocod_Produto: TIntegerField;
    qryProdutocod2_Produto: TStringField;
    qryProdutoNOME: TStringField;
    qryProdutoDESCRICAO: TStringField;
    qryProdutoMARCA: TStringField;
    qryProdutoTAMANHO: TIntegerField;
    qryProdutoTIPO: TStringField;
    cdsProdutocod_Item: TIntegerField;
    cdsProdutoCOD_COMPRA: TIntegerField;
    cdsProdutoVALOR_TOTAL: TFMTBCDField;
    cdsProdutocod_Produto: TIntegerField;
    cdsProdutocod2_Produto: TStringField;
    cdsProdutoNOME: TStringField;
    cdsProdutoDESCRICAO: TStringField;
    cdsProdutoMARCA: TStringField;
    cdsProdutoTAMANHO: TIntegerField;
    cdsProdutoTIPO: TStringField;
    StatusBar: TStatusBar;
    procedure btBtnAbreFornecedorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edFornecedorEnter(Sender: TObject);
    procedure mEdDataCompra1Enter(Sender: TObject);
    procedure mEdDataCompra2Enter(Sender: TObject);
    procedure mEdDataVencimento1Enter(Sender: TObject);
    procedure mEdDataVencimento2Enter(Sender: TObject);
    procedure edValorTotalCompra1Enter(Sender: TObject);
    procedure edValorTotalCompra2Enter(Sender: TObject);
    procedure edValorTotalCompra2Exit(Sender: TObject);
    procedure edValorTotalCompra1Exit(Sender: TObject);
    procedure mEdDataVencimento1Exit(Sender: TObject);
    procedure mEdDataVencimento2Exit(Sender: TObject);
    procedure mEdDataCompra1Exit(Sender: TObject);
    procedure mEdDataCompra2Exit(Sender: TObject);
    procedure edFornecedorExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btBtnGerarClick(Sender: TObject);
    procedure btBtnNovaClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure edValorTotalCompra1KeyPress(Sender: TObject; var Key: Char);
    procedure edValorTotalCompra2KeyPress(Sender: TObject; var Key: Char);
  private
    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
  public
    codFornecedor: Integer; //controle do Fornecedor
  end;

var
  frmSelecionaRelatorioCompras: TfrmSelecionaRelatorioCompras;

implementation

uses unSelecionaFornecedor, unRelatorioCompraResumo;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)
procedure TfrmSelecionaRelatorioCompras.limpar();
begin
  Self.codFornecedor := 0;
  rdBtnComprasResumo.Checked := true;
  rdBtnComprasDetalhado.Checked := false;
  edFornecedor.Clear;
  mEdDataCompra1.Clear;
  mEdDataCompra2.Clear;
  mEdDataVencimento1.Clear;
  mEdDataVencimento2.Clear;
  edValorTotalCompra1.Clear;
  edValorTotalCompra2.Clear;
end;
(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaRelatorioCompras.btBtnAbreFornecedorClick(
  Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaFornecedor,frmSelecionaFornecedor);
  frmSelecionaFornecedor.tela := 'relatorioCompra';
  frmSelecionaFornecedor.ShowModal;
  frmSelecionaFornecedor.Free;
end;

procedure TfrmSelecionaRelatorioCompras.FormShow(Sender: TObject);
begin
  Self.limpar();
end;

procedure TfrmSelecionaRelatorioCompras.edFornecedorEnter(Sender: TObject);
begin
  edFornecedor.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioCompras.mEdDataCompra1Enter(
  Sender: TObject);
begin
  mEdDataCompra1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioCompras.mEdDataCompra2Enter(
  Sender: TObject);
begin
  mEdDataCompra2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioCompras.mEdDataVencimento1Enter(
  Sender: TObject);
begin
  mEdDataVencimento1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioCompras.mEdDataVencimento2Enter(
  Sender: TObject);
begin
  mEdDataVencimento2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioCompras.edValorTotalCompra1Enter(
  Sender: TObject);
begin
  edValorTotalCompra1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioCompras.edValorTotalCompra2Enter(
  Sender: TObject);
begin
  edValorTotalCompra2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioCompras.edValorTotalCompra2Exit(
  Sender: TObject);
begin
  try
    edValorTotalCompra2.Text := FormatFloat('#0.00',StrToFloat(edValorTotalCompra2.Text));
  except
  end;

  edValorTotalCompra2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioCompras.edValorTotalCompra1Exit(
  Sender: TObject);
begin
  try
    edValorTotalCompra1.Text := FormatFloat('#0.00',StrToFloat(edValorTotalCompra1.Text));
  except
  end;

  edValorTotalCompra1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioCompras.mEdDataVencimento1Exit(
  Sender: TObject);
begin
  mEdDataVencimento1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioCompras.mEdDataVencimento2Exit(
  Sender: TObject);
begin
  mEdDataVencimento2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioCompras.mEdDataCompra1Exit(
  Sender: TObject);
begin
  mEdDataCompra1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioCompras.mEdDataCompra2Exit(
  Sender: TObject);
begin
  mEdDataCompra2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioCompras.edFornecedorExit(Sender: TObject);
begin
  edFornecedor.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioCompras.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=27) then
    Self.Close;
end;

procedure TfrmSelecionaRelatorioCompras.btBtnGerarClick(Sender: TObject);
begin
  qryCompraResumo.Close;
  qryCompraResumo.SQL.Clear;
  qryCompraResumo.SQL.Add('SELECT c.codigo,c.data_compra,c.vencimento,c.observacoes,c.valor_total,c.valor_pago, ');
  qryCompraResumo.SQL.Add('(c.valor_total-c.valor_pago) AS "Valor_Resta", f.razao_social ');
  qryCompraResumo.SQL.Add('FROM compra c,fornecedor f ');
  qryCompraResumo.SQL.Add('WHERE c.cod_fornecedor=f.codigo ');
  //fornecedor
  if (Self.codFornecedor<>0) then
    begin
    qryCompraResumo.SQL.Add('AND c.cod_fornecedor=:codFor ');
    qryCompraResumo.ParamByName('codFor').AsInteger := Self.codFornecedor;
    end;
  //data da compra
  if ((mEdDataCompra1.Text <> '  /  /    ')and(mEdDataCompra2.Text <> '  /  /    '))then
    begin
    qryCompraResumo.SQL.Add('AND CAST (c.data_compra AS DATE) BETWEEN :dtCom1 AND :dtCom2 ');
    qryCompraResumo.ParamByName('dtCom1').AsDate := StrToDate(mEdDataCompra1.Text);
    qryCompraResumo.ParamByName('dtCom2').AsDate := StrToDate(mEdDataCompra2.Text);
    end;
  //data de vencimento
  if ((mEdDataVencimento1.Text <> '  /  /    ')and(mEdDataVencimento2.Text <> '  /  /    '))then
    begin
    qryCompraResumo.SQL.Add('AND CAST (c.vencimento AS DATE) BETWEEN :dtVen1 AND :dtVen2 ');
    qryCompraResumo.ParamByName('dtVen1').AsDate := StrToDate(mEdDataVencimento1.Text);
    qryCompraResumo.ParamByName('dtVen2').AsDate := StrToDate(mEdDataVencimento1.Text);
    end;
  //valor total
  if ((edValorTotalCompra1.Text <> '')and(edValorTotalCompra2.Text <> ''))then
    begin
    qryCompraResumo.SQL.Add('AND c.valor_total BETWEEN :valTot1 AND :valTot2 ');
    qryCompraResumo.ParamByName('valTot1').AsFloat := StrToFloat(edValorTotalCompra1.Text);
    qryCompraResumo.ParamByName('valTot2').AsFloat := StrToFloat(edValorTotalCompra2.Text);
    end;
  qryCompraResumo.SQL.Add('ORDER BY c.vencimento');
  qryCompraResumo.Prepared := true;
  qryCompraResumo.Open;
  cdsCompraResumo.Open;
  cdsCompraResumo.Refresh;

  if (cdsCompraResumo.RecordCount <> 0) then
    begin
    if (rdBtnComprasResumo.Checked=true) then
      begin
      Application.CreateForm(TqckRepRelatorioCompraResumo,qckRepRelatorioCompraResumo);
      qckRepRelatorioCompraResumo.qrLblRegistros.Caption := IntToStr(cdsCompraResumo.RecordCount);
      qckRepRelatorioCompraResumo.Prepare;
      qckRepRelatorioCompraResumo.Preview;
      qckRepRelatorioCompraResumo.Free;
      end
    else if (rdBtnComprasDetalhado.Checked=true) then
      begin
      RvProject.ProjectFile := 'C:\Noiva Linda\Relatórios\rave_compras_com_itens.rav';
      RvProject.Execute;
      end;
    end
  else
    MessageDlg('Nenhum Registro encontrado!',mtInformation,[mbOK],0);
end;

procedure TfrmSelecionaRelatorioCompras.btBtnNovaClick(Sender: TObject);
begin
  Self.limpar();
end;

procedure TfrmSelecionaRelatorioCompras.ApplicationEventsHint(
  Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaRelatorioCompras.edValorTotalCompra1KeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmSelecionaRelatorioCompras.edValorTotalCompra2KeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

end.
