unit unObjVenda;

interface

uses
  unDM,
  Controls; //TDate

  type TObjVenda = class

    private
      FnCodigo: Integer;
      FdDataCadastro: TDateTime;
      FdDataVenda: TDate;
      FsAtivo: String[3];
      FsTipoPessoa: String[8];
      FnFk_PessoaFisica: Integer;
      FnFk_PessoaJuridica: Integer;
      //FnFk_Cliente: Integer;
      FnFk_Imovel: Integer;
      FsTipoVenda: String[16];
      FsVendaMeuAgenciamentoMeu: String[3];
      FsVendaMeuAgenciamentoColegas: String[3];
      FsVendaPautaConstrutora: String[3];
      FsVendaPautaTerceiros: String[3];
      FnFk_Construtora: Integer;
      FdValorVenda: Double;
      FdDeducoes: Double;
      FdValorBemNegociavel: Double;
      FsDeduzirBemNegocValorVenda: String[3];
      FdValorParaCalculoComissao: Double;
      FdPercentualSobreVenda: Double;
      FdValorTotalComissao: Double;
      FdPercentualSobreComissao: Double;
      FsObservacao: String;
      FdDataCancelamento: TDateTime;
      //FsExibeCliente: String;
      FsExibePessoaFisica: String;
      FsExibePessoaJuridica: String;
      FsExibeImovel: String;
      FsExibeConstrutora: String;
    public
      procedure setCodigo(pnCodigo: Integer);
      procedure setDataCadastro(pdDataCadastro: TDateTime);
      procedure setDataVenda(pdDataVenda: TDate);
      procedure setAtivo(psAtivo: String);
      procedure setTipoPessoa(psTipoPessoa: String);
      procedure setFk_PessoaFisica(pnFk_PessoaFisica: Integer);
      procedure setFk_PessoaJuridica(pnFk_PessoaJuridica: Integer);
      //procedure setFk_Cliente(pnFk_Cliente: Integer);
      procedure setFk_Imovel(pnFk_Imovel: Integer);
      procedure setTipoVenda(psTipoVenda: String);
      procedure setVendaMeuAgenciamentoMeu(psVendaMeuAgenciamentoMeu: String);
      procedure setVendaMeuAgenciamentoColegas(psVendaMeuAgenciamentoColegas: String);
      procedure setVendaPautaConstrutora(psVendaPautaConstrutora: String);
      procedure setVendaPautaTerceiros(psVendaPautaTerceiros: String);
      procedure setFk_Construtora(pnFk_Construtora: Integer);
      procedure setValorVenda(pdValorVenda: Double);
      procedure setDeducoes(pdDeducoes: Double);
      procedure setValorBemNegociavel(pdValorBemNegociavel: Double);
      procedure setDeduzirBemNegocValorVenda(psDeduzirBemNegocValorVenda: String);
      procedure setValorParaCalculoComissao(pdValorParaCalculoComissao: Double);
      procedure setPercentualSobreVenda(pdPercentualSobreVenda: Double);
      procedure setValorTotalComissao(pdValorTotalComissao: Double);
      procedure setPercentualSobreComissao(pdPercentualSobreComissao: Double);
      procedure setObservacao(psObservacao: String);
      procedure setDataCancelamento(pdDataCancelamento: TDateTime);
      //procedure setExibeCliente();
      procedure setExibePessoaFisica(const pbMostrarNaoDefinido: Boolean = True);
      procedure setExibePessoaJuridica(const pbMostrarNaoDefinido: Boolean = True);
      procedure setExibeImovel(const pbMostrarNaoDefinido: Boolean = True);
      procedure setExibeConstrutora(const pbMostrarNaoDefinido: Boolean = True);

      function getCodigo(): Integer;
      function getDataCadastro(): TDateTime;
      function getDataVenda(): TDate;
      function getAtivo(): String;
      function getTipoPessoa(): String;
      function getFk_PessoaFisica(): Integer;
      function getFk_PessoaJuridica(): Integer;
      //function getFk_Cliente(): Integer;
      function getFk_Imovel(): Integer;
      function getTipoVenda(): String;
      function getVendaMeuAgenciamentoMeu(): String;
      function getVendaMeuAgenciamentoColegas(): String;
      function getVendaPautaConstrutora(): String;
      function getVendaPautaTerceiros(): String;
      function getFk_Construtora(): Integer;
      function getValorVenda(): Double;
      function getDeducoes(): Double;
      function getValorBemNegociavel(): Double;
      function getDeduzirBemNegocValorVenda(): String;
      function getValorParaCalculoComissao(): Double;
      function getPercentualSobreVenda(): Double;
      function getValorTotalComissao(): Double;
      function getPercentualSobreComissao(): Double;
      function getObservacao(): String;
      function getDataCancelamento(): TDateTime;
      //function getExibeCliente(): String;
      function getExibePessoaFisica(): String;
      function getExibePessoaJuridica(): String;
      function getExibeImovel(): String;
      function getExibeConstrutora(): String;

      //limpa os dados do objeto
      procedure limparObjeto();

      //verifica se existe diferença no objeto. Quando estiver editando registro
      //function verificarDiferencaCadastro(): Boolean;
  end;

