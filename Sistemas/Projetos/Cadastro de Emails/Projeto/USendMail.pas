unit USendMail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdIOHandler, IdIOHandlerSocket, IdSSLOpenSSL,
  IdAntiFreezeBase, IdAntiFreeze, IdMessage, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,WinInet; // para verificação de conexão

type
  TfrmSendMail = class(TForm)
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    IdAntiFreeze1: TIdAntiFreeze;
    SSLSocket: TIdSSLIOHandlerSocket;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    cancelar: Boolean;
  public
    { Public declarations }
  end;

var
  frmSendMail: TfrmSendMail;

implementation

{$R *.dfm}

procedure TfrmSendMail.Button1Click(Sender: TObject);
var
  i: integer;
begin
  try
  cancelar:= false;
  Screen.Cursor:= crHourGlass;
  //btnEnviar.Enabled:= false;
  //pg1.MaxValue := StrToInt(EdtNum.Text);
  //pg1.Progress := 0;
  IdSMTP1.Host := 'smtp.gmail.com';
  IdSMTP1.Username:= 'bugrii@gmail.com';
  IdSMTP1.Password := 'qwe370268';

  IdSMTP1.AuthenticationType:= atLogin;
  //IdSMTP1.AuthenticationType:= atNone;

  IdMessage1.MessageParts.Clear;
  //for i:= 0 to ListBoxAnexos.Items.Count - 1 do
  //TIdAttachment.Create(IdMessage1.MessageParts, ListBoxAnexos.Items[i]);

  IdMessage1.From.Address := 'bugrii@gmail.com';
  IdMessage1.Subject:= 'assunto';
  IdMessage1.Body.Text := 'body';

  IdMessage1.ContentType:='text/html';
  {aqui eu coloquei  codigo html   e todos estão marcados com *  }
  IdMessage1.Body.Add('<*html><*body>');
  IdMessage1.Body.Add('<*p><*a href="http://marcos.sytes.net/comprar/index.php"><*img src="http://www.websitebauru.110mb.com/compra.gif"><*/a><*/p>');
  IdMessage1.Body.Add('<*p><*hr><*/p><*br>');
  IdMessage1.Body.Add('<*/body><*/html>');

  IdMessage1.Recipients.EMailAddresses := 'jonassazevedo@hotmail.com';
  //IdMessage1.BccList.EMailAddresses := EdtBCC.Text;
  //IdMessage1.CCList.EMailAddresses := EdtCC.Text;

  if not IdSMTP1.Connected then
    IdSMTP1.Connect();

  IdSMTP1.Send(IdMessage1);

  Application.ProcessMessages;

finally
IdSMTP1.Disconnect;
Screen.Cursor:= crDefault;

end;
end;

procedure TfrmSendMail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
IdSMTP1.Disconnect;
end;

procedure TfrmSendMail.FormKeyPress(Sender: TObject; var Key: Char);
begin
cancelar:= (key = #27);
end;

procedure TfrmSendMail.FormCreate(Sender: TObject);
begin
  with IdSMTP1 do
  begin
    AuthenticationType := atLogin;
    Host := 'smtp.gmail.com';
    IOHandler := SSLSocket;
    Password := 'qwe370268';
    Port := 465;
    Username := 'bugrii@gmail.com';
  end;
  SSLSocket.SSLOptions.Method := sslvSSLv3;// sslvSSLv2;
  SSLSocket.SSLOptions.Mode := sslmClient;
end;

end.
