unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, plsMemo, plsComboBox, plsEdit, Buttons, unVariaveis,
  Menus, ExtCtrls, ZAbstractRODataset, ZDataset, DB, DBClient,
  ZAbstractDataset, ComCtrls;

  type
    TCadastroEmail = record
      //codigo: integer;
      email: string[100];
      servidor_do_email: string[50];
      dominio_1: string[10];
      dominio_2: string[5];
      nome_proprietario: string[100];
      cidade_proprietario: string[100];
      estado_proprietario: string[5];
      pais_proprietario: string[50];
      meio_captacao: string[200];
      relevancia: integer;
    end;

type
  TfrmCadastroEmails = class(TForm)
    grpBxCadastroLoteEmail: TGroupBox;
    mmLoteEmails: TMemo;
    lblSeparadorEmailsLote: TLabel;
    btBtnSalvarImportacaoLote: TBitBtn;
    ckBxVerificarEmailNomeProprietario: TCheckBox;
    MainMenu1: TMainMenu;
    mnItArquivo: TMenuItem;
    mnItOpcoes: TMenuItem;
    mnItLimpar: TMenuItem;
    mnItSair: TMenuItem;
    lblRelevancia: TLabel;
    cbBxRelevancia: TPlsComboBox;
    pnlOutrosDadosCadastro: TPanel;
    grpBxDadosEmail: TGroupBox;
    lblEmail: TLabel;
    lblNome: TLabel;
    lblCidade: TLabel;
    lblEstado: TLabel;
    lblServidor: TLabel;
    lblDominio1: TLabel;
    lblDominio2: TLabel;
    lblPais: TLabel;
    lblDadosEmail: TLabel;
    lblDadosProprietario: TLabel;
    edEmail: TPlsEdit;
    edServidor: TPlsEdit;
    edDominio1: TPlsEdit;
    edDominio2: TPlsEdit;
    edNome: TPlsEdit;
    edCidade: TPlsEdit;
    edEstado: TPlsEdit;
    edPais: TPlsEdit;
    btBtnSalvarCadastroSimples: TBitBtn;
    grpBxAreasInteresse: TGroupBox;
    cdsServidores: TClientDataSet;
    cdsDominios_1: TClientDataSet;
    cdsDominios_2: TClientDataSet;
    zQryBuscarDistinct: TZQuery;
    ckBxConfirmarServidorDominios: TCheckBox;
    grpBxAcompanhamentoProcesso: TGroupBox;
    lblInfTotalEmails: TLabel;
    lblTotalEmails: TLabel;
    lblInfEmailsInseridos: TLabel;
    lblTotalEmailsInseridos: TLabel;
    lblInfEmailsRepetidos: TLabel;
    lblInfEmailsRejeitados: TLabel;
    lblTotalEmailsRepetidos: TLabel;
    lblTotalEmailsRejeitados: TLabel;
    prgBarAcompanhamentoProcesso: TProgressBar;
    pnlMeioCaptacao: TPanel;
    lblMeioCaptacao: TLabel;
    mmMeioCaptacao: TPlsMemo;
    btBtnSelecionarMeioCaptacao: TBitBtn;
    GroupBox1: TGroupBox;
    lblInfServidorDesconhecido: TLabel;
    lblTotalServidorDesconhecido: TLabel;
    lblInfDominio1Desconhecido: TLabel;
    lblTotalDominio1Desconhecido: TLabel;
    lblInfDominio2Desconhecido: TLabel;
    lblTotalDominio2Desconhecido: TLabel;
    Atalhos1: TMenuItem;
    mnItFocoLoteEmails: TMenuItem;
    mnItFocoCaracterSeparador: TMenuItem;
    mnItSelecaoMeioCaptacao: TMenuItem;
    mnItImportaoLote: TMenuItem;
    rdGrpSeparacaoEmailNomeProprietario: TRadioGroup;
    ScrollBar1: TScrollBar;
    pnlVerificarCampoValido: TPanel;
    ckBxOkEmails: TCheckBox;
    ckBxOkCaracSeparador: TCheckBox;
    ckBxOkRelevancia: TCheckBox;
    ckBxOkMeioCaptacao: TCheckBox;
    ckBxOkVerificarEmailNome: TCheckBox;
    lblAcompanhamentoProcesso: TLabel;
    Label1: TLabel;
    StatusBar: TStatusBar;
    cbBxCaracterSeparador: TPlsComboBox;
    ckBxPegarNomeProprietarioEmail: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btBtnSalvarCadastroSimplesClick(Sender: TObject);
    procedure btBtnSalvarImportacaoLoteClick(Sender: TObject);
    procedure edEmailExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btBtnSelecionarMeioCaptacaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnItLimparClick(Sender: TObject);
    procedure mnItSairClick(Sender: TObject);
    procedure mnItFocoLoteEmailsClick(Sender: TObject);
    procedure mnItFocoCaracterSeparadorClick(Sender: TObject);
    procedure mnItSelecaoMeioCaptacaoClick(Sender: TObject);
    procedure mnItImportaoLoteClick(Sender: TObject);
    procedure ckBxVerificarEmailNomeProprietarioClick(Sender: TObject);
    procedure mmLoteEmailsChange(Sender: TObject);
    procedure mmLoteEmailsExit(Sender: TObject);
    procedure edCaracterSeparadorxChange(Sender: TObject);
    procedure edCaracterSeparadorxExit(Sender: TObject);
    procedure mmMeioCaptacaoChange(Sender: TObject);
    procedure mmMeioCaptacaoExit(Sender: TObject);
    procedure rdGrpSeparacaoEmailNomeProprietarioClick(Sender: TObject);
    procedure cbBxRelevanciaChange(Sender: TObject);
    procedure cbBxRelevanciaExit(Sender: TObject);
    procedure cbBxCaracterSeparadorChange(Sender: TObject);
    procedure cbBxCaracterSeparadorExit(Sender: TObject);
  public
    procedure PassarParametro(pTipo:String; pValores:OleVariant);
  private
    FnTotalEmails: Integer;
    FoCadEmail: TCadastroEmail;

    FnTotalEmailsInseridos, FnTotalEmailsRepetidos, FnTotalEmailsRejeitados: Integer;
    FoEmailsInseridos: TStringList;
    FoEmailsRepetidos: TStringList;
    FoEmailsRejeitados: TStringList;

    FbBuscarDistinctServidorDominio1e2: Boolean;
    FnTotalServidorNaoCadastrado, FnTotalDominio1NaoCadastrado, FnTotalDominio2NaoCadastrado: Integer;
    FoEmailsServidorNaoCadastro: TStringList;
    FoEmailsDominio1NaoCadastro: TStringList;
    FoEmailsDominio2NaoCadastro: TStringList;

    FbVerificarEmailNomeProprietario: Boolean;
    FnModoVerificarEmailNomeProprietario: Integer;

    procedure LimparTela;
    procedure LimparDadosEmail;
    procedure LimparListaEmailsResumo;
    procedure LimparListaEmailsSemServidorDominioCadastrado;
    procedure CriarAreasInteresse;
    procedure InciarVariaveis;

    procedure ContarTotalEmails;
    function ValidarCamposObrigatorios(oTipoCadastro: TTipoCadastro): Boolean;
    function ValidarDadosAntesCadastrar: Boolean;
    function ValidarEmail(psEmail: string): Boolean;
    function VerificarEmailExiste(psEmail: String): Boolean;
    procedure EncontrarDadosNoEnderecoEmail;
    procedure InserirEmail;
    procedure InserirAreasInteresse;
    function SalvarEmailUnico: boolean;
    function SalvarEmailLote: boolean;
    function VerificarEmailNomeProprietario(psEmail: String): String;
    procedure PegarNomeProprietarioEmailAteArroba(psEmail: String);
    procedure AbrirSelecaoMeioCaptacao;
    procedure PovoarClientDataSetServidorDominio1e2;
    procedure VerificarExisteEmailComEsteServidorDominio1e2;
    procedure AbreTelaResumo;
    procedure AbreTelaResumoServidorDominiosNaoCadastrados;
    procedure VerificaCampoValido(oCampo: TCampoObrigatorio);
  end;

