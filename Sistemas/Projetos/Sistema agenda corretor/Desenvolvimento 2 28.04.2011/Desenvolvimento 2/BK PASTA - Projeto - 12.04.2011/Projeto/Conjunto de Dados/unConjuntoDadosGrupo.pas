//grupo configuração do imóvel
unit unConjuntoDadosGrupo;


interface

  uses
    unConjuntoDados;

  type TConjuntoDadosGrupo = class(TConjunto)

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

constructor TConjuntoDadosGrupo.CriaObjeto();
begin
  inherited;

  SetNomeTabela(TABLE_GRUPO_CONFIGURACAO_IMOVEL);
  SetSQLPrincipal();
  ExecutarSQLSelecao();
  DeletarRegistroNaoDefinido();
end;

function TConjuntoDadosGrupo.GetCodigo: Integer;
begin
  if(FcdsDados.Active)and(FcdsDados.RecordCount > 0)then
    Result := FcdsDados.FieldByName('codigo').AsInteger
  else
    Result := NUMERO_INDEFINIDO;
end;

function TConjuntoDadosGrupo.GetNome: String;
begin
  if(FcdsDados.Active)and(FcdsDados.RecordCount > 0)then
    Result := FcdsDados.FieldByName('nome').AsString
  else
    Result := STRING_INDEFINIDO;
end;

end.
