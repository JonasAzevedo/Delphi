unit unBckupRestore;

interface

  type TBackupRestore = class
    private
      function GetNroBackup: Integer;
      function GetDataHora: String;
      procedure GravarBackupRealizado(psPathBackup:String);
    public
      procedure RealizarBackup;
      procedure DeletarBackupAntigo(const pnPreservarUltimos:Integer = 5);
  end;

implementation

uses
  ShellAPI, unDM, SysUtils, unConstantes, unFuncoes;

{ TBackupRestore }


function TBackupRestore.GetNroBackup: Integer;
var
  nRetorno: Integer;
begin
  nRetorno := 1;
  DM.zQryAuxBackup.Close;
  DM.zQryAuxBackup.SQL.Clear;
  DM.zQryAuxBackup.SQL.Add('SELECT MAX(codigo) AS codigo FROM backup');
  DM.zQryAuxBackup.Open;
  if(DM.zQryAuxBackup.Active)and(DM.zQryAuxBackup.RecordCount=1)then
    nRetorno := DM.zQryAuxBackupCODIGO.AsInteger;

  if(nRetorno = 0)then
    Result := 1
  else
    Result := nRetorno;
end;

function TBackupRestore.GetDataHora: String;
var
  dDataHora: TDateTime;
  sDataHora: String;
begin
  dDataHora := Now;
  sDataHora := DateTimeToStr(dDataHora);
  sDataHora := StringReplace(sDataHora, '/','.',[rfReplaceAll, rfIgnoreCase]);
  sDataHora := StringReplace(sDataHora, ' ','_',[rfReplaceAll, rfIgnoreCase]);
  sDataHora := StringReplace(sDataHora, ':','.',[rfReplaceAll, rfIgnoreCase]);
  Result := sDataHora;
end;

procedure TBackupRestore.RealizarBackup;
const
  sDIRETORIO_BACKUP = 'C:\GICI_BKP\';
var
  Dados: TSHFileOpStruct;
  sLocalOrigem: String;
  sDestino: String;
  FoFuncoes: TFuncoes;
begin
  FoFuncoes := TFuncoes.Create;
  try
    if FoFuncoes.VerificarExisteCriarDiretorio(sDIRETORIO_BACKUP) then
    begin
      try
        DM.ZConnection.Connected := False;
        DM.ZConnection.Disconnect;
        sDestino := sDIRETORIO_BACKUP + 'bkpBD_GICI_' +IntToStr(GetNroBackup)+ '_' +GetDataHora+ '.FDB';// + DateTimeToStr(Now) + '.FDB';
        FillChar(Dados,SizeOf(Dados), 0);
        with Dados do
        begin
          wFunc := FO_COPY;
          //pFrom := PChar('E:\Delphi\Sistemas\Meus Sistemas\Sistema agenda corretor\Desenvolvimento 2\BD\BD.FDB');
          sLocalOrigem :=  ExtractFilePath(ParamStr(0)) + 'BD\BD.FDB';
          pFrom := PChar(sLocalOrigem);
          pTo   := PChar(sDestino);
          fFlags:= FOF_ALLOWUNDO;
        end;
        DM.ZConnection.Connected := True;
        DM.ZConnection.Connect;
        GravarBackupRealizado(sDestino);
        SHFileOperation(Dados);
      except
      end;
    end;
  finally
    FreeAndNil(FoFuncoes);
  end;
end;

procedure TBackupRestore.GravarBackupRealizado(psPathBackup:String);
begin
  try
    DM.ZConnection.StartTransaction;
    DM.zQryBackup.Close;
    DM.zQryBackup.SQL.Clear;
    DM.zQryBackup.SQL.Add('INSERT INTO backup(path_backup,ativo) VALUES (:path_backup,:ativo)');
    DM.zQryBackup.ParamByName('path_backup').AsString := psPathBackup;
    DM.zQryBackup.ParamByName('ativo').AsString := VLR_SIM;
    DM.zQryBackup.ExecSQL;
    DM.ZConnection.Commit;
  except
    DM.ZConnection.Rollback;
  end;
end;

procedure TBackupRestore.DeletarBackupAntigo(const pnPreservarUltimos:Integer = 5);
var
  nMax: Integer;
  sCodBackupDeletado: String;
  sSql: String;
  FoFuncoes: TFuncoes;
begin
  sCodBackupDeletado := STRING_INDEFINIDO;
  FoFuncoes := TFuncoes.Create;
  try
    //pega o código limite do backup que será deletado
    DM.zQryAuxBackup.Close;
    DM.zQryAuxBackup.SQL.Clear;
    DM.zQryAuxBackup.SQL.Add('SELECT MAX(codigo) AS codigo FROM backup');
    DM.zQryAuxBackup.Open;
    if(DM.zQryAuxBackup.Active)and(DM.zQryAuxBackup.RecordCount=1)then
      nMax := DM.zQryAuxBackupCODIGO.AsInteger - pnPreservarUltimos
    else
      nMax := NUMERO_INDEFINIDO;

    //selecionando os backup's que serão deletados
    if(nMax > NUMERO_INDEFINIDO)then
    begin
      DM.zQryBackup.Close;
      DM.zQryBackup.SQL.Clear;
      DM.zQryBackup.SQL.Add('SELECT * FROM backup WHERE codigo <= :codigo');
      DM.zQryBackup.ParamByName('codigo').AsInteger := nMax;
      DM.zQryBackup.Open;
      //deletando backup's
      if(DM.zQryBackup.Active)and(DM.zQryBackup.RecordCount > NUMERO_INDEFINIDO)then
      begin
        DM.zQryBackup.First;
        while not(DM.zQryBackup.Eof)do
        begin
          if DeleteFile(DM.zQryBackupPATH_BACKUP.AsString)then
            FoFuncoes.AdicionarInformacao(sCodBackupDeletado,DM.zQryBackupCODIGO.AsString);
          DM.zQryBackup.Next;
        end;
      end;
      //atualizando backup's para inativos
      if (sCodBackupDeletado <> STRING_INDEFINIDO)then
      begin
        sSql := 'UPDATE backup SET ativo='''+VLR_NAO+''' WHERE codigo IN('+sCodBackupDeletado+')';
        try
          DM.ZConnection.StartTransaction;
          DM.zQryBackup.Close;
          DM.zQryBackup.SQL.Clear;
          DM.zQryBackup.SQL.Add(sSql);
          DM.zQryBackup.ExecSQL;
          DM.ZConnection.Commit;
        except
          DM.ZConnection.Rollback;
        end;
      end;
    end;
  finally
    FreeAndNil(FoFuncoes);
  end;
end;

end.

