unit unRelatorioEntradaFinanceira;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TqckRepEntradaFinanceira = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRBand2: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    qrShpDivisao1: TQRShape;
    QRBand3: TQRBand;
    QRLabel9: TQRLabel;
    qrLblTotalRegistros: TQRLabel;
    qrLblValorTotal: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel8: TQRLabel;
    QRDBText7: TQRDBText;
    QRDBText6: TQRDBText;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    valorTotal: Real;

  public

  end;

var
  qckRepEntradaFinanceira: TqckRepEntradaFinanceira;

implementation

uses unSelecionaRelatorioEntradasFinanceiras;

{$R *.DFM}

procedure TqckRepEntradaFinanceira.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  valorTotal := 0;
end;

procedure TqckRepEntradaFinanceira.QRBand2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  valorTotal := valorTotal + frmSelecionaRelatorioEntradasFinanceiras.cdsRelatorioEntradaFinanceiraVALOR.AsFloat;
end;

procedure TqckRepEntradaFinanceira.QRBand3BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrLblValorTotal.Caption := FormatFloat('#0.00',valorTotal);
end;

end.
