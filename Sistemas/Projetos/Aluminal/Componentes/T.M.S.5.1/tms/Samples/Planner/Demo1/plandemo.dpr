program plandemo;

uses
  Forms,
  Uplan in 'Uplan.pas' {Form1},
  Uhelp in 'Uhelp.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
