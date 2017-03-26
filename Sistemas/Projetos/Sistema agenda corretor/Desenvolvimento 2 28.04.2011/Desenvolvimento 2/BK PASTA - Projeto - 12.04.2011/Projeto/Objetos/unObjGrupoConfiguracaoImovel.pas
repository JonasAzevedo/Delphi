unit unObjGrupoConfiguracaoImovel;

interface

  type TObjGrupoConfiguracaoImovel = class
    private
      FnCodigo: Integer;
      FsNome: String[50];
    public
      procedure setCodigo(pnCodigo: Integer);
      procedure setNome(psNome: String);

      function getCodigo(): Integer;
      function getNome(): String;
      //verifica se existe diferença no objeto. Quando estiver editando registro
      function verificarDiferencaCadastro(psNome:String): boolean;
  end;

implementation

uses
  unConstantes;

{ TObjGrupoConfiguracaoImovel }


{***** set's e get's *****}
procedure TObjGrupoConfiguracaoImovel.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjGrupoConfiguracaoImovel.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjGrupoConfiguracaoImovel.setNome(psNome: String);
begin
  try
    Self.FsNome := psNome;
  except
    Self.FsNome := STRING_INDEFINIDO;
  end;
end;

function TObjGrupoConfiguracaoImovel.getNome: String;
begin
  Result := Self.FsNome;
end;

{***** procedimentos diversos *****}
//verifica se existe diferença no objeto. Quando estiver editando registro
function TObjGrupoConfiguracaoImovel.verificarDiferencaCadastro(psNome:String): boolean;
var
  retorno: Boolean;
begin
  retorno := False;

  if (psNome <> Self.getNome) then
    retorno := True;

  Result := retorno;
end;

end.