implementation

uses
  unConstantes, Variants;

{ TObjAgenciamento }

{***** set's e get's *****}
procedure TObjVenda.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjVenda.setDataCadastro(pdDataCadastro: TDateTime);
begin
  try
    Self.FdDataCadastro := pdDataCadastro;
  except
    Self.FdDataCadastro := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getDataCadastro(): TDateTime;
begin
  Result := Self.FdDataCadastro;
end;

procedure TObjVenda.setDataVenda(pdDataVenda: TDate);
begin
  try
    Self.FdDataVenda := pdDataVenda;
  except
    Self.FdDataVenda := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getDataVenda(): TDate;
begin
  Result := Self.FdDataVenda;
end;

procedure TObjVenda.setAtivo(psAtivo: String);
begin
  try
    Self.FsAtivo := psAtivo;
  except
    Self.FsAtivo := STRING_INDEFINIDO;
  end;
end;

function TObjVenda.getAtivo(): String;
begin
  Result := Self.FsAtivo;
end;

procedure TObjVenda.setTipoPessoa(psTipoPessoa: String);
begin
  try
    Self.FsTipoPessoa := psTipoPessoa;
  except
    Self.FsTipoPessoa := STRING_INDEFINIDO;
  end;
end;

function TObjVenda.getTipoPessoa(): String;
begin
  Result := Self.FsTipoPessoa;
end;

procedure TObjVenda.setFk_PessoaFisica(pnFk_PessoaFisica: Integer);
begin
  try
    Self.FnFk_PessoaFisica := pnFk_PessoaFisica;
  except
    Self.FnFk_PessoaFisica := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getFk_PessoaFisica(): Integer;
begin
  Result := Self.FnFk_PessoaFisica;
end;

procedure TObjVenda.setFk_PessoaJuridica(pnFk_PessoaJuridica: Integer);
begin
  try
    Self.FnFk_PessoaJuridica := pnFk_PessoaJuridica;
  except
    Self.FnFk_PessoaJuridica := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getFk_PessoaJuridica(): Integer;
begin
  Result := Self.FnFk_PessoaJuridica;
end;

procedure TObjVenda.setFk_Imovel(pnFk_Imovel: Integer);
begin
  try
    Self.FnFk_Imovel := pnFk_Imovel;
  except
    Self.FnFk_Imovel := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getFk_Imovel(): Integer;
begin
  Result := Self.FnFk_Imovel;
end;

procedure TObjVenda.setTipoVenda(psTipoVenda: String);
begin
  try
    Self.FsTipoVenda := psTipoVenda;
  except
    Self.FsTipoVenda := STRING_INDEFINIDO;
  end;
end;

function TObjVenda.getTipoVenda(): String;
begin
  Result := Self.FsTipoVenda;
end;

procedure TObjVenda.setVendaMeuAgenciamentoMeu(psVendaMeuAgenciamentoMeu: String);
begin
  try
    Self.FsVendaMeuAgenciamentoMeu := psVendaMeuAgenciamentoMeu;
  except
    Self.FsVendaMeuAgenciamentoMeu := STRING_INDEFINIDO;
  end;
