unit unObjProfissao;

interface

uses
  unDM;

  type TObjProfissao = class

    private
      FnCodigo: Integer;
      FsNome: String[100];
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

{ TObjProfissao }

{***** set's e get's *****}
procedure TObjProfissao.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjProfissao.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjProfissao.setNome(psNome: String);
begin
  try
    Self.FsNome := psNome;
  except
    Self.FsNome := STRING_INDEFINIDO;
  end;
end;

function TObjProfissao.getNome: String;
begin
  Result := Self.FsNome;
end;

{***** procedimentos diversos *****}
//verifica se existe diferença no objeto. Quando estiver editando registro
function TObjProfissao.verificarDiferencaCadastro(psNome:String): boolean;
var
  retorno: Boolean;
begin
  retorno := False;

  if (psNome <> Self.getNome) then
    retorno := True;

  Result := retorno;
end;

end.
