program projetoComThread;

uses
  Forms,
  unComThread in 'unComThread.pas' {Form1},
  unTHread in 'unTHread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.