var
  frmCadastroEmails: TfrmCadastroEmails;

implementation

uses
  unConstantes, unDM, unResumoInserirEmail, unExibirMeiosCaptacao,
  unResumoServidorDominiosNaoCadastrados, unAcompanharProcesso;

const
  n_EMAIL_NOME_1 = 1; //nome <email>
  n_EMAIL_NOME_2 = 2; //email <nome>
  n_EMAIL_NOME_3 = 3; //nome (email)
  n_EMAIL_NOME_4 = 4; //email (nome)

var
  vet_valido: array [0..35] of string = ('0','1','2','3','4','5','6','7', '8','9','a','b','c','d','e','f', 'g','h','i','j','k','l','m','n', 'o','p','q','r','s','t','u','v', 'w','x','y','z');

{$R *.dfm}

procedure TfrmCadastroEmails.InciarVariaveis;
begin
  FbVerificarEmailNomeProprietario := ckBxVerificarEmailNomeProprietario.Checked;
  if FbVerificarEmailNomeProprietario then
    FnModoVerificarEmailNomeProprietario := rdGrpSeparacaoEmailNomeProprietario.ItemIndex+1;

  FbBuscarDistinctServidorDominio1e2 := ckBxConfirmarServidorDominios.Checked;
end;

procedure TfrmCadastroEmails.PassarParametro(pTipo:String; pValores:OleVariant);
begin
  if(pTipo = PRM_SELECIONOU_MEIO_CAPTACAO)then
    mmMeioCaptacao.Text := pValores;
end;

procedure TfrmCadastroEmails.LimparTela;
begin
  mmLoteEmails.Clear;
  //edCaracterSeparador.Text := ',';
  cbBxCaracterSeparador.ItemIndex := -1;
  cbBxRelevancia.ItemIndex := -1;
  mmMeioCaptacao.Clear;
  ckBxVerificarEmailNomeProprietario.Checked := True;
  FbVerificarEmailNomeProprietario := True;
  FnModoVerificarEmailNomeProprietario := NUMERO_NULO;
  rdGrpSeparacaoEmailNomeProprietario.ItemIndex := -1;
  ckBxPegarNomeProprietarioEmail.Checked := True;
  ckBxConfirmarServidorDominios.Checked := True;
  FbBuscarDistinctServidorDominio1e2 := True;

  edEmail.Clear;
  edServidor.Clear;
  edDominio1.Clear;
  edDominio2.Clear;
  edNome.Clear;
  edPais.Clear;
  edCidade.Clear;
  edEstado.Clear;

  lblTotalEmails.Caption := '0';
  lblTotalEmailsInseridos.Caption := '0';
  lblTotalEmailsRepetidos.Caption := '0';
  lblTotalEmailsRejeitados.Caption := '0';
  prgBarAcompanhamentoProcesso.Position := 0;
  lblTotalServidorDesconhecido.Caption := '0';
  lblTotalDominio1Desconhecido.Caption := '0';
  lblTotalDominio2Desconhecido.Caption := '0';

  //seta componentes para pendentes.
  VerificaCampoValido([emails]);
  VerificaCampoValido([caracSeparador]);
  VerificaCampoValido([relevancia]);
  VerificaCampoValido([meioCaptacao]);
  VerificaCampoValido([verificEmailNome]);
end;

procedure TfrmCadastroEmails.LimparDadosEmail;
begin
  FoCadEmail.email := STRING_INDEFINIDO;
  FoCadEmail.servidor_do_email := STRING_INDEFINIDO;
  FoCadEmail.dominio_1 := STRING_INDEFINIDO;
  FoCadEmail.dominio_2 := STRING_INDEFINIDO;
  FoCadEmail.nome_proprietario := STRING_INDEFINIDO;
  FoCadEmail.pais_proprietario := STRING_INDEFINIDO;
  FoCadEmail.cidade_proprietario := STRING_INDEFINIDO;
  FoCadEmail.estado_proprietario := STRING_INDEFINIDO;
  FoCadEmail.meio_captacao := STRING_INDEFINIDO;
  FoCadEmail.relevancia := NUMERO_NULO;
end;

procedure TfrmCadastroEmails.LimparListaEmailsResumo;
begin
  FnTotalEmails := NUMERO_NULO;
  FnTotalEmailsInseridos := NUMERO_NULO;
  FnTotalEmailsRepetidos := NUMERO_NULO;
  FnTotalEmailsRejeitados := NUMERO_NULO;

  FoEmailsInseridos.Clear;
  FoEmailsRepetidos.Clear;
  FoEmailsRejeitados.Clear;
end;

procedure TfrmCadastroEmails.LimparListaEmailsSemServidorDominioCadastrado;
begin
  FnTotalServidorNaoCadastrado := NUMERO_NULO;
  FnTotalDominio1NaoCadastrado := NUMERO_NULO;
  FnTotalDominio2NaoCadastrado := NUMERO_NULO;

  FoEmailsServidorNaoCadastro.Clear;
  FoEmailsDominio1NaoCadastro.Clear;
  FoEmailsDominio2NaoCadastro.Clear;
end;

procedure TfrmCadastroEmails.ContarTotalEmails;
var
  i: Integer;
  nTotCaractesLoteEmails: Integer;
  sCaracSeparador: String;
begin
  nTotCaractesLoteEmails := length(Trim(mmLoteEmails.Text));
  sCaracSeparador := cbBxCaracterSeparador.Text;

  for i:=1 to nTotCaractesLoteEmails do
  begin
    if (mmLoteEmails.Text[i] = sCaracSeparador) then
      inc(FnTotalEmails);
  end;

  if (mmLoteEmails.Text[nTotCaractesLoteEmails] <> sCaracSeparador) then
    inc(FnTotalEmails);

  lblTotalEmails.Caption := IntToStr(FnTotalEmails);
  prgBarAcompanhamentoProcesso.Max := FnTotalEmails;
  prgBarAcompanhamentoProcesso.Min := NUMERO_NULO;
  prgBarAcompanhamentoProcesso.Position := NUMERO_NULO;
end;

