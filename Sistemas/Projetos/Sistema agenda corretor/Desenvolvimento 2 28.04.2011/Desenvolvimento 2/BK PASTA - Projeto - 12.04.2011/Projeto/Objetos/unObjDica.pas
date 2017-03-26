unit unObjDica;

interface

uses
  unDM;

  type TObjDica = class

    private
      FnCodigo: Integer;
      FnFk_Usuario: Integer;
      FsTela: String[30];
      FsDica: String;
      FsExibeUsuario: String;
      FsExibeTela: String;
    public
      procedure setCodigo(pnCodigo: Integer);
      procedure setFkUsuario(pnFkUsuario: Integer);
      procedure setTela(psTela: String);
      procedure setDica(psDica: String);
      procedure setExibeUsuario();

      function getCodigo(): Integer;
      function getFkUsuario(): Integer;
      function getTela(): String;
      function getDica(): String;
      function getExibeUsuario(): String;
      //verifica se existe diferença no objeto. Quando estiver editando registro
      function verificarDiferencaCadastro(psTela:String; psDica:String): boolean;
  end;

implementation

uses
  unConstantes;

{ TObjDica }

{***** set's e get's *****}
procedure TObjDica.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjDica.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjDica.setFkUsuario(pnFkUsuario: Integer);
begin
  try
    Self.FnFk_Usuario := pnFkUsuario;
  except
    Self.FnFk_Usuario := NUMERO_INDEFINIDO;
  end;
end;

function TObjDica.getFkUsuario: Integer;
begin
  Result := Self.FnFk_Usuario;
end;

procedure TObjDica.setTela(psTela: String);
begin
  try
    Self.FsTela := psTela;
  except
    Self.FsTela := STRING_INDEFINIDO;
  end;
end;

function TObjDica.getTela: String;
begin
  Result := Self.FsTela;
end;

procedure TObjDica.setDica(psDica: String);
begin
  try
    Self.FsDica := psDica;
  except
    Self.FsDica := STRING_INDEFINIDO;
  end;
end;

function TObjDica.getDica: String;
begin
  Result := Self.FsDica;
end;

procedure TObjDica.setExibeUsuario();
begin
  Self.FsExibeUsuario := STRING_INDEFINIDO;

  if(Self.FnFk_Usuario <> NUMERO_INDEFINIDO)then
  begin
    DM.zQryUsuario.Close;
    DM.zQryUsuario.SQL.Clear;
    DM.zQryUsuario.SQL.Add('SELECT * FROM usuario WHERE codigo=:cod');
    DM.zQryUsuario.ParamByName('cod').AsInteger := Self.FnFk_Usuario;
    DM.zQryUsuario.Open;
    if(DM.zQryUsuario.RecordCount = 1)then
      //Self.FsExibeEstado := DM.zQryEstadoCODIGO.AsString + ' - ' + DM.zQryEstadoNOME.AsString;
      Self.FsExibeUsuario := DM.zQryUsuarioNOME.AsString;
  end;
end;

function TObjDica.getExibeUsuario(): String;
begin
  Result := Self.FsExibeUsuario;
end;

{***** procedimentos diversos *****}
//verifica se existe diferença no objeto. Quando estiver editando registro
function TObjDica.verificarDiferencaCadastro(psTela:String; psDica:String): boolean;
var
  retorno: Boolean;
begin
  retorno := False;

  if (psTela <> Self.getTela) then
    retorno := True;
  if (psDica <> Self.getDica) then
    retorno := True;

  Result := retorno;
end;

end.
