unit unObjImovelInteresse;

interface

uses
  unDM,
  Controls; //TDate

  type TObjImovelInteresse = class

    private
      FnCodigo: Integer;
      FdtDataCadastro: TDateTime;
      FsAtivo: String[3];
      FdtDataCaptacao: TDate;
      FnFk_Cliente: Integer;
      FnFk_TipoImovel: Integer;
      FsFinalidadeImovel: String[10];
      FsImovelDesejavel: String[20];
      FdValorImovel: Double;
      FsCondicaoPagamento: String[10];
      FdPgto_Vista_Cach: Double;
      FdPgto_Vista_Valor_Bem: Double;
      FsPgto_Vista_Descricao_Bem: String; //String[500];
      FdPgto_Fincto_Cach_Financiado: Double;
      FdPgto_Fincto_Cach: Double;
      FdPgto_Fincto_Valor_Bem: Double;
      FsPgto_Fincto_Descricao_Bem: String; //String[500];
      FdRendimento: Double;
      FsObservacao: String; //String[500];
      FdtDataBaixa: TDateTime;
      FsCaracteristicas: String; //String[500];

      FsExibeCliente: String;
      FsExibeTipoImovel: String;
    public
      procedure setCodigo(pnCodigo: Integer);
      procedure setDataCadastro(pdtDataCadastro: TDateTime);
      procedure setAtivo(psAtivo: String);
      procedure setDataCaptacao(pdtDataCaptacao: TDate);
      procedure setFk_Cliente(pnFk_Cliente: Integer);
      procedure setFk_TipoImovel(pnFkTipo_Imovel: Integer);
      procedure setFinalidadeImovel(psFinalidadeImovel: String);
      procedure setImovelDesejavel(psImovelDesejavel: String);
      procedure setValorImovel(pdValorImovel: Double);
      procedure setCondicaoPagamento(psCondicaoPagamento: String);
      procedure setPgto_Vista_Cach(pdPgto_Vista_Cach: Double);
      procedure setPgto_Vista_Valor_Bem(pdPgto_Vista_Valor_Bem: Double);
      procedure setPgto_Vista_Descricao_Bem(psPgto_Vista_Descricao_Bem: String);
      procedure setPgto_Fincto_Cach_Financiado(pdPgto_Fincto_Cach_Financiado: Double);
      procedure setPgto_Fincto_Cach(pdPgto_Fincto_Cach: Double);
      procedure setPgto_Fincto_Valor_Bem(pdPgto_Fincto_Valor_Bem: Double);
      procedure setPgto_Fincto_Descricao_Bem(psPgto_Fincto_Descricao_Bem: String);
      procedure setRendimento(pdRendimento: Double);
      procedure setObservacao(psObservacao: String);
      procedure setDataBaixa(pdtDataBaixa: TDateTime);
      procedure setCaracteristicas(psCaracteristicas: String);
      procedure setExibeCliente(const pbMostrarNaoDefinido: Boolean = True);
      procedure setExibeTipoImovel(const pbMostrarNaoDefinido: Boolean = True);

      function getCodigo(): Integer;
      function getDataCadastro(): TDateTime;
      function getAtivo(): String;
      function getDataCaptacao(): TDate;
      function getFk_Cliente(): Integer;
      function getFk_TipoImovel(): Integer;
      function getFinalidadeImovel(): String;
      function getImovelDesejavel(): String;
      function getValorImovel(): Double;
      function getCondicaoPagamento(): String;
      function getPgto_Vista_Cach(): Double;
      function getPgto_Vista_Valor_Bem(): Double;
      function getPgto_Vista_Descricao_Bem(): String;
      function getPgto_Fincto_Cach_Financiado(): Double;
      function getPgto_Fincto_Cach(): Double;
      function getPgto_Fincto_Valor_Bem(): Double;
      function getPgto_Fincto_Descricao_Bem(): String;
      function getRendimento(): Double;
      function getObservacao(): String;
      function getDataBaixa(): TDateTime;
      function getCaracteristicas(): String;
      function getExibeCliente(): String;
      function getExibeTipoImovel(): String;

      //limpa os dados do objeto
      procedure limparObjeto();

      //verifica se existe diferença no objeto. Quando estiver editando registro
      function verificarDiferencaCadastro(psAtivo:String; pdtDataCaptacao:TDate;
        pnFk_Cliente:Integer; pnFkTipoImovel:Integer; psFinalidadeImovel:String;
        psImovelDesejavel:String; pdValorImovel:Double; psCondicaoPagamento:String;
        pdPgto_Vista_Cach:Double; pdPgto_Vista_Valor_Bem:Double;
        psPgto_Vista_Descricao_Bem:String;pdPgto_Fincto_Cach_Financiado:Double;
        pdPgto_Fincto_Cach:Double; pdPgto_Fincto_Valor_Bem:Double;
        psPgto_Fincto_Descricao_Bem:String; pdRendimento:Double; psObservacao:String;
        psCaracteristicas:String): Boolean;
  end;

