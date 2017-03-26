unit unLoko;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  TfrmIeIe = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    lblLeatroLoko: TLabel;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIeIe: TfrmIeIe;

implementation

{$R *.dfm}

procedure TfrmIeIe.Timer1Timer(Sender: TObject);
begin
  lblLeatroLoko.Font.Size := lblLeatroLoko.Font.Size + 6;
  if (lblLeatroLoko.Font.Size > 70) then
    lblLeatroLoko.Font.Size := 8;

end;

end.
