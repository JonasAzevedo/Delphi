unit unObjPessoaFisica;

interface

uses
  unDM,
  Controls; //TDate

  type TObjPessoaFisica = class

    private
      FnCodigo: Integer;
      FdDataCadastro: TDateTime;
      FsNome: String[100];
      FsEmail: String[100];
      FsCPF: String[14];
      FsIdentidade: String[20];
      FdDataNascimento: TDate;
      FsConjuge: String[100];
      FsTelefoneResidencial: String[13];
      FsTelefoneComercial: String[13];
      FsTelefoneCelular: String[13];
      FnFk_MeioCaptacao: Integer;
      FnFk_Estado: Integer;
      FnFk_Cidade: Integer;
      FnFk_Bairro: Integer;
      FnFk_Rua: Integer;
      FsEnderecoCEP: String[9];
      FsEnderecoComplemento: String;
      FsHorarioLigacao: String[8];
      FtHoraInicio: TTime;
      FtHoraFinal: TTime;
      FsExibeMeioCaptacao: String;
      FsExibeEstado: String;
      FsExibeCidade: String;
      FsExibeBairro: String;
      FsExibeRua: String;
    public
      procedure setCodigo(pnCodigo: Integer);
      procedure setDataCadastro(pdDataCadastro: TDateTime);
      procedure setNome(psNome: String);
      procedure setEmail(psEmail: String);
      procedure setCPF(psCPF: String);
      procedure setIdentidade(psIdentidade: String);
      procedure setDataNascimento(pdDataNascimento: TDate);
      procedure setConjuge(psConjuge: String);
      procedure setTelefoneResidencial(psTelefoneResidencial: String);
      procedure setTelefoneComercial(psTelefoneComercial: String);
      procedure setTelefoneCelular(psTelefoneCelular: String);
      procedure setFkMeioCaptacao(pnFkMeioCaptacao: Integer);
      procedure setFkEstado(pnFkEstado: Integer);
      procedure setFkCidade(pnFkCidade: Integer);
      procedure setFkBairro(pnFkBairro: Integer);
      procedure setFkRua(pnFkRua: Integer);
      procedure setEnderecoCEP(psEnderecoCEP: String);
      procedure setEnderecoComplemento(psEnderecoComplemento: String);
      procedure setHorarioLigacao(psHorarioLigacao: String);
      procedure setHoraInicio(ptHoraInicio: TTime);
      procedure setHoraFinal(ptHoraFinal: TTime);
      procedure setExibeMeioCaptacao(const pbMostrarNaoDefinido: Boolean = True);
      procedure setExibeEstado(const pbMostrarNaoDefinido: Boolean = True);
      procedure setExibeCidade(const pbMostrarNaoDefinido: Boolean = True);
      procedure setExibeBairro(const pbMostrarNaoDefinido: Boolean = True);
      procedure setExibeRua(const pbMostrarNaoDefinido: Boolean = True);

      function getCodigo(): Integer;
      function getDataCadastro(): TDateTime;
      function getNome(): String;
      function getEmail(): String;
      function getCPF(): String;
      function getIdentidade(): String;
      function getDataNascimento(): TDate;
      function getConjuge(): String;
      function getTelefoneResidencial(): String;
      function getTelefoneComercial(): String;
      function getTelefoneCelular(): String;
      function getFkMeioCaptacao(): Integer;
      function getFkEstado(): Integer;
      function getFkCidade(): Integer;
      function getFkBairro(): Integer;
      function getFkRua(): Integer;
      function getEnderecoCEP(): String;
      function getEnderecoComplemento(): String;
      function getHorarioLigacao(): String;
      function getHoraInicio(): TTime;
      function getHoraFinal(): TTime;
      function getExibeMeioCaptacao(): String;
      function getExibeEstado(): String;
      function getExibeCidade(): String;
      function getExibeBairro(): String;
      function getExibeRua(): String;

      //limpa os dados do objeto
      procedure limparObjeto();

      //verifica se existe diferença no objeto. Quando estiver editando registro
      function verificarDiferencaCadastro(pnFkMeioCaptacao:Integer;
       pnFkEstado:Integer;pnFkCidade:Integer;pnFkBairro:Integer; pnFkRua:Integer;
       psEnderecoCEP:String;psEnderecoComplemento:String; psNome:String;
       psEmail:String; psCPF:String; psIdentidade:String; pdDataNascimento:TDate;
       psConjuge:String;psTelefoneResidencial:String; psTelefoneComercial:String;
       psTelefoneCelular:String; psHorarioLigacao:String; ptHoraInicio: TTime;
       ptHoraFinal: TTime): Boolean;
  end;

