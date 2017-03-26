unit unCliente;

interface

uses
  ZConnection, ZDataset, Provider, DBClient, Controls, unFuncoes, unConstantes;

  type TCliente = class
    private
      nCodigo: Integer;
      dData: TDateTime;
      sNome: string;
      sCPF: string;
      sCNPJ: string;
      sIdentidade: string;
      dDataNascimento: TDate;
      sProfissao: string;
      sEmail: string;
      sTelefone1: string;
      sTelefone2: string;
      sEnderecoEstado: string;
      sEnderecoCidade: string;
      sEnderecoBairro: string;
      sEnderecoRua: string;
      nEnderecoNumero: Integer;
      sEnderecoCEP: string;
      sEnderecoComplemento: string;

      FoFuncoes: TFuncoes;
      function VerificarClienteExisteAntesSalvar(
        const pbCodigoNaoValida: boolean = False): Boolean;
      function VerificarClientePodeSerDeletado: Boolean;
    private
      procedure PegarSetarCodigoClienteInserido;
    public
      procedure SetCodigo(pnCodigo: Integer);
      procedure SetData(psData: string);
      procedure SetNome(psNome: string);
      procedure SetCPF(psCPF: string);
      procedure SetCNPJ(psCNPJ: string);
      procedure SetIdentidade(psIdentidade: string);
      procedure SetDataNascimento(psDataNascimento: string);
      procedure SetProfissao(psProfissao: string);
      procedure SetEmail(psEmail: string);
      procedure SetTelefone1(psTelefone1: string);
      procedure SetTelefone2(psTelefone2: string);
      procedure SetEnderecoEstado(psEnderecoEstado: string);
      procedure SetEnderecoCidade(psEnderecoCidade: string);
      procedure SetEnderecoBairro(psEnderecoBairro: string);
      procedure SetEnderecoRua(psEnderecoRua: string);
      procedure SetEnderecoNumero(pnEnderecoNumero: Integer);
      procedure SetEnderecoCEP(psEnderecoCEP: string);
      procedure SetEnderecoComplemento(psEnderecoComplemento: string);

      function GetCodigo: Integer;
      function GetDataAsDate: TDate;
      function GetDataAsDateTime: TDateTime;
      function GetDataAsString(const pbRetornaDateTime: Boolean = True): string;
      function GetNome: string;
      function GetCPF: string;
      function GetCPF_IsNull: Boolean;
      function GetCNPJ: string;
      function GetCNPJ_IsNull: Boolean;
      function GetIdentidade: string;
      function GetDataNascimentoAsDate: TDate;
      function GetDataNascimentoAsString: string;
      function GetProfissao: string;
      function GetEmail: string;
      function GetTelefone1: string;
      function GetTelefone2: string;
      function GetEnderecoEstado: string;
      function GetEnderecoCidade: string;
      function GetEnderecoBairro: string;
      function GetEnderecoRua: string;
      function GetEnderecoNumero: integer;
      function GetEnderecoNumeroAsString: string;
      function GetEnderecoCEP: string;
      function GetEnderecoComplemento: string;

      constructor CriarCliente;

      procedure Limpar;
      //function ValidarClienteAntesSalvar: Boolean;
      function Salvar(pnTipo: integer): Boolean;
      function Deletar: Boolean;
      procedure CarregarCliente(const pnCodigo: Integer = NUMERO_INDEFINIDO);
      function ExisteCliente: Boolean;
      function TotalPedidosDoCliente: Integer;
  end;

implementation

uses
  unDM, Classes, Dialogs, SysUtils, Variants;


procedure TCliente.PegarSetarCodigoClienteInserido;
var
  nCodigo: Integer;
begin
  nCodigo := NUMERO_INDEFINIDO;

  DM.cdsCliente.Close;
  DM.zQryCliente.Close;
  DM.zQryCliente.SQL.Clear;
  DM.zQryCliente.SQL.Add('SELECT FIRST 1 * FROM cliente ORDER BY codigo DESC');
  DM.zQryCliente.Open;
  DM.cdsCliente.Open;

  if (DM.cdsCliente.RecordCount = 1) then
    nCodigo := DM.cdsCliente.FieldByName('codigo').AsInteger;
    
  Self.SetCodigo(nCodigo);
