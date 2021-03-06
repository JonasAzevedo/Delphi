unit unFuncoes;

interface

uses
  Controls, unConstantes, DB, DBClient, DBGrids, Dialogs, Forms;

(*  plsEdit,
  unVariaveis,
  ExtCtrls, //TPanel
  ComCtrls, //TToolBar
  StdCtrls, //TGroupBox
  Types, //TRect
  Graphics, //TColor
  Grids; //TGridDrawState
*)
  type TFuncoes = class
    private
    public
(*      procedure configurarComponenteEscreveDireitaParaEsquerda(poForm: TForm);
      procedure fecharComponentesBD(poForm: TForm);//fecha componentes de acesso ao BD
      function getVersao(): string;
      procedure gravaMensagemSistemaDiversos(pvDescricao: Variant; psTipo: String); //grava um registro na tabela sistema_diversos
      procedure iniciarTela(); //inicia configura��es da tela
*)      function retirarCaracteres(psPalavra, psCaracRetirar: string; const pbTrimRetorno: boolean = True): string;
      procedure focarComponente(poComp: TWinControl);
  (*    function formatarDataFormatoAmericano(psData: string): string; overload;
      function formatarDataFormatoAmericano(pData: TDate): string; overload;
      function inserirCondicaoSelectNaoTrazerRegistroNulo(const psAlias:String = STRING_INDEFINIDO): String; //insere condi��o para o select n�o trazer registro nulo
      *)function FormatarValorMonetario(psValor:String): String;
      procedure FormatarValorMonetarioEmBloco(poCds:TClientDataSet; psCampo:String);
      (*function realizarLogin(psUsuario,psSenha: string; var nCodigo:Integer; var sNome: String): boolean;
*)
      function RetornarValorInteiro(psValor: string): Integer;
      function RetornarValorDouble(psValor: string; const pdRetornoErro:double = NUMERO_INDEFINIDO): Double;
      function validarData(psData: string): boolean;
      function validarDataHora(psData: string): boolean;
      function validarHora(psHora: string): boolean;
      function validarEmail(psEmail: string): boolean;
      function validarTelefone(psTelefone: string): boolean;
      function validarCPF(psCPF: string): boolean;
      function VerificaDigitoCPF(Numero: string): boolean;
      function validarCNPJ(psCNPJ: string): boolean;
      function validarCEP(psCEP: string): boolean;
      function validarValorMonetario(psValor: string; const pbValorZeroValido: Boolean = True): boolean;
      function verificaTelefone_EhVazio(psTelefone: String): boolean; //valida se o telefone est� vazio
      function verificaCPF_EhVazio(psCPF: String): boolean; //valida se o CPF est� vazio
      function verificaCNPJ_EhVazio(psCNPJ: String): boolean; //valida se o CNPJ est� vazio
      function verificaCEP_EhVazio(psCEP: String): boolean; //valida se o CEP est� vazio
      function formatarData(psData: String): TDate;
      function formatarValorInteiro(psValor: string): Integer;
      function formatarValorDouble(psValor: string): Double;
      function formatarValorCurrency(psValor: String; pbRetirarPonto: Boolean = True; psRetirarCaracteres: string = ''): Currency;
      function formatarCPF(psCPF: String): String; //formata CPF, inserindo os caracteres '.-'
      function formatarCNPJ(psCNPJ: String): String; //formata CNPJ, inserindo os caracteres './-'
      function PossuiValor(psValor: string): Boolean;
      procedure AdicionarValorLista(psValor: string; var psSaida: string; const psSeparador: string = ', ');
      function NaoPossuiValor(psValor:string): Boolean;
      procedure CopiarCamposEntreDatasets(oCDSOriginal: TClientDataSet; var oCDSDestino: TClientDataSet);
      procedure CopiarRegistro(oCDSOriginal: TClientDataSet; var oCDSDestino: TClientDataSet);
      function GetGeneratorDaTable(psTable: String): String; //retorna o generator da table
      function RetornarProximoCodigo(psTabela: String; const pbDesconsiderarRegistroNulo: Boolean = True): Integer; //retorna proximo registro da tabela vazio
      //verifica se a pKey pertence ao poConjuntoTeclas
