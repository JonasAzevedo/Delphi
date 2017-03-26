unit unFuncoes;

interface

uses
  Controls, //TWinControl
  Forms, //TForm
  unConstantes,
  plsEdit,
  unVariaveis;
  
  type TFuncoes = class

    private

    public
      procedure configurarComponenteEscreveDireitaParaEsquerda(poForm: TForm);
      procedure fecharComponentesBD(poForm: TForm);//fecha componentes de acesso ao BD
      function getVersao(): string;
      procedure gravaMensagemSistemaDiversos(pvDescricao: Variant; psTipo: String); //grava um registro na tabela sistema_diversos
      procedure iniciarTela(); //inicia configurações da tela
      function retirarCaracteres(psPalavra, psCaracRetirar: string): string;
      procedure focarComponente(poComp: TWinControl);
      function formatarDataFormatoAmericano(psData: string): string; overload;
      function formatarDataFormatoAmericano(pData: TDate): string; overload;
      function inserirCondicaoSelectNaoTrazerRegistroNulo(const psAlias:String = STRING_INDEFINIDO): String; //insere condição para o select não trazer registro nulo
      function formatarValorMonetario(psValor:String): String;
      function realizarLogin(psUsuario,psSenha: string; var nCodigo:Integer; var sNome: String): boolean;

      function validarData(psData: string): boolean;
      function validarHora(psHora: string): boolean;
      function validarEmail(psEmail: string): boolean;
      function validarTelefone(psTelefone: string): boolean;
      function validarCPF(psCPF: string): boolean;
      function validarCNPJ(psCNPJ: string): boolean;
      function validarCEP(psCEP: string): boolean;
      function validarValorMonetario(psValor: string): boolean;
      function verificaTelefone_EhVazio(psTelefone: String): boolean; //valida se o telefone está vazio
      function verificaCPF_EhVazio(psCPF: String): boolean; //valida se o CPF está vazio
      function verificaCNPJ_EhVazio(psCNPJ: String): boolean; //valida se o CNPJ está vazio
      function verificaCEP_EhVazio(psCEP: String): boolean; //valida se o CEP está vazio
      function formatarData(psData: String): TDate;
      function formatarValorInteiro(psValor: string): Integer;
      function formatarValorCurrency(psValor: String; pbRetirarPonto: Boolean = True): Currency;
      function formatarCPF(psCPF: String): String; //formata CPF, inserindo os caracteres '.-'
      function formatarCNPJ(psCNPJ: String): String; //formata CNPJ, inserindo os caracteres './-'

      //verifica se a pKey pertence ao poConjuntoTeclas
      function verificarCaracterPertenceConjuntoTeclasAceitas(pKey: Word;
        poConjuntoTeclas: TConjuntosTeclas = [todas]; pbVerificarOutrosCaracteres: Boolean = True): Boolean;
  end;

implementation

uses
  SysUtils, //configurarFormatoDataHora()
  ZDataset, //TZQuery, TZTable
  DBClient, //TClientDataSet
  Windows,
  Dialogs,
  StrUtils,
  unDM,
  classes;

var
  vet_valido: array [0..35] of string = ('0','1','2','3','4','5','6','7', '8','9','a','b','c','d','e','f', 'g','h','i','j','k','l','m','n', 'o','p','q','r','s','t','u','v', 'w','x','y','z');

{ TFuncoes }

procedure TFuncoes.configurarComponenteEscreveDireitaParaEsquerda(poForm: TForm);
var
  i: Integer;
  OldSysLocal: TSysLocale;
begin
  for i:= 0 to poForm.ComponentCount-1 do
  begin
    if(poForm.Components[i] is TPlsEdit)then
    begin
      if(TPlsEdit(poForm.Components[i]).plsEntraCaracteres = direitaEsquerda)then
      begin
        OldSysLocal := SysLocale;
        SysLocale.MiddleEast := True;
        TPlsEdit(poForm.Components[i]).BiDiMode := bdRightToLeft;
      end;
    end;
  end;
end;