end;

procedure TCliente.SetCodigo(pnCodigo: Integer);
begin
  Self.nCodigo := pnCodigo;
end;

procedure TCliente.SetData(psData: string);
begin
  if (not (FoFuncoes.validarDataHora(psData))) or (psData = sDATA_INVALIDA) then
    Self.dData := 0
  else
    Self.dData := StrToDateTime(psData);
end;

procedure TCliente.SetNome(psNome: string);
begin
  Self.sNome := psNome;
end;

procedure TCliente.SetCPF(psCPF: string);
begin
  if (psCPF = sCPF_INVALIDO) then
    Self.sCPF := STRING_INDEFINIDO
  else
    Self.sCPF := psCPF;
end;

procedure TCliente.SetCNPJ(psCNPJ: string);
begin
  if (psCNPJ = sCNPJ_INVALIDO) then
    Self.sCNPJ := STRING_INDEFINIDO
  else
    Self.sCNPJ := psCNPJ;
end;

procedure TCliente.SetIdentidade(psIdentidade: string);
begin
  Self.sIdentidade := psIdentidade;
end;

procedure TCliente.SetDataNascimento(psDataNascimento: string);
begin
  if (not (FoFuncoes.validarData(psDataNascimento))) or (psDataNascimento = sDATA_INVALIDA) then
    Self.dDataNascimento := 0
  else
    Self.dDataNascimento := StrToDate(psDataNascimento);
end;

procedure TCliente.SetProfissao(psProfissao: string);
begin
  Self.sProfissao := psProfissao;
end;

procedure TCliente.SetEmail(psEmail: string);
begin
  Self.sEmail := psEmail;
end;

procedure TCliente.SetTelefone1(psTelefone1: string);
begin
  if (psTelefone1 = sTELEFONE_INVALIDO) then
    Self.sTelefone1 := STRING_INDEFINIDO
  else
    Self.sTelefone1 := psTelefone1;
end;

procedure TCliente.SetTelefone2(psTelefone2: string);
begin
  if (psTelefone2 = sTELEFONE_INVALIDO) then
    Self.sTelefone2 := STRING_INDEFINIDO
  else
    Self.sTelefone2 := psTelefone2;
end;

procedure TCliente.SetEnderecoEstado(psEnderecoEstado: string);
begin
  Self.sEnderecoEstado := psEnderecoEstado;
end;

procedure TCliente.SetEnderecoCidade(psEnderecoCidade: string);
begin
  Self.sEnderecoCidade := psEnderecoCidade;
end;

procedure TCliente.SetEnderecoBairro(psEnderecoBairro: string);
begin
  Self.sEnderecoBairro := psEnderecoBairro;
end;

procedure TCliente.SetEnderecoRua(psEnderecoRua: string);
begin
  Self.sEnderecoRua := psEnderecoRua;
end;

procedure TCliente.SetEnderecoNumero(pnEnderecoNumero: Integer);
begin
  Self.nEnderecoNumero := pnEnderecoNumero;
end;

procedure TCliente.SetEnderecoCEP(psEnderecoCEP: string);
begin
  if (psEnderecoCEP = sCEP_INVALIDO) then
    Self.sEnderecoCEP := STRING_INDEFINIDO
  else
    Self.sEnderecoCEP := psEnderecoCEP;
end;

procedure TCliente.SetEnderecoComplemento(psEnderecoComplemento: string);
begin
  Self.sEnderecoComplemento := psEnderecoComplemento;
end;

function TCliente.GetCodigo: Integer;
begin
  Result := Self.nCodigo;
end;

function TCliente.GetDataAsDate: TDate;
begin
  Result := Self.dData;
end;

function TCliente.GetDataAsDateTime: TDateTime;
begin
  Result := Self.dData;
end;

function TCliente.GetDataAsString(const pbRetornaDateTime: Boolean): string;
begin
  //na teoria sempre vai ter um valor válido para o campo 'data'.
  if pbRetornaDateTime then
    Result := DateTimeToStr(Self.dData)
  else
    Result := DateToStr(Self.dData);
end;

function TCliente.GetNome: string;
begin
  Result := Self.sNome;
end;

