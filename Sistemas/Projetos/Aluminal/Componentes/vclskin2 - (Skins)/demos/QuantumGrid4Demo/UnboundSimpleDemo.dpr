program UnboundSimpleDemo;

uses
  Forms,
  UnboundSimpleDemoMain in 'UnboundSimpleDemoMain.pas' {UnboundSimpleDemoMainForm},
  UnboundSimpleDemoAbout in 'UnboundSimpleDemoAbout.pas' {UnboundSimpleDemoAboutForm},
  SkinEQGrid in 'SkinEQGrid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid4 UnboundSimple Demo';
  Application.HelpFile := '..\..\Help\EQGrid4.hlp';
  Application.CreateForm(TUnboundSimpleDemoMainForm, UnboundSimpleDemoMainForm);
  Application.Run;
end.
