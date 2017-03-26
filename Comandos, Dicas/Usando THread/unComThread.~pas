unit unComThread;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses unTHread;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  THreadContador: TContador;
begin
  THreadContador := TContador.Create(true);
  THreadContador.FreeOnTerminate := true;
  THreadContador.Resume;
end;

end.
