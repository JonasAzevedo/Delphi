unit unConjuntoDadosRegiaoLocalidade;

interface

  uses
    unConjuntoDados;

  type TConjuntoDadosRegiaoLocalidade = class(TConjunto)

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

constructor TConjuntoDadosRegiaoLocalidade.CriaObjeto();
begin
  inherited;

  SetNomeTabela(TABLE_REGIAO_LOCALIDADE);
  SetSQLPrincipal();
  ExecutarSQLSelecao();
  DeletarRegistroNaoDefinido();
end;

function TConjuntoDadosRegiaoLocalidade.GetCodigo: Integer;
begin
  if(FcdsDados.Active)and(FcdsDados.RecordCount > 0)then
    Result := FcdsDados.FieldByName('codigo').AsInteger
  else
    Result := NUMERO_INDEFINIDO;
end;

function TConjuntoDadosRegiaoLocalidade.GetNome: String;
begin
  if(FcdsDados.Active)and(FcdsDados.RecordCount > 0)then
    Result := FcdsDados.FieldByName('nome').AsString
  else
    Result := STRING_INDEFINIDO;
end;

end.
