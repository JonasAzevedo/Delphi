unit unUsuario;

interface

{uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, unFuncoes, StdCtrls;
}
uses
  unObjLog;


  type TUsuario = class(TObject)

    private
      FnCodigo: Integer;
      FsNome: String;
      FoLog: TObjLog;
    public
      constructor Create();

      procedure setCodigo(pnCodigo: Integer);
      procedure setNome(psNome: String);
      function getCodigo(): Integer;
      function getNome(): String;

      procedure iniciarLog();
      procedure finalizarLog();
  end;

implementation

uses
  unDM, unConstantes, SysUtils;

{ TUsuario }

constructor TUsuario.Create();
begin
  inherited Create;
  Self.FnCodigo := NUMERO_INDEFINIDO;
  Self.FsNome := STRING_INDEFINIDO;
  Self.FoLog := TObjLog.Create;
end;

procedure TUsuario.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TUsuario.getCodigo(): Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TUsuario.setNome(psNome: String);
begin
  try
    Self.FsNome := psNome;
   except
     Self.FsNome := STRING_INDEFINIDO;
  end;
end;

function TUsuario.getNome(): String;
begin
  Result := Self.FsNome;
end;

procedure TUsuario.iniciarLog();
  //carrega dados do log realizado
  procedure pegarLogRealizado();
  begin
    DM.zQryLog.Close;
    DM.zQryLog.SQL.Clear;
    DM.zQryLog.SQL.Add('SELECT * FROM log ORDER BY codigo DESC ROWS 1');
    DM.zQryLog.Open;
    if((DM.zQryLog.Active)and(DM.zQryLog.RecordCount > 0))then
    begin
      DM.zQryLog.First;
      Self.FoLog.setCodigo(DM.zQryLogCODIGO.AsInteger);
      Self.FoLog.setDataCadastro(DM.zQryLogDATA_CADASTRO.AsDateTime);
      Self.FoLog.setFKCodUsuario(DM.zQryLogCOD_FK_USUARIO.AsInteger);
      Self.FoLog.setDataLogin(DM.zQryLogDATA_LOGIN.AsDateTime);
      Self.FoLog.setDataLogoff(NUMERO_INDEFINIDO);
    end;
  end;

begin
  if(Self.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    try
      DM.ZConnection.StartTransaction;
      DM.zQryLog.Close;
      DM.zQryLog.SQL.Clear;
      DM.zQryLog.SQL.Add('INSERT INTO log(cod_fk_usuario,data_login) VALUES (:codFK_usu,:dt_log)');
      DM.zQryLog.ParamByName('codFK_usu').AsInteger := Self.getCodigo;
      DM.zQryLog.ParamByName('dt_log').AsDateTime := Now;
      DM.zQryLog.ExecSQL();
      DM.ZConnection.Commit;
      pegarLogRealizado();
    except
      DM.ZConnection.Rollback;
    end;
  end;
end;

procedure TUsuario.finalizarLog();
begin
  if(Self.FoLog.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    try
      DM.ZConnection.StartTransaction;
      DM.zQryLog.Close;
      DM.zQryLog.SQL.Clear;
      DM.zQryLog.SQL.Add('UPDATE log SET data_logoff=:dt_log WHERE codigo=:cod');
      DM.zQryLog.ParamByName('dt_log').AsDateTime := Now;
      DM.zQryLog.ParamByName('cod').AsInteger := Self.FoLog.getCodigo;
      DM.zQryLog.ExecSQL();
      DM.ZConnection.Commit;
    except
      DM.ZConnection.Rollback;
    end;
  end;
end;


end.
