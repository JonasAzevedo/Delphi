unit ufrmSM;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter;

type
{$METHODINFO ON}
  TfrmSM = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
  end;
{$METHODINFO OFF}

implementation


{$R *.dfm}


uses System.StrUtils;

function TfrmSM.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TfrmSM.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