implementation

uses
  unConstantes, Variants;

{ TObjPessoaFisica }

{***** set's e get's *****}
procedure TObjPessoaFisica.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjPessoaFisica.setDataCadastro(pdDataCadastro: TDateTime);
begin
  try
    Self.FdDataCadastro := pdDataCadastro;
  except
    Self.FdDataCadastro := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getDataCadastro(): TDateTime;
begin
  Result := Self.FdDataCadastro;
end;

procedure TObjPessoaFisica.setFkMeioCaptacao(pnFkMeioCaptacao: Integer);
begin
  try
    Self.FnFk_MeioCaptacao := pnFkMeioCaptacao;
  except
    Self.FnFk_MeioCaptacao := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getFkMeioCaptacao(): Integer;
begin
  Result := Self.FnFk_MeioCaptacao;
end;

procedure TObjPessoaFisica.setFkEstado(pnFkEstado: Integer);
begin
  try
    Self.FnFk_Estado := pnFkEstado;
  except
    Self.FnFk_Estado := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getFkEstado(): Integer;
begin
  Result := Self.FnFk_Estado;
end;

procedure TObjPessoaFisica.setFkCidade(pnFkCidade: Integer);
begin
  try
    Self.FnFk_Cidade := pnFkCidade;
  except
    Self.FnFk_Cidade := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getFkCidade(): Integer;
begin
  Result := Self.FnFk_Cidade;
end;

procedure TObjPessoaFisica.setFkBairro(pnFkBairro: Integer);
begin
  try
    Self.FnFk_Bairro := pnFkBairro;
  except
    Self.FnFk_Bairro := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getFkBairro(): Integer;
begin
  Result := Self.FnFk_Bairro;
end;

procedure TObjPessoaFisica.setFkRua(pnFkRua: Integer);
begin
  try
    Self.FnFk_Rua := pnFkRua;
  except
    Self.FnFk_Rua := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getFkRua(): Integer;
begin
  Result := Self.FnFk_Rua;
end;

procedure TObjPessoaFisica.setEnderecoCEP(psEnderecoCEP: String);
begin
  try
    Self.FsEnderecoCEP := psEnderecoCEP;
  except
    Self.FsEnderecoCEP := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getEnderecoCEP(): String;
begin
  Result := Self.FsEnderecoCEP;
end;

procedure TObjPessoaFisica.setEnderecoComplemento(psEnderecoComplemento: String);
begin
  try
    Self.FsEnderecoComplemento := psEnderecoComplemento;
  except
    Self.FsEnderecoComplemento := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getEnderecoComplemento(): String;
begin
  Result := Self.FsEnderecoComplemento;
end;

procedure TObjPessoaFisica.setNome(psNome: String);
begin
  try
    Self.FsNome := psNome;
  except
    Self.FsNome := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getNome(): String;
begin
  Result := Self.FsNome;
end;

procedure TObjPessoaFisica.setEmail(psEmail: String);
begin
  try
    Self.FsEmail := psEmail;
  except
    Self.FsEmail := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getEmail(): String;
begin
  Result := Self.FsEmail;
end;

procedure TObjPessoaFisica.setCPF(psCPF: String);
begin
  try
    Self.FsCPF := psCPF;
  except
    Self.FsCPF := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getCPF(): String;
begin
  Result := Self.FsCPF;
end;

procedure TObjPessoaFisica.setIdentidade(psIdentidade: String);
begin
  try
    Self.FsIdentidade := psIdentidade;
  except
    Self.FsIdentidade := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getIdentidade(): String;
begin
  Result := Self.FsIdentidade;
end;

procedure TObjPessoaFisica.setDataNascimento(pdDataNascimento: TDate);
begin
  try
    Self.FdDataNascimento := pdDataNascimento;
  except
    Self.FdDataNascimento := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getDataNascimento(): TDate;
