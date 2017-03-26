unit unVerificaOcorrenciaSorteio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvGlowButton, StdCtrls;

type
  TfrmVerificaOcorrenciaSorteio = class(TForm)
    edNro1: TEdit;
    edNro2: TEdit;
    edNro3: TEdit;
    edNro4: TEdit;
    edNro5: TEdit;
    edNro6: TEdit;
    edNro7: TEdit;
    edNro8: TEdit;
    edNro9: TEdit;
    edNro10: TEdit;
    edNro11: TEdit;
    edNro12: TEdit;
    edNro13: TEdit;
    edNro14: TEdit;
    edNro15: TEdit;
    Label1: TLabel;
    advGlwBtnPesquisar: TAdvGlowButton;
    edQtdeAcertos5: TEdit;
    edQtdeAcertos6: TEdit;
    edQtdeAcertos7: TEdit;
    edQtdeAcertos8: TEdit;
    edQtdeAcertos9: TEdit;
    edQtdeAcertos10: TEdit;
    edQtdeAcertos11: TEdit;
    edQtdeAcertos12: TEdit;
    edQtdeAcertos13: TEdit;
    edQtdeAcertos14: TEdit;
    edQtdeAcertos15: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lblTotalSorteios: TLabel;
    Label14: TLabel;
    lblTotalPremios: TLabel;
    procedure advGlwBtnPesquisarClick(Sender: TObject);
    procedure edNro1KeyPress(Sender: TObject; var Key: Char);
    procedure edNro2KeyPress(Sender: TObject; var Key: Char);
    procedure edNro3KeyPress(Sender: TObject; var Key: Char);
    procedure edNro4KeyPress(Sender: TObject; var Key: Char);
    procedure edNro5KeyPress(Sender: TObject; var Key: Char);
    procedure edNro6KeyPress(Sender: TObject; var Key: Char);
    procedure edNro7KeyPress(Sender: TObject; var Key: Char);
    procedure edNro8KeyPress(Sender: TObject; var Key: Char);
    procedure edNro9KeyPress(Sender: TObject; var Key: Char);
    procedure edNro10KeyPress(Sender: TObject; var Key: Char);
    procedure edNro11KeyPress(Sender: TObject; var Key: Char);
    procedure edNro12KeyPress(Sender: TObject; var Key: Char);
    procedure edNro13KeyPress(Sender: TObject; var Key: Char);
    procedure edNro14KeyPress(Sender: TObject; var Key: Char);
    procedure edNro15KeyPress(Sender: TObject; var Key: Char);
    procedure edNro1Enter(Sender: TObject);
    procedure edNro2Enter(Sender: TObject);
    procedure edNro3Enter(Sender: TObject);
    procedure edNro4Enter(Sender: TObject);
    procedure edNro5Enter(Sender: TObject);
    procedure edNro6Enter(Sender: TObject);
    procedure edNro7Enter(Sender: TObject);
    procedure edNro8Enter(Sender: TObject);
    procedure edNro9Enter(Sender: TObject);
    procedure edNro10Enter(Sender: TObject);
    procedure edNro11Enter(Sender: TObject);
    procedure edNro12Enter(Sender: TObject);
    procedure edNro13Enter(Sender: TObject);
    procedure edNro14Enter(Sender: TObject);
    procedure edNro15Enter(Sender: TObject);
    procedure edNro1Exit(Sender: TObject);
    procedure edNro2Exit(Sender: TObject);
    procedure edNro3Exit(Sender: TObject);
    procedure edNro4Exit(Sender: TObject);
    procedure edNro5Exit(Sender: TObject);
    procedure edNro6Exit(Sender: TObject);
    procedure edNro7Exit(Sender: TObject);
    procedure edNro8Exit(Sender: TObject);
    procedure edNro9Exit(Sender: TObject);
    procedure edNro10Exit(Sender: TObject);
    procedure edNro11Exit(Sender: TObject);
    procedure edNro12Exit(Sender: TObject);
    procedure edNro13Exit(Sender: TObject);
    procedure edNro14Exit(Sender: TObject);
    procedure edNro15Exit(Sender: TObject);
  private
    function verificaPesquisa(): boolean;
  public
    { Public declarations }
  end;

var
  frmVerificaOcorrenciaSorteio: TfrmVerificaOcorrenciaSorteio;

implementation

uses unDM;

{$R *.dfm}

(* MINHAS PROCEDURES *)

function TfrmVerificaOcorrenciaSorteio.verificaPesquisa(): boolean;
var
  n: array[1..15] of Integer;
  i: Integer;
  repetidos: String;
  foraEscopo: String;
  continua: boolean;
  achouForaEscopo: boolean;