function TCliente.GetCPF: string;
begin
  Result := Self.sCPF;
end;

function TCliente.GetCPF_IsNull: Boolean;
begin
  Result := (GetCPF = sCPF_INVALIDO) or (FoFuncoes.retirarCaracteres(GetCPF,'.-') = STRING_INDEFINIDO);
end;

function TCliente.GetCNPJ: string;
begin
  Result := Self.sCNPJ;
end;

function TCliente.GetCNPJ_IsNull: Boolean;
begin
  Result := (GetCNPJ = sCNPJ_INVALIDO) or (FoFuncoes.retirarCaracteres(GetCNPJ, './-') = STRING_INDEFINIDO);
end;

function TCliente.GetIdentidade: string;
begin
  Result := Self.sIdentidade;
end;

function TCliente.GetDataNascimentoAsDate: TDate;
begin
  Result := Self.dDataNascimento;
end;

function TCliente.GetDataNascimentoAsString: string;
begin
  if not (FoFuncoes.validarData(DateToStr(Self.dDataNascimento))) or (Self.dDataNascimento = 0) then
    Result := STRING_INDEFINIDO
  else
    Result := DateToStr(Self.dDataNascimento);
end;

function TCliente.GetProfissao: string;
begin
  Result := Self.sProfissao;
end;

function TCliente.GetEmail: string;
begin
  Result := Self.sEmail;
end;

function TCliente.GetTelefone1: string;
begin
  Result := Self.sTelefone1;
end;

function TCliente.GetTelefone2: string;
begin
  Result := Self.sTelefone2;
end;

function TCliente.GetEnderecoEstado: string;
begin
  Result := Self.sEnderecoEstado;
end;

function TCliente.GetEnderecoCidade: string;
begin
  Result := Self.sEnderecoCidade;
end;

function TCliente.GetEnderecoBairro: string;
begin
  Result := Self.sEnderecoBairro;
end;

function TCliente.GetEnderecoRua: string;
begin
  Result := Self.sEnderecoRua;
end;

function TCliente.GetEnderecoNumero: integer;
begin
  Result := Self.nEnderecoNumero;
end;

function TCliente.GetEnderecoNumeroAsString: string;
begin
  if(Self.nEnderecoNumero = NUMERO_INDEFINIDO) then
    Result := STRING_INDEFINIDO
  else
    Result := IntToStr(Self.nEnderecoNumero);
end;

function TCliente.GetEnderecoCEP: string;
begin
  Result := STRING_INDEFINIDO; 
  if FoFuncoes.validarCEP(Self.sEnderecoCEP) then
    Result := Self.sEnderecoCEP;
end;

function TCliente.GetEnderecoComplemento: string;
begin
  Result := Self.sEnderecoComplemento;
end;

constructor TCliente.CriarCliente;
begin
  inherited;
  Self.Limpar;
end;

(*function TCliente.ValidarClienteAntesSalvar: Boolean;
begin
end;*)

function TCliente.VerificarClienteExisteAntesSalvar(
  const pbCodigoNaoValida: boolean): Boolean;

  procedure AdicionarCondicaoCodigoNaoValida;
  begin
    if pbCodigoNaoValida then
    begin
      //caso estiver editando, não validar o código do cliente atual, fazer a validação somente com os demais.
      DM.zQryExiste.SQL.Add(' AND codigo <> :codigo');
      DM.zQryExiste.ParamByName('codigo').AsInteger := Self.GetCodigo;
    end;
  end;

