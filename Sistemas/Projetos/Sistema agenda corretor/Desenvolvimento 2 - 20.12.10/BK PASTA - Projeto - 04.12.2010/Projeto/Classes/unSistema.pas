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
      procedure carregarParametros(); //carrega os parâmetros do sistema
      procedure configurarFormatoDataHora();//configura formato para data e hora, para serem usados no sistema
  end;

implementation

uses
  unDM, unConstantes;

{ TSistema }

constructor TSistema.Create();
begin
  inherited Create;
  Self.FnTempoAvisaAgenda := NUMERO_INDEFINIDO;
  Self.carregarParametros();
end;

//carrega os parâmetros do sistema
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
function TSistema.getTempoAvisaAgenda(): Integer;
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


end.
