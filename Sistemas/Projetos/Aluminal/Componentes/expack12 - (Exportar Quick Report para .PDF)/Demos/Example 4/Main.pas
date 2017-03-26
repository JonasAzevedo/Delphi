unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FR_Class, FR_BDEDB, ExportPack, Buttons, ExtCtrls;

type
  TMainForm = class(TForm)
    Report: TfrReport;
    BDE: TfrBDEComponents;
    BtnClose: TBitBtn;
    EXFR: TExportFR;
    BtnGuardar: TBitBtn;
    RGFileFormat: TRadioGroup;
    Label1: TLabel;
    edFileName: TEdit;
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
  Report.LoadFromFile('1.FRF');
  Report.PrepareReport;
  EXFR.Report := Report;
  case RGFileFormat.ItemIndex of
    0 : EXFR.ExportFRPDF(edFileName.Text, True);
    1 : EXFR.ExportFRPDF(edFileName.Text, False);
    2 : EXFR.ExportFRJPG(edFileName.Text);
    3 : EXFR.ExportFRBMP(edFileName.Text);
    4 : EXFR.ExportFRWMF(edFileName.Text);
    5 : EXFR.ExportFREMF(edFileName.Text);
  end;
end;

end.