end;

function TObjVenda.getVendaMeuAgenciamentoMeu(): String;
begin
  Result := Self.FsVendaMeuAgenciamentoMeu;
end;

procedure TObjVenda.setVendaMeuAgenciamentoColegas(psVendaMeuAgenciamentoColegas: String);
begin
  try
    Self.FsVendaMeuAgenciamentoColegas := psVendaMeuAgenciamentoColegas;
  except
    Self.FsVendaMeuAgenciamentoColegas := STRING_INDEFINIDO;
  end;
end;

function TObjVenda.getVendaMeuAgenciamentoColegas(): String;
begin
  Result := Self.FsVendaMeuAgenciamentoColegas;
end;

procedure TObjVenda.setVendaPautaConstrutora(psVendaPautaConstrutora: String);
begin
  try
    Self.FsVendaPautaConstrutora := psVendaPautaConstrutora;
  except
    Self.FsVendaPautaConstrutora := STRING_INDEFINIDO;
  end;
end;

function TObjVenda.getVendaPautaConstrutora(): String;
begin
  Result := Self.FsVendaPautaConstrutora;
end;

procedure TObjVenda.setVendaPautaTerceiros(psVendaPautaTerceiros: String);
begin
  try
    Self.FsVendaPautaTerceiros := psVendaPautaTerceiros;
  except
    Self.FsVendaPautaTerceiros := STRING_INDEFINIDO;
  end;
end;

function TObjVenda.getVendaPautaTerceiros(): String;
begin
  Result := Self.FsVendaPautaTerceiros;
end;

procedure TObjVenda.setFk_Construtora(pnFk_Construtora: Integer);
begin
  try
    Self.FnFk_Construtora := pnFk_Construtora;
  except
    Self.FnFk_Construtora := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getFk_Construtora(): Integer;
begin
  Result := Self.FnFk_Construtora;
end;

procedure TObjVenda.setValorVenda(pdValorVenda: Double);
begin
  try
    Self.FdValorVenda := pdValorVenda;
  except
    Self.FdValorVenda := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getValorVenda(): Double;
begin
  Result := Self.FdValorVenda;
end;

procedure TObjVenda.setDeducoes(pdDeducoes: Double);
begin
  try
    Self.FdDeducoes := pdDeducoes;
  except
    Self.FdDeducoes := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getDeducoes(): Double;
begin
  Result := Self.FdDeducoes;
end;

procedure TObjVenda.setValorBemNegociavel(pdValorBemNegociavel: Double);
begin
  try
    Self.FdValorBemNegociavel := pdValorBemNegociavel;
  except
    Self.FdValorBemNegociavel := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getValorBemNegociavel(): Double;
begin
  Result := Self.FdValorBemNegociavel;
end;

procedure TObjVenda.setDeduzirBemNegocValorVenda(psDeduzirBemNegocValorVenda: String);
begin
  try
    Self.FsDeduzirBemNegocValorVenda := psDeduzirBemNegocValorVenda;
  except
    Self.FsDeduzirBemNegocValorVenda := STRING_INDEFINIDO;
  end;
end;

function TObjVenda.getDeduzirBemNegocValorVenda(): String;
begin
  Result := Self.FsDeduzirBemNegocValorVenda;
end;

procedure TObjVenda.setValorParaCalculoComissao(pdValorParaCalculoComissao: Double);
begin
  try
    Self.FdValorParaCalculoComissao := pdValorParaCalculoComissao;
  except
    Self.FdValorParaCalculoComissao := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getValorParaCalculoComissao(): Double;
begin
  Result := Self.FdValorParaCalculoComissao;
end;

procedure TObjVenda.setPercentualSobreVenda(pdPercentualSobreVenda: Double);
begin
  try
    Self.FdPercentualSobreVenda := pdPercentualSobreVenda;
  except
    Self.FdPercentualSobreVenda := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getPercentualSobreVenda(): Double;
begin
  Result := Self.FdPercentualSobreVenda;
end;

