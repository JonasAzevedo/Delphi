unit unSistema;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, unFuncoes, StdCtrls;

  type TSistema = class(TObject)

    private
      FnTempoAvisaAgendaINT: Integer; //INT = interna
      function getTempoAvisaAgenda(): Integer;
      procedure setTempoAvisaAgenda(pnTempoAvisaAgenda: Integer);

    public
      constructor Create();
      property FnTempoAvisaAgenda: Integer read getTempoAvisaAgenda write setTempoAvisaAgenda;
      procedure carregarParametros; //carrega os par�metros do sistema
      procedure configurarFormatoDataHora;//configura formato para data e hora, para serem usados no sistema
      function VerificarRegistroSistema: Boolean; //verifica se o sistema est� registrado
  end;

implementation

uses
  unConstantes, DB, unDM;

{ TSistema }

constructor TSistema.Create();
begin
  inherited Create;
  Self.FnTempoAvisaAgenda := NUMERO_INDEFINIDO;
  Self.carregarParametros();
end;

//carrega os par�metros do sistema
procedure TSistema.carregarParametros();
begin
  DM.zQryParametrosSistema.Close;
  DM.zQryParametrosSistema.SQL.Clear;
  DM.zQryParametrosSistema.SQL.Add('SELECT * FROM parametros_sistema ');
  DM.zQryParametrosSistema.SQL.Add('WHERE codigo = 1');
  DM.zQryParametrosSistema.Open;
  if(DM.zQryParametrosSistema.RecordCount = 1)then
  begin
    Self.FnTempoAvisaAgenda := DM.zQryParametrosSistemaTEMPO_AVISO_AGENDA.AsInteger;
  end;
end;

//FnTempoAvisaAgenda: property
function TSistema.getTempoAvisaAgenda: Integer;
begin
  Result := Self.FnTempoAvisaAgendaINT;
end;

procedure TSistema.setTempoAvisaAgenda(pnTempoAvisaAgenda: Integer);
begin
  Self.FnTempoAvisaAgendaINT := pnTempoAvisaAgenda;
end;

procedure TSistema.configurarFormatoDataHora();
begin
  ShortDateFormat := 'dd/mm/yyyy';
  LongDateFormat := 'dd/mm/yyyy';
  DateSeparator := '/';
  ShortTimeFormat := 'hh:mm:ss';
  LongTimeFormat := 'hh:mm:ss';
  TimeSeparator := ':';
end;

//verifica se o sistema est� registrado
function TSistema.VerificarRegistroSistema: Boolean;
var
  bRetorno: Boolean;
  nTotalLogs: Integer;
  sSerialHD: String;
  sSerialRegistrado: String;
  FoFuncoes: TFuncoes;
begin
  bRetorno := True;
  nTotalLogs := NUMERO_INDEFINIDO;
  FoFuncoes := TFuncoes.Create;
  try
    sSerialHD := FoFuncoes.GetSerialNum(sDRIVER_C);
    sSerialHD := FoFuncoes.GetSerieFormatada(sSerialHD);
    //verifica se o sistema possui registro
    DM.zQryParametrosSistema.Close;
    DM.zQryParametrosSistema.SQL.Clear;
    DM.zQryParametrosSistema.SQL.Add('SELECT * FROM parametros_sistema WHERE codigo=1');
    DM.zQryParametrosSistema.Open;
    if(DM.zQryParametrosSistema.Active)and(DM.zQryParametrosSistema.RecordCount=1)then
    begin
      sSerialRegistrado := DM.zQryParametrosSistemaSERIAL.AsString;
      if(sSerialHD <> sSerialRegistrado)then //se s�rie do HD n�o confere
      begin
        MessageDlg('    Sistema com cadastro inv�lido!'+ #13 +'Consulte o administrador do sistema.',mtInformation,[mbOk],0);
        bRetorno := False;
      end
    end

    else //sistema sem cadastrado, verifica se j� executou o limite de vezes dispon�veis
    begin
      DM.zQryAuxTotalLogs.Close;
      DM.zQryAuxTotalLogs.SQL.Clear;
      DM.zQryAuxTotalLogs.SQL.Add('SELECT COUNT(codigo) AS total FROM log');
      DM.zQryAuxTotalLogs.Open;
      if(DM.zQryAuxTotalLogs.Active)and(DM.zQryAuxTotalLogs.RecordCount = 1)then
      begin
        DM.zQryAuxTotalLogs.First;
        nTotalLogs := DM.zQryAuxTotalLogsTOTAL.AsInteger;
      end;
      if (nTotalLogs > nLIMETE_LOGS_SEM_REGISTRO)then
        bRetorno := False;
    end;

  finally
    FreeAndNil(FoFuncoes);
  end;

  Result := bRetorno;
end;

end.
