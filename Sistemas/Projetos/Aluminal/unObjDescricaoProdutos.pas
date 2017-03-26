unit unObjDescricaoProdutos;

interface

uses
  unDM;

  type TObjDescricaoProdutos = class

    private
      FnCodigo: Integer;
      FsNome: String[100];
      FdValor: Double;
    public
      procedure setCodigo(pnCodigo: Integer);
      procedure setNome(psNome: String);
      procedure setValor(pdValor: Double);

      function getCodigo: Integer;
      function getNome: String;
      function getValor: Double;

      //verifica se existe diferença no objeto. Quando estiver editando registro
      function verificarDiferencaCadastro(psNome:String; pdValor:Double): boolean;
  end;

implementation

uses
  unConstantes;

{ TObjDescricaoProdutos }
                  
{***** set's e get's *****}
procedure TObjDescricaoProdutos.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjDescricaoProdutos.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjDescricaoProdutos.setNome(psNome: String);
begin
  try
    Self.FsNome := psNome;
  except
    Self.FsNome := STRING_INDEFINIDO;
  end;
end;

function TObjDescricaoProdutos.getNome: String;
begin
  Result := Self.FsNome;
end;

procedure TObjDescricaoProdutos.setValor(pdValor: Double);
begin
  try
    Self.FdValor := pdValor;
  except
    Self.FdValor := NUMERO_INDEFINIDO;
  end;
end;

function TObjDescricaoProdutos.GetValor: Double;
begin
  Result := Self.FdValor;
end;


{***** procedimentos diversos *****}
//verifica se existe diferença no objeto. Quando estiver editando registro
function TObjDescricaoProdutos.verificarDiferencaCadastro(psNome:String; pdValor:Double): boolean;
var
  retorno: Boolean;
begin
  retorno := False;

  if (psNome <> Self.getNome) then
    retorno := True;
  if (pdValor <> Self.getValor) then
    retorno := True;

  Result := retorno;
end;

end.
