unit unObjAgenciamento;

interface

uses
  unDM,
  Controls; //TDate

  type TObjAgenciamento = class

    private
      FnCodigo: Integer;
      FdDataCadastro: TDateTime;
      FdDataAgenciamento: TDate;
      FsAtivo: String[3];
      FsNormal: String[5];
      FsStandBy: String[5];
      FsTipoPessoa: String[8];
      FnFk_Pessoa_Fisica: Integer;
      FnFk_Pessoa_Juridica: Integer;
      FnFk_Imovel: Integer;
      FnFk_MeioCaptacao: Integer;
      //FsMeioCaptacao: String[20];
      FsCondicaoPagamento: String[20];
      FdValorTotal: Double;
      FdPgto_Vista_Cach: Double;
      FdPgto_Vista_Valor_Bem: Double;
      FsPgto_Vista_Descricao_Bem: String; //String[500];
      FdPgto_Fincto_Cach_Financiado: Double;
      FdPgto_Fincto_Cach: Double;
      FdPgto_Fincto_Valor_Bem: Double;
      FsPgto_Fincto_Descricao_Bem: String; //String[500];
      FsObservacao: String; //String[500];
      FdPrazo_Autorizacao: TDate;
      FdData_Reagenciamento: TDate;
      FdData_Baixa: TDate;
      FsExibePessoaFisica: String;
      FsExibePessoaJuridica: String;
      FsExibeImovel: String;

      //copiado da unit unFuncoes
      function formatarValorMonetario(psValor:String): String;
    public
      procedure setCodigo(pnCodigo: Integer);
      procedure setDataCadastro(pdDataCadastro: TDateTime);
      procedure setDataAgenciamento(pdDataAgenciamento: TDate);
      procedure setAtivo(psAtivo: String);
      procedure setNormal(psNormal: String);
      procedure setStandBy(psStandBy: String);
      procedure setTipoPessoa(psTipoPessoa: String);
      procedure setFk_Pessoa_Fisica(piFk_Pessoa_Fisica: Integer);
      procedure setFk_Pessoa_Juridica(piFk_Pessoa_Juridica: Integer);
      procedure setFk_Imovel(piFk_Imovel: Integer);
      //procedure setMeioCaptacao(psMeioCaptacao: String);
      procedure setFk_MeioCaptacao(piFk_MeioCaptacao: Integer);
      procedure setCondicaoPagamento(psCondicaoPagamento: String);
      procedure setValorTotal(pdValorTotal: Double);
      procedure setPgto_Vista_Cach(pdPgto_Vista_Cach: Double);
      procedure setPgto_Vista_Valor_Bem(pdPgto_Vista_Valor_Bem: Double);
      procedure setPgto_Vista_Descricao_Bem(psPgto_Vista_Descricao_Bem: String);
      procedure setPgto_Fincto_Cach_Financiado(pdPgto_Fincto_Cach_Financiado: Double);
      procedure setPgto_Fincto_Cach(pdPgto_Fincto_Cach: Double);
      procedure setPgto_Fincto_Valor_Bem(pdPgto_Fincto_Valor_Bem: Double);
      procedure setPgto_Fincto_Descricao_Bem(psPgto_Fincto_Descricao_Bem: String);
      procedure setObservacao(psObservacao: String);
      procedure setPrazo_Autorizacao(pdPrazo_Autorizacao: TDate);
      procedure setData_Reagenciamento(pdData_Reagenciamento: TDate);
      procedure setData_Baixa(pdData_Baixa: TDate);
      procedure setExibePessoaFisica();
      procedure setExibePessoaJuridica();
      procedure setExibeImovel();

      function getCodigo(): Integer;
      function getDataCadastro(): TDateTime;
      function getDataAgenciamento(): TDate;
      function getAtivo(): String;
      function getNormal(): String;
      function getStandBy(): String;
      function getTipoPessoa(): String;
      function getFk_Pessoa_Fisica(): Integer;
      function getFk_Pessoa_Juridica(): Integer;
      function getFk_Imovel(): Integer;
      //function getMeioCaptacao(): String;
      function getFk_MeioCaptacao(): Integer;
      function getCondicaoPagamento(): String;
      function getValorTotal(): Double;
      function getPgto_Vista_Cach(): Double;
      function getPgto_Vista_Valor_Bem(): Double;
      function getPgto_Vista_Descricao_Bem(): String;
      function getPgto_Fincto_Cach_Financiado(): Double;
      function getPgto_Fincto_Cach(): Double;
      function getPgto_Fincto_Valor_Bem(): Double;
      function getPgto_Fincto_Descricao_Bem(): String;
      function getObservacao(): String;
      function getPrazo_Autorizacao(): TDate;
      function getData_Reagenciamento(): TDate;
      function getData_Baixa(): TDate;
      function getExibePessoaFisica(): String;
      function getExibePessoaJuridica(): String;
      function getExibeImovel(): String;

      //limpa os dados do objeto
      procedure limparObjeto();

      //verifica se existe diferença no objeto. Quando estiver editando registro
      function verificarDiferencaCadastro(psAtivo:String; psNormal:String;
        psStandBy:String; psTipoPessoa:String; pnFk_Pessoa_Fisica:Integer;
        pnFk_Pessoa_Juridica:Integer; pnFk_Imovel:Integer; pnFk_MeioCaptacao:Integer; //psMeioCaptacao:String;
        psCondicaoPagamento:String; pdValorTotal:Double; pdPgto_Vista_Cach:Double;
        pdPgto_Vista_Valor_Bem:Double; psPgto_Vista_Descricao_Bem:String;
        pdPgto_Fincto_Cach_Financiado:Double; pdPgto_Fincto_Cach:Double;
        pdPgto_Fincto_Valor_Bem:Double; psPgto_Fincto_Descricao_Bem:String;
        psObservacao:String; pdPrazo_Autorizacao:TDate;
        pdData_Reagenciamento:TDate): Boolean;
  end;

