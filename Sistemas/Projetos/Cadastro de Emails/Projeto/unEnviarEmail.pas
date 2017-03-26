unit unEnviarEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, unEmail;

type
  TfrmEnviarEmail = class(TForm)
    grpBxListaEmails: TGroupBox;
    lstBxListaEmails: TListBox;
    pnlBotaoLimparLista: TPanel;
    btBtnListarLista: TBitBtn;
    lblTotalEmails: TLabel;
    lblTituloTotalEmails: TLabel;
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btBtnListarListaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  public
    procedure AdicionarEmailNaLista(psEmail: String);
    procedure DeletarEmailDaLista(psEmail: String);
  end;

var
  frmEnviarEmail: TfrmEnviarEmail;

implementation

{$R *.dfm}

{ TfrmEnviarEmail }

procedure TfrmEnviarEmail.AdicionarEmailNaLista(psEmail: String);

  function VerificarEmailJaEstaNaLista(): Boolean;
  var
    bRetorno: Boolean;
    n: Integer;
  begin
    bRetorno := False;
    for n:=0 to lstBxListaEmails.Items.Count-1 do
    begin
      if(lstBxListaEmails.Items.Strings[n] = psEmail)then
      begin
        bRetorno := True;
        Break;
      end;
    end;
    Result := bRetorno;
  end;

begin
  if not(VerificarEmailJaEstaNaLista)then
    lstBxListaEmails.Items.Add(psEmail);
  lblTotalEmails.Caption := IntToStr(lstBxListaEmails.Items.Count);
end;

procedure TfrmEnviarEmail.DeletarEmailDaLista(psEmail: String);
var
  n: Integer;
begin
  for n:=0 to lstBxListaEmails.Items.Count-1 do
  begin
    if(lstBxListaEmails.Items.Strings[n] = psEmail)then
    begin
      lstBxListaEmails.Items.Delete(n);
      Break;
    end;
  end;
  lblTotalEmails.Caption := IntToStr(lstBxListaEmails.Items.Count);
end;

procedure TfrmEnviarEmail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caNone;
  Hide;
end;

procedure TfrmEnviarEmail.btBtnListarListaClick(Sender: TObject);
begin
  lstBxListaEmails.Items.Clear;
  lblTotalEmails.Caption := '0';  
end;

procedure TfrmEnviarEmail.Button1Click(Sender: TObject);
var
  email: TEmail;
begin
  email := TEmail.Create;
  email.temp;
  email.free;


end;

end.