procedure TfrmCadastroEmails.CriarAreasInteresse;
var
  nTopo: Integer;
  oCheckBox: TCheckBox;
begin
  DM.zQryAreasInteresse.Close;
  DM.zQryAreasInteresse.SQL.Clear;
  DM.zQryAreasInteresse.SQL.Add('SELECT * FROM areas_interesse');
  DM.zQryAreasInteresse.Open;

  if DM.zQryAreasInteresse.RecordCount > NUMERO_NULO then
  begin
    nTopo := 20;
    DM.zQryAreasInteresse.First;
    while not(DM.zQryAreasInteresse.Eof) do
    begin
      oCheckBox := TCheckBox.Create(Self);
      oCheckBox.Top := nTopo;
      oCheckBox.Left := 10;
      oCheckBox.Parent := grpBxAreasInteresse;
      oCheckBox.Caption := DM.zQryAreasInteresseNOME.AsString;
      oCheckBox.Name := 'ckBxAreasInteresse' + DM.zQryAreasInteresseCODIGO.AsString;
      oCheckBox.Enabled := True;
      oCheckBox.Visible := True;
      oCheckBox.Checked := False;
      oCheckBox.Tag := DM.zQryAreasInteresseCODIGO.AsInteger;
      oCheckBox.Font.Name := 'Arial';      
      oCheckBox.Font.Size := 8;
      oCheckBox.Font.Style := [];

      inc(nTopo,20);
      DM.zQryAreasInteresse.Next;
    end;
  end;
end;

function  TfrmCadastroEmails.ValidarCamposObrigatorios(oTipoCadastro: TTipoCadastro): Boolean;
var
  bRetorno: Boolean;
begin
  bRetorno := True;

  //se estiver cadastrando em lote
  if (oTipoCadastro = [lote])then
  begin
    //lote de email's
    if(Trim(mmLoteEmails.Text) = STRING_INDEFINIDO)then
    begin
      MessageDlg('Informe os e-mail''s do lote.', mtInformation, [mbOK], 0);
      mmLoteEmails.SetFocus;
      bRetorno := False;
    end;

    //caracter separador
    if(bRetorno)then
    begin
      if(Trim(cbBxCaracterSeparador.Text) = STRING_INDEFINIDO)then
      begin
        MessageDlg('Informe o caracter separador.', mtInformation, [mbOK], 0);
        cbBxCaracterSeparador.SetFocus;
        bRetorno := False;
      end;
    end;

    //relevância
    if(bRetorno)then
    begin
      if(cbBxRelevancia.ItemIndex < 0)then
      begin
        MessageDlg('Informe a relevância.', mtInformation, [mbOK], 0);
        cbBxRelevancia.SetFocus;
        bRetorno := False;
      end;
    end;

    //meio de captação
    if(bRetorno)then
    begin
      if(Trim(mmMeioCaptacao.Text) = STRING_INDEFINIDO)then
      begin
        MessageDlg('Informe o meio de captação.', mtInformation, [mbOK], 0);
        mmMeioCaptacao.SetFocus;
        bRetorno := False;
      end;
    end;

    //verificar email com nome do proprietário
    if(bRetorno)then
    begin
      if(FbVerificarEmailNomeProprietario)and(rdGrpSeparacaoEmailNomeProprietario.ItemIndex = -1)then
      begin
        MessageDlg('Selecione um modo de separar o email do nome do proprietário.', mtInformation, [mbOK], 0);
        rdGrpSeparacaoEmailNomeProprietario.SetFocus;
        bRetorno := False;
      end;
    end;
  end;

  (*else if(oTipoCadastro = [unico])then
  begin
    //email
    if(Trim(edEmail.Text) = STRING_INDEFINIDO)then
    begin
      MessageDlg('Informe o e-mail.', mtInformation, [mbOK], 0);
      edEmail.SetFocus;
      bRetorno := False;
    end;

    //meio de captação
    if(bRetorno)then
    begin
      if(Trim(mmMeioCaptacao.Text) = STRING_INDEFINIDO)then
      begin
        MessageDlg('Informe o meio de captação.', mtInformation, [mbOK], 0);
        mmMeioCaptacao.SetFocus;
        bRetorno := False;
      end;
    end;
  end;*)

  Result := bRetorno;
end;

//realiza outras validações antes de iniciar o cadastro.
function TfrmCadastroEmails.ValidarDadosAntesCadastrar: Boolean;
var
  bRetorno: Boolean;
  i: Integer;
  sCaracNaoPodeTer: string[1];
  sCaracSep: string[1];
begin
  bRetorno := True;

  //verifica se o caracter separador informado é válido.
  sCaracSep := cbBxCaracterSeparador.Text;
  sCaracNaoPodeTer := STRING_INDEFINIDO;
  if sCaracSep = ',' then
    sCaracNaoPodeTer := ';'
  else if sCaracSep = ';' then
    sCaracNaoPodeTer := ',';

  if sCaracNaoPodeTer <> STRING_INDEFINIDO then
  begin
    for i:=0 to Length(Trim(mmLoteEmails.Text)) do
    begin
      if (mmLoteEmails.Text[i] = sCaracNaoPodeTer) then
      begin
        MessageDlg('Lista de e-mail''s do lote contêm caracter separador inválido: ' +
          sCaracNaoPodeTer, mtInformation, [mbOK], 0);
        mmLoteEmails.SetFocus;
        bRetorno := False;
      end;
    end;
  end;

  Result := bRetorno;
end;

function TfrmCadastroEmails.ValidarEmail(psEmail: string): Boolean;
const
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

(*
  //Verificação final
  if not Result then
    begin
    msg:= msg +#10+ 'Formato de E-mail não aceitável!!';
    MessageDlg(msg,mtWarning,[mbRetry],0);
    end;
*)
end;

function TfrmCadastroEmails.VerificarEmailExiste(psEmail: String): Boolean;
begin
  DM.zQryEmail.Close;
  DM.zQryEmail.SQL.Clear;
  DM.zQryEmail.SQL.Add('SELECT * FROM email WHERE email=:email');
  DM.zQryEmail.ParamByName('email').AsString := psEmail;
  DM.zQryEmail.Open;

  Result := DM.zQryEmail.RecordCount > NUMERO_NULO;
end;

procedure TfrmCadastroEmails.EncontrarDadosNoEnderecoEmail;
const
  sCHAR_INICIA_SERVIDOR = '@';
  sCHAR_INICIA_DOMINIO1 = '.';
  sCHAR_INICIA_DOMINIO2 = '.';
var
  sEmail: String;
  sServidor: String;
  sDominio1,sDominio2: String;

  n: Integer;
  nTamanhoEmail: Integer;
  sCharAtual: String;