implementation

uses
  unConstantes, Variants, SysUtils;

{ TObjAgenciamento }

//copiado da unit unFuncoes
function TObjAgenciamento.formatarValorMonetario(psValor:String): String;
var
  i, x: Integer;
  nQtdeCarac: Integer; //quatidade de caracteres do texto
  nQtdeCaracNumeroInteiro: Integer; ////quatidade de caracteres da parte inteira
  cCaracterAtual: Char; //caracter atual, que o loop está passando
  nCentena: Integer; //se  achou a centena, que o ponto irá separar
  sTexto: string; //texto a formatar
  sTextoParteDecimal: string; //texto a formatar - somente parte decimal
  sParteInteira: string; //parte inteira do número
  sParteDecimal: string; //parte decimal do número
  sRetorno: string; //retorno do método
  sUnidade: string; //cada número retornado no loop (sem ou com ponto)     
begin
  //inicializa variáveis
  if(Trim(psValor)<>'')then
  begin
    sTexto := StringReplace (psValor, '.', '', [rfReplaceAll, rfIgnoreCase]);

    sTextoParteDecimal := '';
    sParteInteira := '';
    sParteDecimal := '';
    sRetorno := '';
    nQtdeCarac := length(sTexto);
    nCentena := 0;
    nQtdeCaracNumeroInteiro := 0;

    //conta caracteres na parte inteira
    for i:=1 to nQtdeCarac do
    begin
      if(sTexto[i]<>',')then
        inc(nQtdeCaracNumeroInteiro)
      else
      begin
        for x:=i+1 to nQtdeCarac do
          sTextoParteDecimal := sTextoParteDecimal + sTexto[x];
        break;
      end;
    end;

    //formata parte inteira do número
    for i:=nQtdeCaracNumeroInteiro downto 1 do
    begin
      cCaracterAtual := sTexto[i];
      inc(nCentena);
      if((nCentena=3)and(i<>1))then
      begin
        sUnidade := '.' + cCaracterAtual;
        nCentena := 0;
      end
      else
        sUnidade := cCaracterAtual;

      sParteInteira := sUnidade + sParteInteira;
    end;

    //formata parte inteira do número
    if(Length(sTextoParteDecimal)<=0)then
      sParteDecimal := '00'
    else if(Length(sTextoParteDecimal)=1)then
      sParteDecimal := sTextoParteDecimal + '0'
    else
      sParteDecimal := Copy(sTextoParteDecimal,1,2);

    //número formatado
    if(sParteInteira = '')then
      sParteInteira := '00';
    sRetorno := sParteInteira + ',' + sParteDecimal;

    Result := sRetorno;
  end;
end;

{***** set's e get's *****}
procedure TObjAgenciamento.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjAgenciamento.setDataCadastro(pdDataCadastro: TDateTime);
begin
  try
    Self.FdDataCadastro := pdDataCadastro;
  except
    Self.FdDataCadastro := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getDataCadastro(): TDateTime;
