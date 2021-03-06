unit unOrcamento;

interface

uses
  ZConnection, ZDataset, Provider, DBClient, Controls, unFuncoes, unConstantes;

  type TOrcamento = class
    private
      nCodigo: Integer;
      nCodCliente: Integer;
      dDataCadastro: TDateTime;
      nStatus: Integer;
      sArquivo: string;
      nValorEstimado: Double;

      FoFuncoes: TFuncoes;
      function VerificarOrcamentoExisteAntesSalvar(const pbCodigoNaoValida: boolean = False): Boolean;
      function VerificarOrcamentoPodeSerDeletado: Boolean;
    public
      procedure SetCodigo(psCodigo: Integer);
      procedure SetCodigoCliente(psCodigoCliente: Integer);
      procedure SetDataCadastro(psDataCadastro: string);
      procedure SetStatus(pnStatus: integer);
      procedure SetArquivo(psArquivo: string);
      procedure SetValorEstimado(nValorEstimado: double);

      function GetCodigo: Integer;
      function GetCodigoCliente: Integer;
      function GetDataCadastroAsDate: TDate;
      function GetDataCadastroAsDateTime: TDateTime;
      function GetDataCadastroAsString(const pbRetornaDateTime: Boolean = True): string;
      function GetStatus: integer;
      function GetArquivo: string;
      function GetValorEstimado: double;

      constructor CriarOrcamento;

      procedure Limpar;
      function Salvar(pnTipo: integer): Boolean;
      function Deletar: Boolean;
      procedure CarregarOrcamento(const pnCodigo: Integer = NUMERO_INDEFINIDO);
      function CarregarOrcamentosDoCliente(const pnCodigoCliente: Integer): Boolean;
    public

  end;

implementation

uses
  unDM, Classes, Dialogs, SysUtils, Variants;

procedure TOrcamento.SetCodigo(psCodigo: Integer);
begin
  Self.nCodigo := psCodigo;
end;

procedure TOrcamento.SetCodigoCliente(psCodigoCliente: Integer);
begin
  Self.nCodCliente := psCodigoCliente;
end;

procedure TOrcamento.SetDataCadastro(psDataCadastro: string);
begin
  if (not (FoFuncoes.validarDataHora(psDataCadastro))) or (psDataCadastro = sDATA_INVALIDA) then
    Self.dDataCadastro := 0
  else
    Self.dDataCadastro := StrToDateTime(psDataCadastro);
end;

procedure TOrcamento.SetStatus(pnStatus: integer);
begin
  Self.nStatus := pnStatus;
end;

procedure TOrcamento.SetArquivo(psArquivo: string);
begin
  Self.sArquivo := psArquivo;
end;

procedure TOrcamento.SetValorEstimado(nValorEstimado: double);
begin
  Self.nValorEstimado := nValorEstimado;
end;

function TOrcamento.GetCodigo: Integer;
begin
  Result := Self.nCodigo;
end;

function TOrcamento.GetCodigoCliente: Integer;
begin
  Result := Self.nCodCliente;
end;

function TOrcamento.GetDataCadastroAsDate: TDate;
begin
  Result := Self.dDataCadastro;
end;

function TOrcamento.GetDataCadastroAsDateTime: TDateTime;
begin
  Result := Self.dDataCadastro;
end;

function TOrcamento.GetDataCadastroAsString(const pbRetornaDateTime: Boolean): string;
begin
  //na teoria sempre vai ter um valor v�lido para o campo 'data'.
  if pbRetornaDateTime then
    Result := DateTimeToStr(Self.dDataCadastro)
  else
    Result := DateToStr(Self.dDataCadastro);
end;

function TOrcamento.GetStatus: integer;
begin
  Result := Self.nStatus;
end;

function TOrcamento.GetArquivo: string;
begin
  Result := Self.sArquivo;
end;

function TOrcamento.GetValorEstimado: double;
begin
  Result := Self.nValorEstimado;
end;


constructor TOrcamento.CriarOrcamento;
begin
  inherited;
  Self.Limpar;
end;

function TOrcamento.VerificarOrcamentoExisteAntesSalvar(const pbCodigoNaoValida: boolean = False): Boolean;

  procedure AdicionarCondicaoCodigoNaoValida;
  begin
    if pbCodigoNaoValida then
    begin
      //caso estiver editando, n�o validar o c�digo do or�amento atual, fazer a valida��o somente com os demais.
      DM.zQryExiste.SQL.Add(' AND codigo <> :codigo');
      DM.zQryExiste.ParamByName('codigo').AsInteger := Self.GetCodigo;
    end;
  end;

begin
  Result := True;
end;

function TOrcamento.VerificarOrcamentoPodeSerDeletado: Boolean;
begin
  //xxxxxxxxxxxxxxxxxxxx
  Result := True;
end;