begin
  sEmail := edEmail.Text;
  sServidor := STRING_INDEFINIDO;
  sDominio1 := STRING_INDEFINIDO;
  sDominio2 := STRING_INDEFINIDO;

  nTamanhoEmail := Length(sEmail);

  n := 1;
  while(n <= nTamanhoEmail)do
  begin
    sCharAtual := sEmail[n];
    if(sCharAtual = sCHAR_INICIA_SERVIDOR)then //inicia a copia do servidor
    begin
      inc(n);
      sCharAtual := STRING_INDEFINIDO;
      while(sCharAtual <> sCHAR_INICIA_DOMINIO1)do
      begin
        sCharAtual := sEmail[n];
        if(sCharAtual <> sCHAR_INICIA_DOMINIO1)then
          sServidor := sServidor + sCharAtual;
        if(n >= nTamanhoEmail)then
          Break;
        inc(n);
      end;

      if(n < nTamanhoEmail)then
      begin
        sCharAtual := STRING_INDEFINIDO;
        while(sCharAtual <> sCHAR_INICIA_DOMINIO2)do //inicia a copia do dominio1
        begin
          sCharAtual := sEmail[n];
          if(sCharAtual <> sCHAR_INICIA_DOMINIO2)then
            sDominio1 := sDominio1 + sCharAtual;
          if(n >= nTamanhoEmail)then
            Break;
          inc(n);
        end;

        sCharAtual := STRING_INDEFINIDO;
        if(n < nTamanhoEmail)then
        begin
          while(sCharAtual <> sCHAR_INICIA_DOMINIO2)do //inicia a copia do dominio2
          begin
            sCharAtual := sEmail[n];
            if(sCharAtual <> sCHAR_INICIA_DOMINIO2)then
              sDominio2 := sDominio2 + sCharAtual;
            if(n >= nTamanhoEmail)then
              Break;
            inc(n);
          end;
        end;
      end;
    end;
  inc(n);
  end; //while principal

  edServidor.Text := Trim(sServidor);
  edDominio1.Text := Trim(sDominio1);
  edDominio2.Text := Trim(sDominio2);
end;

procedure TfrmCadastroEmails.InserirEmail;
begin
  if not(VerificarEmailExiste(FoCadEmail.email))then
  begin
    if(ValidarEmail(FoCadEmail.email))then
    begin
      if FbBuscarDistinctServidorDominio1e2 then
        VerificarExisteEmailComEsteServidorDominio1e2;

      DM.zQryEmail.Close;
      DM.zQryEmail.SQL.Clear;
      DM.zQryEmail.SQL.Add('INSERT INTO email(email,servidor_do_email,dominio_1,');
      DM.zQryEmail.SQL.Add('dominio_2,nome_proprietario,cidade_proprietario,');
      DM.zQryEmail.SQL.Add('estado_proprietario,pais_proprietario,meio_captacao,');
      DM.zQryEmail.SQL.Add('relevancia) VALUES (:email,:servidor_do_email,:dominio_1,');
      DM.zQryEmail.SQL.Add(':dominio_2,:nome_proprietario,:cidade_proprietario,');
      DM.zQryEmail.SQL.Add(':estado_proprietario,:pais_proprietario,:meio_captacao,');
      DM.zQryEmail.SQL.Add(':relevancia)');
      DM.zQryEmail.ParamByName('email').AsString := Trim(FoCadEmail.email);
      DM.zQryEmail.ParamByName('servidor_do_email').AsString := Trim(FoCadEmail.servidor_do_email);
      DM.zQryEmail.ParamByName('dominio_1').AsString := Trim(FoCadEmail.dominio_1);
      DM.zQryEmail.ParamByName('dominio_2').AsString := Trim(FoCadEmail.dominio_2);
      DM.zQryEmail.ParamByName('nome_proprietario').AsString := Trim(FoCadEmail.nome_proprietario);
      DM.zQryEmail.ParamByName('cidade_proprietario').AsString := Trim(FoCadEmail.cidade_proprietario);
      DM.zQryEmail.ParamByName('estado_proprietario').AsString := Trim(FoCadEmail.estado_proprietario);
      DM.zQryEmail.ParamByName('pais_proprietario').AsString := Trim(FoCadEmail.pais_proprietario);
      DM.zQryEmail.ParamByName('meio_captacao').AsString := Trim(FoCadEmail.meio_captacao);
      DM.zQryEmail.ParamByName('relevancia').AsInteger := FoCadEmail.relevancia;
      DM.zQryEmail.ExecSQL;

      InserirAreasInteresse;
      FoEmailsInseridos.Add(FoCadEmail.email);
      inc(FnTotalEmailsInseridos);
    end
    else
    begin
      DM.zQryEmailRejeitado.Close;
      DM.zQryEmailRejeitado.SQL.Clear;
      DM.zQryEmailRejeitado.SQL.Add('INSERT INTO email_rejeitado(email,servidor_do_email,dominio_1,');
      DM.zQryEmailRejeitado.SQL.Add('dominio_2,nome_proprietario,cidade_proprietario,');
      DM.zQryEmailRejeitado.SQL.Add('estado_proprietario,pais_proprietario,meio_captacao,');
      DM.zQryEmailRejeitado.SQL.Add('relevancia) VALUES (:email,:servidor_do_email,:dominio_1,');
      DM.zQryEmailRejeitado.SQL.Add(':dominio_2,:nome_proprietario,:cidade_proprietario,');
      DM.zQryEmailRejeitado.SQL.Add(':estado_proprietario,:pais_proprietario,:meio_captacao,');
      DM.zQryEmailRejeitado.SQL.Add(':relevancia)');
      DM.zQryEmailRejeitado.ParamByName('email').AsString := Trim(FoCadEmail.email);
      DM.zQryEmailRejeitado.ParamByName('servidor_do_email').AsString := Trim(FoCadEmail.servidor_do_email);
      DM.zQryEmailRejeitado.ParamByName('dominio_1').AsString := Trim(FoCadEmail.dominio_1);
      DM.zQryEmailRejeitado.ParamByName('dominio_2').AsString := Trim(FoCadEmail.dominio_2);
      DM.zQryEmailRejeitado.ParamByName('nome_proprietario').AsString := Trim(FoCadEmail.nome_proprietario);
      DM.zQryEmailRejeitado.ParamByName('cidade_proprietario').AsString := Trim(FoCadEmail.cidade_proprietario);
      DM.zQryEmailRejeitado.ParamByName('estado_proprietario').AsString := Trim(FoCadEmail.estado_proprietario);
      DM.zQryEmailRejeitado.ParamByName('pais_proprietario').AsString := Trim(FoCadEmail.pais_proprietario);
      DM.zQryEmailRejeitado.ParamByName('meio_captacao').AsString := Trim(FoCadEmail.meio_captacao);
      DM.zQryEmailRejeitado.ParamByName('relevancia').AsInteger := FoCadEmail.relevancia;
      DM.zQryEmailRejeitado.ExecSQL;
      FoEmailsRejeitados.Add(FoCadEmail.email);
      inc(FnTotalEmailsRejeitados);
    end;
  end
  else
  begin
    FoEmailsRepetidos.Add(FoCadEmail.email);
    Inc(FnTotalEmailsRepetidos);
  end;

  lblTotalEmailsInseridos.Caption := IntToStr(FnTotalEmailsInseridos);
  lblTotalEmailsRepetidos.Caption := IntToStr(FnTotalEmailsRepetidos);
  lblTotalEmailsRejeitados.Caption := IntToStr(FnTotalEmailsRejeitados);
  prgBarAcompanhamentoProcesso.Position := FnTotalEmailsInseridos +
    FnTotalEmailsRepetidos + FnTotalEmailsRejeitados;

  Application.ProcessMessages;