begin
  Result := Self.FdDataCadastro;
end;

procedure TObjAgenciamento.setDataAgenciamento(pdDataAgenciamento: TDate);
begin
  try
    Self.FdDataAgenciamento := pdDataAgenciamento;
  except
    Self.FdDataAgenciamento := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getDataAgenciamento(): TDate;
begin
  Result := Self.FdDataAgenciamento;
end;

procedure TObjAgenciamento.setAtivo(psAtivo: String);
begin
  try
    Self.FsAtivo := psAtivo;
  except
    Self.FsAtivo := STRING_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getAtivo(): String;
begin
  Result := Self.FsAtivo;
end;

procedure TObjAgenciamento.setNormal(psNormal: String);
begin
  try
    Self.FsNormal := psNormal;
  except
    Self.FsNormal := STRING_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getNormal(): String;
begin
  Result := Self.FsNormal;
end;

procedure TObjAgenciamento.setStandBy(psStandBy: String);
begin
  try
    Self.FsStandBy := psStandBy;
  except
    Self.FsStandBy := STRING_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getStandBy(): String;
begin
  Result := Self.FsStandBy;
end;

procedure TObjAgenciamento.setTipoPessoa(psTipoPessoa: String);
begin
  try
    Self.FsTipoPessoa := psTipoPessoa;
  except
    Self.FsTipoPessoa := STRING_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getTipoPessoa(): String;
begin
  Result := Self.FsTipoPessoa;
end;

procedure TObjAgenciamento.setFk_Pessoa_Fisica(piFk_Pessoa_Fisica: Integer);
begin
  try
    Self.FnFk_Pessoa_Fisica := piFk_Pessoa_Fisica;
  except
    Self.FnFk_Pessoa_Fisica := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getFk_Pessoa_Fisica(): Integer;
begin
  Result := Self.FnFk_Pessoa_Fisica;
end;

procedure TObjAgenciamento.setFk_Pessoa_Juridica(piFk_Pessoa_Juridica: Integer);
begin
  try
    Self.FnFk_Pessoa_Juridica := piFk_Pessoa_Juridica;
  except
    Self.FnFk_Pessoa_Juridica := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getFk_Pessoa_Juridica(): Integer;
begin
  Result := Self.FnFk_Pessoa_Juridica;
end;

procedure TObjAgenciamento.setFk_Imovel(piFk_Imovel: Integer);
begin
  try
    Self.FnFk_Imovel := piFk_Imovel;
  except
    Self.FnFk_Imovel := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getFk_Imovel(): Integer;
begin
  Result := Self.FnFk_Imovel;
end;

(*
procedure TObjAgenciamento.setMeioCaptacao(psMeioCaptacao: String);
begin
  try
    Self.FsMeioCaptacao := psMeioCaptacao;
  except
    Self.FsMeioCaptacao := STRING_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getMeioCaptacao(): String;
begin
  Result := Self.FsMeioCaptacao;
end;
*)

procedure TObjAgenciamento.setFk_MeioCaptacao(piFk_MeioCaptacao: Integer);
begin
  try
    Self.FnFk_MeioCaptacao := piFk_MeioCaptacao;
  except
    Self.FnFk_MeioCaptacao := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getFk_MeioCaptacao(): Integer;
begin
  Result := Self.FnFk_MeioCaptacao;
end;

procedure TObjAgenciamento.setCondicaoPagamento(psCondicaoPagamento: String);
begin
  try
    Self.FsCondicaoPagamento := psCondicaoPagamento;
  except
    Self.FsCondicaoPagamento := STRING_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getCondicaoPagamento(): String;
begin
  Result := Self.FsCondicaoPagamento;
end;

procedure TObjAgenciamento.setValorTotal(pdValorTotal: Double);
begin
  try
    Self.FdValorTotal := pdValorTotal;
  except
    Self.FdValorTotal := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getValorTotal(): Double;
begin
  Result := Self.FdValorTotal;
end;

procedure TObjAgenciamento.setPgto_Vista_Cach(pdPgto_Vista_Cach: Double);
begin
  try
    Self.FdPgto_Vista_Cach := pdPgto_Vista_Cach;
  except
    Self.FdPgto_Vista_Cach := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getPgto_Vista_Cach(): Double;
begin
  Result := Self.FdPgto_Vista_Cach;
end;

