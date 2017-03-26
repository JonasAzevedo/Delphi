program Design;

uses
  Forms,
  UDesign in 'UDesign.pas' {Form67};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm67, Form67);
  Application.Run;
end.