implementation

uses
  unConstantes, Variants;

{ TObjImovelInteresse }

{***** set's e get's *****}
procedure TObjImovelInteresse.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjImovelInteresse.setDataCadastro(pdtDataCadastro: TDateTime);
begin
  try
    Self.FdtDataCadastro := pdtDataCadastro;
  except
    Self.FdtDataCadastro := NUMERO_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getDataCadastro: TDateTime;
begin
  Result := Self.FdtDataCadastro;
end;

procedure TObjImovelInteresse.setAtivo(psAtivo: String);
begin
  try
    Self.FsAtivo := psAtivo;
  except
    Self.FsAtivo := STRING_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getAtivo: String;
begin
  Result := Self.FsAtivo;
end;

procedure TObjImovelInteresse.setDataCaptacao(pdtDataCaptacao: TDate);
begin
  try
    Self.FdtDataCaptacao := pdtDataCaptacao;
  except
    Self.FdtDataCaptacao := NUMERO_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getDataCaptacao: TDate;
begin
  Result := Self.FdtDataCaptacao;
end;

procedure TObjImovelInteresse.setFk_Cliente(pnFk_Cliente: Integer);
begin
  try
    Self.FnFk_Cliente := pnFk_Cliente;
  except
    Self.FnFk_Cliente := NUMERO_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getFk_Cliente: Integer;
begin
  Result := Self.FnFk_Cliente;
end;

procedure TObjImovelInteresse.setFk_TipoImovel(pnFkTipo_Imovel: Integer);
begin
  try
    Self.FnFk_TipoImovel := pnFkTipo_Imovel;
  except
    Self.FnFk_TipoImovel := NUMERO_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getFk_TipoImovel: Integer;
begin
  Result := Self.FnFk_TipoImovel;
end;

procedure TObjImovelInteresse.setFinalidadeImovel(psFinalidadeImovel: String);
begin
  try
    Self.FsFinalidadeImovel := psFinalidadeImovel;
  except
    Self.FsFinalidadeImovel := STRING_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getFinalidadeImovel: String;
begin
  Result := Self.FsFinalidadeImovel;
end;

procedure TObjImovelInteresse.setImovelDesejavel(psImovelDesejavel: String);
begin
  try
    Self.FsImovelDesejavel := psImovelDesejavel;
  except
    Self.FsImovelDesejavel := STRING_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getImovelDesejavel: String;
begin
  Result := Self.FsImovelDesejavel;
end;

procedure TObjImovelInteresse.setValorImovel(pdValorImovel: Double);
begin
  try
    Self.FdValorImovel := pdValorImovel;
  except
    Self.FdValorImovel := NUMERO_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getValorImovel: Double;
begin
  Result := Self.FdValorImovel;
end;

