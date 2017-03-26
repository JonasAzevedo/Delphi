unit unObjBairro;

interface

uses
  unDM;

  type TObjBairro = class

    private
      FnCodigo: Integer;
      FnFk_Cidade: Integer;
      FsNome: String[100];
      FsExibeCidade: String;
    public
      procedure setCodigo(pnCodigo: Integer);
      procedure setFkCidade(pnFkCidade: Integer);
      procedure setNome(psNome: String);
      procedure setExibeCidade();

      function getCodigo(): Integer;
      function getFkCidade(): Integer;
      function getNome(): String;
      function getExibeCidade(): String;
      //verifica se existe diferença no objeto. Quando estiver editando registro
      function verificarDiferencaCadastro(pnFkCidade:Integer; psNome:String): boolean;
  end;

implementation

uses
  unConstantes;

{ TObjBairro }


{***** set's e get's *****}
procedure TObjBairro.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjBairro.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjBairro.setFkCidade(pnFkCidade: Integer);
begin
  try
    Self.FnFk_Cidade := pnFkCidade;
  except
    Self.FnFk_Cidade := NUMERO_INDEFINIDO;
  end;
end;

function TObjBairro.getFkCidade: Integer;
begin
  Result := Self.FnFk_Cidade;
end;

procedure TObjBairro.setNome(psNome: String);
begin
  try
    Self.FsNome := psNome;
  except
    Self.FsNome := STRING_INDEFINIDO;
  end;
end;

function TObjBairro.getNome: String;
begin
  Result := Self.FsNome;
end;

procedure TObjBairro.setExibeCidade();
begin
  Self.FsExibeCidade := STRING_INDEFINIDO;

  if(Self.FnFk_Cidade <> NUMERO_INDEFINIDO)then
  begin
    DM.zQryCidade.Close;
    DM.zQryCidade.SQL.Clear;
    DM.zQryCidade.SQL.Add('SELECT * FROM cidade WHERE codigo=:cod');
    DM.zQryCidade.ParamByName('cod').AsInteger := Self.FnFk_Cidade;
    DM.zQryCidade.Open;
    if(DM.zQryCidade.RecordCount = 1)then
      //Self.FsExibeCidade := DM.zQryCidadeCODIGO.AsString + ' - ' + DM.zQryCidadeNOME.AsString;
      Self.FsExibeCidade := DM.zQryCidadeNOME.AsString;
  end;
end;

function TObjBairro.getExibeCidade(): String;
begin
  Result := Self.FsExibeCidade;
end;

{***** procedimentos diversos *****}
//verifica se existe diferença no objeto. Quando estiver editando registro
function TObjBairro.verificarDiferencaCadastro(pnFkCidade:Integer; psNome:String): boolean;
var
  retorno: Boolean;
begin
  retorno := False;

  if (pnFkCidade <> Self.getFkCidade) then
    retorno := True;
  if (psNome <> Self.getNome) then
    retorno := True;

  Result := retorno;
end;

end.
