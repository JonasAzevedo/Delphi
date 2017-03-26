unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FR_Class, FR_BDEDB, ExportPack, Buttons;

type
  TMainForm = class(TForm)
    EXQR: TExportQR;
    BtnExportQR: TBitBtn;
    BtnPreviewQR: TBitBtn;
    BtnClose: TBitBtn;
    procedure BtnExportQRClick(Sender: TObject);
    procedure BtnPreviewQRClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
  Report;
{$R *.DFM}

procedure TMainForm.BtnExportQRClick(Sender: TObject);
begin
  EXQR.Report := Rep;
  EXQR.ExportQR;
end;

procedure TMainForm.BtnPreviewQRClick(Sender: TObject);
begin
  Rep.T.Open;
  Rep.PreviewModal;
  Rep.T.Close;
end;

procedure TMainForm.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
