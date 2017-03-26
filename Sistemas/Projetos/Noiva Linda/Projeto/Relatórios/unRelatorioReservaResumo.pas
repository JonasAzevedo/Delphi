unit unRelatorioReservaResumo;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TqckRepRelatorioReservaResumo = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape1: TQRShape;
    QRBand3: TQRBand;
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
    QRLabel15: TQRLabel;
    QRDBText8: TQRDBText;
    QRBand4: TQRBand;
    qrShpDivisao: TQRShape;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    qrLblRegistros: TQRLabel;
    qrLblValorTotal: TQRLabel;
    qrLblValorPago: TQRLabel;
    qrLblValorDeve: TQRLabel;
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
  qckRepRelatorioReservaResumo: TqckRepRelatorioReservaResumo;

implementation

uses unSelecionaRelatorioReservas;

{$R *.DFM}

procedure TqckRepRelatorioReservaResumo.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  vlrTotal := 0;
  vlrPago := 0;
  vlrDeve := 0;
end;

procedure TqckRepRelatorioReservaResumo.QRBand3BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  vlrTotal := vlrTotal + frmSelecionaRelatorioReservas.cdsReservaResumoVALOR_TOTAL.AsFloat;
  vlrPago := vlrPago   + frmSelecionaRelatorioReservas.cdsReservaResumoVALOR_PAGO.AsFloat;
  vlrDeve := vlrDeve   + frmSelecionaRelatorioReservas.cdsReservaResumoValor_Resta.AsFloat;
end;

procedure TqckRepRelatorioReservaResumo.QRBand4BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrLblValorTotal.Caption := FormatFloat('#0.00',Self.vlrTotal);
  qrLblValorPago.Caption := FormatFloat('#0.00',Self.vlrPago);
  qrLblValorDeve.Caption := FormatFloat('#0.00',Self.vlrDeve);
end;

end.