procedure TObjAgenciamento.setPgto_Vista_Valor_Bem(pdPgto_Vista_Valor_Bem: Double);
begin
  try
    Self.FdPgto_Vista_Valor_Bem := pdPgto_Vista_Valor_Bem;
  except
    Self.FdPgto_Vista_Valor_Bem := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getPgto_Vista_Valor_Bem(): Double;
begin
  Result := Self.FdPgto_Vista_Valor_Bem;
end;

procedure TObjAgenciamento.setPgto_Vista_Descricao_Bem(psPgto_Vista_Descricao_Bem: String);
begin
  try
    Self.FsPgto_Vista_Descricao_Bem := psPgto_Vista_Descricao_Bem;
  except
    Self.FsPgto_Vista_Descricao_Bem := STRING_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getPgto_Vista_Descricao_Bem(): String;
begin
  Result := Self.FsPgto_Vista_Descricao_Bem;
end;

procedure TObjAgenciamento.setPgto_Fincto_Cach_Financiado(pdPgto_Fincto_Cach_Financiado: Double);
begin
  try
    Self.FdPgto_Fincto_Cach_Financiado := pdPgto_Fincto_Cach_Financiado;
  except
    Self.FdPgto_Fincto_Cach_Financiado := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getPgto_Fincto_Cach_Financiado(): Double;
begin
  Result := Self.FdPgto_Fincto_Cach_Financiado;
end;

procedure TObjAgenciamento.setPgto_Fincto_Cach(pdPgto_Fincto_Cach: Double);
begin
  try
    Self.FdPgto_Fincto_Cach := pdPgto_Fincto_Cach;
  except
    Self.FdPgto_Fincto_Cach := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getPgto_Fincto_Cach(): Double;
begin
  Result := Self.FdPgto_Fincto_Cach;
end;

procedure TObjAgenciamento.setPgto_Fincto_Valor_Bem(pdPgto_Fincto_Valor_Bem: Double);
begin
  try
    Self.FdPgto_Fincto_Valor_Bem := pdPgto_Fincto_Valor_Bem;
  except
    Self.FdPgto_Fincto_Valor_Bem := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getPgto_Fincto_Valor_Bem(): Double;
begin
  Result := Self.FdPgto_Fincto_Valor_Bem;
end;

procedure TObjAgenciamento.setPgto_Fincto_Descricao_Bem(psPgto_Fincto_Descricao_Bem: String);
begin
  try
    Self.FsPgto_Fincto_Descricao_Bem := psPgto_Fincto_Descricao_Bem;
  except
    Self.FsPgto_Fincto_Descricao_Bem := STRING_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getPgto_Fincto_Descricao_Bem(): String;
begin
  Result := Self.FsPgto_Fincto_Descricao_Bem;
end;

procedure TObjAgenciamento.setObservacao(psObservacao: String);
begin
  try
    Self.FsObservacao := psObservacao;
  except
    Self.FsObservacao := STRING_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getObservacao(): String;
begin
  Result := Self.FsObservacao;
end;

procedure TObjAgenciamento.setPrazo_Autorizacao(pdPrazo_Autorizacao: TDate);
begin
  try
    Self.FdPrazo_Autorizacao := pdPrazo_Autorizacao;
  except
    Self.FdPrazo_Autorizacao := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getPrazo_Autorizacao(): TDate;
begin
  Result := Self.FdPrazo_Autorizacao;
end;

procedure TObjAgenciamento.setData_Reagenciamento(pdData_Reagenciamento: TDate);
begin
  try
    Self.FdData_Reagenciamento := pdData_Reagenciamento;
  except
    Self.FdData_Reagenciamento := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getData_Reagenciamento(): TDate;
begin
  Result := Self.FdData_Reagenciamento;
end;

procedure TObjAgenciamento.setData_Baixa(pdData_Baixa: TDate);
begin
  try
    Self.FdData_Baixa := pdData_Baixa;
  except
    Self.FdData_Baixa := NUMERO_INDEFINIDO;
  end;
end;

function TObjAgenciamento.getData_Baixa(): TDate;
begin
  Result := Self.FdData_Baixa;
end;

