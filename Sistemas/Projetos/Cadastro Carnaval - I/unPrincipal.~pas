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
  nome: String;
  nomeEnviar: String;
begin
  nome := edNome.Text;
  totPalavras := mmPalavras.Lines.Count;
  WebBrowser.Silent := true; //desabilita javascript
  for i:=1 to 10000 do
    begin
    WebBrowser.Navigate('http://www.blocoosbartira.com.br/form.php');
    aguardaProcesso();
    Randomize;
    r := Random(totPalavras-1);
    nomeEnviar := mmPalavras.Lines.Strings[r];
    //nomeEnviar := nome + '_' + IntToStr(i);
    lblCadastro.Caption := IntToStr(i);
    lblNome.Caption := nomeEnviar;
    Application.ProcessMessages;
    WebBrowser.OleObject.document.forms.item('envia').elements.item('nome').value := nomeEnviar;
    WebBrowser.OleObject.document.forms.item('envia').elements.item('nascimento').value := 'e agora José?';
    WebBrowser.OleObject.document.forms.item('envia').elements.item('celular').value := 'psss';
    Randomize;
    r := Random(5);
    case r of
      1: WebBrowser.OleObject.document.forms.item('envia').elements.item('tamanho').value := 'P';
      2: WebBrowser.OleObject.document.forms.item('envia').elements.item('tamanho').value := 'M';
      3: WebBrowser.OleObject.document.forms.item('envia').elements.item('tamanho').value := 'G';
      4: WebBrowser.OleObject.document.forms.item('envia').elements.item('tamanho').value := 'GG';
      5: WebBrowser.OleObject.document.forms.item('envia').elements.item('tamanho').value := 'EGG';
    end;
    WebBrowser.OleObject.document.forms.item('envia').elements.item('Submit').Click;
    aguardaProcesso();
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