end;

procedure TfrmCadastroEmails.InserirAreasInteresse;
var
  n: Integer;
  nCodigoEmail: Integer;
  nCodigoAreaInteresse: Integer;

  procedure PegarCodigoEmail;
  begin
    if(nCodigoEmail = NUMERO_NULO)then
    begin
      DM.zQryEmail.Close;
      DM.zQryEmail.SQL.Clear;
      DM.zQryEmail.SQL.Add('SELECT * FROM email ORDER BY codigo DESC ROWS 1');
      DM.zQryEmail.Open;
      if(DM.zQryEmail.RecordCount > NUMERO_NULO)then
        nCodigoEmail := DM.zQryEmailCODIGO.AsInteger;
    end;
  end;

  procedure SalvarAreaInteresse;
  begin
    if(nCodigoEmail <> NUMERO_NULO)and(nCodigoAreaInteresse <> NUMERO_NULO)then
    begin
      DM.zQryAreasInteresse.Close;
      DM.zQryAreasInteresse.SQL.Clear;
      DM.zQryAreasInteresse.SQL.Add('INSERT INTO associa_email_areas_interesse(');
      DM.zQryAreasInteresse.SQL.Add('codigo_fk_email,codigo_fk_areas_interesse)');
      DM.zQryAreasInteresse.SQL.Add(' VALUES (:codigo_fk_email,:codigo_fk_areas_interesse)');
      DM.zQryAreasInteresse.ParamByName('codigo_fk_email').AsInteger := nCodigoEmail;
      DM.zQryAreasInteresse.ParamByName('codigo_fk_areas_interesse').AsInteger := nCodigoAreaInteresse;
      DM.zQryAreasInteresse.ExecSQL;
    end;
  end;

begin
  nCodigoEmail := NUMERO_NULO;
  nCodigoAreaInteresse := NUMERO_NULO;

  for n:=0 to frmCadastroEmails.ComponentCount-1 do
  begin
    if(frmCadastroEmails.Components[n] is TCheckBox)and
      ((frmCadastroEmails.Components[n] as TCheckBox).Parent = grpBxAreasInteresse)and
      ((frmCadastroEmails.Components[n] as TCheckBox).Checked = True)then
    begin
      PegarCodigoEmail;
      nCodigoAreaInteresse := (frmCadastroEmails.Components[n] as TCheckBox).Tag;
      SalvarAreaInteresse;
    end;
  end;
end;

function TfrmCadastroEmails.SalvarEmailUnico: boolean;
var
  bRetorno: boolean;
begin
  bRetorno := True;

  LimparDadosEmail;
  LimparListaEmailsResumo;
  LimparListaEmailsSemServidorDominioCadastrado;
  FoCadEmail.email := Trim(edEmail.Text);
  FoCadEmail.servidor_do_email := Trim(edServidor.Text);
  FoCadEmail.dominio_1 := Trim(edDominio1.Text);
  FoCadEmail.dominio_2 := Trim(edDominio2.Text);
  FoCadEmail.nome_proprietario := Trim(edNome.Text);
  FoCadEmail.pais_proprietario := Trim(edPais.Text);
  FoCadEmail.cidade_proprietario := Trim(edCidade.Text);
  FoCadEmail.estado_proprietario := Trim(edEstado.Text);
  FoCadEmail.meio_captacao := Trim(mmMeioCaptacao.Text);
  try
    FoCadEmail.relevancia := StrToInt(cbBxRelevancia.Text);
  except
    FoCadEmail.relevancia := 1;
  end;

  try
    DM.ZConnection.StartTransaction;
    InserirEmail;
    DM.ZConnection.Commit;
  except
    bRetorno := False;
    DM.ZConnection.Rollback;
  end;

  Result := bRetorno;
end;

function TfrmCadastroEmails.VerificarEmailNomeProprietario(psEmail: String): String;
var
  nInicia, nFecha: Integer;
  sCharInicia, sCharFecha: Char;
  sEmail: String; //retorno
  sNomeProprietario: String;

  procedure PegarCaracteresInicioFim;
  begin
    case FnModoVerificarEmailNomeProprietario of
      n_EMAIL_NOME_1:
      begin
        sCharInicia := '<';
        sCharFecha := '>';
      end;

      n_EMAIL_NOME_2:
      begin
        sCharInicia := '<';
        sCharFecha := '>';
      end;

      n_EMAIL_NOME_3:
      begin
        sCharInicia := '(';
        sCharFecha := ')';
      end;

      n_EMAIL_NOME_4:
      begin
        sCharInicia := '(';
        sCharFecha := ')';
      end;
    end;
  end;


  procedure PegarNomeProprietarioEmail;
  begin
      case FnModoVerificarEmailNomeProprietario of
      n_EMAIL_NOME_1:
      begin
        sNomeProprietario := Copy(psEmail,0,nInicia);
        sEmail :=  Copy(psEmail,nInicia,nFecha);
      end;

      n_EMAIL_NOME_2:
      begin
        sEmail := Copy(psEmail,0,nInicia);
        sNomeProprietario :=  Copy(psEmail,nInicia,nFecha);
      end;

      n_EMAIL_NOME_3:
      begin
        sNomeProprietario := Copy(psEmail,0,nInicia);
        sEmail :=  Copy(psEmail,nInicia,nFecha);
      end;

      n_EMAIL_NOME_4:
      begin
        sEmail := Copy(psEmail,0,nInicia);
        sNomeProprietario :=  Copy(psEmail,nInicia,nFecha);
      end;
    end;
  end;

