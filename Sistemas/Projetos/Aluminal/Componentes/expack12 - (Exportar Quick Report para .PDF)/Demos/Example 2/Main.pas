unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FR_Class, FR_BDEDB, ExportPack, Buttons;

type
  TMainForm = class(TForm)
    Report: TfrReport;
    BDE: TfrBDEComponents;
    BtnPreviewQR: TBitBtn;
    BtnPreviewFR: TBitBtn;
    BtnClose: TBitBtn;
    EXFR: TExportFR;
    procedure BtnPreviewFRClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnPreviewQRClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
  PreviewFR;
{$R *.DFM}

procedure TMainForm.BtnPreviewFRClick(Sender: TObject);
begin
 Report.LoadFromFile('1.FRF');
 Report.Preview := FPreviewFR.Preview;
 Report.ShowReport;
 FPreviewFR.ShowModal;
end;

procedure TMainForm.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.BtnPreviewQRClick(Sender: TObject);
begin
  Report.LoadFromFile ('1.FRF');
  EXFR.Report := Report;
  EXFR.ExportFR; 
end;

end.