begin
  Result := Self.FdDataNascimento;
end;

procedure TObjPessoaFisica.setConjuge(psConjuge: String);
begin
  try
    Self.FsConjuge := psConjuge;
  except
    Self.FsConjuge := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getConjuge(): String;
begin
  Result := Self.FsConjuge;
end;

procedure TObjPessoaFisica.setTelefoneResidencial(psTelefoneResidencial: String);
begin
  try
    Self.FsTelefoneResidencial := psTelefoneResidencial;
  except
    Self.FsTelefoneResidencial := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getTelefoneResidencial(): String;
begin
  Result := Self.FsTelefoneResidencial;
end;

procedure TObjPessoaFisica.setTelefoneComercial(psTelefoneComercial: String);
begin
  try
    Self.FsTelefoneComercial := psTelefoneComercial;
  except
    Self.FsTelefoneComercial := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getTelefoneComercial(): String;
begin
  Result := Self.FsTelefoneComercial;
end;

procedure TObjPessoaFisica.setTelefoneCelular(psTelefoneCelular: String);
begin
  try
    Self.FsTelefoneCelular := psTelefoneCelular;
  except
    Self.FsTelefoneCelular := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getTelefoneCelular(): String;
begin
  Result := Self.FsTelefoneCelular;
end;


procedure TObjPessoaFisica.setHorarioLigacao(psHorarioLigacao: String);
begin
  try
    Self.FsHorarioLigacao := psHorarioLigacao;
  except
    Self.FsHorarioLigacao := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getHorarioLigacao(): String;
begin
  Result := Self.FsHorarioLigacao;
end;

procedure TObjPessoaFisica.setHoraInicio(ptHoraInicio: TTime);
begin
  try
    Self.FtHoraInicio := ptHoraInicio;
  except
    Self.FtHoraInicio := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getHoraInicio(): TTime;
begin
  Result := Self.FtHoraInicio;
end;

procedure TObjPessoaFisica.setHoraFinal(ptHoraFinal: TTime);
begin
  try
    Self.FtHoraFinal := ptHoraFinal;
  except
    Self.FtHoraFinal := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaFisica.getHoraFinal(): TTime;
begin
  Result := Self.FtHoraFinal;
end;

procedure TObjPessoaFisica.setExibeMeioCaptacao(const pbMostrarNaoDefinido: Boolean = True);
begin
  Self.FsExibeMeioCaptacao := STRING_INDEFINIDO;

  if(not(pbMostrarNaoDefinido) and (Self.FnFk_MeioCaptacao =REGISTRO_NULO))then
    Self.FsExibeMeioCaptacao := STRING_INDEFINIDO

  else
  begin
    if(Self.FnFk_MeioCaptacao <> NUMERO_INDEFINIDO)then
    begin
      DM.zQryMeioCaptacao.Close;
      DM.zQryMeioCaptacao.SQL.Clear;
      DM.zQryMeioCaptacao.SQL.Add('SELECT * FROM meio_captacao WHERE codigo=:cod');
      DM.zQryMeioCaptacao.ParamByName('cod').AsInteger := Self.FnFk_MeioCaptacao;
      DM.zQryMeioCaptacao.Open;
      if(DM.zQryMeioCaptacao.RecordCount = 1)then
        //Self.FsExibeBairro := DM.zQryBairroCODIGO.AsString + ' - ' + DM.zQryBairroNOME.AsString;
        Self.FsExibeMeioCaptacao := DM.zQryMeioCaptacaoNOME.AsString;
    end;
  end;
end;

function TObjPessoaFisica.getExibeMeioCaptacao(): String;
begin
  Result := Self.FsExibeMeioCaptacao;
end;