procedure TObjImovelInteresse.setCondicaoPagamento(psCondicaoPagamento: String);
begin
  try
    Self.FsCondicaoPagamento := psCondicaoPagamento;
  except
    Self.FsCondicaoPagamento := STRING_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getCondicaoPagamento: String;
begin
  Result := Self.FsCondicaoPagamento;
end;

procedure TObjImovelInteresse.setPgto_Vista_Cach(pdPgto_Vista_Cach: Double);
begin
  try
    Self.FdPgto_Vista_Cach := pdPgto_Vista_Cach;
  except
    Self.FdPgto_Vista_Cach := NUMERO_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getPgto_Vista_Cach(): Double;
begin
  Result := Self.FdPgto_Vista_Cach;
end;

procedure TObjImovelInteresse.setPgto_Vista_Valor_Bem(pdPgto_Vista_Valor_Bem: Double);
begin
  try
    Self.FdPgto_Vista_Valor_Bem := pdPgto_Vista_Valor_Bem;
  except
    Self.FdPgto_Vista_Valor_Bem := NUMERO_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getPgto_Vista_Valor_Bem(): Double;
begin
  Result := Self.FdPgto_Vista_Valor_Bem;
end;

procedure TObjImovelInteresse.setPgto_Vista_Descricao_Bem(psPgto_Vista_Descricao_Bem: String);
begin
  try
    Self.FsPgto_Vista_Descricao_Bem := psPgto_Vista_Descricao_Bem;
  except
    Self.FsPgto_Vista_Descricao_Bem := STRING_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getPgto_Vista_Descricao_Bem(): String;
begin
  Result := Self.FsPgto_Vista_Descricao_Bem;
end;

procedure TObjImovelInteresse.setPgto_Fincto_Cach_Financiado(pdPgto_Fincto_Cach_Financiado: Double);
begin
  try
    Self.FdPgto_Fincto_Cach_Financiado := pdPgto_Fincto_Cach_Financiado;
  except
    Self.FdPgto_Fincto_Cach_Financiado := NUMERO_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getPgto_Fincto_Cach_Financiado(): Double;
begin
  Result := Self.FdPgto_Fincto_Cach_Financiado;
end;

procedure TObjImovelInteresse.setPgto_Fincto_Cach(pdPgto_Fincto_Cach: Double);
begin
  try
    Self.FdPgto_Fincto_Cach := pdPgto_Fincto_Cach;
  except
    Self.FdPgto_Fincto_Cach := NUMERO_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getPgto_Fincto_Cach(): Double;
begin
  Result := Self.FdPgto_Fincto_Cach;
end;

procedure TObjImovelInteresse.setPgto_Fincto_Valor_Bem(pdPgto_Fincto_Valor_Bem: Double);
begin
  try
    Self.FdPgto_Fincto_Valor_Bem := pdPgto_Fincto_Valor_Bem;
  except
    Self.FdPgto_Fincto_Valor_Bem := NUMERO_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getPgto_Fincto_Valor_Bem(): Double;
begin
  Result := Self.FdPgto_Fincto_Valor_Bem;
end;

procedure TObjImovelInteresse.setPgto_Fincto_Descricao_Bem(psPgto_Fincto_Descricao_Bem: String);
begin
  try
    Self.FsPgto_Fincto_Descricao_Bem := psPgto_Fincto_Descricao_Bem;
  except
    Self.FsPgto_Fincto_Descricao_Bem := STRING_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getPgto_Fincto_Descricao_Bem(): String;
begin
  Result := Self.FsPgto_Fincto_Descricao_Bem;
end;

procedure TObjImovelInteresse.setRendimento(pdRendimento: Double);
begin
  try
    Self.FdRendimento := pdRendimento;
  except
    Self.FdRendimento := NUMERO_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getRendimento(): Double;
begin
  Result := Self.FdRendimento;
end;

procedure TObjImovelInteresse.setObservacao(psObservacao: String);
begin
  try
    Self.FsObservacao := psObservacao;
  except
    Self.FsObservacao := STRING_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getObservacao(): String;
