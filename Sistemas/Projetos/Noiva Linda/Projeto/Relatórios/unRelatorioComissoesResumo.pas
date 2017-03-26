unit unRelatorioComissoesResumo;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TqckRepRelatorioComissoesResumo = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape1: TQRShape;
    QRBand3: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel10: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRBand4: TQRBand;
    qrShpDivisao: TQRShape;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    qrLblRegistros: TQRLabel;
    qrLblTotalVendas: TQRLabel;
    qrLblTotalLocacoes: TQRLabel;
    qrLblValorTotal: TQRLabel;
    QRDBText3: TQRDBText;
    qrLblComissao: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    totalVendas,totalLocacoes: Integer;
    vlrTotal: Real;
  public

  end;

var
  qckRepRelatorioComissoesResumo: TqckRepRelatorioComissoesResumo;

implementation

uses unSelecionaRelatorioComissoes, DB;

{$R *.DFM}

procedure TqckRepRelatorioComissoesResumo.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
    vlrTotal := 0;
    totalVendas := 0;
    totalLocacoes := 0;
end;

procedure TqckRepRelatorioComissoesResumo.QRBand3BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if(frmSelecionaRelatorioComissoes.cdsComissoesCOD_LOCACAO.AsString <> '')then
    begin
    qrLblComissao.Caption := 'LOCAÇÃO';
    inc(totalLocacoes);
    end;
  if(frmSelecionaRelatorioComissoes.cdsComissoesCOD_VENDA.AsString <> '')then
    begin
    qrLblComissao.Caption := 'VENDA';
    inc(totalVendas);
    end;
  vlrTotal := vlrTotal + frmSelecionaRelatorioComissoes.cdsComissoesVALOR.AsFloat;
end;

procedure TqckRepRelatorioComissoesResumo.QRBand4BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrLblTotalVendas.Caption := IntToStr(totalVendas);
  qrLblTotalLocacoes.Caption := IntToStr(totalLocacoes);
  qrLblValorTotal.Caption := FormatFloat('#0.00',vlrTotal);
end;

end.
