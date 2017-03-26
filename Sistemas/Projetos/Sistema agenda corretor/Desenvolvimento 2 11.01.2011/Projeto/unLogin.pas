unit unLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AppEvnts, ComCtrls, StdCtrls, Buttons, Mask,
  plsTMaskEdit, plsEdit, unFuncoes, unSistema;

type
  TfrmLogin = class(TForm)
    lblSenha: TLabel;
    lblUsuario: TLabel;
    lblVersao: TLabel;
    lblSistema: TLabel;
    plsEdUsuario: TPlsEdit;
    plsMedSenha: TPlsMaskEdit;
    btBtnLogin: TBitBtn;
    btBtnFinalizar: TBitBtn;
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    Timer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerTimer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure btBtnFinalizarClick(Sender: TObject);
    procedure btBtnLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure plsEdUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure plsMedSenhaKeyPress(Sender: TObject; var Key: Char);
  private
    FoLogin: TFuncoes;
    bRealizouLogin: boolean;
    FoSistema: TSistema;
  public

  end;

var
  frmLogin: TfrmLogin;

implementation

uses unPrincipal, unConstantes;

{$R *.dfm}

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  FoSistema := TSistema.Create;
  FoSistema.configurarFormatoDataHora();
  FoLogin := TFuncoes.Create();
  bRealizouLogin := False;
end;


procedure TfrmLogin.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoSistema);
  FreeAndNil(FoLogin);
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if(Self.bRealizouLogin = False)then
    Application.Terminate;
end;

procedure TfrmLogin.TimerTimer(Sender: TObject);
begin
  StatusBar.Panels[1].Text := DateTimeToStr(Now);
end;

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key=#27)then
    Close;
end;

procedure TfrmLogin.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmLogin.btBtnFinalizarClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.btBtnLoginClick(Sender: TObject);
var
  nCodUsuario: Integer;
  sNomeUsuario: String;
  vParametros: Variant;
begin
  nCodUsuario := NUMERO_INDEFINIDO;
  sNomeUsuario := STRING_INDEFINIDO;
  if (FoLogin.realizarLogin(plsEdUsuario.Text,plsMedSenha.Text,nCodUsuario,sNomeUsuario))then
  begin
    vParametros := VarArrayCreate([0,1], varVariant);
    vParametros[0] := nCodUsuario;
    vParametros[1] := sNomeUsuario;
    frmPrincipal.passarParametro(PRM_REALIZOU_LOGIN,vParametros);
    Self.bRealizouLogin := True;
    Self.Close;
  end
  else
  begin
    MessageDlg('Usuário não encontrado.', mtWarning, [mbOK], 0);
    plsEdUsuario.SetFocus;
  end;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  //carregando logotipo
  try
    //imgLogotipo.Visible := True;
    //imgLogotipo.Picture.LoadFromFile(login.carregarLogotipoEmpresa());
  except
    //imgLogotipo.Visible := False;
  end;
//  imgLogotipo.Visible := False;

  //versão
  lblVersao.Caption := 'Versão: ' + FoLogin.getVersao();

  plsEdUsuario.Clear;
  plsMedSenha.Clear;
  plsEdUsuario.SetFocus;
end;

procedure TfrmLogin.plsEdUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key=#13)then
  begin
    if((plsEdUsuario.Text <> STRING_INDEFINIDO)and(plsMedSenha.Text <> STRING_INDEFINIDO))then
      btBtnLoginClick(Self);
  end;
end;

procedure TfrmLogin.plsMedSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key=#13)then
  begin
    if((plsEdUsuario.Text <> STRING_INDEFINIDO)and(plsMedSenha.Text <> STRING_INDEFINIDO))then
      btBtnLoginClick(Self);
  end;
end;

end.