begin
  continua := true;

  //pegando números
  try
    n[1] := StrToInt(edNro1.Text);
    n[2] := StrToInt(edNro2.Text);
    n[3] := StrToInt(edNro3.Text);
    n[4] := StrToInt(edNro4.Text);
    n[5] := StrToInt(edNro5.Text);
    n[6] := StrToInt(edNro6.Text);
    n[7] := StrToInt(edNro7.Text);
    n[8] := StrToInt(edNro8.Text);
    n[9] := StrToInt(edNro9.Text);
    n[10] := StrToInt(edNro10.Text);
    n[11] := StrToInt(edNro11.Text);
    n[12] := StrToInt(edNro12.Text);
    n[13] := StrToInt(edNro13.Text);
    n[14] := StrToInt(edNro14.Text);
    n[15] := StrToInt(edNro15.Text);
  except
    MessageDlg('Preencha os 15 números corretamente!',mtInformation,[mbOK],0);
    continua := false;
  end;

  //revisando números fora do escopo
  if(continua=true)then
    begin
    foraEscopo := 'Os números devem estar entre 1 e 25: ';
    achouForaEscopo := false;
    if(n[1]<1)or(n[1]>25)then
      begin
      foraEscopo := foraEscopo + '1º';
      achouForaEscopo := true;
      end;
    if(n[2]<1)or(n[2]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '2º'
      else
        foraEscopo := foraEscopo + ' - 2º';
      achouForaEscopo := true;
      end;
    if(n[3]<1)or(n[3]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '3º'
      else
        foraEscopo := foraEscopo + ' - 3º';
      achouForaEscopo := true;
      end;
    if(n[4]<1)or(n[4]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '4º'
      else
        foraEscopo := foraEscopo + ' - 4º';
      achouForaEscopo := true;
      end;
    if(n[5]<1)or(n[5]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '5º'
      else
        foraEscopo := foraEscopo + ' - 5º';
      achouForaEscopo := true;
      end;
    if(n[6]<1)or(n[6]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '6º'
      else
        foraEscopo := foraEscopo + ' - 6º';
      achouForaEscopo := true;
      end;
    if(n[7]<1)or(n[7]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '7º'
      else
        foraEscopo := foraEscopo + ' - 7º';
      achouForaEscopo := true;
      end;
    if(n[8]<1)or(n[8]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '8º'
      else
        foraEscopo := foraEscopo + ' - 8º';
      achouForaEscopo := true;
      end;
    if(n[9]<1)or(n[9]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '9º'
      else
        foraEscopo := foraEscopo + ' - 9º';
      achouForaEscopo := true;
      end;
    if(n[10]<1)or(n[10]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '10º'
      else
        foraEscopo := foraEscopo + ' - 10º';
      achouForaEscopo := true;
      end;
    if(n[11]<1)or(n[11]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '11º'
      else
        foraEscopo := foraEscopo + ' - 11º';
      achouForaEscopo := true;
      end;
    if(n[12]<1)or(n[12]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '12º'
      else
        foraEscopo := foraEscopo + ' - 12º';
      achouForaEscopo := true;
      end;
    if(n[13]<1)or(n[13]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '13º'
      else
        foraEscopo := foraEscopo + ' - 13º';
      achouForaEscopo := true;
      end;
    if(n[14]<1)or(n[14]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '14º'
      else
        foraEscopo := foraEscopo + ' - 14º';
      achouForaEscopo := true;
      end;
    if(n[15]<1)or(n[15]>25)then
      begin
      if(achouForaEscopo=false)then
        foraEscopo := foraEscopo + '15º'
      else
        foraEscopo := foraEscopo + ' - 15º';
      achouForaEscopo := true;
      end;
    if(foraEscopo <> 'Os números devem estar entre 1 e 25: ')then
      begin
      MessageDlg(foraEscopo,mtWarning,[mbOK],0);
      continua := false;
      end;
    end;

  //revisando números repetidos
  if(continua=true)then
    begin
    repetidos := 'Números Repetidos: ';
    for i:= 2 to 15 do
      begin
      if (n[1] = n[i]) then
        repetidos := repetidos + #13 + '1º e ' + IntToStr(i) + 'º';
      end;

    for i:= 3 to 15 do
      begin
      if (n[2] = n[i])then
        repetidos := repetidos + #13 + '2º e ' + IntToStr(i) + 'º';
    end;

    for i:= 4 to 15 do
      begin
      if (n[3] = n[i])then
        repetidos := repetidos + #13 + '3º e ' + IntToStr(i) + 'º';
      end;

    for i:= 5 to 15 do
      begin
      if (n[4] = n[i])then
        repetidos := repetidos + #13 + '4º e ' + IntToStr(i) + 'º';
      end;

    for i:= 6 to 15 do
      begin
      if (n[5] = n[i])then
        repetidos := repetidos + #13 + '5º e ' + IntToStr(i) + 'º';
      end;

    for i:= 7 to 15 do
      begin
      if (n[6] = n[i])then
        repetidos := repetidos + #13 + '6 e ' + IntToStr(i) + 'º';
      end;

    for i:= 8 to 15 do
      begin
      if (n[7] = n[i])then
        repetidos := repetidos + #13 + '7º e ' + IntToStr(i) + 'º';
      end;

    for i:= 9 to 15 do
      begin
      if (n[8] = n[i])then
        repetidos := repetidos + #13 + '8º e ' + IntToStr(i) + 'º';
      end;

    for i:= 10 to 15 do
      begin
      if (n[9] = n[i])then
        repetidos := repetidos + #13 + '9º e ' + IntToStr(i) + 'º';
      end;

    for i:= 11 to 15 do
      begin
      if (n[10] = n[i])then
        repetidos := repetidos + #13 + '10º e ' + IntToStr(i) + 'º';
      end;

    for i:= 12 to 15 do
      begin
      if (n[11] = n[i])then
        repetidos := repetidos + #13 + '11º e ' + IntToStr(i) + 'º';
      end;

    for i:= 13 to 15 do
      begin
      if (n[12] = n[i])then
        repetidos := repetidos + #13 + '12º e ' + IntToStr(i) + 'º';
      end;

    for i:= 14 to 15 do
      begin
      if (n[13] = n[i])then
        repetidos := repetidos + #13 + '13º e ' + IntToStr(i) + 'º';
      end;

    for i:= 15 to 15 do
      begin
      if (n[14] = n[i])then
        repetidos := repetidos + #13 + '14º e ' + IntToStr(i) + 'º';
      end;
    if(repetidos <> 'Números Repetidos: ')then
      begin
      MessageDlg(repetidos,mtWarning,[mbOK],0);
      continua := false;
      end;
    end;

  Result := continua;
end;

(* FIM MINHAS PROCEDURES *)

procedure TfrmVerificaOcorrenciaSorteio.advGlwBtnPesquisarClick(
  Sender: TObject);
var
  numeros: array[1..15] of Integer;
  i: Integer;
  qtdeAcertos: Integer;
  total: Integer;
  sorteios: Integer;
  premios: Integer;
begin
  if(verificaPesquisa = true)then
    begin
    //limpando
    sorteios := 0;
    premios := 0;
    edQtdeAcertos5.Text := '0';
    edQtdeAcertos6.Text := '0';
    edQtdeAcertos7.Text := '0';
    edQtdeAcertos8.Text := '0';
    edQtdeAcertos9.Text := '0';
    edQtdeAcertos10.Text := '0';
    edQtdeAcertos11.Text := '0';
    edQtdeAcertos12.Text := '0';
    edQtdeAcertos13.Text := '0';
    edQtdeAcertos14.Text := '0';
    edQtdeAcertos15.Text := '0';

    //números a verificar
    numeros[1] := StrToInt(edNro1.Text);
    numeros[2] := StrToInt(edNro2.Text);
    numeros[3] := StrToInt(edNro3.Text);
    numeros[4] := StrToInt(edNro4.Text);
    numeros[5] := StrToInt(edNro5.Text);
    numeros[6] := StrToInt(edNro6.Text);
    numeros[7] := StrToInt(edNro7.Text);
    numeros[8] := StrToInt(edNro8.Text);
    numeros[9] := StrToInt(edNro9.Text);
    numeros[10] := StrToInt(edNro10.Text);
    numeros[11] := StrToInt(edNro11.Text);
    numeros[12] := StrToInt(edNro12.Text);
    numeros[13] := StrToInt(edNro13.Text);
    numeros[14] := StrToInt(edNro14.Text);
    numeros[15] := StrToInt(edNro15.Text);

    DM.zQryLotoFacil.Close;
    DM.zQryLotoFacil.SQL.Clear;
    DM.zQryLotoFacil.SQL.Add('SELECT * FROM LotoFacil ORDER BY sorteio');
    DM.zQryLotoFacil.Open;
    DM.zQryLotoFacil.Refresh;
    if(DM.zQryLotoFacil.RecordCount <> 0)then
      begin
      DM.zQryLotoFacil.First;
      while(not(DM.zQryLotoFacil.Eof))do
        begin
        qtdeAcertos := 0;
        //comparando ocorrência
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN1.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN2.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN3.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN4.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN5.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN6.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN7.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN8.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN9.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN10.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN11.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN12.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN13.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN14.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          if(DM.zQryLotoFacilN15.AsInteger = numeros[i])then
            begin
            inc(qtdeAcertos);
            continue;
            end;
          end; //for

          //mostrando ocorrência
          case qtdeAcertos of
            5: begin
               total := StrToInt(edQtdeAcertos5.Text);
               inc(total);
               edQtdeAcertos5.Text := IntToStr(total);
               inc(sorteios);
               end;
            6: begin
               total := StrToInt(edQtdeAcertos6.Text);
               inc(total);
               edQtdeAcertos6.Text := IntToStr(total);
               inc(sorteios);
               end;
            7: begin
               total := StrToInt(edQtdeAcertos7.Text);
               inc(total);
               edQtdeAcertos7.Text := IntToStr(total);
               inc(sorteios);
               end;
            8: begin
               total := StrToInt(edQtdeAcertos8.Text);
               inc(total);
               edQtdeAcertos8.Text := IntToStr(total);
               inc(sorteios);
               end;
            9: begin
               total := StrToInt(edQtdeAcertos9.Text);
               inc(total);
               edQtdeAcertos9.Text := IntToStr(total);
               inc(sorteios);
               end;
            10: begin
                total := StrToInt(edQtdeAcertos10.Text);
                inc(total);
                edQtdeAcertos10.Text := IntToStr(total);
                inc(sorteios);
                end;
            11: begin
                total := StrToInt(edQtdeAcertos11.Text);
                inc(total);
                edQtdeAcertos11.Text := IntToStr(total);
                inc(sorteios);
                end;
            12: begin
                total := StrToInt(edQtdeAcertos12.Text);
                inc(total);
                edQtdeAcertos12.Text := IntToStr(total);
                inc(sorteios);
                end;
            13: begin
                total := StrToInt(edQtdeAcertos13.Text);
                inc(total);
                edQtdeAcertos13.Text := IntToStr(total);
                inc(sorteios);
                end;
            14: begin
                total := StrToInt(edQtdeAcertos14.Text);
                inc(total);
                edQtdeAcertos14.Text := IntToStr(total);
                inc(sorteios);
                end;
            15: begin
                total := StrToInt(edQtdeAcertos15.Text);
                inc(total);
                edQtdeAcertos15.Text := IntToStr(total);
                inc(sorteios);
                end;
          end;
        DM.zQryLotoFacil.Next;
        end;
      lblTotalSorteios.Caption := IntToStr(sorteios);
      //prêmios
      premios := StrToInt(edQtdeAcertos11.Text) + StrToInt(edQtdeAcertos12.Text) + StrToInt(edQtdeAcertos13.Text) + StrToInt(edQtdeAcertos14.Text) + StrToInt(edQtdeAcertos15.Text);
      lblTotalPremios.Caption := IntToStr(premios);
      end;
    end;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro3KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro4KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro5KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro6KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro7KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro8KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro9KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro10KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro11KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro12KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro13KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro14KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro15KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro1Enter(Sender: TObject);
begin
  edNro1.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro2Enter(Sender: TObject);
begin
  edNro2.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro3Enter(Sender: TObject);
begin
  edNro3.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro4Enter(Sender: TObject);
begin
  edNro4.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro5Enter(Sender: TObject);
begin
  edNro5.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro6Enter(Sender: TObject);
begin
  edNro6.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro7Enter(Sender: TObject);
begin
  edNro7.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro8Enter(Sender: TObject);
begin
  edNro8.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro9Enter(Sender: TObject);
begin
  edNro9.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro10Enter(Sender: TObject);
begin
  edNro10.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro11Enter(Sender: TObject);
begin
  edNro11.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro12Enter(Sender: TObject);
begin
  edNro12.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro13Enter(Sender: TObject);
begin
  edNro13.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro14Enter(Sender: TObject);
begin
  edNro14.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro15Enter(Sender: TObject);
begin
  edNro15.Color := clMoneyGreen;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro1Exit(Sender: TObject);
begin
  edNro1.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro2Exit(Sender: TObject);
begin
  edNro2.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro3Exit(Sender: TObject);
begin
  edNro3.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro4Exit(Sender: TObject);
begin
  edNro4.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro5Exit(Sender: TObject);
begin
  edNro5.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro6Exit(Sender: TObject);
begin
  edNro6.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro7Exit(Sender: TObject);
begin
  edNro7.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro8Exit(Sender: TObject);
begin
  edNro8.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro9Exit(Sender: TObject);
begin
  edNro9.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro10Exit(Sender: TObject);
begin
  edNro10.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro11Exit(Sender: TObject);
begin
  edNro11.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro12Exit(Sender: TObject);
begin
  edNro12.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro13Exit(Sender: TObject);
begin
  edNro13.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro14Exit(Sender: TObject);
begin
  edNro14.Color := clWindow;
end;

procedure TfrmVerificaOcorrenciaSorteio.edNro15Exit(Sender: TObject);
begin
  edNro15.Color := clWindow;
end;

end.
