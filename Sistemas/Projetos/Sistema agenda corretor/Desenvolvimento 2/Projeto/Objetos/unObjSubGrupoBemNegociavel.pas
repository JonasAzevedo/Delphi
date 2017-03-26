unit unObjSubGrupoBemNegociavel;

interface

uses
  unDM;

  type TObjSubGrupoBemNegociavel = class

    private
      FnCodigo: Integer;
      FnFk_Grupo: Integer;
      FsNome: String[50];
      FsExibeGrupo: String;
    public
      procedure setCodigo(pnCodigo: Integer);
      procedure setFkGrupo(pnFkGrupo: Integer);
      procedure setNome(psNome: String);
      procedure setExibeGrupo();

      function getCodigo(): Integer;
      function getFkGrupo(): Integer;
      function getNome(): String;
      function getExibeGrupo(): String;
      //verifica se existe diferença no objeto. Quando estiver editando registro
      function verificarDiferencaCadastro(pnFkGrupo:Integer; psNome:String): boolean;
  end;

implementation

uses
  unConstantes;

{ TObjSubGrupoBemNegociavel }


{***** set's e get's *****}
procedure TObjSubGrupoBemNegociavel.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjSubGrupoBemNegociavel.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjSubGrupoBemNegociavel.setFkGrupo(pnFkGrupo: Integer);
begin
  try
    Self.FnFk_Grupo := pnFkGrupo;
  except
    Self.FnFk_Grupo := NUMERO_INDEFINIDO;
  end;
end;

function TObjSubGrupoBemNegociavel.getFkGrupo: Integer;
begin
  Result := Self.FnFk_Grupo;
end;

procedure TObjSubGrupoBemNegociavel.setNome(psNome: String);
begin
  try
    Self.FsNome := psNome;
  except
    Self.FsNome := STRING_INDEFINIDO;
  end;
end;

function TObjSubGrupoBemNegociavel.getNome: String;
begin
  Result := Self.FsNome;
end;

procedure TObjSubGrupoBemNegociavel.setExibeGrupo();
begin
  Self.FsExibeGrupo := STRING_INDEFINIDO;

  if(Self.FnFk_Grupo <> NUMERO_INDEFINIDO)then
  begin
    DM.zQryGrupoBemNegociavel.Close;
    DM.zQryGrupoBemNegociavel.SQL.Clear;
    DM.zQryGrupoBemNegociavel.SQL.Add('SELECT * FROM grupo_bem_negociavel WHERE codigo=:cod');
    DM.zQryGrupoBemNegociavel.ParamByName('cod').AsInteger := Self.FnFk_Grupo;
    DM.zQryGrupoBemNegociavel.Open;
    if(DM.zQryGrupoBemNegociavel.RecordCount = 1)then
      //Self.FsExibeEstado := DM.zQryEstadoCODIGO.AsString + ' - ' + DM.zQryEstadoNOME.AsString;
      Self.FsExibeGrupo := DM.zQryGrupoBemNegociavelNOME.AsString;
  end;
end;

function TObjSubGrupoBemNegociavel.getExibeGrupo(): String;
begin
  Result := Self.FsExibeGrupo;
end;


{***** procedimentos diversos *****}
//verifica se existe diferença no objeto. Quando estiver editando registro
function TObjSubGrupoBemNegociavel.verificarDiferencaCadastro(pnFkGrupo:Integer; psNome:String): boolean;
var
  retorno: Boolean;
begin
  retorno := False;

  if (pnFkGrupo <> Self.getFkGrupo) then
    retorno := True;
  if (psNome <> Self.getNome) then
    retorno := True;

  Result := retorno;
end;

end.
