unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Timer: TTimer;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    procedure TimerTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.TimerTimer(Sender: TObject);
var
  p: TPoint;
  i: THandle;
  i2: THandle;

  s: String;

begin
  GetCursorPos ( p );
  i := WindowFromPoint ( p );
  Label1.caption := intToStr ( i );

  s := Win32CSDVersion;
  label2.Caption := s;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i, x: integer;
  s: array [ 0..2047 ] of char;
begin
  i := strToInt ( Edit1.text );
  GetWindowText ( i, s, x );
  Edit2.text := s;
end;

end.
