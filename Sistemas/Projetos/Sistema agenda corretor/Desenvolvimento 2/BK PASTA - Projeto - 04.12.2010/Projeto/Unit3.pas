unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, plsEdit;

type
  TForm3 = class(TForm)
    PlsEdit1: TPlsEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#27) then
    Self.Close;
end;

end.
