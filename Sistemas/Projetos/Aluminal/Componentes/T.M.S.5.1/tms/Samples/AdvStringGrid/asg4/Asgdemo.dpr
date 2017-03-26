program Asgdemo;

uses
  Forms,
  Asgunit in 'ASGUNIT.PAS' {Demo},
  asprev in 'asprev.pas' {PagePreview},
  asabout in 'asabout.pas' {About},
  asfind in 'asfind.pas' {finddlg};

{$R *.RES}
{$R ASGXP.RES}
               
begin
  Application.CreateForm(TDemo, Demo);
  Application.Run;
end.
