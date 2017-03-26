unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, Buttons, DBXpress, DB, SqlExpr,
  Menus, ExtCtrls, IdBaseComponent, IdMessage, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP, RXShell;

type
  TfrmPrincipal = class(TForm)
    mmHTML: TMemo;
    MainMenu: TMainMenu;
    mnArquivo: TMenuItem;
    mnItSair: TMenuItem;
    mnCadastro: TMenuItem;
    mnItSite: TMenuItem;
    mnItEMails: TMenuItem;
    grpBxOpcoes: TGroupBox;
    btBtnVerificar: TBitBtn;
    wbBrsSite: TWebBrowser;
    Timer: TTimer;
    IdMessage: TIdMessage;
    IdSMTP: TIdSMTP;
    RxTrayIcon: TRxTrayIcon;
    PopupMenu: TPopupMenu;
    Abrir1: TMenuItem;
    Fechar1: TMenuItem;
    procedure Button2Click(Sender: TObject);
    procedure mnItSairClick(Sender: TObject);
    procedure mnItSiteClick(Sender: TObject);
    procedure mnItEMailsClick(Sender: TObject);
    procedure wbBrsSiteDownloadComplete(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure RxTrayIconDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Abrir1Click(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
  private
    etapa: Integer;
    procedure aguardaProcesso();
    procedure pegaHTML();
    procedure verificaStatusSite();
    procedure enviaEmail();
  public

  end;

var
  frmPrincipal: TfrmPrincipal;
  H : THandle;

implementation

uses unCadastroSite, unCadastroEmail, unDM, unSelecionaEmailParaSite,
  unSelecionaEmailEnviar;

{$R *.dfm}

(*procedimentos específicos*)
procedure TfrmPrincipal.enviaEmail();
begin


end;

procedure TfrmPrincipal.aguardaProcesso();
var
  b: boolean;
begin
  b := false;
  while(b=false)do
    begin
      if(wbBrsSite.ReadyState = READYSTATE_COMPLETE) then
        b := true;
      Application.ProcessMessages;
    end;
end;

procedure TfrmPrincipal.pegaHTML();
var
  documento: Variant;
begin
  documento := wbBrsSite.Document;
  mmHTML.Text := documento.Body.OuterHTML;
end;


procedure TfrmPrincipal.verificaStatusSite();
var
  i: Integer;
  msg: TStrings;
begin
  i := pos('registrado',mmHTML.Text);
  //achou site
  if(i>0)then
    begin
    //atualizando cadastro do site
    DM.zQryAtualizaSite.Close;
    DM.zQryAtualizaSite.SQL.Clear;
    DM.zQryAtualizaSite.SQL.Add('UPDATE site SET status=1, data_ativacao=CURRENT_TIMESTAMP WHERE codigo=:cod');
    DM.zQryAtualizaSite.ParamByName('cod').AsInteger := DM.zQrySiteCODIGO.AsInteger;
    DM.zQryAtualizaSite.ExecSQL;

    //enviando E-Mail
    DM.zQryEnviaEmailSite.Close;
    DM.zQryEnviaEmailSite.SQL.Clear;
    DM.zQryEnviaEmailSite.SQL.Add('SELECT * FROM envia_email_site WHERE cod_site=:co_si');
    DM.zQryEnviaEmailSite.ParamByName('co_si').AsInteger := DM.zQrySiteCODIGO.AsInteger;
    DM.zQryEnviaEmailSite.Open;
    DM.zQryEnviaEmailSite.Refresh;
    DM.zQryEnviaEmailSite.First;
    while(not(DM.zQryEnviaEmailSite.Eof))do
      begin
      DM.zQryEnviaEmail.Close;
      DM.zQryEnviaEmail.SQL.Clear;
      DM.zQryEnviaEmail.SQL.Add('SELECT * FROM envia_email WHERE codigo=:cod');
      DM.zQryEnviaEmail.ParamByName('cod').AsInteger := DM.zQryEnviaEmailSiteCOD_ENVIA_EMAIL.AsInteger;
      DM.zQryEnviaEmail.Open;
      DM.zQryEnviaEmail.Refresh;
      if(DM.zQryEnviaEmail.RecordCount<>0)then
        begin
        IdMessage.From.Address := DM.zQryEnviaEmailEMAIL_DE.AsString;
        IdMessage.From.Name := DM.zQryEnviaEmailEMAIL_PARA.AsString;
        IdSMTP.Host := DM.zQryEnviaEmailHOST.AsString;
        IdSMTP.Port := DM.zQryEnviaEmailPORTA.AsInteger;
        IdSMTP.Username := DM.zQryEnviaEmailEMAIL_DE.AsString;
        IdSMTP.Password := DM.zQryEnviaEmailSENHA_DE.AsString;
        IdMessage.Recipients.EMailAddresses := DM.zQryEnviaEmailEMAIL_PARA.AsString;
        IdMessage.Subject := 'Status do site ' + DM.zQrySiteSITE.AsString;
        msg := TStringList.Create;
        msg.Add('Site ');
        msg.Add(DM.zQrySiteSITE.AsString);
        msg.Add(' cadastrado com sucesso');
        IdMessage.Body := msg;

        IdSMTP.AuthenticationType := atLogin;

        IdSMTP.Connect(3000);
        Application.ProcessMessages;
        try
          IdSMTP.Send(IdMessage);
        finally
          IdSMTP.Disconnect;
          msg.Destroy;
        end;
        end;
      DM.zQryEnviaEmailSite.Next;
      end;
    end;
end;

(*fim procedimentos específicos*)

procedure TfrmPrincipal.Button2Click(Sender: TObject);
var
  i: Integer;
begin
  i := pos('registrado',mmHTML.Text);
  if(i>0)then
    ShowMessage('Registrado')
  else
    ShowMessage('Não Registrado');
end;

procedure TfrmPrincipal.mnItSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.mnItSiteClick(Sender: TObject);
begin
  Application.CreateForm(TfrmCadastroSite,frmCadastroSite);
  frmCadastroSite.ShowModal;
  frmCadastroSite.Free;
end;

procedure TfrmPrincipal.mnItEMailsClick(Sender: TObject);
begin
  Application.CreateForm(TfrmCadastroEmails,frmCadastroEmails);
  frmCadastroEmails.ShowModal;
  frmCadastroEmails.Free;
end;

procedure TfrmPrincipal.wbBrsSiteDownloadComplete(Sender: TObject);
begin
  if(etapa=10)then
    begin
    pegaHTML();
    Sleep(200);
    Application.ProcessMessages;
    verificaStatusSite();
    etapa := 0;
    end;
end;

procedure TfrmPrincipal.TimerTimer(Sender: TObject);
begin
  //aproximadamente 15 minutos
  DM.zQrySite.Close;
  DM.zQrySite.SQL.Clear;
  DM.zQrySite.SQL.Add('SELECT * FROM site WHERE status=0');
  DM.zQrySite.Open;
  DM.zQrySite.Refresh;
  DM.zQrySite.First;
  while(not(DM.zQrySite.Eof))do
    begin
    etapa := 0;
    wbBrsSite.Navigate('www.registro.br');
    aguardaProcesso();
    wbBrsSite.OleObject.Document.All.Tags('input').item('qr').value:=DM.zQrySiteSITE.AsString;
    Sleep(200);
    Application.ProcessMessages;
    wbBrsSite.OleObject.Document.All.Tags('input').item(1).Click;
    aguardaProcesso();
    etapa := 10;
    
    DM.zQrySite.Next;
    end;
end;

procedure TfrmPrincipal.RxTrayIconDblClick(Sender: TObject);
begin
  show; {Mostra o form}
  H := FindWindow(nil,'TrayIcon'); { acha o ponteiro da aplicação no sistema}
  ShowWindow(h,SW_RESTORE); { mostra aplicação na barra de tarefas}
  RxTrayIcon.Active := false; {oculta ícone do tray icon}
end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if CanClose then { se o comando para fechar for acionado }
    CanClose := false; { cancela o comando }
  H := FindWindow(nil,'TrayIcon'); { acha o ponteiro da aplicação no sistema}
  ShowWindow(h,SW_HIDE); { esconde a aplicação da barra de tarefas}
  RxTrayIcon.Active := true; { coloca ícone no tray icon}
  hide; { esconde o form }
end;

procedure TfrmPrincipal.Abrir1Click(Sender: TObject);
begin
  RxTrayIconDblClick(Sender);
end;

procedure TfrmPrincipal.Fechar1Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
