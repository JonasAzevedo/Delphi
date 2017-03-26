unit unObjEstado;

interface

  type TObjEstado = class

    private
      FnCodigo: Integer;
      FsNome: String[50];
      FsSigla: String[2];
    public
      procedure setCodigo(pnCodigo: Integer);
      procedure setNome(psNome: String);
      procedure setSigla(psSigla: String);

      function getCodigo(): Integer;
      function getNome(): String;
      function getSigla(): String;
      //verifica se existe diferença no objeto. Quando estiver editando registro
      function verificarDiferencaCadastro(psNome:String; psSigla:String): boolean;
  end;

implementation

uses Variants;

{ TObjEstado }

//tratamento de valores nulos
//Integer = 0
//String = ''
//Date = 0

{***** set's e get's *****}      
procedure TObjEstado.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := 0;
  end;
end;

function TObjEstado.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;


procedure TObjEstado.setNome(psNome: String);
begin
  try
    Self.FsNome := psNome;
  except
    Self.FsNome := '';
  end;
end;

function TObjEstado.getNome: String;
begin
  Result := Self.FsNome;
end;

procedure TObjEstado.setSigla(psSigla: String);
begin
  try
    Self.FsSigla := psSigla;
  except
    Self.FsSigla := '';
  end;
end;

function TObjEstado.getSigla: String;
begin
  Result := Self.FsSigla;
end;

{***** procedimentos diversos *****}
//verifica se existe diferença no objeto. Quando estiver editando registro
function TObjEstado.verificarDiferencaCadastro(psNome:String; psSigla:String): boolean;
var
  retorno: boolean;
begin
  retorno := false;

  if (psNome <> Self.getNome) then
    retorno := true;
  if (psSigla <> Self.getSigla) then
    retorno := true;

  Result := retorno;
end;

end.
