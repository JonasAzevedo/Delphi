unit unObjPessoaJuridica;

interface

uses
  unDM,
  Controls; //TDate

  type TObjPessoaJuridica = class

    private
      FnCodigo: Integer;
      FdDataCadastro: TDateTime;
      FsNome: String[100];
      FsEmail: String[100];
      FsCNPJ: String[30];
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
      procedure setCNPJ(psCNPJ: String);
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
      function getCNPJ(): String;
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
      function verificarDiferencaCadastro(psNome:String; psEmail:String; psCNPJ:String;
       psTelefoneResidencial:String; psTelefoneComercial:String; psTelefoneCelular:String;
       pnFkMeioCaptacao:Integer; pnFkEstado:Integer; pnFkCidade:Integer;
       pnFkBairro:Integer; pnFkRua:Integer; psEnderecoCEP:String;
       psEnderecoComplemento:String; psHorarioLigacao:String; ptHoraInicio: TTime;
       ptHoraFinal: TTime): Boolean;
  end;

implementation

uses
  unConstantes, Variants;

{ TObjPessoaJuridica }

{***** set's e get's *****}
procedure TObjPessoaJuridica.setCodigo(pnCodigo: Integer);
begin
  try
    Self.FnCodigo := pnCodigo;
  except
    Self.FnCodigo := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getCodigo: Integer;
begin
  Result := Self.FnCodigo;
end;

procedure TObjPessoaJuridica.setDataCadastro(pdDataCadastro: TDateTime);
begin
  try
    Self.FdDataCadastro := pdDataCadastro;
  except
    Self.FdDataCadastro := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getDataCadastro(): TDateTime;
begin
  Result := Self.FdDataCadastro;
end;

procedure TObjPessoaJuridica.setNome(psNome: String);
begin
  try
    Self.FsNome := psNome;
  except
    Self.FsNome := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getNome(): String;
begin
  Result := Self.FsNome;
end;

procedure TObjPessoaJuridica.setEmail(psEmail: String);
begin
  try
    Self.FsEmail := psEmail;
  except
    Self.FsEmail := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getEmail(): String;
begin
  Result := Self.FsEmail;
end;

procedure TObjPessoaJuridica.setCNPJ(psCNPJ: String);
begin
  try
    Self.FsCNPJ := psCNPJ;
  except
    Self.FsCNPJ := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getCNPJ(): String;
begin
  Result := Self.FsCNPJ;
end;

procedure TObjPessoaJuridica.setTelefoneResidencial(psTelefoneResidencial: String);
begin
  try
    Self.FsTelefoneResidencial := psTelefoneResidencial;
  except
    Self.FsTelefoneResidencial := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getTelefoneResidencial(): String;
begin
  Result := Self.FsTelefoneResidencial;
end;

procedure TObjPessoaJuridica.setTelefoneComercial(psTelefoneComercial: String);
begin
  try
    Self.FsTelefoneComercial := psTelefoneComercial;
  except
    Self.FsTelefoneComercial := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getTelefoneComercial(): String;
begin
  Result := Self.FsTelefoneComercial;
end;

procedure TObjPessoaJuridica.setTelefoneCelular(psTelefoneCelular: String);
begin
  try
    Self.FsTelefoneCelular := psTelefoneCelular;
  except
    Self.FsTelefoneCelular := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getTelefoneCelular(): String;
begin
  Result := Self.FsTelefoneCelular;
end;

procedure TObjPessoaJuridica.setFkMeioCaptacao(pnFkMeioCaptacao: Integer);
begin
  try
    Self.FnFk_MeioCaptacao := pnFkMeioCaptacao;
  except
    Self.FnFk_MeioCaptacao := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getFkMeioCaptacao(): Integer;
begin
  Result := Self.FnFk_MeioCaptacao;
end;

procedure TObjPessoaJuridica.setFkEstado(pnFkEstado: Integer);
begin
  try
    Self.FnFk_Estado := pnFkEstado;
  except
    Self.FnFk_Estado := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getFkEstado(): Integer;
begin
  Result := Self.FnFk_Estado;
end;

procedure TObjPessoaJuridica.setFkCidade(pnFkCidade: Integer);
begin
  try
    Self.FnFk_Cidade := pnFkCidade;
  except
    Self.FnFk_Cidade := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getFkCidade(): Integer;
begin
  Result := Self.FnFk_Cidade;
end;

procedure TObjPessoaJuridica.setFkBairro(pnFkBairro: Integer);
begin
  try
    Self.FnFk_Bairro := pnFkBairro;
  except
    Self.FnFk_Bairro := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getFkBairro(): Integer;
begin
  Result := Self.FnFk_Bairro;
end;

procedure TObjPessoaJuridica.setFkRua(pnFkRua: Integer);
begin
  try
    Self.FnFk_Rua := pnFkRua;
  except
    Self.FnFk_Rua := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getFkRua(): Integer;
begin
  Result := Self.FnFk_Rua;
end;

procedure TObjPessoaJuridica.setEnderecoCEP(psEnderecoCEP: String);
begin
  try
    Self.FsEnderecoCEP := psEnderecoCEP;
  except
    Self.FsEnderecoCEP := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getEnderecoCEP(): String;
begin
  Result := Self.FsEnderecoCEP;
end;

procedure TObjPessoaJuridica.setEnderecoComplemento(psEnderecoComplemento: String);
begin
  try
    Self.FsEnderecoComplemento := psEnderecoComplemento;
  except
    Self.FsEnderecoComplemento := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getEnderecoComplemento(): String;
