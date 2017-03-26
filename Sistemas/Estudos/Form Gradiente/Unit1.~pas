unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TForm1 = class(TForm)
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormPaint(Sender: TObject);
var
  altura, coluna: Word;
begin
  altura := (ClientHeight + 255) div 256;
  for coluna := 0 to 255 do
    with Canvas do
    begin
      Brush.Color := RGB(coluna, 0, 0); { Modifique para obter cores diferentes }
      FillRect(Rect(0, coluna * altura, ClientWidth, (coluna + 1) * altura)) ;
    end;
end;


procedure TForm1.FormResize(Sender: TObject);
begin
  Invalidate;
end;

end.
