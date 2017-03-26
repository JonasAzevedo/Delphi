program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmPrincipal};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