begin
  Result := True;
  //nome já cadastrado.
  DM.zQryExiste.Close;
  DM.zQryExiste.SQL.Clear;
  DM.zQryExiste.SQL.Add('SELECT codigo FROM cliente WHERE nome = :nome');
  DM.zQryExiste.ParamByName('nome').AsString := Self.GetNome;
  AdicionarCondicaoCodigoNaoValida;
  DM.zQryExiste.Open;
  if not (DM.zQryExiste.IsEmpty) then
  begin
    MessageDlg('Cliente já cadastrado com o nome: ' + Self.GetNome, mtInformation, [mbOK], 0);
    Result := False;
    Exit;
  end;

  //CPF já cadastrado.
  if (Self.GetCPF <> STRING_INDEFINIDO) then
  begin
    DM.zQryExiste.Close;
    DM.zQryExiste.SQL.Clear;
    DM.zQryExiste.SQL.Add('SELECT codigo FROM cliente WHERE cpf = :cpf');
    DM.zQryExiste.ParamByName('CPF').AsString := Self.GetCPF;
    AdicionarCondicaoCodigoNaoValida;
    DM.zQryExiste.Open;
    if not (DM.zQryExiste.IsEmpty) then
    begin
      MessageDlg('Cliente já cadastrado com este CPF: ' + Self.GetCPF, mtInformation, [mbOK], 0);
      Result := False;
      Exit;
    end;
  end;

  //CNPJ já cadastrado.
  if (Self.GetCNPJ <> STRING_INDEFINIDO) then
  begin
    DM.zQryExiste.Close;
    DM.zQryExiste.SQL.Clear;
    DM.zQryExiste.SQL.Add('SELECT codigo FROM cliente WHERE cnpj = :cnpj');
    DM.zQryExiste.ParamByName('CNPJ').AsString := Self.GetCNPJ;
    AdicionarCondicaoCodigoNaoValida;
    DM.zQryExiste.Open;
    if not (DM.zQryExiste.IsEmpty) then
    begin
      MessageDlg('Cliente já cadastrado com este CNPJ: ' + Self.GetCNPJ, mtInformation, [mbOK], 0);
      Result := False;
      Exit;
    end;
  end;

  //identidade já cadastrada.
  if (Self.GetIdentidade <> STRING_INDEFINIDO) then
  begin
    DM.zQryExiste.Close;
    DM.zQryExiste.SQL.Clear;
    DM.zQryExiste.SQL.Add('SELECT codigo FROM cliente WHERE identidade = :identidade');
    DM.zQryExiste.ParamByName('identidade').AsString := Self.GetIdentidade;
    AdicionarCondicaoCodigoNaoValida;
    DM.zQryExiste.Open;
    if not (DM.zQryExiste.IsEmpty) then
    begin
      MessageDlg('Cliente já cadastrado com esta identidade: ' + Self.GetIdentidade, mtInformation, [mbOK], 0);
      Result := False;
      Exit;
    end;
  end;

  //email já cadastrado.
  if (Self.GetEmail <> STRING_INDEFINIDO) then
  begin
    DM.zQryExiste.Close;
    DM.zQryExiste.SQL.Clear;
    DM.zQryExiste.SQL.Add('SELECT codigo FROM cliente WHERE email = :email');
    DM.zQryExiste.ParamByName('email').AsString := Self.GetEmail;
    AdicionarCondicaoCodigoNaoValida;
    DM.zQryExiste.Open;
    if not (DM.zQryExiste.IsEmpty) then
    begin
      MessageDlg('Cliente já cadastrado com este email: ' + Self.GetEmail, mtInformation, [mbOK], 0);
      Result := False;
      Exit;
    end;
  end;
end;

function TCliente.VerificarClientePodeSerDeletado: Boolean;
begin
  //xxxxxxxxxxxxxxxxxxxx
  Result := True;
end;

procedure TCliente.Limpar;
begin
  SetCodigo(NUMERO_INDEFINIDO);
  SetData(STRING_INDEFINIDO);
  SetNome(STRING_INDEFINIDO);
  SetCPF(STRING_INDEFINIDO);
  SetCNPJ(STRING_INDEFINIDO);
  SetIdentidade(STRING_INDEFINIDO);
  SetDataNascimento(STRING_INDEFINIDO);
  SetProfissao(STRING_INDEFINIDO);
  SetEmail(STRING_INDEFINIDO);
  SetTelefone1(STRING_INDEFINIDO);
  SetTelefone2(STRING_INDEFINIDO);
  SetEnderecoEstado(STRING_INDEFINIDO);
  SetEnderecoCidade(STRING_INDEFINIDO);
  SetEnderecoBairro(STRING_INDEFINIDO);
  SetEnderecoRua(STRING_INDEFINIDO);
  SetEnderecoNumero(NUMERO_INDEFINIDO);
  SetEnderecoCEP(STRING_INDEFINIDO);
  SetEnderecoComplemento(STRING_INDEFINIDO);
end;