begin
  Result := Self.FsObservacao;
end;

procedure TObjImovelInteresse.setDataBaixa(pdtDataBaixa: TDateTime);
begin
  try
    Self.FdtDataBaixa := pdtDataBaixa;
  except
    Self.FdtDataBaixa := NUMERO_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getDataBaixa(): TDateTime;
begin
  Result := Self.FdtDataBaixa;
end;

procedure TObjImovelInteresse.setCaracteristicas(psCaracteristicas: String);
begin
  try
    Self.FsCaracteristicas := psCaracteristicas;
  except
    Self.FsCaracteristicas := STRING_INDEFINIDO;
  end;
end;

function TObjImovelInteresse.getCaracteristicas(): String;
begin
  Result := Self.FsCaracteristicas;
end;

procedure TObjImovelInteresse.setExibeCliente(const pbMostrarNaoDefinido: Boolean = True);
begin
  Self.FsExibeCliente := STRING_INDEFINIDO;

  if(not(pbMostrarNaoDefinido) and (Self.FnFk_Cliente =REGISTRO_NULO))then
    Self.FsExibeCliente := STRING_INDEFINIDO

  else
  begin
    if(Self.FnFk_Cliente <> NUMERO_INDEFINIDO)then
    begin
      DM.zQryCliente.Close;
      DM.zQryCliente.SQL.Clear;
      DM.zQryCliente.SQL.Add('SELECT * FROM cliente WHERE codigo=:cod');
      DM.zQryCliente.ParamByName('cod').AsInteger := Self.FnFk_Cliente;
      DM.zQryCliente.Open;
      if(DM.zQryCliente.RecordCount = 1)then
        Self.FsExibeCliente := DM.zQryClienteNOME.AsString;
    end;
  end;
end;

function TObjImovelInteresse.getExibeCliente(): String;
begin
  Result := Self.FsExibeCliente;
end;

procedure TObjImovelInteresse.setExibeTipoImovel(const pbMostrarNaoDefinido: Boolean = True);
begin
  Self.FsExibeTipoImovel := STRING_INDEFINIDO;

  if(not(pbMostrarNaoDefinido) and (Self.FnFk_TipoImovel =REGISTRO_NULO))then
    Self.FsExibeTipoImovel := STRING_INDEFINIDO

  else
  begin
    if(Self.FnFk_TipoImovel <> NUMERO_INDEFINIDO)then
    begin
      DM.zQryTipoImovel.Close;
      DM.zQryTipoImovel.SQL.Clear;
      DM.zQryTipoImovel.SQL.Add('SELECT * FROM tipo_imovel WHERE codigo=:cod');
      DM.zQryTipoImovel.ParamByName('cod').AsInteger := Self.FnFk_TipoImovel;
      DM.zQryTipoImovel.Open;
      if(DM.zQryTipoImovel.RecordCount = 1)then
        Self.FsExibeTipoImovel := DM.zQryTipoImovelNOME.AsString;
    end;
  end;
end;

function TObjImovelInteresse.getExibeTipoImovel(): String;
begin
  Result := Self.FsExibeCliente;
end;

{***** procedimentos diversos *****}