//inicia configurações da tela
procedure TFuncoes.fecharComponentesBD(poForm: TForm);
var
  n: Integer;
  nTotComponentes: integer;
begin
  nTotComponentes := poForm.ComponentCount;
  try
    for n:=0 to nTotComponentes-1 do
    begin
      try
        if(poForm.Components[n] is TZQuery)then
          (poForm.Components[n] as TZQuery).Close
        else if(poForm.Components[n] is TZTable)then
          (poForm.Components[n] as TZTable).Close
        else if (poForm.Components[n] is TClientDataSet)then
          (poForm.Components[n] as TClientDataSet).Close
      except
        Self.gravaMensagemSistemaDiversos('procedure TFuncoes.fecharComponentesBD(poForm: TForm)', 'Erro');
      end;
    end;
  except
  end;
end;

function TFuncoes.getVersao(): String;
type
    PFFI = ^vs_FixedFileInfo;
var
    F : PFFI;
    Handle : Dword;
    Len : Longint;
    Data : Pchar;
    Buffer : Pointer;
    Tamanho : Dword;
    Parquivo: Pchar;
    Arquivo : String;
begin
  Arquivo := Application.ExeName;
  Parquivo := StrAlloc(Length(Arquivo) + 1);
  StrPcopy(Parquivo, Arquivo);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  Result := '';
  if (Len > 0) then
    begin
    Data:=StrAlloc(Len+1);
    if (GetFileVersionInfo(Parquivo,Handle,Len,Data)) then
      begin
      VerQueryValue(Data, '\',Buffer,Tamanho);
      F := PFFI(Buffer);
      Result := Format('%d.%d.%d.%d',
      [HiWord(F^.dwFileVersionMs),
      LoWord(F^.dwFileVersionMs),
      HiWord(F^.dwFileVersionLs),
      Loword(F^.dwFileVersionLs)]);
      end;
    StrDispose(Data);
    end;
  StrDispose(Parquivo);
end;

//grava um registro tabela sistema_diversos
procedure TFuncoes.gravaMensagemSistemaDiversos(pvDescricao: Variant;
  psTipo: String);
begin
  try
    DM.ZConnection.StartTransaction;
    DM.zQrySistema_Diversos.Close;
    DM.zQrySistema_Diversos.SQL.Clear;
    DM.zQrySistema_Diversos.SQL.Add('INSERT INTO sistema_diversos(descricao,tipo) ');
    DM.zQrySistema_Diversos.SQL.Add('VALUES(:des, :tip)');
    DM.zQrySistema_Diversos.ParamByName('des').AsBlob := pvDescricao;
    DM.zQrySistema_Diversos.ParamByName('tip').AsString := psTipo;
    DM.zQrySistema_Diversos.ExecSQL;
    DM.ZConnection.Commit;
  except
    DM.ZConnection.Rollback;
  end;
end;

//inicia configurações da tela
procedure TFuncoes.iniciarTela();
begin

end;

//retirar caracteres de um texto
function TFuncoes.retirarCaracteres(psPalavra, psCaracRetirar: string): string;
var
  i: Integer;
  c: String;
begin
  for i:=1 to length(psCaracRetirar) do
  begin
    c := Copy(psCaracRetirar,i,1);
    psPalavra := StringReplace(psPalavra, c, '', [rfReplaceAll, rfIgnoreCase]);
  end;
  Result := Trim(psPalavra);
end;

procedure TFuncoes.focarComponente(poComp: TWinControl);
begin
  try
    if poComp is TWinControl then
      TWinControl(poComp).SetFocus;
  except
  end;
end;

function TFuncoes.formatarDataFormatoAmericano(psData: string): string;
var
  sAux,sRetorno: string;
begin
  sAux := '';
  sRetorno := '';
  sAux := copy(psData,7,4); //ano
  sRetorno := sAux + '/';
  sAux := copy(psData,4,2); //mês
  sRetorno := sRetorno + sAux + '/';
  sAux := copy(psData,1,2); //dia
  sRetorno := sRetorno + sAux;

  Result := sRetorno;
end;

function TFuncoes.formatarDataFormatoAmericano(pData: TDate): string;
var
  sData: string;
  sAux,sRetorno: string;
begin
  sAux := '';
  sData := DateToStr(pData);
  sRetorno := '';
  sAux := copy(sData,7,4); //ano
  sRetorno := sAux + '/';
  sAux := copy(sData,4,2); //mês
  sRetorno := sRetorno + sAux + '/';
  sAux := copy(sData,1,2); //dia
  sRetorno := sRetorno + sAux;

  Result := sRetorno;
end;

//insere condição para o select não trazer registro nulo
function TFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo(const psAlias:String = STRING_INDEFINIDO): String;
begin
  if(psAlias = STRING_INDEFINIDO)then
    Result := ' WHERE codigo <> ''' + IntToStr(REGISTRO_NULO) + ''''
  else
    Result := ' WHERE ' + psAlias + '.codigo <> ''' + IntToStr(REGISTRO_NULO) + '''';
end;

function TFuncoes.formatarValorMonetario(psValor:String): String;
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

function TFuncoes.realizarLogin(psUsuario,psSenha: string;
 var nCodigo:Integer; var sNome: String): boolean;
begin
  DM.zQryUsuario.Close;
  DM.zQryUsuario.SQL.Clear;
  DM.zQryUsuario.SQL.Add('SELECT * FROM usuario WHERE login=:log AND senha=:sen');
  DM.zQryUsuario.ParamByName('log').AsString := psUsuario;
  DM.zQryUsuario.ParamByName('sen').AsString := psSenha;
  DM.zQryUsuario.Open;
  if(DM.zQryUsuario.RecordCount = 1)then
  begin
    nCodigo := DM.zQryUsuarioCODIGO.AsInteger;
    sNome := DM.zQryUsuarioNOME.AsString;
    Result := True;
  end
  else
  begin
    nCodigo := NUMERO_INDEFINIDO;
    sNome := STRING_INDEFINIDO;
    Result := False;
  end;
end;

function TFuncoes.validarData(psData: string): boolean;
begin
  Result := True;
  try
    StrToDate(psData);
  except
    on EConvertError do
      result := False;
  end;
end;

function TFuncoes.validarHora(psHora: string): boolean;
begin
  Result := true;
  try
    StrToTime(psHora);
  except
    on EConvertError do
      result := False;
  end;
end;

function TFuncoes.validarEmail(psEmail: string): boolean;
const
  //function VerificaEmail
  msg1 = 'Caractere(s) inválido(s) no início do e-mail.';
  msg2 = 'Símbolo @ não foi encontrado.';
  msg3 = 'Excesso do símbolo @.';
  msg4 = 'Caractere(s) inválido(s) antes do símbolo @.';
  msg5 = 'Caractere(s) inválido(s) depois do símbolo @.';
  msg6 = 'Agrupamento de caractere(s) inválido(s) a esqueda do @.';
  msg7 = 'Não existe ponto(s) digitado(s).';
  msg8 = 'Ponto encontrado no final do e-mail.';
  msg9 = 'Ausência de caractere(s) após o último ponto.';
  msg10 = 'Excesso de ponto(s) a direita do @.';
  msg11 = 'Ponto(s) disposto(s) de forma errada após o @.';
  msg12 = 'Caractere(s) inválido(s) antes do ponto.';
  msg13 = 'Caractere(s) inválido(s) depois do ponto.';

var
  i, j, tam_email, simb_arroba, simb_arroba2, qtd_arroba, qtd_pontos,
  qtd_pontos_esq, qtd_pontos_dir, posicao, posicao2, ponto, ponto2: integer;
  vet_email: array [0..49] of string; //50 posições, capacidade do Edit
  msg: string;
begin
  qtd_pontos:= 0;
  qtd_pontos_esq:= 0;
  qtd_pontos_dir:= 0;
  qtd_arroba:= 0;
  posicao:=0;
  posicao2:=0;
  simb_arroba:=0;
  simb_arroba2:=0;
  ponto:= 0;
  ponto2:= 0;
  msg:='';
  Result:= True;

  //Verificando parte inicial do E-mail
  tam_email:= Length(psEmail);
  for i:= 0 to tam_email-1 do
    begin
    vet_email[i]:= Copy(psEmail,i+1,1);
    if vet_email[i] = '@' then
      begin
      Inc(qtd_arroba);
      posicao:= i;
      end;
    end;

  if ((vet_email[0] = '@') or (vet_email[0] = '.') or (vet_email[0] = '-')) then
    begin
    Result:= False;
    msg:= msg1;
    end;

  //Verificando se tem o símbolo @ e quantos tem
  if qtd_arroba < 1 then
    begin
    Result:= False;
    msg:= msg2;
    end
  else if qtd_arroba > 1 then
    begin
    Result:= False;
    msg:= msg3 + ' Encontrado(s): '+IntToStr(qtd_arroba)+'.';
    end
  else
    //Verificando o que vem antes e depois do símbolo @
    begin
    for i:=0 to 35 do
      begin
      if vet_email[posicao-1] <> vet_valido[i] then
        Inc(simb_arroba)
      else
        Dec(simb_arroba);
      if vet_email[posicao+1] <> vet_valido[i] then
        Inc(simb_arroba2)
      else
        Dec(simb_arroba2);
    end;
  if simb_arroba = 36 then
    begin
    //Antes do arroba há um símbolo desconhecido do vetor válido
    Result:= False;
    msg:= msg4;
    end
  else if simb_arroba2 = 36 then
    begin
    //Depois do arroba há um símbolo desconhecido do vetor válido
    Result:= False;
    msg:= msg5;
    end
  end;

  //Verificando se há pontos e quantos, e Verificando parte final do e-mail
  for j:=0 to tam_email-1 do
    if vet_email[j] = '-' then
      if ((vet_email[j-1] = '.') or (vet_email[j-1] = '-')) then
        begin
        Result:= False;
        msg:= msg6;
        end;
  for i:=0 to tam_email-1 do
    if vet_email[i] = '.' then
      begin
      Inc(qtd_pontos);
      posicao2:= i+1;
      if i > posicao then
        Inc(qtd_pontos_dir)
      else
        Inc(qtd_pontos_esq);
      if ((vet_email[i-1] = '.') or (vet_email[i-1] = '-')) then
        begin
        Result:= False;
        msg:= msg6;
        end;
      end;
  if qtd_pontos < 1 then
    begin
    Result:= False;
    msg:= msg7;
    end
  else if vet_email[tam_email-1] = '.' then
    begin
    Result:= False;
    msg:= msg8;
    end
  else if vet_email[tam_email-2] = '.' then
    begin
    Result:= False;
    msg:= msg9;
    end
  else if qtd_pontos_dir > 3 then
    begin
    Result:= False;
    msg:= msg10 + ' Encontrado(s): '+
    IntToStr(qtd_pontos)+#10+'Encontrado(s) a direita do @: '+
    IntToStr(qtd_pontos_dir)+'.';
    end
  else if (not ((((tam_email - posicao2) < 4) and (qtd_pontos_dir = 3)) or
  (((tam_email - posicao2) < 4) and (qtd_pontos_dir = 2)) or
  (((tam_email - posicao2) < 4) and (qtd_pontos_dir = 1)))) then
    begin
    Result:= False;
    msg:= msg11 +#10+ 'Encontrado(s) a esquerda do @: '+
    IntToStr(qtd_pontos_esq) +#10+ 'Encontrado(s) a direita do @: '+
    IntToStr(qtd_pontos_dir)+'.';
    end
  else
    //Verificando o que vem antes e depois do ponto
    begin
    for i:=0 to 35 do
      begin
      if vet_email[posicao2-2] <> vet_valido[i] then
        Inc(ponto)
      else
        Dec(ponto);
      if vet_email[posicao2] <> vet_valido[i] then
        Inc(ponto2)
      else
        Dec(ponto2);
    end;
  if ponto = 36 then
    begin
    //Antes do ponto há um símbolo desconhecido do vetor válido
    Result:= False;
    msg:= msg12;
    end
  else if ponto2 = 36 then
    begin
    //Depois do ponto há um símbolo desconhecido do vetor válido
    Result:= False;
    msg:= msg13;
    end
  end;

  //Verificação final
  if not Result then
    begin
    msg:= msg +#10+ 'Formato de E-mail não aceitável!!';
    MessageDlg(msg,mtWarning,[mbRetry],0);
    end;
end;

function TFuncoes.validarTelefone(psTelefone: string): boolean;
var
  bRetorno: boolean;
  i: Integer;
  iAux: Integer;
  sAux: String;
begin
  bRetorno := true;
  if(Length(psTelefone) <> 13)then
    bRetorno := false;

  if(bRetorno)then //verifica caracteres do telefone
  begin
    if(Copy(psTelefone,1,1)<>'(')then // '('
      bRetorno := false;
    if(bRetorno)then
    begin
      sAux := Copy(psTelefone,2,2); //DDD
      try
        iAux := StrToInt(sAux);
      except
        bRetorno := false;
      end;
      if(bRetorno)then // ')'
      begin
        if(Copy(psTelefone,4,1)<>')')then
          bRetorno := false;
        if(bRetorno)then //4 nºs iniciais do telefone
        begin
          sAux := Copy(psTelefone,5,4);
          try
            iAux := StrToInt(sAux);
          except
            bRetorno := false;
          end;
          if(bRetorno)then //traço que divide as duas partes do nº
          begin
            if(Copy(psTelefone,9,1)<>'-')then // '('
              bRetorno := false;
            if(bRetorno)then //4 nºs finais do telefone
            begin
              sAux := Copy(psTelefone,10,4);
              try
                iAux := StrToInt(sAux);
              except
                bRetorno := false;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  Result := bRetorno;
end;

//baseado no artigo Algoritmo CNPJ do Clube da Informática
//http://www.clubedainformatica.com.br/mostraartigo.php?artigo=63
function TFuncoes.validarCNPJ(psCNPJ: string): boolean;
var
  cnpj: array[1..15] of integer;
  apoio: array[0..15] of integer;
  f: integer;//para uso no for
  total: integer;//para totalização dos valores
  D1: integer;//primeiro dígito calculado
  D2: integer;//segundo dígito calculado
begin
  //primeiro teste: o número de algarismos
  if (Length(psCNPJ)<>14) then
    Result:=false
  else
  begin
    //Antes do teste propriamente dito temos que montar a matriz com os
    //algarismos do CNPJ e depois uma matriz apoio que terá os números
    //que ajudarão a verificar so dígitos verificadores.
    //Monta matriz cnpj
    for f := 1 to 14 do
    begin
      cnpj[f]:=strtoint(psCNPJ[f]);
    end;
  end;
  //Monta matriz de apoio
  apoio[0]:=6;//só será usada no cálculo do segundo dígito verificador
  apoio[1]:=5;
  apoio[2]:=4;
  apoio[3]:=3;
  apoio[4]:=2;
  apoio[5]:=9;
  apoio[6]:=8;
  apoio[7]:=7;
  apoio[8]:=6;
  apoio[9]:=5;
  apoio[10]:=4;
  apoio[11]:=3;
  apoio[12]:=2;
  //começa cálculo do primeiro dígito verificador
  total:=0;//variável que conterá a soma da operação com os números
  for f := 1 to 12 do
  begin
    total:=total+(cnpj[f]*apoio[f]);
  end;
  D1 := total mod 11;
  if (D1<2) then
    D1:=0
  else
    D1:=11-D1;
  if (D1<>cnpj[13]) then
  begin
    //primeiro dígito verificador não confere
    Result:=false;
  end
  else
  begin
    //entrou aqui, então o primeiro dígito confere!
    total:=0;
    for f := 0 to 12 do
    begin
      total:=total+(cnpj[f+1]*apoio[f]);
    end;
    D2 :=total mod 11;
    if (D2<2) then
      D2:=0
    else
      D2:=11-D2;
    if (D2<>cnpj[14]) then
    begin
      //segundo digito verificador não confere
      Result:=false;
    end
    else
      Result:=true;
  end;
end;

function TFuncoes.validarCEP(psCEP: string): boolean;
var
  bRetorno: boolean;
  iAux: Integer;
  sAux: String;
begin
  bRetorno := True;
  if(Length(psCEP) <> 9)then
    bRetorno := false;

  if(bRetorno)then //verifica caracteres do cep
  begin
    sAux := Copy(psCEP,1,5); //1ª parte do CEP
    try
      iAux := StrToInt(sAux);
    except
      bRetorno := false;
    end;
    if(bRetorno)then // '-'
    begin
      if(Copy(psCEP,6,1)<>'-')then
        bRetorno := false;
      if(bRetorno)then //2ª parte do CEP
      begin
        sAux := Copy(psCEP,7,3);
        try
          iAux := StrToInt(sAux);
        except
          bRetorno := false;
        end;
      end;
    end;
  end;

  Result := bRetorno;
end;

function TFuncoes.validarValorMonetario(psValor: string): boolean;
var
  sValor: String;
begin
  Result := True;

  sValor := Self.retirarCaracteres(psValor, '.');
  try
    StrToCurr(sValor);
  except
    on EConvertError do
      result := False;
  end;
end;

(*
function TFuncoes.validarCPF(psCPF: string): boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9:integer;
  d1,d2:integer;
  digitado, calculado:string;
begin
  if(Length(psCPF)=11)then
  begin
    n1:= StrToInt(psCPF[1]);
    n2:= StrToInt(psCPF[2]);
    n3:= StrToInt(psCPF[3]);
    n4:= StrToInt(psCPF[4]);
    n5:= StrToInt(psCPF[5]);
    n6:= StrToInt(psCPF[6]);
    n7:= StrToInt(psCPF[7]);
    n8:= StrToInt(psCPF[8]);
    n9:= StrToInt(psCPF[9]);
    d1:= n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
    d1:= 11-(d1 mod 11);
    if(d1>=10)then
      d1:=0;
    d2:= d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
    d2:= 11-(d2 mod 11);
    if(d2>=10)then
      d2:=0;
    calculado:= inttostr(d1)+inttostr(d2);
    digitado:= psCPF[10]+psCPF[11];
    if(calculado=digitado)then
      Result := true
    else
      Result := false;
  end
  else //cpf  não tem um tamanho válido(11 caracteres)
    Result := false;
end;
*)

//fonte: http://forum.imasters.com.br/index.php?/topic/195531-validacao-de-cpfcnpj/
function TFuncoes.validarCPF(psCPF: string): boolean;
var
  cpf: string;
  x, total, dg1, dg2: Integer;
  ret: boolean;
begin
  ret:=True;
  for x:=1 to Length(psCPF) do
    if not (psCPF[x] in ['0'..'9', '-', '.', ' ']) then
      ret:=False;
  if ret then
  begin
    ret:=True;
    cpf:='';
    for x:=1 to Length(psCPF) do
      if psCPF[x] in ['0'..'9'] then
        cpf:=cpf + psCPF[x];
    if Length(cpf) <> 11 then
      ret:=False;
    if ret then
    begin
      //1° dígito
      total:=0;
      for x:=1 to 9 do
        total:=total + (StrToInt(cpf[x]) * x);
      dg1:=total mod 11;
      if dg1 = 10 then
        dg1:=0;
      //2° dígito
      total:=0;
      for x:=1 to 8 do
        total:=total + (StrToInt(cpf[x + 1]) * (x));
      total:=total + (dg1 * 9);
      dg2:=total mod 11;
      if dg2 = 10 then
        dg2:=0;
      //Validação final
      if dg1 = StrToInt(cpf[10]) then
        if dg2 = StrToInt(cpf[11]) then
          ret:=True;
      //Inválidos
      case AnsiIndexStr(cpf,['00000000000','11111111111','22222222222','33333333333','44444444444',
       '55555555555','66666666666','77777777777','88888888888','99999999999']) of
       0..9:   ret:=False;
      end;
    end
    else
    begin
      //Se não informado deixa passar
      if cpf = '' then
        ret:=True;
    end;
  end;
  Result := ret;
end;

//valida se o telefone está vazio
//se for vazio, retorna True
function TFuncoes.verificaTelefone_EhVazio(psTelefone: String): boolean;
var
  bRetorno: Boolean;
  sTelefone: String;
begin
  bRetorno := False;
  sTelefone := Trim(psTelefone);
  sTelefone := Self.retirarCaracteres(sTelefone,' ');
  if(sTelefone = '()-')then
    bRetorno := True;
  if(sTelefone = STRING_INDEFINIDO)then
    bRetorno := True;

  Result := bRetorno;
end;
              
//valida se o CPF está vazio
//se for vazio, retorna True
function TFuncoes.verificaCPF_EhVazio(psCPF: String): boolean;
var
  bRetorno: Boolean;
  sCPF: String;
begin
  bRetorno := False;
  sCPF := Trim(psCPF);
  sCPF := Self.retirarCaracteres(sCPF,' ');
  if(sCPF = '..-')then
    bRetorno := True;
  if(sCPF = STRING_INDEFINIDO)then
    bRetorno := True;

  Result := bRetorno;
end;

//valida se o CNPJ está vazio
//se for vazio, retorna True
function TFuncoes.verificaCNPJ_EhVazio(psCNPJ: String): boolean;
var
  bRetorno: Boolean;
  sCNPJ: String;
begin
  bRetorno := False;
  sCNPJ := Trim(psCNPJ);
  sCNPJ := Self.retirarCaracteres(sCNPJ,' ');
  if(sCNPJ = '../-')then
    bRetorno := True;
  if(sCNPJ = STRING_INDEFINIDO)then
    bRetorno := True;

  Result := bRetorno;
end;

function TFuncoes.verificaCEP_EhVazio(psCEP: String): boolean;
var
  bRetorno: Boolean;
  sCEP: String;
begin
  bRetorno := False;
  sCEP := Trim(psCEP);
  sCEP := Self.retirarCaracteres(sCEP,' ');
  if(sCEP = '-')then
    bRetorno := True;
  if(sCEP = STRING_INDEFINIDO)then
    bRetorno := True;

  Result := bRetorno;
end;

function TFuncoes.formatarData(psData: String): TDate;
var
  bData: TDate;
begin
  try
    bData := StrToDate(psData);
  except
    bData := NUMERO_INDEFINIDO;
  end;

  Result := bData;
end;

function TFuncoes.formatarValorInteiro(psValor: string): Integer;
var
  nValor: Integer;
begin
  try
    nValor := StrToInt(psValor);
  except
    nValor := NUMERO_INDEFINIDO;
  end;
  Result := nValor;
end;

function TFuncoes.formatarValorCurrency(psValor: String;
  pbRetirarPonto: Boolean = True): Currency;
var
  dValor: Currency;
  sValor: String;
begin
  if(pbRetirarPonto)then
    sValor := Self.retirarCaracteres(psValor,'.')
  else
    sValor := psValor;

  try
    dValor := StrToCurr(sValor);
  except
    dValor := NUMERO_INDEFINIDO;
  end;

  Result := dValor;
end;

//formata CPF, inserindo os caracteres '.-'
function TFuncoes.formatarCPF(psCPF: String): String;
var
  sRetorno: String;
  n: Integer;
begin
  //000.000.000-000
  sRetorno := STRING_INDEFINIDO;
  for n:=1 to Length(psCPF)do
  begin
    sRetorno := sRetorno + psCPF[n];
    if(n in [3,6])then
      sRetorno := sRetorno + '.';
    if(n in [9])then
      sRetorno := sRetorno + '-';
  end;
  Result := sRetorno;
end;

//formata CNPJ, inserindo os caracteres './-'
function TFuncoes.formatarCNPJ(psCNPJ: String): String;
var
  sRetorno: String;
  n: Integer;
begin

  Result := sRetorno;
end;

//verifica se a pKey pertence ao poConjuntoTeclas
function TFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(pKey: Word;
 poConjuntoTeclas: TConjuntosTeclas = [todas]; pbVerificarOutrosCaracteres: Boolean = True): Boolean;
var
  bRetorno: Boolean;

  function KeyEhNumero(): Boolean;
  var
    bEhNumero: Boolean;
  begin
    bEhNumero := False;
    if(pKey in[48..57])then //0..9
      bEhNumero := True;

    Result := bEhNumero;
  end;

  function KeyEhAlfanumerico(): Boolean;
  var
    bEhAlfanumerico: Boolean;
  begin
    bEhAlfanumerico := False;
    if(pKey in[65..90])then //A..Z
      bEhAlfanumerico := True
    else if(pKey in[97..122])then //a..z
      bEhAlfanumerico := True;

    Result := bEhAlfanumerico;
  end;

  function KeyEhAlfanumericoComAcento(): Boolean;
  var
    bEhAlfanumericoComAcento: Boolean;
  begin
    bEhAlfanumericoComAcento := False;

    if(pKey in[192..197])then //À,Á,Â,Ã,Ä,Å
      bEhAlfanumericoComAcento := True
    else if(pKey in[224..229])then //à,á,â,ã,ä,å
      bEhAlfanumericoComAcento := True
    else if(pKey in[200..203])then //È,É,Ê,Ë
      bEhAlfanumericoComAcento := True
    else if(pKey in[232..235])then //è,é,ê,ë
      bEhAlfanumericoComAcento := True
    else if(pKey in[204..207])then //Ì,Í,Î,Ï
      bEhAlfanumericoComAcento := True
    else if(pKey in[236..239])then //ì,í,î,ï
      bEhAlfanumericoComAcento := True
    else if(pKey in[210..214])then //Ò,Ó,Ô,Õ,Ö
      bEhAlfanumericoComAcento := True
    else if(pKey in[242..246])then //ò,ó,ô,õ,ö
      bEhAlfanumericoComAcento := True
    else if(pKey in[217..220])then //Ù,Ú,Û,Ü
      bEhAlfanumericoComAcento := True
    else if(pKey in[249..252])then //ù,ú,û,ü
      bEhAlfanumericoComAcento := True
    else if(pKey in[199,231])then //Ç,ç
      bEhAlfanumericoComAcento := True
    else if(pKey in[209,241])then //Ñ,ñ
      bEhAlfanumericoComAcento := True;

    Result := bEhAlfanumericoComAcento;
  end;

  function KeyEhOutroCaracterAceito(): Boolean;
  var
    bEhOutroCaracterAceito: Boolean;
  begin
    bEhOutroCaracterAceito := False;

    if(poConjuntoTeclas = [todas])or(poConjuntoTeclas = [alfanumericas])then
    begin
      if(pKey in[8,32])then //backspace,espaço
        bEhOutroCaracterAceito := True;
    end
    else if(poConjuntoTeclas = [numeros])then
    begin
      if(pKey in[8])then //backspace
        bEhOutroCaracterAceito := True;
    end;

    Result := bEhOutroCaracterAceito;
  end;

begin
  bRetorno := False;

  if(poConjuntoTeclas = [todas])then
  begin
    bRetorno := KeyEhNumero;
    if(bRetorno = False)then
      bRetorno := KeyEhAlfanumerico;
    if(bRetorno = False)then
      bRetorno := KeyEhAlfanumericoComAcento;
  end

  else if(poConjuntoTeclas = [alfanumericas])then
  begin
    bRetorno := KeyEhAlfanumerico;
    if(bRetorno = False)then
      bRetorno := KeyEhAlfanumericoComAcento;
  end

  else if(poConjuntoTeclas = [numeros])then
  begin
    bRetorno := KeyEhNumero;
  end;

  if(bRetorno = False)and(pbVerificarOutrosCaracteres)then
    bRetorno := KeyEhOutroCaracterAceito;

  Result := bRetorno;
end;

end.
