unit unObjConstrutora;

interface

uses
  unDM;

  type TObjConstrutora = class

    private
      FnCodigo: Integer;
      FsNome: String[100];
      FsTelefone1: String[13];
      FsTelefone2: String[13];
    public
      procedure setCodigo(pnCodigo: Integer);
      procedure setNome(psNome: String);
      procedure setTelefone1(psTelefone1: String);
      procedure setTelefone2(psTelefone2: String);

      function getCodigo(): Integer;
      function getNome(): String;
      function getTeleone1(): String;
      function getTeleone2(): String;

      //verifica se existe diferença no objeto. Quando estiver editando registro
      function verificarDiferencaCadastro(psNome:String; psTelefone1:String;
        psTelefone2:String): boolean;
  end;

implementation

uses
  unConstantes;

{ TObjConstrutora }


{***** set's e get's *****}
procedure TObjConstrutora.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjConstrutora.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjConstrutora.setNome(psNome: String);
begin
  try
    Self.FsNome := psNome;
  except
    Self.FsNome := STRING_INDEFINIDO;
  end;
end;

function TObjConstrutora.getNome: String;
begin
  Result := Self.FsNome;
end;

procedure TObjConstrutora.setTelefone1(psTelefone1: String);
begin
  try
    Self.FsTelefone1 := psTelefone1;
  except
    Self.FsTelefone1 := STRING_INDEFINIDO;
  end;
end;

function TObjConstrutora.getTeleone1(): String;
begin
  Result := Self.FsTelefone1;
end;

procedure TObjConstrutora.setTelefone2(psTelefone2: String);
begin
  try
    Self.FsTelefone2 := psTelefone2;
  except
    Self.FsTelefone2 := STRING_INDEFINIDO;
  end;
end;

function TObjConstrutora.getTeleone2(): String;
begin
  Result := Self.FsTelefone2;
end;

{***** procedimentos diversos *****}
//verifica se existe diferença no objeto. Quando estiver editando registro
function TObjConstrutora.verificarDiferencaCadastro(psNome:String;
 psTelefone1:String; psTelefone2:String): boolean;
var
  retorno: Boolean;
begin
  retorno := False;

  if (psNome <> Self.getNome) then
    retorno := True;
  if (psTelefone1 <> Self.getTeleone1) then
    retorno := True;
  if (psTelefone2 <> Self.getTeleone2) then
    retorno := True;

  Result := retorno;
end;

end.
