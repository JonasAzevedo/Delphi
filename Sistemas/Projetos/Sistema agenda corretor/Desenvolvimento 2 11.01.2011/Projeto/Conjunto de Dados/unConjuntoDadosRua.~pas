unit unConjuntoDadosRua;

interface

  uses
    unConjuntoDados;

  type TConjuntoDadosRua = class(TConjunto)

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

constructor TConjuntoDadosRua.CriaObjeto();
begin
  inherited;

  SetNomeTabela(TABLE_RUA);
  SetSQLPrincipal();
  ExecutarSQLSelecao();
  DeletarRegistroNaoDefinido();
end;

function TConjuntoDadosRua.GetCodigo: Integer;
begin
  if(FcdsDados.Active)and(FcdsDados.RecordCount > 0)then
    Result := FcdsDados.FieldByName('codigo').AsInteger
  else
    Result := NUMERO_INDEFINIDO;
end;

function TConjuntoDadosRua.GetNome: String;
begin
  if(FcdsDados.Active)and(FcdsDados.RecordCount > 0)then
    Result := FcdsDados.FieldByName('nome').AsString
  else
    Result := STRING_INDEFINIDO;
end;

end.
