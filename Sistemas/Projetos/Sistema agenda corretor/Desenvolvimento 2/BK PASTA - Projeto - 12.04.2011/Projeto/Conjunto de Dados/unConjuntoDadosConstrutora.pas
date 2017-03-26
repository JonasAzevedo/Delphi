unit unConjuntoDadosConstrutora;

interface

  uses
    unConjuntoDados;

  type TConjuntoDadosConstrutora = class(TConjunto)

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

constructor TConjuntoDadosConstrutora.CriaObjeto();
begin
  inherited;

  SetNomeTabela(TABLE_CONSTRUTORA);
  SetSQLPrincipal();
  ExecutarSQLSelecao();
  DeletarRegistroNaoDefinido();
end;

function TConjuntoDadosConstrutora.GetCodigo: Integer;
begin
  if(FcdsDados.Active)and(FcdsDados.RecordCount > 0)then
    Result := FcdsDados.FieldByName('codigo').AsInteger
  else
    Result := NUMERO_INDEFINIDO;
end;

function TConjuntoDadosConstrutora.GetNome: String;
begin
  if(FcdsDados.Active)and(FcdsDados.RecordCount > 0)then
    Result := FcdsDados.FieldByName('nome').AsString
  else
    Result := STRING_INDEFINIDO;
end;

end.
