unit unRelatorioSaida;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, jpeg;

type
  TrelatorioSaida = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRImage1: TQRImage;
    QRShape1: TQRShape;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRBand3: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRBand4: TQRBand;
    QRLabel8: TQRLabel;
    QRDBText8: TQRDBText;
    QRShape2: TQRShape;
  private

  public

  end;

var
  relatorioSaida: TrelatorioSaida;

implementation

uses unSelecionaSaida;

{$R *.DFM}

end.