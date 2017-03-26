unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FR_Class, FR_BDEDB, ExportPack, Buttons, ExtCtrls;

type
  TMainForm = class(TForm)
    EXQR: TExportQR;
    BtnClose: TBitBtn;
    RGFileFormat: TRadioGroup;
    Label1: TLabel;
    edFileName: TEdit;
    BtnGuardar: TBitBtn;
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnGuardarClick(Sender: TObject);
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

procedure TMainForm.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.BtnGuardarClick(Sender: TObject);
begin
  if (edFileName.Text = '') then begin
    MessageDlg ('Especifique el fichero de salida', mtError, [mbOK],0);
    edFileName.SetFocus;
    Exit;
  end;
  Rep.T.Open;
  Rep.Prepare;
  EXQR.Report := Rep;
  case RGFileFormat.ItemIndex of
    0 : EXQR.ExportQRPDF(edFileName.Text, True);
    1 : EXQR.ExportQRPDF(edFileName.Text, False);
    2 : EXQR.ExportQRJPG(edFileName.Text);
    3 : EXQR.ExportQRBMP(edFileName.Text);
    4 : EXQR.ExportQRWMF(edFileName.Text);
    5 : EXQR.ExportQREMF(edFileName.Text);
  end;
  Rep.QRPrinter.Free;
  Rep.QRPrinter := nil;
  Rep.T.Close;

end;

end.
