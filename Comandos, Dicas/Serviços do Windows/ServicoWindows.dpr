program ServicoWindows;

uses
  SvcMgr,
  unPrincipal in 'unPrincipal.pas' {srvPrincipal: TService};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TsrvPrincipal, srvPrincipal);
  Application.Run;
end.
