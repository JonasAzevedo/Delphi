unit unRelatorioCompraResumo;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TqckRepRelatorioCompraResumo = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    qrShpDivisao: TQRShape;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    qrLblRegistros: TQRLabel;
    qrLblValorTotal: TQRLabel;
    qrLblValorPago: TQRLabel;
    qrLblValorDeve: TQRLabel;
    QRShape1: TQRShape;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    vlrTotal,vlrPago,vlrDeve: Real;
  public

  end;

var
  qckRepRelatorioCompraResumo: TqckRepRelatorioCompraResumo;

implementation

uses unSelecionaRelatorioCompras, DB;

{$R *.DFM}

procedure TqckRepRelatorioCompraResumo.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  vlrTotal := 0;
  vlrPago := 0;
  vlrDeve := 0;
end;

procedure TqckRepRelatorioCompraResumo.QRBand3BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  vlrTotal := vlrTotal + frmSelecionaRelatorioCompras.cdsCompraResumoVALOR_TOTAL.AsFloat;
  vlrPago := vlrPago   + frmSelecionaRelatorioCompras.cdsCompraResumoVALOR_PAGO.AsFloat;
  vlrDeve := vlrDeve   + frmSelecionaRelatorioCompras.cdsCompraResumoValor_Resta.AsFloat;
end;

procedure TqckRepRelatorioCompraResumo.QRBand4BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrLblValorTotal.Caption := FormatFloat('#0.00',Self.vlrTotal);
  qrLblValorPago.Caption := FormatFloat('#0.00',Self.vlrPago);
  qrLblValorDeve.Caption := FormatFloat('#0.00',Self.vlrDeve);
end;

end.