begin
(*
  n_EMAIL_NOME_1 = 1; //nome <email>
  n_EMAIL_NOME_2 = 2; //email <nome>
  n_EMAIL_NOME_3 = 3; //nome (email)
  n_EMAIL_NOME_4 = 4; //email (nome)
*)

  PegarCaracteresInicioFim;

  sEmail := STRING_INDEFINIDO;
  sNomeProprietario := STRING_INDEFINIDO;

  nInicia := Pos(sCharInicia, psEmail);
  nFecha := Pos(sCharFecha, psEmail);
  if(nInicia > NUMERO_NULO)and(nFecha > NUMERO_NULO)then
  begin
    PegarNomeProprietarioEmail;

    sNomeProprietario := StringReplace(sNomeProprietario,sCharInicia,'',[rfReplaceAll]);
    sNomeProprietario := StringReplace(sNomeProprietario,sCharFecha,'',[rfReplaceAll]);
    sNomeProprietario := StringReplace(sNomeProprietario,';','',[rfReplaceAll]);
    sNomeProprietario := StringReplace(sNomeProprietario,'"','',[rfReplaceAll]);
    sNomeProprietario := StringReplace(sNomeProprietario,'''','',[rfReplaceAll]);
    sEmail := StringReplace(sEmail,sCharInicia,'',[rfReplaceAll]);
    sEmail := StringReplace(sEmail,sCharFecha,'',[rfReplaceAll]);
    sEmail := StringReplace(sEmail,';','',[rfReplaceAll]);
    sEmail := StringReplace(sEmail,'"','',[rfReplaceAll]);
    sEmail := StringReplace(sEmail,'''','',[rfReplaceAll]);

    sNomeProprietario := Trim(sNomeProprietario);
    sEmail := Trim(sEmail);
  end;

  //dava pau, pois inseria o nome atual para o nome seguinte, caso o seguinte
  //não tivesse um nome.
  //if(Trim(sNomeProprietario) = STRING_INDEFINIDO)then
  //  sNomeProprietario := Trim(edNome.Text);

  edNome.Text := sNomeProprietario;
  FoCadEmail.nome_proprietario := sNomeProprietario;

  if(sEmail <> STRING_INDEFINIDO)then
    Result := sEmail
  else
    Result := psEmail;
end;

{aqui faz mais uma verificação, caso o email ainda não tenha um nome de
 proprietário, e está setado "Pegar Nome do Proprietário do Email"
 (ckBxPegarNomeProprietarioEmail), então a rotina seta o nome do proprietário
 para o endereço de email até encontrar o arroba}
procedure TfrmCadastroEmails.PegarNomeProprietarioEmailAteArroba(psEmail: String);
var
  nFimNome: Integer;
  sNomeProprietario: String;
begin
  if (ckBxPegarNomeProprietarioEmail.Checked) then
  begin
    nFimNome := Pos('@', psEmail)-1;
    sNomeProprietario :=  Copy(psEmail,0,nFimNome);
    edNome.Text := sNomeProprietario;
    FoCadEmail.nome_proprietario := sNomeProprietario;
  end;
end;

function TfrmCadastroEmails.SalvarEmailLote: boolean;
var
  bRetorno: boolean;
  nIni: integer;
  nTotCaractesLoteEmails: integer;
  sCharSeparador: string;
  sCharAtual: string;
  sEmailAtual: string;
  nTotEmailsLote: Integer;
  oArrayEmails: array[1..10] of String;

  procedure LimparArrayEmails;
  var
    n: Integer;
  begin
    for n:=1 to 10 do
      oArrayEmails[n] := STRING_INDEFINIDO;
  end;

  //procedimento para limpar a tela de onde os dados serão retirados para
  //inserir o registro atual.
  procedure LimparTelaInsercaoLote;
  begin
    edNome.Clear;
    edEmail.Clear;
    edServidor.Clear;
    edDominio1.Clear;
    edDominio2.Clear;
  end;

  function InserirEmailsLote: Boolean;
  var
    n: Integer;
  begin
    try
      Result := True;
      DM.ZConnection.StartTransaction;
      for n:=1 to 10 do
      begin
        LimparTelaInsercaoLote;
        if(oArrayEmails[n] <> STRING_INDEFINIDO)then
        begin
          if(FbVerificarEmailNomeProprietario)then
            oArrayEmails[n] := VerificarEmailNomeProprietario(oArrayEmails[n]);

          if (FoCadEmail.nome_proprietario = STRING_INDEFINIDO) then
            PegarNomeProprietarioEmailAteArroba(oArrayEmails[n]);

          edEmail.Text := oArrayEmails[n];
          EncontrarDadosNoEnderecoEmail;

          FoCadEmail.email := Trim(oArrayEmails[n]);
          FoCadEmail.servidor_do_email := Trim(edServidor.Text);
          FoCadEmail.dominio_1 := Trim(edDominio1.Text);
          FoCadEmail.dominio_2 := Trim(edDominio2.Text);
          InserirEmail;
        end;
      end;
      DM.ZConnection.Commit;
    except
      Result := False;
      DM.ZConnection.Rollback;
    end;
  end;

begin
  bRetorno := True;

  LimparArrayEmails;
  LimparDadosEmail;
  LimparListaEmailsResumo;
  LimparListaEmailsSemServidorDominioCadastrado;
  FoCadEmail.email := STRING_INDEFINIDO;
  FoCadEmail.servidor_do_email := STRING_INDEFINIDO;
  FoCadEmail.dominio_1 := STRING_INDEFINIDO;
  FoCadEmail.dominio_2 := STRING_INDEFINIDO;
  FoCadEmail.nome_proprietario := Trim(edNome.Text);
  FoCadEmail.pais_proprietario := Trim(edPais.Text);
  FoCadEmail.cidade_proprietario := Trim(edCidade.Text);
  FoCadEmail.estado_proprietario := Trim(edEstado.Text);
  FoCadEmail.meio_captacao := Trim(mmMeioCaptacao.Text);
  try
    FoCadEmail.relevancia := StrToInt(cbBxRelevancia.Text);
  except
    FoCadEmail.relevancia := 1;
  end;

  nTotCaractesLoteEmails := length(mmLoteEmails.Text);
  sCharSeparador := cbBxCaracterSeparador.Text;

  sCharAtual := STRING_INDEFINIDO;
  sEmailAtual := STRING_INDEFINIDO;
  nTotEmailsLote := 1;
  //varre o mmLoteEmails buscando por email's separados pelo caracter contido no edCaracterSeparador
  for nIni:=1 to nTotCaractesLoteEmails do
  begin
    sCharAtual := mmLoteEmails.Text[nIni];
    if(sCharAtual <> sCharSeparador)then
      sEmailAtual := sEmailAtual + sCharAtual;

    if(sCharAtual = sCharSeparador)or(nIni = nTotCaractesLoteEmails)then
    begin
      oArrayEmails[nTotEmailsLote] := sEmailAtual;
      inc(nTotEmailsLote);
      sEmailAtual := STRING_INDEFINIDO;
    end;

    if(nTotEmailsLote > 10)or(nIni >= nTotCaractesLoteEmails)then
    begin
      bRetorno := InserirEmailsLote;
      nTotEmailsLote := 1;
      LimparArrayEmails;
    end;
  end;

  Result := bRetorno;
end;

procedure TfrmCadastroEmails.AbrirSelecaoMeioCaptacao;
begin
  Application.CreateForm(TfrmExibirMeiosCaptacao,frmExibirMeiosCaptacao);
  frmExibirMeiosCaptacao.ShowModal;
  FreeAndNil(frmExibirMeiosCaptacao);
end;

procedure TfrmCadastroEmails.PovoarClientDataSetServidorDominio1e2;

  //buscando por servidores
  procedure BuscarServidores;
  begin
    zQryBuscarDistinct.Close;
    zQryBuscarDistinct.SQL.Clear;
    zQryBuscarDistinct.SQL.Add('SELECT DISTINCT(e.servidor_do_email)');
    zQryBuscarDistinct.SQL.Add(' FROM email e');
    zQryBuscarDistinct.SQL.Add(' ORDER BY e.servidor_do_email');
    zQryBuscarDistinct.Open;
    if(zQryBuscarDistinct.Active)and(zQryBuscarDistinct.RecordCount > NUMERO_NULO)then
    begin
      zQryBuscarDistinct.First;
      while not(zQryBuscarDistinct.Eof)do
      begin
        cdsServidores.Append;
        cdsServidores.FieldByName('SERVIDOR_DO_EMAIL').AsString :=
          zQryBuscarDistinct.fieldByName('servidor_do_email').AsString;
        zQryBuscarDistinct.Next;
      end;
      cdsServidores.Post;
    end;
  end;

  //buscando por dominio_1
  procedure BuscarDominio1;
  begin
    zQryBuscarDistinct.Close;
    zQryBuscarDistinct.SQL.Clear;
    zQryBuscarDistinct.SQL.Add('SELECT DISTINCT(e.dominio_1)');
    zQryBuscarDistinct.SQL.Add(' FROM email e');
    zQryBuscarDistinct.SQL.Add(' ORDER BY e.dominio_1');
    zQryBuscarDistinct.Open;
    if(zQryBuscarDistinct.Active)and(zQryBuscarDistinct.RecordCount > NUMERO_NULO)then
    begin
      zQryBuscarDistinct.First;
      while not(zQryBuscarDistinct.Eof)do
      begin
        cdsDominios_1.Append;
        cdsDominios_1.FieldByName('DOMINIO_1').AsString :=
          zQryBuscarDistinct.fieldByName('dominio_1').AsString;
        zQryBuscarDistinct.Next;
      end;
      cdsDominios_1.Post;
    end;
  end;

  //buscando por dominio_2
  procedure BuscarDominio2;
  begin
    zQryBuscarDistinct.Close;
    zQryBuscarDistinct.SQL.Clear;
    zQryBuscarDistinct.SQL.Add('SELECT DISTINCT(e.dominio_2)');
    zQryBuscarDistinct.SQL.Add(' FROM email e');
    zQryBuscarDistinct.SQL.Add(' ORDER BY e.dominio_2');
    zQryBuscarDistinct.Open;
    if(zQryBuscarDistinct.Active)and(zQryBuscarDistinct.RecordCount > NUMERO_NULO)then
    begin
      zQryBuscarDistinct.First;
      while not(zQryBuscarDistinct.Eof)do
      begin
        cdsDominios_2.Append;
        cdsDominios_2.FieldByName('DOMINIO_2').AsString :=
          zQryBuscarDistinct.fieldByName('dominio_2').AsString;
        zQryBuscarDistinct.Next;
      end;
      cdsDominios_2.Post;
    end;
  end;

begin
  //limpando data set's
  cdsServidores.Active;
  cdsDominios_1.Active;
  cdsDominios_2.Active;
  cdsServidores.EmptyDataSet;
  cdsDominios_1.EmptyDataSet;
  cdsDominios_2.EmptyDataSet;

  BuscarServidores;
  BuscarDominio1;
  BuscarDominio2;
end;

procedure TfrmCadastroEmails.VerificarExisteEmailComEsteServidorDominio1e2;

  function VerificarExisteRegistroNaLista(poLista:TStringList; psValor:string): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i:=0 to poLista.Count-1 do
    begin
      if(poLista.Strings[i] = psValor)then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

begin
  if not(cdsServidores.Locate('SERVIDOR_DO_EMAIL',FoCadEmail.servidor_do_email,[]))then
  begin
    if not(VerificarExisteRegistroNaLista(FoEmailsServidorNaoCadastro,FoCadEmail.servidor_do_email))then
    begin
      FoEmailsServidorNaoCadastro.Add(FoCadEmail.servidor_do_email);
      inc(FnTotalServidorNaoCadastrado);
    end;
  end;

  if not(cdsDominios_1.Locate('DOMINIO_1',FoCadEmail.dominio_1,[]))then
  begin
    if not(VerificarExisteRegistroNaLista(FoEmailsDominio1NaoCadastro,FoCadEmail.dominio_1))then
    begin
      FoEmailsDominio1NaoCadastro.Add(FoCadEmail.dominio_1);
      inc(FnTotalDominio1NaoCadastrado);
    end;
  end;

  if not(cdsDominios_2.Locate('DOMINIO_2',FoCadEmail.dominio_2,[]))then
  begin
    if not(VerificarExisteRegistroNaLista(FoEmailsDominio2NaoCadastro,FoCadEmail.dominio_2))then
    begin
      FoEmailsDominio2NaoCadastro.Add(FoCadEmail.dominio_2);
      inc(FnTotalDominio2NaoCadastrado);
    end;
  end;

  lblTotalServidorDesconhecido.Caption := IntToStr(FnTotalServidorNaoCadastrado);
  lblTotalDominio1Desconhecido.Caption := IntToStr(FnTotalDominio1NaoCadastrado);
  lblTotalDominio2Desconhecido.Caption := IntToStr(FnTotalDominio2NaoCadastrado);

  Application.ProcessMessages;
end;

procedure TfrmCadastroEmails.AbreTelaResumo;
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2], varVariant);
  vParametros[0] := FoEmailsInseridos.CommaText;
  vParametros[1] := FoEmailsRepetidos.CommaText;
  vParametros[2] := FoEmailsRejeitados.CommaText;

  Application.CreateForm(TfrmResumoInseriuEmail,frmResumoInseriuEmail);
  frmResumoInseriuEmail.passarParametro(PRM_EMAILS_TELA_RESUMO,vParametros);
  frmResumoInseriuEmail.ShowModal;
  FreeAndNil(frmResumoInseriuEmail);