procedure TOrcamento.Limpar;
begin
  SetCodigo(NUMERO_INDEFINIDO);
  SetCodigoCliente(NUMERO_INDEFINIDO);
  SetDataCadastro(STRING_INDEFINIDO);
  SetStatus(NUMERO_INDEFINIDO);
  SetArquivo(STRING_INDEFINIDO);
  SetValorEstimado(NUMERO_INDEFINIDO);
end;

function TOrcamento.Salvar(pnTipo: integer): Boolean;

  function GerarInsertOuUpdate: boolean;
  begin
    Result := False;
    if (pnTipo = nOPERACAO_NOVO) then
    begin

      Result := True;
    end

    else if (pnTipo = nOPERACAO_EDITAR) then
    begin

      Result := True;
    end
  end;

begin
  Result := False;
  if not VerificarOrcamentoExisteAntesSalvar(pnTipo = nOPERACAO_EDITAR) then
    Abort;

  try

  except

  end;
end;

function TOrcamento.Deletar: Boolean;
begin
  Result := False;

  if not VerificarOrcamentoPodeSerDeletado then
    Abort;

  try

    Result := True;
  except

  end;
end;

//se pnCodigo = NUMERO_INDEFINIDO, vai carregar o �ltimo or�amento (parte do
//princ�pio que est� sendo realizado um INSERT no �ltimo registro), caso contr�rio,
//carrega o or�amento contido no c�digo pnCodigo.
procedure TOrcamento.CarregarOrcamento(const pnCodigo: Integer = NUMERO_INDEFINIDO);

  procedure SetarDados;
  begin
    if (DM.cdsOrcamento.IsEmpty) then
      Limpar
    else if (DM.cdsOrcamento.RecordCount = 1) then
    begin
      SetCodigo(DM.cdsOrcamento.FieldByName('codigo').AsInteger);
      SetCodigoCliente(DM.cdsOrcamento.FieldByName('cod_cliente').AsInteger);      
      SetDataCadastro(DM.cdsOrcamento.FieldByName('data_cadastro').AsString);
      SetStatus(DM.cdsOrcamento.FieldByName('status').AsInteger);
      SetArquivo(DM.cdsOrcamento.FieldByName('arquivo').AsString);
      SetValorEstimado(DM.cdsOrcamento.FieldByName('valor_estimado').AsCurrency);
    end;
  end;

begin
  //foi realizado um INSERT
  if (pnCodigo = NUMERO_INDEFINIDO) then
  begin
    DM.cdsOrcamento.Close;
    DM.zQryOrcamento.Close;
    DM.zQryOrcamento.SQL.Clear;
    DM.zQryOrcamento.SQL.Add('SELECT FIRST 1 * FROM orcamento ORDER BY codigo DESC');
    DM.zQryOrcamento.Open;
    DM.zQryOrcamento.Open;
  end
  //foi realizado um UPDATE
  else
  begin
    DM.cdsOrcamento.Close;
    DM.zQryOrcamento.Close;
    DM.zQryOrcamento.SQL.Clear;
    DM.zQryOrcamento.SQL.Add('SELECT * FROM orcamento WHERE codigo = :codigo ORDER BY codigo DESC');
    DM.zQryOrcamento.ParamByName('codigo').AsInteger := pnCodigo;
    DM.zQryOrcamento.Open;
    DM.cdsOrcamento.Open;
  end;

  SetarDados;
end;

function TOrcamento.CarregarOrcamentosDoCliente(const pnCodigoCliente: Integer): Boolean;

  procedure SetarDados;
  begin
    if (DM.cdsOrcamento.IsEmpty) then
      Limpar
    else if (DM.cdsOrcamento.RecordCount > 1) then
    begin
      SetCodigo(DM.cdsOrcamento.FieldByName('codigo').AsInteger);
      SetCodigoCliente(DM.cdsOrcamento.FieldByName('cod_cliente').AsInteger);
      SetDataCadastro(DM.cdsOrcamento.FieldByName('data_cadastro').AsString);
      SetStatus(DM.cdsOrcamento.FieldByName('status').AsInteger);
      SetArquivo(DM.cdsOrcamento.FieldByName('arquivo').AsString);
      SetValorEstimado(DM.cdsOrcamento.FieldByName('valor_estimado').AsCurrency);
    end;
  end;

begin
  Result := False;
  try
    DM.cdsOrcamento.Close;
    DM.zQryOrcamento.Close;
    DM.zQryOrcamento.SQL.Clear;
    DM.zQryOrcamento.SQL.Add('SELECT * FROM orcamento WHERE cod_cliente = :cod_cliente  ORDER BY data_cadastro DESC');
    DM.zQryOrcamento.Open;
    DM.cdsOrcamento.Open;

    Result := not DM.cdsOrcamento.IsEmpty;

    SetarDados;
  finally
  end;
end;

end.
