unit unConjuntoDadosBairro;

interface

  uses
    unConjuntoDados;

  type TConjuntoDadosBairro = class(TConjunto)

    private
    published
      constructor CriaObjeto(); override;
      function GetCodigo: Integer;
      function GetNome: String;
    public

  end;

implementation

uses
  unConstantes;

constructor TConjuntoDadosBairro.CriaObjeto();
begin
  inherited;

  SetNomeTabela(TABLE_BAIRRO);
  SetSQLPrincipal();
  ExecutarSQLSelecao();
end;

function TConjuntoDadosBairro.GetCodigo: Integer;
begin
  if(FcdsDados.Active)and(FcdsDados.RecordCount > 0)then
    Result := FcdsDados.FieldByName('codigo').AsInteger
  else
    Result := NUMERO_INDEFINIDO;
end;

function TConjuntoDadosBairro.GetNome: String;
begin
  if(FcdsDados.Active)and(FcdsDados.RecordCount > 0)then
    Result := FcdsDados.FieldByName('nome').AsString
  else
    Result := STRING_INDEFINIDO;
end;

end.