procedure TObjAgenciamento.setExibePessoaFisica();
begin
  Self.FsExibePessoaFisica := STRING_INDEFINIDO;

  if(Self.FnFk_Pessoa_Fisica <> NUMERO_INDEFINIDO)then
  begin
    DM.zQryPessoaFisica.Close;
    DM.zQryPessoaFisica.SQL.Clear;
    DM.zQryPessoaFisica.SQL.Add('SELECT * FROM pessoa_fisica WHERE codigo=:cod');
    DM.zQryPessoaFisica.ParamByName('cod').AsInteger := Self.FnFk_Pessoa_Fisica;
    DM.zQryPessoaFisica.Open;
    if(DM.zQryPessoaFisica.RecordCount = 1)then
      //Self.FsExibePessoaFisica := DM.zQryPessoaFisicaCODIGO.AsString + ' - ' + DM.zQryPessoaFisicaNOME.AsString;
      Self.FsExibePessoaFisica := DM.zQryPessoaFisicaNOME.AsString;
  end;
end;

function TObjAgenciamento.getExibePessoaFisica(): String;
begin
  Result := Self.FsExibePessoaFisica;
end;

procedure TObjAgenciamento.setExibePessoaJuridica();
begin
  Self.FsExibePessoaJuridica := STRING_INDEFINIDO;

  if(Self.FnFk_Pessoa_Juridica <> NUMERO_INDEFINIDO)then
  begin
    DM.zQryPessoaJuridica.Close;
    DM.zQryPessoaJuridica.SQL.Clear;
    DM.zQryPessoaJuridica.SQL.Add('SELECT * FROM pessoa_juridica WHERE codigo=:cod');
    DM.zQryPessoaJuridica.ParamByName('cod').AsInteger := Self.FnFk_Pessoa_Juridica;
    DM.zQryPessoaJuridica.Open;
    if(DM.zQryPessoaJuridica.RecordCount = 1)then
      //Self.FsExibePessoaJuridica := DM.zQryPessoaJuridicaCODIGO.AsString + ' - ' + DM.zQryPessoaJuridicaNOME.AsString;
      Self.FsExibePessoaJuridica := DM.zQryPessoaJuridicaNOME.AsString;
  end;
end;

function TObjAgenciamento.getExibePessoaJuridica(): String;
begin
  Result := Self.FsExibePessoaJuridica;
end;

procedure TObjAgenciamento.setExibeImovel();
begin
  Self.FsExibeImovel := STRING_INDEFINIDO;

  if(Self.FnFk_Imovel <> NUMERO_INDEFINIDO)then
  begin
    DM.zQryAux.Close;
    DM.zQryAux.SQL.Clear;
    DM.zQryAux.SQL.Add('SELECT i.codigo,i.valor_imovel,e.sigla,c.nome ');
    DM.zQryAux.SQL.Add('FROM imovel i ');
    DM.zQryAux.SQL.Add('JOIN estado e ON i.cod_fk_estado = e.codigo ');
    DM.zQryAux.SQL.Add('JOIN cidade c ON i.cod_fk_cidade = c.codigo ');
    DM.zQryAux.SQL.Add('ORDER BY i.codigo DESC ROWS 1');
    DM.zQryAux.Open;
    if(DM.zQryAux.RecordCount = 1)then
    begin
      //nCodigo := DM.zQryAux.FieldByName('codigo').AsInteger;
      Self.FsExibeImovel := DM.zQryAux.FieldByName('sigla').AsString + ' - ' +
        DM.zQryAux.FieldByName('nome').AsString + ' - ' +
        Self.formatarValorMonetario(DM.zQryAux.FieldByName('valor_imovel').AsString);
    end;
  end;
end;

function TObjAgenciamento.getExibeImovel(): String;
begin
  Result := Self.FsExibeImovel;
end;


{***** procedimentos diversos *****}