procedure TObjVenda.setValorTotalComissao(pdValorTotalComissao: Double);
begin
  try
    Self.FdValorTotalComissao := pdValorTotalComissao;
  except
    Self.FdValorTotalComissao := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getValorTotalComissao(): Double;
begin
  Result := Self.FdValorTotalComissao;
end;

procedure TObjVenda.setPercentualSobreComissao(pdPercentualSobreComissao: Double);
begin
  try
    Self.FdPercentualSobreComissao := pdPercentualSobreComissao;
  except
    Self.FdPercentualSobreComissao := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getPercentualSobreComissao(): Double;
begin
  Result := Self.FdPercentualSobreComissao;
end;

procedure TObjVenda.setObservacao(psObservacao: String);
begin
  try
    Self.FsObservacao := psObservacao;
  except
    Self.FsObservacao := STRING_INDEFINIDO;
  end;
end;

function TObjVenda.getObservacao(): String;
begin
  Result := Self.FsObservacao;
end;

procedure TObjVenda.setDataCancelamento(pdDataCancelamento: TDateTime);
begin
  try
    Self.FdDataCancelamento := pdDataCancelamento;
  except
    Self.FdDataCancelamento := NUMERO_INDEFINIDO;
  end;
end;

function TObjVenda.getDataCancelamento(): TDateTime;
begin
  Result := Self.FdDataCancelamento;
end;

procedure TObjVenda.setExibePessoaFisica(const pbMostrarNaoDefinido: Boolean = True);
begin
  Self.FsExibePessoaFisica := STRING_INDEFINIDO;

  if(not(pbMostrarNaoDefinido) and (Self.FnFk_PessoaFisica = REGISTRO_NULO))then
    Self.FsExibePessoaFisica := STRING_INDEFINIDO

  else

  if(Self.FnFk_PessoaFisica <> NUMERO_INDEFINIDO)then
  begin
    DM.zQryClientePessoaFisica.Close;
    DM.zQryClientePessoaFisica.SQL.Clear;
    DM.zQryClientePessoaFisica.SQL.Add('SELECT * FROM cliente_pessoa_fisica WHERE codigo=:cod');
    DM.zQryClientePessoaFisica.ParamByName('cod').AsInteger := Self.FnFk_PessoaFisica;
    DM.zQryClientePessoaFisica.Open;
    if(DM.zQryClientePessoaFisica.RecordCount = 1)then
      Self.FsExibePessoaFisica := DM.zQryClientePessoaFisicaNOME.AsString;
  end;
end;

function TObjVenda.getExibePessoaFisica(): String;
begin
  Result := Self.FsExibePessoaFisica;
end;

procedure TObjVenda.setExibePessoaJuridica(const pbMostrarNaoDefinido: Boolean = True);
begin
  Self.FsExibePessoaJuridica := STRING_INDEFINIDO;

  if(not(pbMostrarNaoDefinido) and (Self.FnFk_PessoaJuridica = REGISTRO_NULO))then
    Self.FsExibePessoaJuridica := STRING_INDEFINIDO

  else
  begin
    if(Self.FnFk_PessoaJuridica <> NUMERO_INDEFINIDO)then
    begin
      DM.zQryClientePessoaJuridica.Close;
      DM.zQryClientePessoaJuridica.SQL.Clear;
      DM.zQryClientePessoaJuridica.SQL.Add('SELECT * FROM cliente_pessoa_juridica WHERE codigo=:cod');
      DM.zQryClientePessoaFisica.ParamByName('cod').AsInteger := Self.FnFk_PessoaFisica;
      DM.zQryClientePessoaFisica.Open;
      if(DM.zQryClientePessoaFisica.RecordCount = 1)then
        Self.FsExibePessoaFisica := DM.zQryClientePessoaFisicaNOME.AsString;
    end;
  end;
end;

function TObjVenda.getExibePessoaJuridica(): String;
begin
  Result := Self.FsExibePessoaJuridica;
end;

