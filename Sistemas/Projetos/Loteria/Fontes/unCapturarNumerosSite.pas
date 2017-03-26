unit unCapturarNumerosSite;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, Buttons, ExtCtrls, OleCtrls, SHDocVw, ComCtrls,
  unDefinicaoJogos;

type
  TfrmCapturarNumerosSite = class(TForm)
    StatusBar: TStatusBar;
    WebBrsr: TWebBrowser;
    pnlDados: TPanel;
    BitBtn1: TBitBtn;
    pnlLink: TPanel;
    Label1: TLabel;
    edSite: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblJogo: TLabel;
    Label5: TLabel;
    mmNumeros: TMemo;
    edSorteio: TEdit;
    mEdData: TMaskEdit;
    mmHTML: TMemo;
    Label6: TLabel;
    mmGanhadoresPremio: TMemo;
    btBtnImportar: TBitBtn;
    procedure edSiteEnter(Sender: TObject);
    procedure edSorteioEnter(Sender: TObject);
    procedure mEdDataEnter(Sender: TObject);
    procedure mmNumerosEnter(Sender: TObject);
    procedure mmNumerosExit(Sender: TObject);
    procedure mEdDataExit(Sender: TObject);
    procedure edSorteioExit(Sender: TObject);
    procedure edSiteExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edSiteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure btBtnImportarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    documentoSite: variant;

    lotoFacil: TLotoFacil;

    procedure aguardaProcessoPagina(); //aguarda processamento da página
    procedure capturaHTML(); //captura HTML da página
    procedure pegaDadosPagina(); //pega dados da página

  public
    jogo: String;
  end;

var
  frmCapturarNumerosSite: TfrmCapturarNumerosSite;

implementation

uses unLotoFacil;

{$R *.dfm}

{aguarda processamento da página}
procedure TfrmCapturarNumerosSite.aguardaProcessoPagina();
var
  b: boolean;
begin
  b := false;
  //enquanto o site não é carregado totalmente fica no loop até o estado do ReadyState for completo
  while(b=false)do
    begin
    if(WebBrsr.ReadyState = READYSTATE_COMPLETE) then
      b := true;
    Application.ProcessMessages;
    end;
  Sleep(300);
  Application.ProcessMessages;
end;

{captura HTML da página}
procedure TfrmCapturarNumerosSite.capturaHTML();
begin
  //pegando código HTML
  documentoSite := WebBrsr.Document;
  mmHTML.Clear;
  mmHTML.Lines.Text := documentoSite.Body.OuterHTML;//adicionando o código HTML ao MEMO
  Application.ProcessMessages;
  Sleep(500);
end;

{pega dados da página}
procedure TfrmCapturarNumerosSite.pegaDadosPagina();
var
  i,ii: Integer;
  carac: String;
  sorteio: String;
  dataSorteio: String;
  numero: String;
  ganhadores,premio: String;
  idxGanhadores: Integer;
  x: Integer;
  str: String;
