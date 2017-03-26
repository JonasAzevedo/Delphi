unit unRelatorioOperacoesVenda;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TqckRepOperacoesVenda = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    qrLblOperacao: TQRLabel;
    QRBand2: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    qrShpDivisao1: TQRShape;
    QRBand3: TQRBand;
    QRLabel9: TQRLabel;
    qrLblTotalRegistros: TQRLabel;
    qrLblValorTotal: TQRLabel;
    QRLabel10: TQRLabel;
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    valorTotal: Real;
  public

  end;

var
  qckRepOperacoesVenda: TqckRepOperacoesVenda;

implementation

uses unSelecionaRelatorioOperacoes;

{$R *.DFM}

procedure TqckRepOperacoesVenda.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  valorTotal := valorTotal + frmSelecionaRelatorioOperacoes.cdsRelatorioVendaVALOR_TOTAL.AsFloat;
end;

procedure TqckRepOperacoesVenda.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  valorTotal := 0;
end;

procedure TqckRepOperacoesVenda.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrLblValorTotal.Caption := FormatFloat('#0.00',valorTotal);
end;

end.