procedure TObjPessoaFisica.setExibeEstado(const pbMostrarNaoDefinido: Boolean = True);
begin
  Self.FsExibeEstado := STRING_INDEFINIDO;

  if(not(pbMostrarNaoDefinido) and (Self.FnFk_Estado =REGISTRO_NULO))then
    Self.FsExibeEstado := STRING_INDEFINIDO

  else
  begin
    if(Self.FnFk_Estado <> NUMERO_INDEFINIDO)then
    begin
      DM.zQryEstado.Close;
      DM.zQryEstado.SQL.Clear;
      DM.zQryEstado.SQL.Add('SELECT * FROM estado WHERE codigo=:cod');
      DM.zQryEstado.ParamByName('cod').AsInteger := Self.FnFk_Estado;
      DM.zQryEstado.Open;
      if(DM.zQryEstado.RecordCount = 1)then
        //Self.FsExibeEstado := DM.zQryEstadoCODIGO.AsString + ' - ' + DM.zQryEstadoNOME.AsString;
        Self.FsExibeEstado := DM.zQryEstadoNOME.AsString;
    end;
  end;
end;

function TObjPessoaFisica.getExibeEstado(): String;
begin
  Result := Self.FsExibeEstado;
end;

procedure TObjPessoaFisica.setExibeCidade(const pbMostrarNaoDefinido: Boolean = True);
begin
  Self.FsExibeCidade := STRING_INDEFINIDO;

  if(not(pbMostrarNaoDefinido) and (Self.FnFk_Cidade =REGISTRO_NULO))then
    Self.FsExibeCidade := STRING_INDEFINIDO

  else
  begin
    if(Self.FnFk_Cidade <> NUMERO_INDEFINIDO)then
    begin
      DM.zQryCidade.Close;
      DM.zQryCidade.SQL.Clear;
      DM.zQryCidade.SQL.Add('SELECT * FROM cidade WHERE codigo=:cod');
      DM.zQryCidade.ParamByName('cod').AsInteger := Self.FnFk_Cidade;
      DM.zQryCidade.Open;
      if(DM.zQryCidade.RecordCount = 1)then
        //Self.FsExibeCidade := DM.zQryCidadeCODIGO.AsString + ' - ' + DM.zQryCidadeNOME.AsString;
        Self.FsExibeCidade := DM.zQryCidadeNOME.AsString;
    end;
  end;
end;

function TObjPessoaFisica.getExibeCidade(): String;
begin
  Result := Self.FsExibeCidade;
end;

procedure TObjPessoaFisica.setExibeBairro(const pbMostrarNaoDefinido: Boolean = True);
begin
  Self.FsExibeBairro := STRING_INDEFINIDO;

  if(not(pbMostrarNaoDefinido) and (Self.FnFk_Bairro =REGISTRO_NULO))then
    Self.FsExibeBairro := STRING_INDEFINIDO

  else
  begin
    if(Self.FnFk_Bairro <> NUMERO_INDEFINIDO)then
    begin
      DM.zQryBairro.Close;
      DM.zQryBairro.SQL.Clear;
      DM.zQryBairro.SQL.Add('SELECT * FROM bairro WHERE codigo=:cod');
      DM.zQryBairro.ParamByName('cod').AsInteger := Self.FnFk_Bairro;
      DM.zQryBairro.Open;
      if(DM.zQryBairro.RecordCount = 1)then
        //Self.FsExibeBairro := DM.zQryBairroCODIGO.AsString + ' - ' + DM.zQryBairroNOME.AsString;
        Self.FsExibeBairro := DM.zQryBairroNOME.AsString;
    end;
  end;
end;

function TObjPessoaFisica.getExibeBairro(): String;
begin
  Result := Self.FsExibeBairro;
end;

procedure TObjPessoaFisica.setExibeRua(const pbMostrarNaoDefinido: Boolean = True);
begin
  Self.FsExibeRua := STRING_INDEFINIDO;

  if(not(pbMostrarNaoDefinido) and (Self.FnFk_Rua =REGISTRO_NULO))then
    Self.FsExibeRua := STRING_INDEFINIDO

  else
  begin
    if(Self.FnFk_Rua <> NUMERO_INDEFINIDO)then
    begin
      DM.zQryRua.Close;
      DM.zQryRua.SQL.Clear;
      DM.zQryRua.SQL.Add('SELECT * FROM rua WHERE codigo=:cod');
      DM.zQryRua.ParamByName('cod').AsInteger := Self.FnFk_Rua;
      DM.zQryRua.Open;
      if(DM.zQryRua.RecordCount = 1)then
        //Self.FsExibeRua := DM.zQryRuaCODIGO.AsString + ' - ' + DM.zQryRuaNOME.AsString;
        Self.FsExibeRua := DM.zQryRuaNOME.AsString;
    end;
  end;