begin
  //sorteio
  sorteio := '';
  str := 'id=span_conc>';
  i := pos(str,mmHTML.Lines.Text);
  if(i>0)then
    begin
    i := i + 13;
    carac := '';
    while(carac<>'<')do
      begin
      carac := copy(mmHTML.Lines.Text,i,1);
      if(carac<>'<')then
        begin
        sorteio := sorteio + carac;
        inc(i);
        end;
      end;
    end;
  edSorteio.Text := sorteio;
  try
    lotoFacil.sorteio := StrToInt(sorteio);
  except
    lotoFacil.sorteio := 0;
  end;

  //data do sorteio
  dataSorteio := '';
  str := 'lotofacil_resultado.asp#"><B>';
  i := pos(str,mmHTML.Lines.Text);
  if(i>0)then
    begin
    i := i + 29;
    carac := '';
    while(carac<>'<')do
      begin
      carac := copy(mmHTML.Lines.Text,i,1);
      if(carac<>'<')then
        begin
        dataSorteio := dataSorteio + carac;
        inc(i);
        end;
      end;
    end;
  mEdData.Text := dataSorteio;
  try
    lotoFacil.data := StrToDate(dataSorteio);
  except
    lotoFacil.data := Null;
  end;


  //pegando numeros
  for x:=1 to 15 do
    begin
    str := '<TD><SPAN id=lfacil'+IntToStr(x)+'_2>';
    i := pos(str,mmHTML.Lines.Text);
    if(i>0)then
      begin
      if(x<=9)then //ir para o final do texto encontrado
        i := i + 23
      else
        i := i + 24;
      numero := copy(mmHTML.Lines.Text,i,2);
      mmNumeros.Lines.Add(IntToStr(x) + ' = ' + numero);
      try
        lotoFacil.numeros[x] := StrToInt(numero);
      except
        lotoFacil.numeros[x] := 0;
      end;
      end //if(i>0)then
    else
      begin
      mmNumeros.Lines.Add(IntToStr(x) + ' = Não Encontrado');
      lotoFacil.numeros[x] := 0;
      end;
    end; //for

  //pegando ganhadores/premio
  x := 16;
  idxGanhadores := 15;
  while(x<=25)do
    begin
    ganhadores := '';
    premio := '';
    str := '<SPAN id=lfacil'+IntToStr(x)+'>';
    i := pos(str,mmHTML.Lines.Text);
    if(i>0)then
      //ganhadores
      begin
      i := i + 18;
      carac := '';
      while(carac<>'<')do
        begin
        carac := copy(mmHTML.Lines.Text,i,1);
        if(carac<>'<')then
          begin
          ganhadores := ganhadores + carac;
          inc(i);
          end;
        end;
      //premio
      x := x + 1;
      str := '<SPAN id=lfacil'+IntToStr(x)+'>';
      ii := pos(str,mmHTML.Lines.Text);
      if(ii>0)then
        begin
        ii := ii + 18;
        carac := '';
        while(carac<>'<')do
          begin
          carac := copy(mmHTML.Lines.Text,ii,1);
          if(carac<>'<')then
            begin
            premio := premio + carac;
            inc(ii);
            end;
          end;
        end;
      x := x + 1;
      end
    else
      x := x + 2;

    if((ganhadores<>'')and(premio<>''))then
      begin
      mmGanhadoresPremio.Lines.Add(IntToStr(idxGanhadores) + ' Acertos: ' +  ' Ganhadores: ' + ganhadores + ' - Premio: ' + premio);
      try
        ganhadores := StringReplace(ganhadores,'.','',[rfReplaceAll]);
        lotoFacil.ganhadores[idxGanhadores] := StrToInt(ganhadores);
        premio := StringReplace(premio,'.','',[rfReplaceAll]);
        lotoFacil.premio[idxGanhadores] := StrToFloat(premio);
      except
        lotoFacil.ganhadores[idxGanhadores] := 0;
        lotoFacil.premio[idxGanhadores] := 0;
      end;
      end
    else
      begin
      ganhadores := '0';
      premio := '0';
      mmGanhadoresPremio.Lines.Add(IntToStr(idxGanhadores) + ' Acertos: ' +  ' Ganhadores: ' + ganhadores + ' - Premio: ' + premio);
      lotoFacil.ganhadores[idxGanhadores] := 0;
      lotoFacil.premio[idxGanhadores] := 0;
      end;
    dec(idxGanhadores);
    end;

end;


{********************FIM PROCEDURES********************}

procedure TfrmCapturarNumerosSite.edSiteEnter(Sender: TObject);
begin
  edSite.Color := clMoneyGreen;
end;

procedure TfrmCapturarNumerosSite.edSorteioEnter(Sender: TObject);
begin
  edSorteio.Color := clMoneyGreen;
end;

procedure TfrmCapturarNumerosSite.mEdDataEnter(Sender: TObject);
begin
  mEdData.Color := clMoneyGreen;
end;

procedure TfrmCapturarNumerosSite.mmNumerosEnter(Sender: TObject);
begin
  mmNumeros.Color := clMoneyGreen;
end;

procedure TfrmCapturarNumerosSite.mmNumerosExit(Sender: TObject);
begin
  mmNumeros.Color := clWindow;
end;

procedure TfrmCapturarNumerosSite.mEdDataExit(Sender: TObject);
begin
  mEdData.Color := clWindow;
end;

procedure TfrmCapturarNumerosSite.edSorteioExit(Sender: TObject);
begin
  edSorteio.Color := clWindow;
end;

procedure TfrmCapturarNumerosSite.edSiteExit(Sender: TObject);
begin
  edSite.Color := clWindow;
end;