//limpa os dados do objeto
procedure TObjAgenciamento.limparObjeto();
begin
    Self.setCodigo(NUMERO_INDEFINIDO);
    Self.setDataCadastro(NUMERO_INDEFINIDO);
    Self.setDataAgenciamento(NUMERO_INDEFINIDO);
    Self.setAtivo(STRING_INDEFINIDO);
    Self.setNormal(STRING_INDEFINIDO);
    Self.setStandBy(STRING_INDEFINIDO);
    Self.setTipoPessoa(STRING_INDEFINIDO);
    Self.setFk_Pessoa_Fisica(NUMERO_INDEFINIDO);
    Self.setFk_Pessoa_Juridica(NUMERO_INDEFINIDO);
    Self.setFk_Imovel(NUMERO_INDEFINIDO);
    //Self.setMeioCaptacao(STRING_INDEFINIDO);
    Self.setFk_MeioCaptacao(NUMERO_INDEFINIDO);
    Self.setCondicaoPagamento(STRING_INDEFINIDO);
    Self.setValorTotal(NUMERO_INDEFINIDO);
    Self.setPgto_Vista_Cach(NUMERO_INDEFINIDO);
    Self.setPgto_Vista_Valor_Bem(NUMERO_INDEFINIDO);
    Self.setPgto_Vista_Descricao_Bem(STRING_INDEFINIDO);
    Self.setPgto_Fincto_Cach_Financiado(NUMERO_INDEFINIDO);
    Self.setPgto_Fincto_Cach(NUMERO_INDEFINIDO);
    Self.setPgto_Fincto_Valor_Bem(NUMERO_INDEFINIDO);
    Self.setPgto_Fincto_Descricao_Bem(STRING_INDEFINIDO);
    Self.setObservacao(STRING_INDEFINIDO);
    Self.setPrazo_Autorizacao(NUMERO_INDEFINIDO);
    Self.setData_Reagenciamento(NUMERO_INDEFINIDO);
    Self.setData_Baixa(NUMERO_INDEFINIDO);
    Self.setExibePessoaFisica();
    Self.setExibePessoaJuridica();
    Self.setExibeImovel();
end;

//verifica se existe diferença no objeto. Quando estiver editando registro
function TObjAgenciamento.verificarDiferencaCadastro(psAtivo:String; psNormal:String;
  psStandBy:String; psTipoPessoa:String; pnFk_Pessoa_Fisica:Integer;
  pnFk_Pessoa_Juridica:Integer; pnFk_Imovel:Integer; pnFk_MeioCaptacao:Integer; //psMeioCaptacao:String;
  psCondicaoPagamento:String; pdValorTotal:Double; pdPgto_Vista_Cach:Double;
  pdPgto_Vista_Valor_Bem:Double; psPgto_Vista_Descricao_Bem:String;
  pdPgto_Fincto_Cach_Financiado:Double; pdPgto_Fincto_Cach:Double;
  pdPgto_Fincto_Valor_Bem:Double; psPgto_Fincto_Descricao_Bem:String;
  psObservacao:String; pdPrazo_Autorizacao:TDate;
  pdData_Reagenciamento:TDate): Boolean;
var
  retorno: Boolean;
begin
  retorno := False;

  if (psAtivo <> Self.getAtivo) then
    retorno := True;
  if (psNormal <> Self.getNormal) then
    retorno := True;
  if (psStandBy <> Self.getStandBy) then
    retorno := True;
  if (psTipoPessoa <> Self.getTipoPessoa) then
    retorno := True;
  if (pnFk_Pessoa_Fisica <> Self.getFk_Pessoa_Fisica) then
    retorno := True;
  if (pnFk_Pessoa_Juridica <> Self.getFk_Pessoa_Juridica) then
    retorno := True;
  if (pnFk_Imovel <> Self.getFk_Imovel) then
    retorno := True;
  //if (psMeioCaptacao <> Self.getMeioCaptacao) then
  //  retorno := True;
  if (pnFk_MeioCaptacao <> Self.getFk_MeioCaptacao) then
    retorno := True;
  if (psCondicaoPagamento <> Self.getCondicaoPagamento) then
    retorno := True;
  if (pdValorTotal <> Self.getValorTotal) then
    retorno := True;
  if (pdPgto_Vista_Cach <> Self.getPgto_Vista_Cach) then
    retorno := True;
  if (pdPgto_Vista_Valor_Bem <> Self.getPgto_Vista_Valor_Bem) then
    retorno := True;
  if (psPgto_Vista_Descricao_Bem <> Self.getPgto_Vista_Descricao_Bem) then
    retorno := True;
  if (pdPgto_Fincto_Cach_Financiado <> Self.getPgto_Fincto_Cach_Financiado) then
    retorno := True;
  if (pdPgto_Fincto_Cach <> Self.getPgto_Fincto_Cach) then
    retorno := True;
  if (pdPgto_Fincto_Valor_Bem <> Self.getPgto_Fincto_Valor_Bem) then
    retorno := True;
  if (psPgto_Fincto_Descricao_Bem <> Self.getPgto_Fincto_Descricao_Bem) then
    retorno := True;
  if (psObservacao <> Self.getObservacao) then
    retorno := True;
  if (pdPrazo_Autorizacao <> Self.getPrazo_Autorizacao) then
    retorno := True;
  if (pdData_Reagenciamento <> Self.getData_Reagenciamento) then
    retorno := True;

  Result := retorno;
end;

end.