end;

procedure TfrmCadastroEmails.AbreTelaResumoServidorDominiosNaoCadastrados;
var
  vParametros: Variant;
begin
  if(FoEmailsServidorNaoCadastro.Count > NUMERO_NULO)or
    (FoEmailsDominio1NaoCadastro.Count > NUMERO_NULO)or
    (FoEmailsDominio2NaoCadastro.Count > NUMERO_NULO)then
  begin
    vParametros := VarArrayCreate([0,2], varVariant);
    vParametros[0] := FoEmailsServidorNaoCadastro.CommaText;
    vParametros[1] := FoEmailsDominio1NaoCadastro.CommaText;
    vParametros[2] := FoEmailsDominio2NaoCadastro.CommaText;

    Application.CreateForm(TfrmResumoServidorDominiosNaoCadastrados,frmResumoServidorDominiosNaoCadastrados);
    frmResumoServidorDominiosNaoCadastrados.passarParametro(PRM_EMAIL_TELA_RESUMO_SERVIDOR_DOMINIOS_NAO_CADASTRADOS,vParametros);
    frmResumoServidorDominiosNaoCadastrados.ShowModal;
    FreeAndNil(frmResumoServidorDominiosNaoCadastrados);
  end;
end;

procedure TfrmCadastroEmails.VerificaCampoValido(oCampo: TCampoObrigatorio);
const
  oCOR_OK = clBlue;
  oCOR_PENDENTE = clRed;
var
  bOk: Boolean;

  procedure DefineFonteCampo(poCampo: TCheckBox; pbOk: Boolean);
  begin
    if pbOk then
    begin
      poCampo.Font.Color := oCOR_OK;
      poCampo.Font.Style := [];
    end
    else
    begin
      poCampo.Font.Color := oCOR_PENDENTE;
      poCampo.Font.Style := [fsItalic];
    end;

    poCampo.Checked := pbOk;
  end;

