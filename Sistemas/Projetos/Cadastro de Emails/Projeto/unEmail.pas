unit unEmail;

interface
uses
  IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient,
  IdSMTP, IdBaseComponent, IdMessage,
  Classes, //TStringList

  Windows, Messages, Variants, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, Buttons,
  UrlMon, Menus, ComCtrls, AppEvnts, ExtCtrls,
  ActiveX,
  RXShell;


  type TEmail = class
    private
      IdMessage: TIdMessage;
      IdSMTP: TIdSMTP;
      //variáveis que controlam as propriedades para os componentes de  envio de email
      oAutenticacao: TAuthenticationType;
      sUsername: string;
      sPassword: string;
      sNomeRemetente: string;
      sDestinatario: string;
      sHost: string;
      nPorta: integer;
      sAssunto: string;
      oMensagem: TStringList;
    public
      constructor Create;
      destructor Destroy; override;
      procedure IniciarPropriedadesComponentesEnvioEmail;
      //configuração dos componentes de envio de email
      procedure ConfigurarAuntenticacao;
      procedure ConfigurarRemetente;
      procedure ConfigurarDestinatario;
      procedure ConfigurarServidorRemetente;
      procedure ConfigurarAssuntoMensagem;
      procedure EnviarEmail;
      procedure temp;
  end;

implementation

uses SysUtils;

constructor TEmail.Create;
begin
  IdMessage := TIdMessage.Create(nil);
  IdSMTP := TIdSMTP.Create(nil);
  oMensagem := TStringList.Create;
  inherited Create;
end;

destructor TEmail.Destroy;
begin
  FreeAndNil(IdMessage);
  FreeAndNil(IdSMTP);
  FreeAndNil(oMensagem);
  inherited;
end;

procedure TEmail.IniciarPropriedadesComponentesEnvioEmail;
begin
  oAutenticacao := atLogin;
  sUsername := 'bugrii@gmail.com';
  sPassword := 'qwe370268';
  sNomeRemetente := 'Jonas';
  sDestinatario := 'bugrii@gmail.com';
  sHost := 'smtp.gmail.com';
  nPorta := 465;
  //nPorta := 25;
  sAssunto := 'Assunto';
  oMensagem.Add('mensagem');
end;

procedure TEmail.ConfigurarAuntenticacao;
begin
  IdSMTP.AuthenticationType := oAutenticacao;
  IdSMTP.ASCIIFilter := False;
  IdSMTP.BoundPort := 0;
//  IdSMTP.MaxLineAction := maException;
  IdSMTP.MaxLineLength := 16384;
  IdSMTP.ReadTimeout := 0;
  IdSMTP.RecvBufferSize := 1;
  IdSMTP.SendBufferSize := 1;
  IdSMTP.UseEhLo := True;

  IdMessage.AttachmentEncoding := 'MIME';
  IdMessage.Encoding := meMIME;
  IdMessage.NoDecode := False;
  IdMessage.NoEncode := False;
  IdMessage.Priority := mpNormal;
  IdMessage.UseNowForDate := True;
end;

procedure TEmail.ConfigurarRemetente;
begin
  IdSMTP.Username := sUsername;
  IdSMTP.Password := sPassword;
  IdMessage.From.Address := sUsername;
  IdMessage.From.Name := sNomeRemetente;
end;

procedure TEmail.ConfigurarDestinatario;
begin
  IdMessage.Recipients.EMailAddresses := sDestinatario;
end;

procedure TEmail.ConfigurarServidorRemetente;
begin
  IdSMTP.Host := sHost;
  IdSMTP.Port := nPorta;
end;

procedure TEmail.ConfigurarAssuntoMensagem;
begin
  IdMessage.Subject := sAssunto;
  IdMessage.Body := oMensagem;
end;

procedure TEmail.EnviarEmail;
begin
  IdSMTP.Connect;
  try
    IdSMTP.Send(IdMessage);
  finally
    IdSMTP.Disconnect;
  end;
end;

procedure TEmail.temp;
begin
  IniciarPropriedadesComponentesEnvioEmail;
  ConfigurarAuntenticacao;
  ConfigurarRemetente;
  ConfigurarDestinatario;
  ConfigurarServidorRemetente;
  ConfigurarAssuntoMensagem;
  EnviarEmail;
end;

end.
//      IdSMTP.AuthenticationType := atLogin;
//      IdSMTP.Username := DM.zQryEnvioEmailEMAIL_DE.AsString;
//      IdSMTP.Password := DM.zQryEnvioEmailSENHA_DE.AsString;
//      IdSMTP.Host := DM.zQryEnvioEmailHOST.AsString;
//      IdSMTP.Port := DM.zQryEnvioEmailPORTA.AsInteger;
//      IdMessage.From.Address := DM.zQryEnvioEmailEMAIL_DE.AsString;
//      IdMessage.From.Name := DM.zQryEnvioEmailNOME_DE.AsString;

//      IdMessage.Recipients.EMailAddresses := DM.zQryEnvioEmailEMAIL_PARA.AsString;
  //    IdMessage.Subject := 'PLÁ - Resumo Diário';
//      IdMessage.Body := mensagemResumo;
//      IdSMTP.Connect();
    //  try
  //      IdSMTP.Send(IdMessage);
//      finally
  //      IdSMTP.Disconnect;
//      end;
