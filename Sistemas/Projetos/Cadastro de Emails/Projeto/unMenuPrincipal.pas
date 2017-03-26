unit unMenuPrincipal;

interface

uses
  Windows, Controls, StdCtrls, Buttons, Classes,
  Messages, SysUtils, Variants, Graphics, Forms,
  Dialogs;

type
  TfrmPrincipal = class(TForm)
    btBtnPesquisaEmails: TBitBtn;
    btBtnCadastrarEmails: TBitBtn;
    lblVersao: TLabel;
    btBtnEnviarEmail: TBitBtn;
    btBtnAreasInteresse: TBitBtn;
    btBtnAjustarEmails: TBitBtn;
    btBtnConfiguracoes: TBitBtn;
    procedure btBtnPesquisaEmailsClick(Sender: TObject);
    procedure btBtnCadastrarEmailsClick(Sender: TObject);
    procedure btBtnEnviarEmailClick(Sender: TObject);
    procedure btBtnAreasInteresseClick(Sender: TObject);
    procedure btBtnAjustarEmailsClick(Sender: TObject);
    procedure btBtnConfiguracoesClick(Sender: TObject);
    procedure btnTempClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses unPesquisaEmails, unPrincipal, unEnviarEmail, unCadAreasInteresse,
  unAjustarCadastroEmails, unConfiguracoes, USendMail;

{$R *.dfm}

procedure TfrmPrincipal.btBtnPesquisaEmailsClick(Sender: TObject);
begin
  Application.CreateForm(TfrmPesquisaEmails,frmPesquisaEmails);
  frmPesquisaEmails.ShowModal;
  FreeAndNil(frmPesquisaEmails);
end;

procedure TfrmPrincipal.btBtnCadastrarEmailsClick(Sender: TObject);
begin
  Application.CreateForm(TfrmCadastroEmails,frmCadastroEmails);
  frmCadastroEmails.ShowModal;
  FreeAndNil(frmCadastroEmails);
end;

procedure TfrmPrincipal.btBtnEnviarEmailClick(Sender: TObject);
begin
  frmEnviarEmail.Show;
end;

procedure TfrmPrincipal.btBtnAreasInteresseClick(Sender: TObject);
begin
  Application.CreateForm(TfrmCadAreasInteresse,frmCadAreasInteresse);
  frmCadAreasInteresse.ShowModal;
  FreeAndNil(frmCadAreasInteresse);
end;

procedure TfrmPrincipal.btBtnAjustarEmailsClick(Sender: TObject);
begin
  Application.CreateForm(TfrmAjustarCadastroEmails, frmAjustarCadastroEmails);
  frmAjustarCadastroEmails.ShowModal;
  FreeAndNil(frmAjustarCadastroEmails);
end;

procedure TfrmPrincipal.btBtnConfiguracoesClick(Sender: TObject);
begin
  Application.CreateForm(TfrmConfiguracoes, frmConfiguracoes);
  frmConfiguracoes.ShowModal;
  FreeAndNil(frmConfiguracoes);
end;

procedure TfrmPrincipal.btnTempClick(Sender: TObject);
begin
  frmSendMail.Show;
end;

end.