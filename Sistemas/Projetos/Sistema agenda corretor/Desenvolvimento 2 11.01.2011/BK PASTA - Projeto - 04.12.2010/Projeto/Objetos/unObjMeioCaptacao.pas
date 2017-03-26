unit unObjMeioCaptacao;

interface

uses
  unDM;

  type TObjMeioCaptacao = class

    private
      FnCodigo: Integer;
      FsNome: String[50];
      FsDescricao: String[200];
    public
      procedure setCodigo(pnCodigo: Integer);
      procedure setNome(psNome: String);
      procedure setDescricao(psDescricao: String);

      function getCodigo(): Integer;
      function getNome(): String;
      function getDescricao(): String;

      //limpa os dados do objeto
      procedure limparObjeto();

      //verifica se existe diferença no objeto. Quando estiver editando registro
      function verificarDiferencaCadastro(psNome:String; psDescricao:String): boolean;
  end;

implementation

uses
  unConstantes;

{ TObjMeioCaptacao }

{***** set's e get's *****}
procedure TObjMeioCaptacao.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjMeioCaptacao.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjMeioCaptacao.setNome(psNome: String);
begin
  try
    Self.FsNome := psNome;
  except
    Self.FsNome := STRING_INDEFINIDO;
  end;
end;

function TObjMeioCaptacao.getNome(): String;
begin
  Result := Self.FsNome;
end;

procedure TObjMeioCaptacao.setDescricao(psDescricao: String);
begin
  try
    Self.FsDescricao := psDescricao;
  except
    Self.FsDescricao := STRING_INDEFINIDO;
  end;
end;

function TObjMeioCaptacao.getDescricao(): String;
begin
  Result := Self.FsDescricao;
end;

{***** procedimentos diversos *****}

procedure TObjMeioCaptacao.limparObjeto();
begin
  Self.setCodigo(NUMERO_INDEFINIDO);
  Self.setNome(STRING_INDEFINIDO);
  self.setDescricao(STRING_INDEFINIDO);
end;

//verifica se existe diferença no objeto. Quando estiver editando registro
function TObjMeioCaptacao.verificarDiferencaCadastro(psNome:String; psDescricao:String): boolean;
var
  retorno: Boolean;
begin
  retorno := False;

  if (psNome <> Self.getNome) then
    retorno := True;
  if (psDescricao <> Self.getDescricao) then
    retorno := True;

  Result := retorno;
end;

end.
