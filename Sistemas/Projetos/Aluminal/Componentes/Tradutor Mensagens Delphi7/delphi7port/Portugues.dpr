program Portugues;

uses
  Forms,
  TraducaoFrm in 'TraducaoFrm.pas' {frmTraducao},
  VDBConsts in 'VDBConsts.pas',
  bdeconst in 'bdeconst.pas',
  ComStrs in 'ComStrs.pas',
  Consts in 'Consts.pas',
  CtlConsts in 'CtlConsts.pas',
  DBConsts in 'DBConsts.pas',
  IBDCLConst in 'IBDCLConst.pas',
  MidConst in 'MidConst.pas',
  Mxconsts in 'Mxconsts.pas',
  OleConst in 'OleConst.pas',
  ScktCnst in 'ScktCnst.pas',
  SqlConst in 'SqlConst.pas',
  ADOConst in 'ADOConst.pas',
  IBXConst in 'IBXConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTraducao, frmTraducao);
  Application.Run;
end.