function TCliente.Salvar(pnTipo: integer): Boolean;

  function GerarInsertOuUpdate: boolean;
  begin
    Result := False;
    if (pnTipo = nOPERACAO_NOVO) then
    begin
      DM.zQryCliente.SQL.Add('INSERT INTO cliente (nome,cpf,identidade,cnpj,data_nascimento,' +
        'profissao,email,telefone_1,telefone_2,estado,cidade,bairro,rua,numero,cep,' +
        'complemento) VALUES (:nome,:cpf,:identidade,:cnpj,:data_nascimento,' +
        ':profissao,:email,:telefone_1,:telefone_2,:estado,:cidade,:bairro,:rua,:numero,' +
        ':cep,:complemento)');
      Result := True;
    end

    else if (pnTipo = nOPERACAO_EDITAR) then
    begin
      DM.zQryCliente.SQL.Add('UPDATE cliente SET nome = :nome, cpf = :cpf, ' +
        'identidade = :identidade, cnpj = :cnpj, data_nascimento = :data_nascimento, profissao = :profissao, ' +
        'email = :email, telefone_1 = :telefone_1, telefone_2 = :telefone_2, ' +
        'estado = :estado, cidade = :cidade, bairro = :bairro, rua = :rua, ' +
        'numero = :numero, cep = :cep, complemento = :complemento ' +
        'WHERE codigo = :codigo');
      DM.zQryCliente.ParamByName('codigo').AsInteger := Self.GetCodigo;
      Result := True;
    end
  end;

begin
  Result := False;
  if not VerificarClienteExisteAntesSalvar(pnTipo = nOPERACAO_EDITAR) then
    Abort;

  try
    DM.ZConnection.StartTransaction;
    DM.zQryCliente.Close;
    DM.zQryCliente.SQL.Clear;

    if not GerarInsertOuUpdate then
      Exit;

    DM.zQryCliente.ParamByName('nome').AsString := Self.GetNome;
    DM.zQryCliente.ParamByName('cpf').AsString := Self.GetCPF;
    DM.zQryCliente.ParamByName('identidade').AsString := Self.GetIdentidade;
    DM.zQryCliente.ParamByName('cnpj').AsString := Self.GetCNPJ;
    if Self.GetDataNascimentoAsDate = 0 then
      DM.zQryCliente.ParamByName('data_nascimento').Clear
    else
      DM.zQryCliente.ParamByName('data_nascimento').AsDate := Self.GetDataNascimentoAsDate;
    DM.zQryCliente.ParamByName('profissao').AsString := Self.GetProfissao;
    DM.zQryCliente.ParamByName('email').AsString := Self.GetEmail;
    DM.zQryCliente.ParamByName('telefone_1').AsString := Self.GetTelefone1;
    DM.zQryCliente.ParamByName('telefone_2').AsString := Self.GetTelefone2;
    DM.zQryCliente.ParamByName('estado').AsString := Self.GetEnderecoEstado;
    DM.zQryCliente.ParamByName('cidade').AsString := Self.GetEnderecoCidade;
    DM.zQryCliente.ParamByName('bairro').AsString := Self.GetEnderecoBairro;
    DM.zQryCliente.ParamByName('rua').AsString := Self.GetEnderecoRua;
    if Self.GetEnderecoNumero = NUMERO_INDEFINIDO then
      DM.zQryCliente.ParamByName('numero').Clear
    else
      DM.zQryCliente.ParamByName('numero').AsInteger := Self.GetEnderecoNumero;
    DM.zQryCliente.ParamByName('cep').AsString := Self.GetEnderecoCEP;
    DM.zQryCliente.ParamByName('complemento').AsString := Self.GetEnderecoComplemento;
    DM.zQryCliente.ExecSQL;
    DM.ZConnection.Commit;
    PegarSetarCodigoClienteInserido;
    Result := True;
  except
    Result := False;
    DM.ZConnection.Rollback;
  end;
end;