procedure TfrmCapturarNumerosSite.FormShow(Sender: TObject);
begin
  if(jogo='lotoFacil')then
    begin
    edSite.Text := 'http://www1.caixa.gov.br/loterias/loterias/lotofacil/lotofacil_resultado.asp';
    WebBrsr.Navigate(edSite.Text);
    end;
  lblJogo.Caption := jogo;
end;

procedure TfrmCapturarNumerosSite.edSiteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if(Key=13)then
    WebBrsr.Navigate(edSite.Text);  
end;

procedure TfrmCapturarNumerosSite.BitBtn1Click(Sender: TObject);
begin
  WebBrsr.Navigate('javascript: mostra_sorteio();');
  Sleep(300);
  Application.ProcessMessages;
  capturaHTML();
  pegaDadosPagina();
end;

procedure TfrmCapturarNumerosSite.btBtnImportarClick(Sender: TObject);
begin
  frmCadastroLotoFacil.edSorteio.Text := IntToStr(lotoFacil.sorteio);
  frmCadastroLotoFacil.mEdData.Text := DateToStr(lotoFacil.data);
  frmCadastroLotoFacil.edN1.Text := IntToStr(lotoFacil.numeros[1]);
  frmCadastroLotoFacil.edN2.Text := IntToStr(lotoFacil.numeros[2]);
  frmCadastroLotoFacil.edN3.Text := IntToStr(lotoFacil.numeros[3]);
  frmCadastroLotoFacil.edN4.Text := IntToStr(lotoFacil.numeros[4]);
  frmCadastroLotoFacil.edN5.Text := IntToStr(lotoFacil.numeros[5]);
  frmCadastroLotoFacil.edN6.Text := IntToStr(lotoFacil.numeros[6]);
  frmCadastroLotoFacil.edN7.Text := IntToStr(lotoFacil.numeros[7]);
  frmCadastroLotoFacil.edN8.Text := IntToStr(lotoFacil.numeros[8]);
  frmCadastroLotoFacil.edN9.Text := IntToStr(lotoFacil.numeros[9]);
  frmCadastroLotoFacil.edN10.Text := IntToStr(lotoFacil.numeros[10]);
  frmCadastroLotoFacil.edN11.Text := IntToStr(lotoFacil.numeros[11]);
  frmCadastroLotoFacil.edN12.Text := IntToStr(lotoFacil.numeros[12]);
  frmCadastroLotoFacil.edN13.Text := IntToStr(lotoFacil.numeros[13]);
  frmCadastroLotoFacil.edN14.Text := IntToStr(lotoFacil.numeros[14]);
  frmCadastroLotoFacil.edN15.Text := IntToStr(lotoFacil.numeros[15]);
  frmCadastroLotoFacil.ed11AcertoGanhadores.Text := IntToStr(lotoFacil.ganhadores[11]);
  frmCadastroLotoFacil.ed12AcertoGanhadores.Text := IntToStr(lotoFacil.ganhadores[12]);
  frmCadastroLotoFacil.ed13AcertoGanhadores.Text := IntToStr(lotoFacil.ganhadores[13]);
  frmCadastroLotoFacil.ed14AcertoGanhadores.Text := IntToStr(lotoFacil.ganhadores[14]);
  frmCadastroLotoFacil.ed15AcertoGanhadores.Text := IntToStr(lotoFacil.ganhadores[15]);
  frmCadastroLotoFacil.ed11AcertoPremio.Text := FloatToStr(lotoFacil.premio[11]);
  frmCadastroLotoFacil.ed12AcertoPremio.Text := FloatToStr(lotoFacil.premio[12]);
  frmCadastroLotoFacil.ed13AcertoPremio.Text := FloatToStr(lotoFacil.premio[13]);
  frmCadastroLotoFacil.ed14AcertoPremio.Text := FloatToStr(lotoFacil.premio[14]);
  frmCadastroLotoFacil.ed15AcertoPremio.Text := FloatToStr(lotoFacil.premio[15]);
end;

procedure TfrmCapturarNumerosSite.Button1Click(Sender: TObject);
begin
  capturaHTML();
  pegaDadosPagina();
end;

procedure TfrmCapturarNumerosSite.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   frmCadastroLotoFacil.mnItCapturaSite.Checked := false;
   frmCadastroLotoFacil.mnItCapturaManual.Checked := true;
   FreeAndNil(frmCapturarNumerosSite);
end;

end.
