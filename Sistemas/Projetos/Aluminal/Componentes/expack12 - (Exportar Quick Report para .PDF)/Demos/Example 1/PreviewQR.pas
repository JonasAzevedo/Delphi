unit PreviewQR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, FR_View, ImgList, ExportPack, ComCtrls, ToolWin,
  QRPrntr, Quickrpt;

type
  TFPreviewQR = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    TBSave: TToolButton;
    TBPrint: TToolButton;
    TBExit: TToolButton;
    IL: TImageList;
    Preview: TQRPreview;
    EXQR: TExportQR;
    procedure TBExitClick(Sender: TObject);
    procedure TBPrintClick(Sender: TObject);
    procedure TBSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPreviewQR: TFPreviewQR;

implementation
uses
  Main, Report;
{$R *.dfm}

procedure TFPreviewQR.TBExitClick(Sender: TObject);
begin
  Close;
  Preview.QRPrinter := nil;
end;

procedure TFPreviewQR.TBPrintClick(Sender: TObject);
begin
  Preview.QRPrinter.Print;
end;

procedure TFPreviewQR.TBSaveClick(Sender: TObject);
begin
// Be careful!, only if export from a preview window
  EXQR.Preview := Preview;
  EXQR.ExportQRFromPreview;
end;

end.