procedure TObjVenda.setExibeImovel(const pbMostrarNaoDefinido: Boolean = True);
begin
  Self.FsExibeImovel := STRING_INDEFINIDO;

  if(not(pbMostrarNaoDefinido) and (Self.FnFk_Imovel = REGISTRO_NULO))then
    Self.FsExibeImovel := STRING_INDEFINIDO

  else
  begin
    if(Self.FnFk_Imovel <> NUMERO_INDEFINIDO)then
    begin
      DM.zQryImovel.Close;
      DM.zQryImovel.SQL.Clear;
      DM.zQryImovel.SQL.Add('SELECT * FROM imovel WHERE codigo=:cod');
      DM.zQryImovel.ParamByName('cod').AsInteger := Self.FnFk_Imovel;
      DM.zQryImovel.Open;
      if(DM.zQryImovel.RecordCount = 1)then
        Self.FsExibeImovel := DM.zQryImovelSITUACAO_DESEJAVEL.AsString;
    end;
  end;
end;

function TObjVenda.getExibeImovel(): String;
begin
  Result := Self.FsExibeImovel;
end;

procedure TObjVenda.setExibeConstrutora(const pbMostrarNaoDefinido: Boolean = True);
begin
  Self.FsExibeConstrutora := STRING_INDEFINIDO;

  if(not(pbMostrarNaoDefinido) and (Self.FnFk_Construtora = REGISTRO_NULO))then
    Self.FsExibeConstrutora := STRING_INDEFINIDO

  else
  begin
    if(Self.FnFk_Construtora <> NUMERO_INDEFINIDO)then
    begin
      DM.zQryConstrutora.Close;
      DM.zQryConstrutora.SQL.Clear;
      DM.zQryConstrutora.SQL.Add('SELECT * FROM construtora WHERE codigo=:cod');
      DM.zQryConstrutora.ParamByName('cod').AsInteger := Self.FnFk_Construtora;
      DM.zQryConstrutora.Open;
      if(DM.zQryConstrutora.RecordCount = 1)then
        Self.FsExibeConstrutora := DM.zQryConstrutoraNOME.AsString;
    end;
  end;
end;

function TObjVenda.getExibeConstrutora(): String;
begin
  Result := Self.FsExibeConstrutora;
end;

{***** procedimentos diversos *****}

//limpa os dados do objeto
procedure TObjVenda.limparObjeto();
begin
    Self.setCodigo(NUMERO_INDEFINIDO);
    Self.setDataCadastro(NUMERO_INDEFINIDO);
    Self.setDataVenda(NUMERO_INDEFINIDO);
    Self.setAtivo(STRING_INDEFINIDO);
    //Self.setFk_Cliente(NUMERO_INDEFINIDO);
    Self.setTipoPessoa(STRING_INDEFINIDO);
    Self.setFk_PessoaFisica(NUMERO_INDEFINIDO);
    Self.setFk_PessoaJuridica(NUMERO_INDEFINIDO);
    Self.setFk_Imovel(NUMERO_INDEFINIDO);
    Self.setTipoVenda(STRING_INDEFINIDO);
    Self.setVendaMeuAgenciamentoMeu(STRING_INDEFINIDO);
    Self.setVendaMeuAgenciamentoColegas(STRING_INDEFINIDO);
    Self.setVendaPautaConstrutora(STRING_INDEFINIDO);
    Self.setVendaPautaTerceiros(STRING_INDEFINIDO);
    Self.setFk_Construtora(NUMERO_INDEFINIDO);
    Self.setValorVenda(NUMERO_INDEFINIDO);
    Self.setDeducoes(NUMERO_INDEFINIDO);
    Self.setValorBemNegociavel(NUMERO_INDEFINIDO);
    Self.setDeduzirBemNegocValorVenda(STRING_INDEFINIDO);
    Self.setValorParaCalculoComissao(NUMERO_INDEFINIDO);
    Self.setPercentualSobreVenda(NUMERO_INDEFINIDO);
    Self.setValorTotalComissao(NUMERO_INDEFINIDO);
    Self.setPercentualSobreComissao(NUMERO_INDEFINIDO);
    Self.setObservacao(STRING_INDEFINIDO);
    Self.setDataCancelamento(NUMERO_INDEFINIDO);
    //Self.setExibeCliente();
    Self.setExibePessoaFisica();
    Self.setExibePessoaJuridica();
    Self.setExibeImovel();
    Self.setExibeConstrutora();
end;


end.
