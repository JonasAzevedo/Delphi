unit unIniciarConiguracoes;

interface

  uses
    IniFiles;

  type TIniciarConfiguracoes = class

    private
      oIniConf: TIniFile;//arquivo .INI
    public
      function ConfigurarBD: Boolean;
  end;

implementation

uses unConstantes, unDM,
     Dialogs,
     SysUtils; //FileExists

(* TIniciarConfiguracoes *)

function TIniciarConfiguracoes.ConfigurarBD: Boolean;
var
  bRetorno: Boolean;
begin
  bRetorno := False;
  //abrindo arquivo .INI
  if (FileExists(ExtractFilePath(ParamStr(0))+ sARQUIVO_INI_CONFIGURACOES)) then //pega diretório do executável + arquivo .INI
  begin
    try
      oIniConf := TIniFile.Create(ExtractFilePath(ParamStr(0))+ sARQUIVO_INI_CONFIGURACOES);
      DM.ZConnection.Disconnect;
      DM.ZConnection.Database := oIniConf.ReadString('BD','path','');
      DM.ZConnection.Connect;
      oIniConf.Free;
      if (DM.ZConnection.Connected = True) then
        bRetorno := True;
    except
      MessageDlg('Banco de Dados não pode ser conectado.',mtInformation,[mbOK],0);
      DM.ZConnection.Disconnect;
    end;
  end;


  Result := bRetorno;
end;



end.