(*      function verificarCaracterPertenceConjuntoTeclasAceitas(pKey: Word;
        poConjuntoTeclas: TConjuntosTeclas = [todas]; pbVerificarOutrosCaracteres: Boolean = True): Boolean;
*)      procedure AjustarLarguraColunasTDBGrid(poGride: TDBGrid);
(*      procedure CriarTelaDicas(pnChamou:Integer);
      procedure AjustarPosicaoFormCadastroPesquisa(poFormPai, poFormCadastro, poFormPesquisa :TForm); //poFormPai = cont�m o form de cadastro e pesquisa; poFormCadastro = form de cadastro; poFormPesquisa = form de pesquisa
      (*poFormPai = cont�m o form de cadastro;
        poFormCadastro=form de cadastro, que cont�m a sele��o do registro;
        poFormSelecao=form de sele��o;
        poPanelSelecaoRegistro=panel de sele��o do registro
        poToolBarFormCadastro=toolBar do form de cadastro
        poGroupBoxFormCadastro=group box do form de cadastro que deve contar o topo para posicionamento do form de sele��o
        pnAuxAjustarFormSelecao=valor a ser acrecentado para ajustar o form de sele��o abaixo do panel de sele��o*)
(*      procedure AjustarPosicaoFormCadastroSelecaoRegistro(poFormPai,poFormCadastro,
       poFormSelecao:TForm; poPanelSelecaoRegistro:TPanel; const poToolBarFormCadastro:TToolBar=nil;
       const poGroupBoxFormCadastro:TGroupBox = nil; pnAuxAjustarFormSelecao:Integer = NUMERO_INDEFINIDO);
      procedure AdicionarInformacao(var psRecebe:String; psInfoAdicionar:String; const psSeparador:string = ', ');*)
      procedure CriarIndiceOrdenarDadosColuna(poClientDataSet:TClientDataSet;poColumn: TColumn);
      (*procedure PintarCelulaGride(poGride: TDBGrid; const Rect: TRect; DataCol: Integer; Column: TColumn;
       State: TGridDrawState; const poColorBrush: TColor = clNone; const poColorFont: TColor = clNone;
       const pbBold:Boolean = False; const pbItalic:Boolean = False; const pbUnderline:Boolean = False;
       const pbStrikeOut:Boolean = False);
      function GetSerialNum(psFDrive:String):String; //retorna o n�mero do serial do driver passado no par�metro FDrive
      procedure ChamarRegistrarSistema;
      function GetSerieFormatada(psSerie:String):String; //formata a s�rie do HD, invertendo posi��es e acrescentando caracteres
      function VerificarChaveValida(psCodigo,psChave:String):Boolean; //verifica se a chave � v�lida
      function VerificarClientDataSetAtivo(poClientDataSet:TClientDataSet; const pbActive:Boolean = True;
       const pbRecordCount:Boolean = True): Boolean; //verificar se o ClientDataSet poClientDataSet est� ativo
      function VerificarExisteCriarDiretorio(psDiretorio:string; const pbCriarNaoExiste:Boolean = True): Boolean; //verifica se o diret�rio do par�metro 'psDiretorio' existe, e se n�o existir cria-o conforme par�metro pbCriarNaoExiste*)
      function RetornarValorInteiroString(psValor: string; const pnValorStringInvalida: Integer = NUMERO_INDEFINIDO): Integer;
      function RetornarCaixaMensagem(const psTexto: string; const poBotao: TMsgDlgButtons = [mbOk];
        const psRotulo: String = 'Aten��o'; const poIcon : TMsgDlgType = mtWarning): integer;
  end;

implementation

uses
  unDM,
  SysUtils,
  StrUtils,
  StdCtrls,
  graphics,
  ZDataset, Variants; //TZQuery, TZTable
(*  Windows,
  unDicas,
  unPrincipal,
  Classes,
  Variants, //null
  DB, //TIndexOptions
  unRegistrarSistema;
  *)
var
  vet_valido: array [0..35] of string = ('0','1','2','3','4','5','6','7', '8','9','a','b','c','d','e','f', 'g','h','i','j','k','l','m','n', 'o','p','q','r','s','t','u','v', 'w','x','y','z');

{ TFuncoes }
  (*
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

//inicia configura��es da tela
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

//inicia configura��es da tela
procedure TFuncoes.iniciarTela();
begin

end;
*)
//retirar caracteres de um texto
function TFuncoes.retirarCaracteres(psPalavra, psCaracRetirar: string;
  const pbTrimRetorno: boolean = True): string;
var
  i: Integer;
  c: String;
begin
  for i:=1 to length(psCaracRetirar) do
  begin
    c := Copy(psCaracRetirar,i,1);
    psPalavra := StringReplace(psPalavra, c, '', [rfReplaceAll, rfIgnoreCase]);
  end;
  if pbTrimRetorno then
    Result := Trim(psPalavra)
  else
    Result := psPalavra;
end;

procedure TFuncoes.focarComponente(poComp: TWinControl);
begin
  try
    if poComp is TWinControl then
      TWinControl(poComp).SetFocus;
  except
  end;
end;
(*
function TFuncoes.formatarDataFormatoAmericano(psData: string): string;
var
  sAux,sRetorno: string;
begin
  sAux := '';
  sRetorno := '';
  sAux := copy(psData,7,4); //ano
  sRetorno := sAux + '/';
  sAux := copy(psData,4,2); //m�s
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
  sAux := copy(sData,4,2); //m�s
  sRetorno := sRetorno + sAux + '/';
  sAux := copy(sData,1,2); //dia
  sRetorno := sRetorno + sAux;

  Result := sRetorno;
end;

//insere condi��o para o select n�o trazer registro nulo
function TFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo(const psAlias:String = STRING_INDEFINIDO): String;
begin
  if(psAlias = STRING_INDEFINIDO)then
    Result := ' WHERE codigo <> ''' + IntToStr(REGISTRO_NULO) + ''''
  else
    Result := ' WHERE ' + psAlias + '.codigo <> ''' + IntToStr(REGISTRO_NULO) + '''';
end;*)

function TFuncoes.formatarValorMonetario(psValor:String): String;
var
  i, x: Integer;
  nQtdeCarac: Integer; //quatidade de caracteres do texto
  nQtdeCaracNumeroInteiro: Integer; ////quatidade de caracteres da parte inteira
  cCaracterAtual: Char; //caracter atual, que o loop est� passando
  nCentena: Integer; //se  achou a centena, que o ponto ir� separar
  sTexto: string; //texto a formatar
  sTextoParteDecimal: string; //texto a formatar - somente parte decimal
  sParteInteira: string; //parte inteira do n�mero
  sParteDecimal: string; //parte decimal do n�mero
  sRetorno: string; //retorno do m�todo
  sUnidade: string; //cada n�mero retornado no loop (sem ou com ponto)

begin
  //inicializa vari�veis
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

    //formata parte inteira do n�mero
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

    //formata parte inteira do n�mero
    if(Length(sTextoParteDecimal)<=0)then
      sParteDecimal := '00'
    else if(Length(sTextoParteDecimal)=1)then
      sParteDecimal := sTextoParteDecimal + '0'
    else
      sParteDecimal := Copy(sTextoParteDecimal,1,2);

    //n�mero formatado
    if(sParteInteira = '')then
      sParteInteira := '00';
    sRetorno := sParteInteira + ',' + sParteDecimal;

    Result := sRetorno;
  end;
end;

procedure TFuncoes.FormatarValorMonetarioEmBloco(poCds:TClientDataSet; psCampo:String);
begin
  if(poCds.Active)and(poCds.RecordCount > NUMERO_INDEFINIDO)then
  begin
    poCds.First;
    while not(poCds.Eof)do
    begin
      poCds.Edit;
      poCds.FieldByName(psCampo).AsString := formatarValorMonetario(poCds.FieldByName(psCampo).AsString);
      poCds.Post;
      poCds.Next;
    end;
  end;
end;

(*
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
*)

function TFuncoes.RetornarValorInteiro(psValor: string): Integer;
begin
  try
    Result := StrToInt(psValor);
  except
    Result := NUMERO_INDEFINIDO;
  end;
end;

function TFuncoes.RetornarValorDouble(psValor: string; const pdRetornoErro:double = NUMERO_INDEFINIDO): Double;
begin
  try
    Result := StrToFloat(psValor);
  except
    Result := pdRetornoErro; //NUMERO_INDEFINIDO;
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

function TFuncoes.validarDataHora(psData: string): boolean;
begin
  Result := True;
  try
    StrToDateTime(psData);
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
  msg1 = 'Caractere(s) inv�lido(s) no in�cio do e-mail.';
  msg2 = 'S�mbolo @ n�o foi encontrado.';
  msg3 = 'Excesso do s�mbolo @.';
  msg4 = 'Caractere(s) inv�lido(s) antes do s�mbolo @.';
  msg5 = 'Caractere(s) inv�lido(s) depois do s�mbolo @.';
  msg6 = 'Agrupamento de caractere(s) inv�lido(s) a esqueda do @.';
  msg7 = 'N�o existe ponto(s) digitado(s).';
  msg8 = 'Ponto encontrado no final do e-mail.';
  msg9 = 'Aus�ncia de caractere(s) ap�s o �ltimo ponto.';
  msg10 = 'Excesso de ponto(s) a direita do @.';
  msg11 = 'Ponto(s) disposto(s) de forma errada ap�s o @.';
  msg12 = 'Caractere(s) inv�lido(s) antes do ponto.';
  msg13 = 'Caractere(s) inv�lido(s) depois do ponto.';

var
  i, j, tam_email, simb_arroba, simb_arroba2, qtd_arroba, qtd_pontos,
  qtd_pontos_esq, qtd_pontos_dir, posicao, posicao2, ponto, ponto2: integer;
  vet_email: array [0..49] of string; //50 posi��es, capacidade do Edit
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

  //Verificando se tem o s�mbolo @ e quantos tem
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
    //Verificando o que vem antes e depois do s�mbolo @
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
    //Antes do arroba h� um s�mbolo desconhecido do vetor v�lido
    Result:= False;
    msg:= msg4;
    end
  else if simb_arroba2 = 36 then
    begin
    //Depois do arroba h� um s�mbolo desconhecido do vetor v�lido
    Result:= False;
    msg:= msg5;
    end
  end;

  //Verificando se h� pontos e quantos, e Verificando parte final do e-mail
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
    //Antes do ponto h� um s�mbolo desconhecido do vetor v�lido
    Result:= False;
    msg:= msg12;
    end
  else if ponto2 = 36 then
    begin
    //Depois do ponto h� um s�mbolo desconhecido do vetor v�lido
    Result:= False;
    msg:= msg13;
    end
  end;

  //Verifica��o final
  if not Result then
    begin
    msg:= msg +#10+ 'Formato de E-mail n�o aceit�vel!!';
    //MessageDlg(msg,mtWarning,[mbRetry],0);
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
        if(bRetorno)then //4 n�s iniciais do telefone
        begin
          sAux := Copy(psTelefone,5,4);
          try
            iAux := StrToInt(sAux);
          except
            bRetorno := false;
          end;
          if(bRetorno)then //tra�o que divide as duas partes do n�
          begin
            if(Copy(psTelefone,9,1)<>'-')then // '('
              bRetorno := false;
            if(bRetorno)then //4 n�s finais do telefone
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

//baseado no artigo Algoritmo CNPJ do Clube da Inform�tica
//http://www.clubedainformatica.com.br/mostraartigo.php?artigo=63
function TFuncoes.validarCNPJ(psCNPJ: string): boolean;
var
  cnpj: array[1..15] of integer;
  apoio: array[0..15] of integer;
  f: integer;//para uso no for
  total: integer;//para totaliza��o dos valores
  D1: integer;//primeiro d�gito calculado
  D2: integer;//segundo d�gito calculado
begin
  //primeiro teste: o n�mero de algarismos
  if (Length(psCNPJ)<>14) then
    Result:=false
  else
  begin
    //Antes do teste propriamente dito temos que montar a matriz com os
    //algarismos do CNPJ e depois uma matriz apoio que ter� os n�meros
    //que ajudar�o a verificar so d�gitos verificadores.
    //Monta matriz cnpj
    for f := 1 to 14 do
    begin
      cnpj[f]:=strtoint(psCNPJ[f]);
    end;
  end;
  //Monta matriz de apoio
  apoio[0]:=6;//s� ser� usada no c�lculo do segundo d�gito verificador
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
  //come�a c�lculo do primeiro d�gito verificador
  total:=0;//vari�vel que conter� a soma da opera��o com os n�meros
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
    //primeiro d�gito verificador n�o confere
    Result:=false;
  end
  else
  begin
    //entrou aqui, ent�o o primeiro d�gito confere!
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
      //segundo digito verificador n�o confere
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
    sAux := Copy(psCEP,1,5); //1� parte do CEP
    try
      iAux := StrToInt(sAux);
    except
      bRetorno := false;
    end;
    if(bRetorno)then // '-'
    begin
      if(Copy(psCEP,6,1)<>'-')then
        bRetorno := false;
      if(bRetorno)then //2� parte do CEP
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

function TFuncoes.validarValorMonetario(psValor: string; const pbValorZeroValido: Boolean = True): boolean;
var
  nAux: Double;
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

  if (Result) and (not(pbValorZeroValido)) then
  begin
    sValor := Self.retirarCaracteres(psValor, '.,');
    try
      nAux := StrToFloat(sValor);
      Result := nAux > 0;
    except
    end;
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
  else //cpf  n�o tem um tamanho v�lido(11 caracteres)
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
      //1� d�gito
      total:=0;
      for x:=1 to 9 do
        total:=total + (StrToInt(cpf[x]) * x);
      dg1:=total mod 11;
      if dg1 = 10 then
        dg1:=0;
      //2� d�gito
      total:=0;
      for x:=1 to 8 do
        total:=total + (StrToInt(cpf[x + 1]) * (x));
      total:=total + (dg1 * 9);
      dg2:=total mod 11;
      if dg2 = 10 then
        dg2:=0;
      //Valida��o final
      if dg1 = StrToInt(cpf[10]) then
        if dg2 = StrToInt(cpf[11]) then
          ret:=True;
      //Inv�lidos
      case AnsiIndexStr(cpf,['00000000000','11111111111','22222222222','33333333333','44444444444',
       '55555555555','66666666666','77777777777','88888888888','99999999999']) of
       0..9:   ret:=False;
      end;
    end
    else
    begin
      //Se n�o informado deixa passar
      if cpf = '' then
        ret:=True;
    end;
  end;
  Result := ret;
end;

//fonte: Softplan 
function TFuncoes.VerificaDigitoCPF(Numero: string): boolean;
var
  total, digito1, digito2, resto, inteiro: integer;
begin
  try
    //C�lculo do primeiro d�gito verificador
    total := 10 * StrToInt(copy(Numero, 1, 1)) + 9 * StrToInt(copy(Numero, 2, 1)) +
      8 * StrToInt(copy(Numero, 3, 1)) + 7 * StrToInt(copy(Numero, 4, 1)) + 6 *
      StrToInt(copy(Numero, 5, 1)) + 5 * StrToInt(copy(Numero, 6, 1)) + 4 *
      StrToInt(copy(Numero, 7, 1)) + 3 * StrToInt(copy(Numero, 8, 1)) + 2 *
      StrToInt(copy(Numero, 9, 1));
    inteiro := (trunc(total / 11)) * 11;
    resto := total - inteiro;
    if (resto = 0) or (resto = 1) then
      digito1 := 0
    else
      digito1 := 11 - resto;
    //C�lculo do segundo d�gito verificador
    total := 11 * StrToInt(copy(Numero, 1, 1)) + 10 * StrToInt(copy(Numero, 2, 1)) +
      9 * StrToInt(copy(Numero, 3, 1)) + 8 * StrToInt(copy(Numero, 4, 1)) + 7 *
      StrToInt(copy(Numero, 5, 1)) + 6 * StrToInt(copy(Numero, 6, 1)) + 5 *
      StrToInt(copy(Numero, 7, 1)) + 4 * StrToInt(copy(Numero, 8, 1)) + 3 *
      StrToInt(copy(Numero, 9, 1)) + 2 * digito1;
    inteiro := (trunc(total / 11)) * 11;
    resto := total - inteiro;
    if (resto = 0) or (resto = 1) then
      digito2 := 0
    else
      digito2 := 11 - resto;
    //Verifica o d�gito
    if concat(IntToStr(digito1), IntToStr(digito2)) <> copy(Numero, 10, 2) then
      VerificaDigitoCPF := False
    else
      VerificaDigitoCPF := True;
  except
    VerificaDigitoCPF := False;
    exit;
  end;
end;


//valida se o telefone est� vazio
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
              
//valida se o CPF est� vazio
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

//valida se o CNPJ est� vazio
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

function TFuncoes.formatarValorDouble(psValor: string): Double;
var
  nValor: Double;
begin
  try
    nValor := StrToFloat(psValor);
  except
    nValor := NUMERO_INDEFINIDO;
  end;
  Result := nValor;
end;

function TFuncoes.formatarValorCurrency(psValor: String; pbRetirarPonto: Boolean = True;
  psRetirarCaracteres: string = ''): Currency;
var
  dValor: Currency;
  sValor: String;
begin
  if pbRetirarPonto then
    sValor := Self.retirarCaracteres(psValor,'.')
  else
    sValor := psValor;

  if (psRetirarCaracteres <> '') then
    sValor := retirarCaracteres(sValor,psRetirarCaracteres);

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
(*
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

    if(pKey in[192..197])then //�,�,�,�,�,�
      bEhAlfanumericoComAcento := True
    else if(pKey in[224..229])then //�,�,�,�,�,�
      bEhAlfanumericoComAcento := True
    else if(pKey in[200..203])then //�,�,�,�
      bEhAlfanumericoComAcento := True
    else if(pKey in[232..235])then //�,�,�,�
      bEhAlfanumericoComAcento := True
    else if(pKey in[204..207])then //�,�,�,�
      bEhAlfanumericoComAcento := True
    else if(pKey in[236..239])then //�,�,�,�
      bEhAlfanumericoComAcento := True
    else if(pKey in[210..214])then //�,�,�,�,�
      bEhAlfanumericoComAcento := True
    else if(pKey in[242..246])then //�,�,�,�,�
      bEhAlfanumericoComAcento := True
    else if(pKey in[217..220])then //�,�,�,�
      bEhAlfanumericoComAcento := True
    else if(pKey in[249..252])then //�,�,�,�
      bEhAlfanumericoComAcento := True
    else if(pKey in[199,231])then //�,�
      bEhAlfanumericoComAcento := True
    else if(pKey in[209,241])then //�,�
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
      if(pKey in[8,32])then //backspace,espa�o
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
*)
//retorna o generator da table
function TFuncoes.GetGeneratorDaTable(psTable: String): String;
var
  sRetorno: String;
begin
  sRetorno := STRING_INDEFINIDO;

  if(psTable = TABLE_CLIENTE)then
    sRetorno := 'GEN_CLIENTE'
  else if(psTable = TABLE_ORCAMENTO)then
    sRetorno := 'GEN_ORCAMENTO'
  else if(psTable = TABLE_PEDIDO)then
    sRetorno := 'GEN_PEDIDO'
  else if(psTable = TABLE_ITEM_PEDIDO)then
    sRetorno := 'GEN_ITEM_PEDIDO'
  else if(psTable = TABLE_ENDERECO)then
    sRetorno := 'GEN_ENDERECO'
  else if(psTable = TABLE_DESCRICAO_PRODUTOS)then
    sRetorno := 'GEN_DESCRICAO_PRODUTOS';

  Result := sRetorno;
end;

function TFuncoes.RetornarProximoCodigo(psTabela: String;
  const pbDesconsiderarRegistroNulo: Boolean = True): Integer;
var
  ozQuery: TZQuery;
  sSQL: String;
  nRetorno: Integer;
  sGenerator: string;
begin
  nRetorno := 0;
  sSQL := STRING_INDEFINIDO;
  sGenerator := GetGeneratorDaTable(psTabela);
  ozQuery := TZQuery.Create(nil);
  try
  //montando o SQL
    (*sSQL := 'SELECT MAX(codigo) AS codigo FROM ' + psTabela;
    if(pbDesconsiderarRegistroNulo)then
      sSQL := sSQL + ' WHERE codigo <> ' + IntToStr(REGISTRO_NULO);
    *)
    //pega o c�digo a partir do generator
    sSQL := 'select gen_id(' +sGenerator+ ',0) AS codigo from rdb$database';

    ozQuery.Connection := DM.ZConnection;
    ozQuery.Close;
    ozQuery.SQL.Clear;
    ozQuery.SQL.Add(sSQL);
    ozQuery.Open;
    ozQuery.Active := True;
    if(ozQuery.Active)and(ozQuery.RecordCount > 0)then
      nRetorno := ozQuery.FieldByName('codigo').AsInteger + 1;
  finally
    FreeAndNil(ozQuery);
  end;

  Result := nRetorno;
end;

procedure TFuncoes.AjustarLarguraColunasTDBGrid(poGride: TDBGrid);
const
  nLARGURA_GRIDE_DESCONSIDERAR = 18;
var
  i: Integer;
  nLarguraGride: Integer;
  nCountColunas: Integer;
  nLarguraColunasMenosUltima: Integer;
  nLarguraUltimaColuna: Integer;

  procedure EsconderScrollHorizontal;
  begin
//    ShowScrollBar(poGride.Handle,SB_HORZ,False);
  end;

  procedure VerificarScrollVertical;
  begin
    //if (TStringGrid(DBGrid1).RowCount-1) then //Se tiver menos de 10 linha
    //ShowScrollBar(DBGrid1.Handle,SB_VERT,False); //Remove barra Vertical
    //ShowScrollBar(dbGrdRegistros.Handle,SB_VERT,False); //Remove barra Vertical
  end;

begin
  nLarguraGride := poGride.Width;
  nCountColunas := poGride.Columns.Count;
  nLarguraColunasMenosUltima := NUMERO_INDEFINIDO;

  if(nLarguraGride > NUMERO_INDEFINIDO)and(nCountColunas > NUMERO_INDEFINIDO)then
  begin
    //calculando largura das colunas da gride, menos a �ltima
    for i:=0 to nCountColunas-2 do
      nLarguraColunasMenosUltima := nLarguraColunasMenosUltima + poGride.Columns[i].Width;

    //calculando largura da �ltima coluna
    nLarguraUltimaColuna := nLarguraGride - nLarguraColunasMenosUltima - nLARGURA_GRIDE_DESCONSIDERAR;
    if(nLarguraUltimaColuna > NUMERO_INDEFINIDO)then
      poGride.Columns[nCountColunas-1].Width := nLarguraUltimaColuna;

    EsconderScrollHorizontal;
    VerificarScrollVertical;
  end;
end;
(*
procedure TFuncoes.CriarTelaDicas(pnChamou:Integer);
begin
  if(Assigned(frmDicas))then
    FreeAndNil(frmDicas);
  Application.CreateForm(TfrmDicas, frmDicas);
  frmDicas.passarParametro(PRM_DEFINE_TELA_DICAS, pnChamou);
  if(frmDicas.VerificarExisteRegistro)then
  begin
    frmDicas.passarParametro(PRM_FORM_DICAS_VISIBLE_TRUE, null);
    frmDicas.Show;
  end
  else
    FreeAndNil(frmDicas);
end;

procedure TFuncoes.AjustarPosicaoFormCadastroPesquisa(poFormPai,
 poFormCadastro, poFormPesquisa :TForm);
const
  //caso n�o consiga definir um top para os formul�rios, usa-se os top's sugestivos
  nTOP_SUGESTIVO_FORM_CADASTRO = 60;
  nTOP_SUGESTIVO_FORM_PESQUISA = 200;
var
  nHeightPai: Integer; //height do form pai
  nPosicaoTopCadastro: Integer; //nova posi��o do form de cadastro
  nPosicaoTopPesquisa: Integer; //nova posi��o do form de pesquisa
  nDifBottomPai: Integer; //diferen�a que sobrou no bottom do form pai
  bContinua: Boolean;
begin
  nHeightPai := poFormPai.Height;
  nPosicaoTopCadastro := poFormCadastro.Top;
  nPosicaoTopPesquisa := nPosicaoTopCadastro + poFormCadastro.Height;
  nDifBottomPai := nHeightPai - (nPosicaoTopPesquisa + poFormPesquisa.Height);
  //posiciona somente o form de pesquisa
  if(nDifBottomPai > 20)then
  begin
    poFormPesquisa.Top := nPosicaoTopPesquisa;
    Exit;
  end
  else
  //tenta reposicionar o form de cadastro e o form de pesquisa
  begin
    bContinua := True;
    while bContinua do
    begin
      nPosicaoTopCadastro := nPosicaoTopCadastro - 5; //reposiciona o topo do form de cadastro, diminuindo de 5 em 5
      nPosicaoTopPesquisa := nPosicaoTopCadastro + poFormCadastro.Height;
      nDifBottomPai := nHeightPai - (nPosicaoTopPesquisa + poFormPesquisa.Height);
      //conseguiu reposicionar o form de cadastro e o form de pesquisa
      if(nDifBottomPai > 20)then
      begin
        poFormCadastro.Top := nPosicaoTopCadastro;
        poFormPesquisa.Top := nPosicaoTopPesquisa;
        bContinua := False;
      end
      //n�o achou um reposicionamento satisfat�rio, usa-se os top's seguestivos
      else if(nPosicaoTopCadastro <= nTOP_SUGESTIVO_FORM_CADASTRO)then
      begin
        poFormCadastro.Top := nTOP_SUGESTIVO_FORM_CADASTRO;
        poFormPesquisa.Top := nTOP_SUGESTIVO_FORM_PESQUISA;
        bContinua := False;
      end;
    end;
  end;
end;

procedure TFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(poFormPai,
 poFormCadastro,poFormSelecao: TForm; poPanelSelecaoRegistro:TPanel; const poToolBarFormCadastro:TToolBar=nil;
 const poGroupBoxFormCadastro: TGroupBox = nil; pnAuxAjustarFormSelecao:Integer = NUMERO_INDEFINIDO);
const
  nACRESCENTA_TOP_FORM_SELECAO = 30;
var
  nHeightFormPrincipal: Integer; //height do form pai
  nWidthFormPrincipal: Integer; //width do form pai
  nTopFormCadastro: Integer; //topo do form de cadastro
  nTopPanelSelecao: Integer; //topo do panel de sele��o, contido no form de cadastro
  nHeightPanelSelecao: Integer; //height do panel de sele��o, contido no form de cadastro
  nHeightToolBar: Integer; //height da toolbar, contida no form de cadastro
  nTopFormSelecao: Integer; //topo do form de sele��o
  nWidthFormSelecao: Integer; //width do form de sele��o
  nHeightFormSelecao: Integer; //height do form de sele��o
  nTopGroupBox: Integer; //topo do groupBox, contido no form de cadastro
  nLeftFormSelecao: Integer; //left do form de sele��o
  nDifBottomPai: Integer; //diferen�a que sobrou no bottom do form pai
begin
  nHeightFormPrincipal := poFormPai.Height;
  nWidthFormPrincipal := frmPrincipal.Width;
  nTopFormCadastro := poFormCadastro.Top;
  nTopPanelSelecao := poPanelSelecaoRegistro.Top;
  nHeightPanelSelecao := poPanelSelecaoRegistro.Height;
  if Assigned(poToolBarFormCadastro)then
    nHeightToolBar := poToolBarFormCadastro.Height
  else
    nHeightToolBar := NUMERO_INDEFINIDO;
  nWidthFormSelecao := poFormSelecao.Width;
  nHeightFormSelecao := poFormSelecao.Height;
  nTopFormSelecao := NUMERO_INDEFINIDO;
  nLeftFormSelecao := NUMERO_INDEFINIDO;
  nDifBottomPai := NUMERO_INDEFINIDO;
  if Assigned(poGroupBoxFormCadastro)then
    nTopGroupBox := poGroupBoxFormCadastro.Top
  else
    nTopGroupBox := NUMERO_INDEFINIDO;

  //left do form sele��o, para posicion�-lo no meio da tela, horizontalmente
  nLeftFormSelecao := (nWidthFormPrincipal - nWidthFormSelecao) div 2;
  poFormSelecao.Left := nLeftFormSelecao;

  //topo do form de sele��o
  nTopFormSelecao := nTopFormCadastro + nTopPanelSelecao + nHeightPanelSelecao +
   pnAuxAjustarFormSelecao + nHeightToolBar + nTopGroupBox + nACRESCENTA_TOP_FORM_SELECAO;
  //posicionar abaixo do panel poPanelSelecaoRegistro
  if((nTopFormSelecao+nHeightFormSelecao)  <= nHeightFormPrincipal)then
    poFormSelecao.Top := nTopFormSelecao
  //posicionar acima do panel poPanelSelecaoRegistro
  else
  begin
    nTopFormSelecao := (nTopFormCadastro + nTopPanelSelecao + nHeightPanelSelecao + nHeightToolBar + nTopGroupBox)-poFormSelecao.Height;
    poFormSelecao.Top := nTopFormSelecao;
  end;
end;

procedure TFuncoes.AdicionarInformacao(var psRecebe:String; psInfoAdicionar:String; const psSeparador:string = ', ');
begin
  if psRecebe = STRING_INDEFINIDO then
    psRecebe := psInfoAdicionar
  else
    psRecebe := psRecebe + psSeparador + psInfoAdicionar;
end;
*)

procedure TFuncoes.CriarIndiceOrdenarDadosColuna(poClientDataSet:TClientDataSet;
 poColumn: TColumn);
var
  sIndexName: String;
  options: TIndexOptions;

  procedure VerificarIndiceUltrapassaTamanho;
  var
    nLength: Integer;
    nInicioCopia: Integer;
    sNovoIndice: String;
  begin
    nLength := Length(sIndexName);
    if(nLength > 31)then //�ndice deve ter um m�ximo de 31 caracterese
    begin
      nInicioCopia := (nLength - 31)+1;
      sNovoIndice := Copy(sIndexName,nInicioCopia,31);
      sIndexName := sNovoIndice;
    end;
  end;

begin
  poClientDataSet.IndexDefs.Update;
  if (poClientDataSet.IndexName = poColumn.FieldName + '_ASC') then
  begin
    sIndexName := poColumn.FieldName + '_DESC';
    options := [ixDescending];
  end
  else
  begin
    sIndexName := poColumn.FieldName + '_ASC';
    Options := [];
  end;

  VerificarIndiceUltrapassaTamanho;

  if (poClientDataSet.IndexDefs.IndexOf(sIndexName)< 0) then
    poClientDataSet.AddIndex(sIndexName, poColumn.FieldName, options);

  poClientDataSet.IndexName := sIndexName;
end;

(*
procedure TFuncoes.PintarCelulaGride(poGride: TDBGrid; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState; const poColorBrush: TColor = clNone; const poColorFont: TColor = clNone;
  const pbBold:Boolean = False; const pbItalic:Boolean = False;
  const pbUnderline:Boolean = False; const pbStrikeOut:Boolean = False);

  procedure DefinirEstiloFonteCelula;
  begin
    //pbUnderline e pbStrikeOut n�o tratados
    if (pbBold)and(not(pbItalic))then
      poGride.Canvas.Font.Style := [fsBold]
    else if (not(pbBold))and(pbItalic)then
      poGride.Canvas.Font.Style := [fsItalic]
    else if (pbBold)and(pbItalic)then
      poGride.Canvas.Font.Style := [fsBold,fsItalic];
  end;

begin
  if(poColorBrush <> clNone)then
    poGride.Canvas.Brush.Color:= poColorBrush;  //"pinta" a celula inteira
  if(poColorFont <> clNone)then
    poGride.Canvas.Font.Color := poColorFont; //"Pinta" a letra
  DefinirEstiloFonteCelula;
  poGride.Canvas.FillRect(Rect);
  poGride.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

//retorna o n�mero do serial do driver passado no par�metro FDrive
function TFuncoes.GetSerialNum(psFDrive:String) :String;
var
  wSerial: DWord;
  wDirLen, wFlags: DWord;
  wDLabel : Array[0..11] of Char;
begin
  try
    GetVolumeInformation(PChar(psFDrive+':\'),wDLabel,12,@wSerial,wDirLen,wFlags,nil,0);
    Result := IntToHex(wSerial,8);
  except
    Result := STRING_INDEFINIDO;
  end;
end;

procedure TFuncoes.ChamarRegistrarSistema;
var
  oForm: TfrmRegistroSistema;
begin
  try
    Application.CreateForm(TfrmRegistroSistema, oForm);
    oForm.ShowModal;
  finally
    FreeAndNil(oForm);
  end;
end;

//formata a s�rie do HD, invertendo posi��es e acrescentando caracteres
function TFuncoes.GetSerieFormatada(psSerie:String):String;
var
  sSerieInvertida,s: String;
  nTam,i: Integer;
  sRetorno: String;
begin
  sRetorno := STRING_INDEFINIDO;
  sSerieInvertida := STRING_INDEFINIDO;
  nTam := Length(psSerie);

  for i:=nTam downto 1 do
  begin
    s := Copy(psSerie, i, 1);
    sSerieInvertida := sSerieInvertida + s;
  end;

  sRetorno := psSerie + 'J37' + sSerieInvertida; //serial do HD + J37 + serial do HD invertido
  Result := sRetorno;
end;

//verifica se a chave � v�lida
function TFuncoes.VerificarChaveValida(psCodigo,psChave:String):Boolean;
var
  sCodigo: String;
  sChaveAvaliar: String;
  sChave: String;
  nTamanho: Integer;
  i: Integer;
  c: String;

begin                 
  sCodigo := psCodigo;
  sChaveAvaliar := psChave;
  sChave := STRING_INDEFINIDO;
  nTamanho := length(sCodigo);

  for i:=1 to nTamanho do
  begin
    c := Copy(sCodigo,i,1);
    if (c = 'a') or (c = 'A')then
      sChave := sChave + 'F'

    else if (c = 'b') or (c ='B')then
      sChave := sChave +   'P'

    else if (c = 'c') or (c ='C')then
      sChave := sChave +   'A'

    else if (c = 'd') or (c ='D')then
      sChave := sChave +   'N'

    else if (c = 'e') or (c ='E')then
      sChave := sChave +   'Q'

    else if (c = 'f') or (c ='F')then
      sChave := sChave +   'M'

    else if (c = 'g') or (c ='G')then
      sChave := sChave +   'S'

    else if (c = 'h') or (c ='H')then
      sChave := sChave +   'V'

    else if (c = 'i') or (c ='I')then
      sChave := sChave +   'B'

    else if (c = 'j') or (c ='J')then
      sChave := sChave +   'R'

    else if (c = 'l') or (c ='L')then
      sChave := sChave +   'G'

    else if (c = 'm') or (c ='M')then
      sChave := sChave +   'X'

    else if (c = 'n') or (c ='N')then
      sChave := sChave +   'C'

    else if (c = 'o') or (c ='O')then
      sChave := sChave +   'D'

    else if (c = 'p') or (c ='P')then
      sChave := sChave +   'U'

    else if (c = 'q') or (c ='Q')then
      sChave := sChave +   'O'

    else if (c = 'r') or (c ='R')then
      sChave := sChave +   'K'

    else if (c = 's') or (c ='S')then
      sChave := sChave +   'E'

    else if (c = 't') or (c ='T')then
      sChave := sChave +   'W'

    else if (c = 'u') or (c ='U')then
      sChave := sChave +   'H'

    else if (c = 'v') or (c = 'V')then
      sChave := sChave +   'L'

    else if (c = 'x') or (c ='X')then
      sChave := sChave +   'T'

    else if (c = 'z') or (c ='Z')then
      sChave := sChave +   'J'

    else if (c = 'y') or (c ='Y')then
      sChave := sChave +   'Z'

    else if (c = 'w') or (c ='W')then
      sChave := sChave +   'Y'

    else if (c = 'k') or (c ='K')then
     sChave := sChave +   'I'

    else if (c = '0')then
      sChave := sChave +   '8'

    else if (c = '1')then
      sChave := sChave +   '3'

    else if (c = '2')then
      sChave := sChave +   '9'

    else if (c = '3')then
      sChave := sChave +   '4'

    else if (c = '4')then
      sChave := sChave +   '0'

    else if (c = '5')then
      sChave := sChave +   '1'

    else if (c = '6')then
      sChave := sChave +   '7'

    else if (c = '7')then
      sChave := sChave +   '5'

    else if (c = '8')then
      sChave := sChave +   '6'

    else if (c = '9')then
      sChave := sChave +   '2'

    else
      sChave := sChave + '!';
  end;//for

  if (sChave = sChaveAvaliar) then
    Result := True

  else
    Result := False;
end;

//verificar se o ClientDataSet poClientDataSet est� ativo
function TFuncoes.VerificarClientDataSetAtivo(poClientDataSet:TClientDataSet;
 const pbActive:Boolean = True; const pbRecordCount:Boolean = True): Boolean;
var
  bRetorno: Boolean;
begin
  bRetorno := True;

  if pbActive then
    bRetorno := poClientDataSet.Active;

  if bRetorno then
  begin
    if pbRecordCount then
      bRetorno := poClientDataSet.RecordCount > NUMERO_INDEFINIDO;
  end;

  Result := bRetorno;
end;

//verifica se o diret�rio do par�metro 'psDiretorio' existe, e se n�o existir cria-o conforme par�metro pbCriarNaoExiste
function TFuncoes.VerificarExisteCriarDiretorio(psDiretorio:string;
 const pbCriarNaoExiste:Boolean = True): Boolean;
var
  bRetorno: Boolean;
begin
  bRetorno := True;
  if DirectoryExists(psDiretorio) then
    bRetorno := True
  else
  begin
    if pbCriarNaoExiste then
    begin
      if CreateDir(psDiretorio) then
        bRetorno := True
      else
        bRetorno := False;
    end;
  end;                    
  Result := bRetorno;
end;
    *)

function TFuncoes.PossuiValor(psValor:string): Boolean;
begin
  Result := (Trim(psValor) <> STRING_INDEFINIDO);
end;

procedure TFuncoes.AdicionarValorLista(psValor: string; var psSaida: string; const psSeparador: string = ', ');
begin
  if psSaida = STRING_INDEFINIDO then
    psSaida := psValor
  else
    psSaida := psSaida + psSeparador + psValor;
end;

function TFuncoes.NaoPossuiValor(psValor:string): Boolean;
begin
  Result := Trim(psValor) = STRING_INDEFINIDO;
end;

procedure TFuncoes.CopiarCamposEntreDatasets(oCDSOriginal: TClientDataSet; var oCDSDestino: TClientDataSet);
var
  i: integer;
begin
  for i := 0 to oCDSOriginal.fields.Count - 1 do
    oCDSDestino.FieldDefs.add(oCDSOriginal.fields[i].fieldName, oCDSOriginal.fields[i].DataType,
      oCDSOriginal.fields[i].Size, oCDSOriginal.fields[i].Required);
end;

procedure TFuncoes.CopiarRegistro(oCDSOriginal: TClientDataSet; var oCDSDestino: TClientDataSet);
var
  j: integer;
begin
  oCDSDestino.append;

  for j := 0 to oCDSOriginal.fields.Count - 1 do
    oCDSDestino.FieldByName(oCDSOriginal.fields[j].fieldName).Value :=
      oCDSOriginal.fields[j].Value;
  oCDSDestino.post;
end;

function TFuncoes.RetornarValorInteiroString(psValor: string;
  const pnValorStringInvalida: Integer): Integer;
begin
  if (VarType(psValor) = varInteger) then
    Result := StrToInt(psValor)
  else
    Result := pnValorStringInvalida;
end;

//cria uma caixa de mensagem.
function TFuncoes.RetornarCaixaMensagem(const psTexto: string; const poBotao: TMsgDlgButtons = [mbOk];
  const psRotulo: String = 'Aten��o'; const poIcon : TMsgDlgType = mtWarning): integer;
var
  wl_mensagem: TForm;
begin
  wl_Mensagem := CreateMessageDialog(psTexto, poIcon, poBotao);

  (wl_mensagem.FindComponent('YES') as TButton).Caption := '&Sim';
  (wl_mensagem.FindComponent('NO') as TButton).Caption  := '&N�o';
  (wl_mensagem.FindComponent('OK') as TButton).Caption  := '&Ok';
  (wl_mensagem.FindComponent('CANCEL') as TButton).Caption  := '&Cancelar';

  wl_mensagem.Color := clBtnFace;
  wl_mensagem.BorderStyle := bsSingle;
  wl_mensagem.BorderIcons := [];

  wl_mensagem.Caption := psRotulo;

  result := wl_mensagem.ShowModal;
end;

end.