//limpa os dados do objeto
procedure TObjImovelInteresse.limparObjeto();
begin
    Self.setCodigo(NUMERO_INDEFINIDO);
    Self.setDataCadastro(NUMERO_INDEFINIDO);
    Self.setAtivo(STRING_INDEFINIDO);
    Self.setDataCaptacao(NUMERO_INDEFINIDO);
    Self.setFk_Cliente(NUMERO_INDEFINIDO);
    Self.setFk_TipoImovel(NUMERO_INDEFINIDO);
    Self.setFinalidadeImovel(STRING_INDEFINIDO);
    Self.setImovelDesejavel(STRING_INDEFINIDO);
    Self.setValorImovel(NUMERO_INDEFINIDO);
    Self.setCondicaoPagamento(STRING_INDEFINIDO);
    Self.setPgto_Vista_Cach(NUMERO_INDEFINIDO);
    Self.setPgto_Vista_Valor_Bem(NUMERO_INDEFINIDO);
    Self.setPgto_Vista_Descricao_Bem(STRING_INDEFINIDO);
    Self.setPgto_Fincto_Cach_Financiado(NUMERO_INDEFINIDO);
    Self.setPgto_Fincto_Cach(NUMERO_INDEFINIDO);
    Self.setPgto_Fincto_Valor_Bem(NUMERO_INDEFINIDO);
    Self.setPgto_Fincto_Descricao_Bem(STRING_INDEFINIDO);
    Self.setRendimento(NUMERO_INDEFINIDO);
    Self.setObservacao(STRING_INDEFINIDO);
    Self.setDataBaixa(NUMERO_INDEFINIDO);
    Self.setCaracteristicas(STRING_INDEFINIDO);
    Self.setExibeCliente();
    Self.setExibeTipoImovel();
end;

//verifica se existe diferença no objeto. Quando estiver editando registro
function TObjImovelInteresse.verificarDiferencaCadastro(psAtivo:String;
  pdtDataCaptacao:TDate;pnFk_Cliente:Integer; pnFkTipoImovel:Integer;
  psFinalidadeImovel:String; psImovelDesejavel:String; pdValorImovel:Double;
  psCondicaoPagamento:String; pdPgto_Vista_Cach:Double;
  pdPgto_Vista_Valor_Bem:Double; psPgto_Vista_Descricao_Bem:String;
  pdPgto_Fincto_Cach_Financiado:Double; pdPgto_Fincto_Cach:Double;
  pdPgto_Fincto_Valor_Bem:Double; psPgto_Fincto_Descricao_Bem:String;
  pdRendimento:Double; psObservacao:String; psCaracteristicas:String): Boolean;
var
  retorno: Boolean;
begin
  retorno := False;

  if (psAtivo <> Self.getAtivo) then
    retorno := True;
  if(pdtDataCaptacao <> Self.getDataCadastro)then
    retorno := True;
  if(pnFk_Cliente <> Self.getFk_Cliente)then
    retorno := True;
  if(pnFkTipoImovel <> Self.getFk_TipoImovel)then
    retorno := True;
  if(psFinalidadeImovel <> Self.getFinalidadeImovel)then
    retorno := True;
  if(psImovelDesejavel <> Self.getImovelDesejavel)then
    retorno := True;
  if(pdValorImovel <> Self.getValorImovel)then
    retorno := True;
  if(psCondicaoPagamento <> Self.getCondicaoPagamento)then
    retorno := True;
  if(pdPgto_Vista_Cach <> Self.getPgto_Vista_Cach)then
    retorno := True;
  if(pdPgto_Vista_Valor_Bem <> Self.getPgto_Vista_Valor_Bem)then
    retorno := True;
  if(psPgto_Vista_Descricao_Bem <> Self.getPgto_Vista_Descricao_Bem)then
    retorno := True;
  if(pdPgto_Fincto_Cach_Financiado <> Self.getPgto_Fincto_Cach_Financiado)then
    retorno := True;
  if(pdPgto_Fincto_Cach <> Self.getPgto_Fincto_Cach)then
    retorno := True;
  if(pdPgto_Fincto_Valor_Bem <> Self.getPgto_Fincto_Valor_Bem)then
    retorno := True;
  if(psPgto_Fincto_Descricao_Bem <> Self.getPgto_Fincto_Descricao_Bem)then
    retorno := True;
  if(pdRendimento <> Self.getRendimento)then
    retorno := True;
  if(psObservacao <> Self.getObservacao)then
    retorno := True;
  if(psCaracteristicas <> Self.getCaracteristicas)then
    retorno := True;

  Result := retorno;
end;

end.