begin
  if oCampo = [emails]then
  begin
    bOk := Trim(mmLoteEmails.Text) <> STRING_INDEFINIDO;
    DefineFonteCampo(ckBxOkEmails,bOk);
  end

  else if oCampo = [caracSeparador] then
  begin
    bOk := Trim(cbBxCaracterSeparador.Text) <> STRING_INDEFINIDO;
    DefineFonteCampo(ckBxOkCaracSeparador,bOk);
  end

  else if oCampo = [relevancia] then
  begin
    bOk := cbBxRelevancia.ItemIndex > -1;
    DefineFonteCampo(ckBxOkRelevancia,bOk);
  end

  else if oCampo = [meioCaptacao] then
  begin
    bOk := Trim(mmMeioCaptacao.Text) <> STRING_INDEFINIDO;
    DefineFonteCampo(ckBxOkMeioCaptacao,bOk);
  end

  else if oCampo = [verificEmailNome] then
  begin
    if ckBxVerificarEmailNomeProprietario.Checked then
      bOk := rdGrpSeparacaoEmailNomeProprietario.ItemIndex > -1
    else
      bOk := True;
      DefineFonteCampo(ckBxOkVerificarEmailNome,bOk);
  end;
end;

procedure TfrmCadastroEmails.FormCreate(Sender: TObject);
begin
  FoEmailsInseridos := TStringList.Create;
  FoEmailsRepetidos := TStringList.Create;
  FoEmailsRejeitados := TStringList.Create;

  FbBuscarDistinctServidorDominio1e2 := False;
  FoEmailsServidorNaoCadastro := TStringList.Create;
  FoEmailsDominio1NaoCadastro := TStringList.Create;
  FoEmailsDominio2NaoCadastro := TStringList.Create;

  CriarAreasInteresse;

  cdsServidores.CreateDataSet;
  cdsDominios_1.CreateDataSet;
  cdsDominios_2.CreateDataSet;
  PovoarClientDataSetServidorDominio1e2;

  LimparTela;
  LimparDadosEmail;
  LimparListaEmailsResumo;
  LimparListaEmailsSemServidorDominioCadastrado;
end;

procedure TfrmCadastroEmails.btBtnSalvarCadastroSimplesClick(Sender: TObject);
var
  bSalvou: Boolean;
begin
  if(ValidarCamposObrigatorios([unico]))then
  begin
    bSalvou := SalvarEmailUnico;
    AbreTelaResumo;
    AbreTelaResumoServidorDominiosNaoCadastrados;
  end;
end;

procedure TfrmCadastroEmails.btBtnSalvarImportacaoLoteClick(Sender: TObject);
var
  bSalvou: Boolean;
begin
  InciarVariaveis;
  if(ValidarCamposObrigatorios([lote]))then
  begin
    if (ValidarDadosAntesCadastrar) then
    begin
      ContarTotalEmails;
      bSalvou := SalvarEmailLote;
      AbreTelaResumo;
      AbreTelaResumoServidorDominiosNaoCadastrados;
    end;
  end;
end;

procedure TfrmCadastroEmails.edEmailExit(Sender: TObject);
begin
  EncontrarDadosNoEnderecoEmail;
end;

procedure TfrmCadastroEmails.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoEmailsInseridos);
  FreeAndNil(FoEmailsRepetidos);
  FreeAndNil(FoEmailsRejeitados);
end;

procedure TfrmCadastroEmails.btBtnSelecionarMeioCaptacaoClick(
  Sender: TObject);
begin
  AbrirSelecaoMeioCaptacao;
end;

procedure TfrmCadastroEmails.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //foco no memo de cadastro de email's em lote
  if(Key = 116)then //F5
    mmLoteEmails.SetFocus;

  //foco no edit do caracter separador
  if(Key = 117)then //F6
    cbBxCaracterSeparador.SetFocus;

  //abre tela de seleção do meio de captação
  if(Key = 118)then //F7
    AbrirSelecaoMeioCaptacao;

  //salva importação do lote
  if(Key = 119)then //F8
    btBtnSalvarImportacaoLoteClick(Self);
end;

procedure TfrmCadastroEmails.mnItLimparClick(Sender: TObject);
begin
  LimparTela;
  LimparDadosEmail;
  LimparListaEmailsResumo;
  LimparListaEmailsSemServidorDominioCadastrado;
end;

procedure TfrmCadastroEmails.mnItSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCadastroEmails.mnItFocoLoteEmailsClick(Sender: TObject);
begin
  mmLoteEmails.SetFocus;
end;

procedure TfrmCadastroEmails.mnItFocoCaracterSeparadorClick(
  Sender: TObject);
begin
  cbBxCaracterSeparador.SetFocus;
end;

procedure TfrmCadastroEmails.mnItSelecaoMeioCaptacaoClick(Sender: TObject);
begin
  AbrirSelecaoMeioCaptacao;
end;

procedure TfrmCadastroEmails.mnItImportaoLoteClick(Sender: TObject);
begin
  btBtnSalvarImportacaoLoteClick(Self);
end;

procedure TfrmCadastroEmails.ckBxVerificarEmailNomeProprietarioClick(
  Sender: TObject);
begin
  rdGrpSeparacaoEmailNomeProprietario.Enabled := ckBxVerificarEmailNomeProprietario.Checked;
  VerificaCampoValido([verificEmailNome]);
end;

procedure TfrmCadastroEmails.mmLoteEmailsChange(Sender: TObject);
begin
  VerificaCampoValido([emails]);
end;

procedure TfrmCadastroEmails.mmLoteEmailsExit(Sender: TObject);
begin
  VerificaCampoValido([emails]);
  mmLoteEmails.Text := AnsiLowerCase(mmLoteEmails.Text);
end;

procedure TfrmCadastroEmails.edCaracterSeparadorxChange(Sender: TObject);
begin
  VerificaCampoValido([caracSeparador]);
end;

procedure TfrmCadastroEmails.edCaracterSeparadorxExit(Sender: TObject);
begin
  VerificaCampoValido([caracSeparador]);
end;

procedure TfrmCadastroEmails.cbBxRelevanciaChange(Sender: TObject);
begin
  VerificaCampoValido([relevancia]);
end;

procedure TfrmCadastroEmails.cbBxRelevanciaExit(Sender: TObject);
begin
  VerificaCampoValido([relevancia]);
end;

procedure TfrmCadastroEmails.mmMeioCaptacaoChange(Sender: TObject);
begin
  VerificaCampoValido([meioCaptacao]);
end;

procedure TfrmCadastroEmails.mmMeioCaptacaoExit(Sender: TObject);
begin
  VerificaCampoValido([meioCaptacao]);
end;

procedure TfrmCadastroEmails.rdGrpSeparacaoEmailNomeProprietarioClick(
  Sender: TObject);
begin
  VerificaCampoValido([verificEmailNome]);
end;

procedure TfrmCadastroEmails.cbBxCaracterSeparadorChange(Sender: TObject);
begin
  VerificaCampoValido([caracSeparador]);
end;

procedure TfrmCadastroEmails.cbBxCaracterSeparadorExit(Sender: TObject);
begin
  VerificaCampoValido([caracSeparador]);
end;

end.
