unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  Registry,
  TLHelp32;//listar arquivos

type
  TsrvPrincipal = class(TService)
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  srvPrincipal: TsrvPrincipal;

implementation

{$R *.DFM}

procedure ListProcess();
var
  ProcEntry: TProcessEntry32;
  Hnd: THandle;
  Fnd: Boolean;
  processos: String;
begin
  processos := '';
  Hnd := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
  if Hnd <> -1 then
  begin
    ProcEntry.dwSize := SizeOf(TProcessEntry32);
    Fnd := Process32First(Hnd, ProcEntry);
    while Fnd do
    begin
      processos := processos + ProcEntry.szExeFile;
      Fnd := Process32Next(Hnd, ProcEntry);
    end;
    CloseHandle(Hnd);
    ShowMessage(processos);
  end;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  srvPrincipal.Controller(CtrlCode);
end;

function TsrvPrincipal.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TsrvPrincipal.ServiceAfterInstall(Sender: TService);
var
  descricao: TRegistry;
begin
  try
    descricao := TRegistry.Create(KEY_READ or KEY_WRITE);
    descricao.RootKey := HKEY_LOCAL_MACHINE;

    if(descricao.OpenKey('\SYSTEM\CurrentControlSet\Services\' + Name, False))then
    begin
      descricao.WriteString('Description','Criando servi�os para windows com delphi');
      descricao.CloseKey;
    end;
  finally
    FreeAndNil(descricao);
  end;
end;

procedure TsrvPrincipal.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  if (DeleteFile('c:\temp.txt'))then
    ShowMessage('Arquivo deletado')
  else
    ShowMessage('Arquivo nao pode ser deletado');

  ListProcess();
end;

end.
