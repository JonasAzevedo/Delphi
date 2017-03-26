unit PreviewFR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, FR_View, ImgList, ExportPack, ComCtrls, ToolWin;

type
  TFPreviewFR = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    TBSave: TToolButton;
    TBPrint: TToolButton;
    TBExit: TToolButton;
    EXFR: TExportFR;
    IL: TImageList;
    Preview: TfrPreview;
    procedure TBPrintClick(Sender: TObject);
    procedure TBExitClick(Sender: TObject);
    procedure TBSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPreviewFR: TFPreviewFR;

implementation
uses
  Main;
{$R *.dfm}

procedure TFPreviewFR.TBPrintClick(Sender: TObject);
begin
  Preview.Print;
end;

procedure TFPreviewFR.TBExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFPreviewFR.TBSaveClick(Sender: TObject);
begin
  // Be careful!!! new method, there was in v. 1.0 wher the
  // Fast report has dialog window
  EXFR.Report := MainForm.Report;
  EXFR.Preview := Preview;
  EXFR.ExportFRFromPreview;
end;

end.