function TCliente.Deletar: Boolean;
begin
  Result := False;

  if not VerificarClientePodeSerDeletado then
    Abort;

  try
    DM.ZConnection.StartTransaction;
    //xxxxxxxxxxxxxx
    //deletar referências
    DM.zQryCliente.Close;
    DM.zQryCliente.SQL.Clear;
    DM.zQryCliente.SQL.Add('DELETE FROM cliente WHERE codigo = :codigo');
    DM.zQryCliente.ParamByName('codigo').AsInteger := Self.GetCodigo;
    DM.zQryCliente.ExecSQL;
    DM.ZConnection.Commit;
    Result := True;
  except
    Result := False;
    DM.ZConnection.Rollback;
  end;
end;

//se pnCodigo = NUMERO_INDEFINIDO, vai carregar o último cliente (parte do
//princípio que está sendo realizado um INSERT no último registro), caso contrário,
//carrega o cliente contido no código pnCodigo.
procedure TCliente.CarregarCliente(const pnCodigo: Integer);

  procedure SetarDados;
  begin
    if (DM.cdsCliente.IsEmpty) then
      Limpar
    else if (DM.cdsCliente.RecordCount = 1) then
    begin
      SetCodigo(DM.cdsCliente.FieldByName('codigo').AsInteger);
      SetData(DM.cdsCliente.FieldByName('data_cadastro').AsString);
      SetNome(DM.cdsCliente.FieldByName('nome').AsString);
      SetCPF(DM.cdsCliente.FieldByName('CPF').AsString);
      SetIdentidade(DM.cdsCliente.FieldByName('identidade').AsString);
      SetCNPJ(DM.cdsCliente.FieldByName('cnpj').AsString);
      SetDataNascimento(DM.cdsCliente.FieldByName('data_nascimento').AsString);
      SetProfissao(DM.cdsCliente.FieldByName('profissao').AsString);
      SetEmail(DM.cdsCliente.FieldByName('email').AsString);
      SetTelefone1(DM.cdsCliente.FieldByName('telefone_1').AsString);
      SetTelefone2(DM.cdsCliente.FieldByName('telefone_2').AsString);
      SetEnderecoEstado(DM.cdsCliente.FieldByName('estado').AsString);
      SetEnderecoCidade(DM.cdsCliente.FieldByName('cidade').AsString);
      SetEnderecoBairro(DM.cdsCliente.FieldByName('bairro').AsString);
      SetEnderecoRua(DM.cdsCliente.FieldByName('rua').AsString);
      SetEnderecoNumero(DM.cdsCliente.FieldByName('numero').AsInteger);
      SetEnderecoCEP(DM.cdsCliente.FieldByName('CEP').AsString);
      SetEnderecoComplemento(DM.cdsCliente.FieldByName('complemento').AsString);
    end;
  end;

begin
  //foi realizado um INSERT
  if (pnCodigo = NUMERO_INDEFINIDO) then
  begin
    DM.cdsCliente.Close;  
    DM.zQryCliente.Close;
    DM.zQryCliente.SQL.Clear;
    DM.zQryCliente.SQL.Add('SELECT FIRST 1 * FROM cliente ORDER BY codigo DESC');
    DM.zQryCliente.Open;
    DM.cdsCliente.Open;
  end
  //foi realizado um UPDATE
  else
  begin
    DM.cdsCliente.Close;
    DM.zQryCliente.Close;
    DM.zQryCliente.SQL.Clear;
    DM.zQryCliente.SQL.Add('SELECT * FROM cliente WHERE codigo = :codigo ORDER BY codigo DESC');
    DM.zQryCliente.ParamByName('codigo').AsInteger := pnCodigo;
    DM.zQryCliente.Open;
    DM.cdsCliente.Open;
  end;

  SetarDados;
end;

function TCliente.ExisteCliente: Boolean;
begin
  Result := GetCodigo <> NUMERO_INDEFINIDO;
end;

function TCliente.TotalPedidosDoCliente: Integer;
begin
  Result := 0;
  DM.zQryAux.Close;
  DM.zQryAux.SQL.Clear;
  DM.zQryAux.SQL.Add('SELECT COUNT(*) AS total FROM pedido WHERE cod_cliente = :cod_cliente');
  DM.zQryAux.ParamByName('cod_cliente').AsInteger := Self.GetCodigo;
  DM.zQryAux.Open;

  if(DM.zQryAux.Active) then
    Result := DM.zQryAux.FieldByName('total').AsInteger;
end;


end.
