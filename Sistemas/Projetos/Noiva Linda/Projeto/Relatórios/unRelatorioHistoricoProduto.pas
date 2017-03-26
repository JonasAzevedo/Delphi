unit unRelatorioHistoricoProduto;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, FMTBcd, DB, DBClient,
  Provider, SqlExpr;

type
  TqckRepHistoricoProduto = class(TQuickRep)
    qrBndTitle: TQRBand;
    qrBndDetail: TQRBand;
    qryHistorico: TSQLQuery;
    qryHistoricoDATA_INICIO: TSQLTimeStampField;
    qryHistoricoDATA_FINAL: TSQLTimeStampField;
    qryHistoricoVALOR_TOTAL: TFMTBCDField;
    qryHistoricoNOME: TStringField;
    qryHistoricoOPERACAO: TStringField;
    dspHistorico: TDataSetProvider;
    cdsHistorico: TClientDataSet;
    cdsHistoricoDATA_INICIO: TSQLTimeStampField;
    cdsHistoricoDATA_FINAL: TSQLTimeStampField;
    cdsHistoricoVALOR_TOTAL: TFMTBCDField;
    cdsHistoricoNOME: TStringField;
    cdsHistoricoOPERACAO: TStringField;
    dsHistorico: TDataSource;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    qrBndColuna: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    qrLblProduto: TQRLabel;
    QRLabel7: TQRLabel;
    qrLblCodigo: TQRLabel;
    qrBndSummary: TQRBand;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    qrLblVlrCompra: TQRLabel;
    qrLblVlrOperacoes: TQRLabel;
    qrLblVlrBalanco: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    qrLblCodigo2: TQRLabel;
    QRLabel13: TQRLabel;
    qrLblTipoProduto: TQRLabel;
    QRLabel14: TQRLabel;
    qrMmDescricao: TQRMemo;
    QRLabel15: TQRLabel;
    qrLblMarca: TQRLabel;
    qrLblTamanho: TQRLabel;
    QRLabel17: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrBndDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrBndSummaryBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    vlrOper: Real;

  public

  end;

var
  qckRepHistoricoProduto: TqckRepHistoricoProduto;

implementation

uses unDM;

{$R *.DFM}

procedure TqckRepHistoricoProduto.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  vlrOper := 0;
end;

procedure TqckRepHistoricoProduto.qrBndDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  vlrOper := vlrOper + cdsHistoricoVALOR_TOTAL.AsFloat;
end;

procedure TqckRepHistoricoProduto.qrBndSummaryBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  vlrPago,vlrBal: Real;
begin
  qrLblVlrOperacoes.Caption := FormatFloat('#0.00',Self.vlrOper);
  vlrPago := StrToFloat(qrLblVlrCompra.Caption);
  vlrBal := Self.vlrOper - vlrPago;
  qrLblVlrBalanco.Caption := FormatFloat('#0.00',vlrBal);

end;

end.