end;

function TObjPessoaFisica.getExibeRua(): String;
begin
  Result := Self.FsExibeRua;
end;

{***** procedimentos diversos *****}

//limpa os dados do objeto
procedure TObjPessoaFisica.limparObjeto();
begin
    Self.setCodigo(NUMERO_INDEFINIDO);
    Self.setDataCadastro(NUMERO_INDEFINIDO);
    Self.setNome(STRING_INDEFINIDO);
    Self.setEmail(STRING_INDEFINIDO);
    Self.setCPF(STRING_INDEFINIDO);
    Self.setIdentidade(STRING_INDEFINIDO);
    Self.setDataNascimento(NUMERO_INDEFINIDO);
    Self.setConjuge(STRING_INDEFINIDO);
    Self.setTelefoneResidencial(STRING_INDEFINIDO);
    Self.setTelefoneComercial(STRING_INDEFINIDO);
    Self.setTelefoneCelular(STRING_INDEFINIDO);
    Self.setFkEstado(NUMERO_INDEFINIDO);
    Self.setFkCidade(NUMERO_INDEFINIDO);
    Self.setFkBairro(NUMERO_INDEFINIDO);
    Self.setFkRua(NUMERO_INDEFINIDO);
    Self.setEnderecoCEP(STRING_INDEFINIDO);
    Self.setEnderecoComplemento(STRING_INDEFINIDO);
    Self.setHorarioLigacao(STRING_INDEFINIDO);
    Self.setHoraInicio(NUMERO_INDEFINIDO);
    Self.setHoraFinal(NUMERO_INDEFINIDO);
    Self.setExibeEstado();
    Self.setExibeCidade();
    Self.setExibeBairro();
    Self.setExibeRua();
end;

//verifica se existe diferença no objeto. Quando estiver editando registro
function TObjPessoaFisica.verificarDiferencaCadastro(pnFkMeioCaptacao:Integer;
  pnFkEstado:Integer; pnFkCidade:Integer; pnFkBairro:Integer; pnFkRua:Integer;
  psEnderecoCEP:String; psEnderecoComplemento:String; psNome:String;
  psEmail:String; psCPF:String; psIdentidade:String; pdDataNascimento:TDate;
  psConjuge:String; psTelefoneResidencial:String; psTelefoneComercial:String;
  psTelefoneCelular:String; psHorarioLigacao:String; ptHoraInicio: TTime;
  ptHoraFinal: TTime): Boolean;
var
  retorno: Boolean;
begin
  retorno := False;

  if (pnFkMeioCaptacao <> Self.getFkMeioCaptacao) then
    retorno := True;
  if (pnFkEstado <> Self.getFkEstado) then
    retorno := True;
  if (pnFkCidade <> Self.getFkCidade) then
    retorno := True;
  if (pnFkBairro <> Self.getFkBairro) then
    retorno := True;
  if (pnFkRua <> Self.getFkRua) then
    retorno := True;
  if (psEnderecoCEP <> Self.getEnderecoCEP) then
    retorno := True;
  if (psEnderecoComplemento <> Self.getEnderecoComplemento) then
    retorno := True;
  if (psNome <> Self.getNome) then
    retorno := True;
  if (psEmail <> Self.getEmail) then
    retorno := True;
  if (psCPF <> Self.getCPF) then
    retorno := True;
  if (psIdentidade <> Self.getIdentidade) then
    retorno := True;
  if (pdDataNascimento <> Self.getDataNascimento) then
    retorno := True;
  if (psConjuge <> Self.getConjuge) then
    retorno := True;
  if (psTelefoneResidencial <> Self.getTelefoneResidencial) then
    retorno := True;
  if (psTelefoneComercial <> Self.getTelefoneComercial) then
    retorno := True;
  if (psTelefoneCelular <> Self.getTelefoneCelular) then
    retorno := True;
  if (psHorarioLigacao <> Self.getHorarioLigacao) then
    retorno := True;
  if (ptHoraInicio <> Self.getHoraInicio) then
    retorno := True;
  if (ptHoraFinal <> Self.getHoraFinal) then
    retorno := True;

  Result := retorno;
end;

end.