begin
  Result := Self.FsEnderecoComplemento;
end;

procedure TObjPessoaJuridica.setHorarioLigacao(psHorarioLigacao: String);
begin
  try
    Self.FsHorarioLigacao := psHorarioLigacao;
  except
    Self.FsHorarioLigacao := STRING_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getHorarioLigacao(): String;
begin
  Result := Self.FsHorarioLigacao;
end;

procedure TObjPessoaJuridica.setHoraInicio(ptHoraInicio: TTime);
begin
  try
    Self.FtHoraInicio := ptHoraInicio;
  except
    Self.FtHoraInicio := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getHoraInicio(): TTime;
begin
  Result := Self.FtHoraInicio;
end;

procedure TObjPessoaJuridica.setHoraFinal(ptHoraFinal: TTime);
begin
  try
    Self.FtHoraFinal := ptHoraFinal;
  except
    Self.FtHoraFinal := NUMERO_INDEFINIDO;
  end;
end;

function TObjPessoaJuridica.getHoraFinal(): TTime;
begin
  Result := Self.FtHoraFinal;
end;

procedure TObjPessoaJuridica.setExibeMeioCaptacao(const pbMostrarNaoDefinido: Boolean = True);
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

function TObjPessoaJuridica.getExibeMeioCaptacao(): String;
begin
  Result := Self.FsExibeMeioCaptacao;
end;

procedure TObjPessoaJuridica.setExibeEstado(const pbMostrarNaoDefinido: Boolean = True);
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

function TObjPessoaJuridica.getExibeEstado(): String;
begin
  Result := Self.FsExibeEstado;
end;

procedure TObjPessoaJuridica.setExibeCidade(const pbMostrarNaoDefinido: Boolean = True);
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

function TObjPessoaJuridica.getExibeCidade(): String;
begin
  Result := Self.FsExibeCidade;
end;

procedure TObjPessoaJuridica.setExibeBairro(const pbMostrarNaoDefinido: Boolean = True);
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

function TObjPessoaJuridica.getExibeBairro(): String;
begin
  Result := Self.FsExibeBairro;
end;

procedure TObjPessoaJuridica.setExibeRua(const pbMostrarNaoDefinido: Boolean = True);
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

function TObjPessoaJuridica.getExibeRua(): String;
begin
  Result := Self.FsExibeRua;
end;

{***** procedimentos diversos *****}

//limpa os dados do objeto
procedure TObjPessoaJuridica.limparObjeto();
begin
  Self.setCodigo(NUMERO_INDEFINIDO);
  Self.setDataCadastro(NUMERO_INDEFINIDO);
  Self.setNome(STRING_INDEFINIDO);
  Self.setEmail(STRING_INDEFINIDO);
  Self.setCNPJ(STRING_INDEFINIDO);
  Self.setTelefoneResidencial(STRING_INDEFINIDO);
  Self.setTelefoneComercial(STRING_INDEFINIDO);
  Self.setTelefoneCelular(STRING_INDEFINIDO);
  Self.setFkMeioCaptacao(NUMERO_INDEFINIDO);
  Self.setFkEstado(NUMERO_INDEFINIDO);
  Self.setFkCidade(NUMERO_INDEFINIDO);
  Self.setFkBairro(NUMERO_INDEFINIDO);
  Self.setFkRua(NUMERO_INDEFINIDO);
  Self.setEnderecoCEP(STRING_INDEFINIDO);
  Self.setEnderecoComplemento(STRING_INDEFINIDO);
  Self.setHorarioLigacao(STRING_INDEFINIDO);
  Self.setHoraInicio(NUMERO_INDEFINIDO);
  Self.setHoraFinal(NUMERO_INDEFINIDO);
  Self.setExibeMeioCaptacao();
  Self.setExibeEstado();
  Self.setExibeCidade();
  Self.setExibeBairro();
  Self.setExibeRua();
end;

//verifica se existe diferença no objeto. Quando estiver editando registro
function TObjPessoaJuridica.verificarDiferencaCadastro(psNome:String; psEmail:String;
  psCNPJ:String; psTelefoneResidencial:String; psTelefoneComercial:String;
  psTelefoneCelular:String; pnFkMeioCaptacao:Integer; pnFkEstado:Integer;
  pnFkCidade:Integer; pnFkBairro:Integer; pnFkRua:Integer; psEnderecoCEP:String;
  psEnderecoComplemento:String; psHorarioLigacao:String; ptHoraInicio: TTime;
  ptHoraFinal: TTime): Boolean;
var
  retorno: Boolean;
begin
  retorno := False;

  if (psNome <> Self.getNome) then
    retorno := True;
  if (psEmail <> Self.getEmail) then
    retorno := True;
  if (psCNPJ <> Self.getCNPJ) then
    retorno := True;
  if (psTelefoneResidencial <> Self.getTelefoneResidencial) then
    retorno := True;
  if (psTelefoneComercial <> Self.getTelefoneComercial) then
    retorno := True;
  if (psTelefoneCelular <> Self.getTelefoneCelular) then
    retorno := True;
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
  if (psHorarioLigacao <> Self.getHorarioLigacao) then
    retorno := True;
  if (ptHoraInicio <> Self.getHoraInicio) then
    retorno := True;
  if (ptHoraFinal <> Self.getHoraFinal) then
    retorno := True;

  Result := retorno;
end;

end.
