unit NewImageForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfmNewImage = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edWidth: TEdit;
    edHeight: TEdit;
    cbColors: TComboBox;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    function GetPixelFormat: TPixelFormat;
    { Private declarations }
  public
    property PixelFormat : TPixelFormat read GetPixelFormat;
    { Public declarations }
  end;

var
  fmNewImage: TfmNewImage;

implementation

{$R *.DFM}

uses HelpContext;

procedure TfmNewImage.FormShow(Sender: TObject);
begin
  cbColors.ItemIndex := 1;
end;

function TfmNewImage.GetPixelFormat: TPixelFormat;
var
  pf : TPixelFormat;
begin
  case cbColors.ItemIndex of
    0 : pf := pf1Bit;
    1 : pf := pf4Bit;
    2 : pf := pf8Bit;
    else
      pf := pf4Bit
  end;

  result := pf;
end;

procedure TfmNewImage.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext (hcNewImageDialog);
end;

end.
