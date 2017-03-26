unit unObjLog;

interface

  type TObjLog = class

    private
      FnCodigo: Integer;
      FdtDataCadastro: TDateTime;
      FnFKCodigoUsuario: Integer;
      FdtDataLogin: TDateTime;
      FdtDataLogoff: TDateTime;
    public
      constructor Create();

      procedure setCodigo(pnCodigo: Integer);
      procedure setDataCadastro(pdtDataCadastro: TDateTime);
      procedure setFKCodUsuario(pnCodigoFkUsuario: Integer);
      procedure setDataLogin(pdtDataLogin: TDateTime);
      procedure setDataLogoff(pdtDataLogoff: TDateTime);

      function getCodigo():Integer;
      function getDataCadastro(): TDateTime;
      function getFKCodUsuario(): Integer;
      function getDataLogin(): TDateTime;
      function getDataLogoff(): TDateTime;
  end;

implementation

uses
  unConstantes;

{ TObjLog }

constructor TObjLog.Create();
begin
  Self.setCodigo(NUMERO_INDEFINIDO);
  Self.setDataCadastro(NUMERO_INDEFINIDO);
  Self.setFKCodUsuario(NUMERO_INDEFINIDO);
  Self.setDataLogin(NUMERO_INDEFINIDO);
  Self.setDataLogoff(NUMERO_INDEFINIDO);
end;

{***** set's e get's *****}
procedure TObjLog.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjLog.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjLog.setDataCadastro(pdtDataCadastro: TDateTime);
begin
  try
    Self.FdtDataCadastro := pdtDataCadastro;
  except
    Self.FdtDataCadastro := NUMERO_INDEFINIDO;
  end;
end;

function TObjLog.getDataCadastro(): TDateTime;
begin
  Result := Self.FdtDataCadastro;
end;

procedure TObjLog.setFKCodUsuario(pnCodigoFkUsuario: Integer);
begin
  try
    Self.FnFKCodigoUsuario := pnCodigoFkUsuario;
  except
    Self.FnFKCodigoUsuario := NUMERO_INDEFINIDO;
  end;
end;

function TObjLog.getFKCodUsuario(): Integer;
begin
  Result := Self.FnFKCodigoUsuario;
end;

procedure TObjLog.setDataLogin(pdtDataLogin: TDateTime);
begin
  try
    Self.FdtDataLogin := pdtDataLogin;
  except
    Self.FdtDataLogin := NUMERO_INDEFINIDO;
  end;
end;

function TObjLog.getDataLogin(): TDateTime;
begin
  Result := Self.FdtDataLogin;
end;

procedure TObjLog.setDataLogoff(pdtDataLogoff: TDateTime);
begin
  try
    Self.FdtDataLogoff := pdtDataLogoff;
  except
    Self.FdtDataLogoff := NUMERO_INDEFINIDO;
  end;
end;

function TObjLog.getDataLogoff(): TDateTime;
begin
  Result := Self.FdtDataLogoff;
end;

end.
