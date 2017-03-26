unit unRelatorioContasReceber;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, jpeg;

type
  TrelatorioContasReceber = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRImage1: TQRImage;
    QRShape1: TQRShape;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRBand3: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRBand4: TQRBand;
    QRLabel8: TQRLabel;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRShape2: TQRShape;
    QRDBText4: TQRDBText;
  private

  public

  end;

var
  relatorioContasReceber: TrelatorioContasReceber;

implementation

uses unSelecionaContaReceber;

{$R *.DFM}

end.
