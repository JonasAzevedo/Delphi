unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    edNome: TEdit;
    Label1: TLabel;
    lblCadastro: TLabel;
    lblNome: TLabel;
    StatusBar: TStatusBar;
    WebBrowser: TWebBrowser;
    ProgressBar: TProgressBar;
    mmPalavras: TMemo;
    edQtde: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    mmEmails: TMemo;
    Label4: TLabel;
    mmTelefones: TMemo;
    Label5: TLabel;
    Label6: TLabel;
    lblTotal: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure WebBrowserDownloadBegin(Sender: TObject);
    procedure WebBrowserDownloadComplete(Sender: TObject);
    procedure WebBrowserProgressChange(Sender: TObject; Progress,
      ProgressMax: Integer);
    procedure WebBrowserStatusTextChange(Sender: TObject;
      const Text: WideString);
  private
    procedure aguardaProcesso();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Math;

{$R *.dfm}

procedure TForm1.aguardaProcesso();
var
  b: boolean;
begin
  b := false;
  while(b=false)do
    begin
    if(WebBrowser.ReadyState = READYSTATE_COMPLETE) then
      b := true;
    Application.ProcessMessages;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: Integer;
  r: Integer;
  totPalavras: Integer;
  totEmails: Integer;
  totTelefones: Integer;
  nome: String;
  nomeEnviar: String;
  emailEnviar: String;
  telefone1Enviar,telefone2Enviar: String;
  nQtde: Integer;
begin
  lblTotal.Caption := '0';
  nQtde := StrToInt(edQtde.Text);
  nome := edNome.Text;
  totPalavras := mmPalavras.Lines.Count;
  totEmails := mmEmails.Lines.Count;
  totTelefones := mmTelefones.Lines.Count;
  WebBrowser.Silent := true; //desabilita javascript
  for i:=1 to nQtde do
    begin
    WebBrowser.Navigate('http://www.blocoosbartira.com.br/inscricoes.php');
    aguardaProcesso();
    //pegando nome a ser enviado
    Randomize;
    r := Random(totPalavras-1);
    nomeEnviar := mmPalavras.Lines.Strings[r];
    //nomeEnviar := nome + '_' + IntToStr(i);

    //pegando email a ser enviado
    Randomize;
    r := Random(totEmails-1);
    emailEnviar := mmEmails.Lines.Strings[r];

    //pegando telefones a serem enviados
    Randomize;
    r := Random(totTelefones-1);
    telefone1Enviar := mmTelefones.Lines.Strings[r];
    Randomize;
    r := Random(totTelefones-1);
    telefone2Enviar := mmTelefones.Lines.Strings[r];

    lblCadastro.Caption := IntToStr(i);
    lblNome.Caption := nomeEnviar;
    Application.ProcessMessages;
    WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('Nome').value := nomeEnviar;
    WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('DataNasc').value := '10/12/2010';
    WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('RG').value := 'rg';
    WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('CPF').value := 'cpf';
    WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('Telefone').value := telefone1Enviar;
    WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('Celular').value := telefone2Enviar;// '(49)1111-3333';
    WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('Email').value := emailEnviar;// 'uantwouknobi@gmail.com';
    Randomize;
    r := Random(4);
    case r of
      1: WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('Tamanho').value := 'P';
      2: WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('Tamanho').value := 'M';
      3: WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('Tamanho').value := 'G';
      4: WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('Tamanho').value := 'GG';
    end;
    r := Random(2);
    case r of
      1: WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('Tipo').value := 'Normal';
      2: WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('Tipo').value := 'Baby Look';
    end;
    WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('Observacoes').value := nomeEnviar;

    WebBrowser.OleObject.document.forms.item('envia_inscricao').elements.item('Submit').Click;
    lblTotal.Caption := IntToStr(i);
    aguardaProcesso();
    Application.ProcessMessages;
    end;
end;


procedure TForm1.WebBrowserDownloadBegin(Sender: TObject);
begin
  //Atualiza o status no inicio da navegação
{  StatusBar.Panels[1].Text := 'Carregando';
  StatusBar.Panels[0].Text := WebBrowser.LocationURL;
  ProgressBar.Position := 0;}
end;

procedure TForm1.WebBrowserDownloadComplete(Sender: TObject);
begin
 { //Atualiza o status no final da navegação
  StatusBar.Panels[0].Text := WebBrowser.LocationName;
  StatusBar.Panels[1].Text := 'Concluído';
  ProgressBar.Position := 0;}
end;

procedure TForm1.WebBrowserProgressChange(Sender: TObject; Progress,
  ProgressMax: Integer);
begin
{  if((Progress>=1)and(ProgressMax>1))then
    begin
    ProgressBar.Position := (round(Progress*100) div ProgressMax);
    ProgressBar.Visible := true;
    StatusBar.Panels[2].Text := IntToStr(Progress) + ' bytes';
    end
  else
    begin
    ProgressBar.Position := 1;
    ProgressBar.Visible := false;
    end;}
end;

procedure TForm1.WebBrowserStatusTextChange(Sender: TObject;
  const Text: WideString);
begin
//  StatusBar.Panels[0].Text := Text;
end;

end.
