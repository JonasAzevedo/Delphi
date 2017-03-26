unit unOcorrenciasSorteio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvGlowButton, StdCtrls, asgcombo, ColorCombo;

type
  TfrmOcorrenciasSorteio = class(TForm)
    advGlwBtnProcessar: TAdvGlowButton;
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
    Label1: TLabel;
    lblTotalSorteios: TLabel;
    lblNro1: TLabel;
    lblNro2: TLabel;
    lblNro3: TLabel;
    lblNro4: TLabel;
    lblNro5: TLabel;
    lblNro6: TLabel;
    lblNro7: TLabel;
    lblNro8: TLabel;
    lblNro9: TLabel;
    lblNro10: TLabel;
    lblNro11: TLabel;
    lblNro12: TLabel;
    lblNro13: TLabel;
    lblNro14: TLabel;
    lblNro15: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    procedure advGlwBtnProcessarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOcorrenciasSorteio: TfrmOcorrenciasSorteio;

implementation

uses unDM;

{$R *.dfm}

procedure TfrmOcorrenciasSorteio.advGlwBtnProcessarClick(Sender: TObject);
var
  i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15: Integer;
  numeros: array[1..15] of Integer;
  x: Integer;
  qtdeAcertos: Integer;
  total: Integer;
  sorteios: Integer;
begin
  for i1:=1 to 25 do
    for i2:=i1+1 to 25 do
      for i3:=i2+1 to 25 do
        for i4:=i3+1 to 25 do
          for i5:=i4+1 to 25 do
            for i6:=i5+1 to 25 do
              for i7:=i6+1 to 25 do
                for i8:=i7+1 to 25 do
                  for i9:=i8+1 to 25 do
                    for i10:=i9+1 to 25 do
                      for i11:=i10+1 to 25 do
                        for i12:=i11+1 to 25 do
                          for i13:=i12+1 to 25 do
                            for i14:=i13+1 to 25 do
                              for i15:=i14+1 to 25 do
                                begin
                                numeros[1] := i1;
                                numeros[2] := i2;
                                numeros[3] := i3;
                                numeros[4] := i4;
                                numeros[5] := i5;
                                numeros[6] := i6;
                                numeros[7] := i7;
                                numeros[8] := i8;
                                numeros[9] := i9;
                                numeros[10] := i10;
                                numeros[11] := i11;
                                numeros[12] := i12;
                                numeros[13] := i13;
                                numeros[14] := i14;
                                numeros[15] := i15;

                                lblNro1.Caption := IntToStr(i1);
                                lblNro2.Caption := IntToStr(i2);
                                lblNro3.Caption := IntToStr(i3);
                                lblNro4.Caption := IntToStr(i4);
                                lblNro5.Caption := IntToStr(i5);
                                lblNro6.Caption := IntToStr(i6);
                                lblNro7.Caption := IntToStr(i7);
                                lblNro8.Caption := IntToStr(i8);
                                lblNro9.Caption := IntToStr(i9);
                                lblNro10.Caption := IntToStr(i10);
                                lblNro11.Caption := IntToStr(i11);
                                lblNro12.Caption := IntToStr(i12);
                                lblNro13.Caption := IntToStr(i13);
                                lblNro14.Caption := IntToStr(i14);
                                lblNro15.Caption := IntToStr(i15);

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
                                    for x:=1 to 15 do
                                      begin
                                      if(DM.zQryLotoFacilN1.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN2.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN3.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN4.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN5.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN6.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN7.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN8.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN9.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN10.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN11.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN12.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN13.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN14.AsInteger = numeros[x])then
                                        begin
                                        inc(qtdeAcertos);
                                        continue;
                                        end;
                                      if(DM.zQryLotoFacilN15.AsInteger = numeros[x])then
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
                                    end; //case
                                    lblTotalSorteios.Caption := IntToStr(sorteios);
                                    Application.ProcessMessages;
                                    DM.zQryLotoFacil.Next;
                                    end; //while
                                  end; //if(DM.zQryLotoFacil.RecordCount <> 0)then
                                end; //for
end;

end.
