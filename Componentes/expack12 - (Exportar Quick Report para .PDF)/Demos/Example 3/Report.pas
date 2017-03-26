unit Report;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TRep = class(TQuickRep)
    T: TTable;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    TSpeciesNo: TFloatField;
    TCategory: TStringField;
    TCommon_Name: TStringField;
    TSpeciesName: TStringField;
    TLengthcm: TFloatField;
    TLength_In: TFloatField;
    TNotes: TMemoField;
    TGraphic: TGraphicField;
    QRDBImage1: TQRDBImage;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRMemo1: TQRMemo;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

var
  Rep: TRep;

implementation
{$R *.DFM}

procedure TRep.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRMemo1.Lines.Text := TNotes.AsString;
end;

end.
