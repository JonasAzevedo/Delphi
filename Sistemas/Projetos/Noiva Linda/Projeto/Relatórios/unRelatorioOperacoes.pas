unit unRelatorioOperacoes;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TqckRepOperacoes = class(TQuickRep)
    QRBand1: TQRBand;
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
    QRDBText6: TQRDBText;
    qrShpDivisao1: TQRShape;
    QRLabel7: TQRLabel;
    QRBand3: TQRBand;
    QRLabel8: TQRLabel;
    qrLblOperacao: TQRLabel;
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
  qckRepOperacoes: TqckRepOperacoes;

implementation

uses unSelecionaRelatorioOperacoes;

{$R *.DFM}

procedure TqckRepOperacoes.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  valorTotal := valorTotal + frmSelecionaRelatorioOperacoes.cdsRelatorioLocacaoVALOR_TOTAL.AsFloat;
end;

procedure TqckRepOperacoes.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  valorTotal := 0;
end;

procedure TqckRepOperacoes.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrLblValorTotal.Caption := FormatFloat('#0.00',valorTotal);
end;

end.
