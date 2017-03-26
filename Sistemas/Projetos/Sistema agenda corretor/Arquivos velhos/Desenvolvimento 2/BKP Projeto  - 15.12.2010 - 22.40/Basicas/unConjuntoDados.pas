unit unConjuntoDados;

interface

uses
  ZConnection, ZDataset, Provider, DBClient;

  type TConjunto = class

    private
      FsTabela: String;
      FsSQL: String;
      FsFiltro: String;
    published
      FzQuery: TZQuery;
      FdspDataSetProvider: TDataSetProvider;
      FcdsDados: TClientDataSet;

      procedure SetNomeTabela(psTabela: String);
      function GetNomeTabela(): String;
      procedure SetFiltro(psFiltro: String);
      function GetFiltro(): String;

      procedure SetSQLPrincipal();
      procedure ExecutarSQLSelecao();
      procedure ExecutarFiltrar();
      function TotalRegistros(): Integer;

      property prFiltro:String read GetFiltro write SetFiltro;
      //FodsDados: TDataSource;
      constructor CriaObjeto(); virtual;
    public

  end;


implementation

uses
  unDM, unConstantes, Classes;

constructor TConjunto.CriaObjeto();
begin
  FsTabela := STRING_INDEFINIDO;
  FsSQL := STRING_INDEFINIDO;
  FsFiltro := STRING_INDEFINIDO;
  FzQuery := TZQuery.Create(nil);
  FdspDataSetProvider := TDataSetProvider.Create(nil);
  FcdsDados := TClientDataSet.Create(nil);

  FzQuery.Connection := DM.ZConnection;
  FdspDataSetProvider.DataSet := FzQuery;
  FcdsDados.SetProvider(FdspDataSetProvider);
end;


procedure TConjunto.SetNomeTabela(psTabela: String);
begin
  FsTabela := psTabela;
end;

function TConjunto.GetNomeTabela(): String;
begin
  Result := FsTabela;
end;

procedure TConjunto.SetSQLPrincipal();
begin
  FsSQL := 'SELECT * FROM ' + FsTabela;
end;

procedure TConjunto.SetFiltro(psFiltro: String);
begin
  FsFiltro := psFiltro;
end;

function TConjunto.GetFiltro(): String;
begin
  Result := FsFiltro;
end;

procedure TConjunto.ExecutarSQLSelecao();
begin
  FcdsDados.Close;
  FzQuery.Close;
  FzQuery.SQL.Clear;
  FzQuery.SQL.Add(FsSQL);
  FzQuery.Open;
  FzQuery.Active := True;
  FcdsDados.Open;
end;

procedure TConjunto.ExecutarFiltrar();
begin
  FcdsDados.Filtered := False;
  FcdsDados.Filter := FsFiltro;
  FcdsDados.Filtered := True;
end;

function TConjunto.TotalRegistros(): Integer;
begin
  Result := FcdsDados.RecordCount;
end;

end.
