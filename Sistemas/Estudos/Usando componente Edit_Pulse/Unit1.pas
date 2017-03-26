unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Edit_Pulse;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit_Pulse1: TEdit_Pulse;
    procedure Edit_Pulse1Valida(poSender: TObject;
      var pnCancelado: Boolean);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Edit_Pulse1Valida(poSender: TObject; var pnCancelado: Boolean);
begin
  ShowMessage('proCodigo = ' + IntToStr(Edit_Pulse1.proCodigo));
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if(Edit_Pulse1.valida)then
    ShowMessage('valida = true')
  else
    ShowMessage('valida = false');
end;

end.
