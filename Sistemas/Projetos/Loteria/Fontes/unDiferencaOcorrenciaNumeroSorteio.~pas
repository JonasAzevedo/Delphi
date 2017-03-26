unit unDiferencaOcorrenciaNumeroSorteio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Menus;

type
  TfrmDiferencaOcorrenciaNumerosSorteios = class(TForm)
    mmQtdeRepeticoes: TMemo;
    strGrdDiferenca: TStringGrid;
    Label5: TLabel;
    Label1: TLabel;
    PopupMenu: TPopupMenu;
    mnItReprocessarPagina: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure mnItReprocessarPaginaClick(Sender: TObject);
  private
    //MINHAS PROCEDURES
    procedure mostraOcorrencias();
  public

  end;

var
  frmDiferencaOcorrenciaNumerosSorteios: TfrmDiferencaOcorrenciaNumerosSorteios;

implementation

uses unDM;

{$R *.dfm}

//******************** MINHAS PROCEDURES ********************\\

procedure TfrmDiferencaOcorrenciaNumerosSorteios.mostraOcorrencias();
var
  numerosSorteio: array[1..15] of Integer;
  qtdeNumerosRepetiu: array[5..15] of Integer;
  i: Integer;
  tot: Integer;
  repetidos: Integer;
  sorteioA,sorteioB: Integer;
begin
  tot := 0;
  for i:=5 to 15 do
    qtdeNumerosRepetiu[i] := 0;

  mmQtdeRepeticoes.Clear;    
  strGrdDiferenca.RowCount := 2;
  strGrdDiferenca.ColCount := 3;
  strGrdDiferenca.Cells[0,0] := 'Sorteio A';
  strGrdDiferenca.Cells[1,0] := 'Sorteio B';
  strGrdDiferenca.Cells[2,0] := 'Repetidos';

  DM.zQryLotoFacil.Close;
  DM.zQryLotoFacil.SQL.Clear;
  DM.zQryLotoFacil.SQL.Add('SELECT * FROM LotoFacil ORDER BY sorteio');
  DM.zQryLotoFacil.Open;
  DM.zQryLotoFacil.Refresh;
  if(DM.zQryLotoFacil.RecordCount<>0)then
    begin
    DM.zQryLotoFacil.First;
    i := 1;
    while(not(DM.zQryLotoFacil.Eof))do
      begin
      if(tot<>0)then
        begin
        repetidos := 0;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN1.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN2.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN3.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN4.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN5.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN6.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN7.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN8.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN9.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN10.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN11.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN12.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN13.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN14.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        for i:=1 to 15 do
          begin
          if(DM.zQryLotoFacilN15.AsInteger = numerosSorteio[i])then
            begin
            inc(repetidos);
            break;
            end;
          end;
        sorteioB := DM.zQryLotoFacilSORTEIO.AsInteger;
        end;
      //coletando dados para próxima comparação
      numerosSorteio[1] := DM.zQryLotoFacilN1.AsInteger;
      numerosSorteio[2] := DM.zQryLotoFacilN2.AsInteger;
      numerosSorteio[3] := DM.zQryLotoFacilN3.AsInteger;
      numerosSorteio[4] := DM.zQryLotoFacilN4.AsInteger;
      numerosSorteio[5] := DM.zQryLotoFacilN5.AsInteger;
      numerosSorteio[6] := DM.zQryLotoFacilN6.AsInteger;
      numerosSorteio[7] := DM.zQryLotoFacilN7.AsInteger;
      numerosSorteio[8] := DM.zQryLotoFacilN8.AsInteger;
      numerosSorteio[9] := DM.zQryLotoFacilN9.AsInteger;
      numerosSorteio[10] := DM.zQryLotoFacilN10.AsInteger;
      numerosSorteio[11] := DM.zQryLotoFacilN11.AsInteger;
      numerosSorteio[12] := DM.zQryLotoFacilN12.AsInteger;
      numerosSorteio[13] := DM.zQryLotoFacilN13.AsInteger;
      numerosSorteio[14] := DM.zQryLotoFacilN14.AsInteger;
      numerosSorteio[15] := DM.zQryLotoFacilN15.AsInteger;
      //mostrando dados
      if(tot <> 0)then
        begin
        strGrdDiferenca.Cells[0,tot] := IntToStr(sorteioA);
        strGrdDiferenca.Cells[1,tot] := IntToStr(sorteioB);
        strGrdDiferenca.Cells[2,tot] := IntToStr(repetidos);
        inc(qtdeNumerosRepetiu[repetidos]);
        strGrdDiferenca.RowCount := strGrdDiferenca.RowCount + 1;
        end;
      sorteioA := DM.zQryLotoFacilSORTEIO.AsInteger;
      inc(tot);
      DM.zQryLotoFacil.Next;
      end;
    end;

  mmQtdeRepeticoes.Clear;
  for i:=5 to 15 do
    mmQtdeRepeticoes.Lines.Add(IntToStr(i) + ' -> ' + IntToStr(qtdeNumerosRepetiu[i]));
end;

//******************** FIM PROCEDURES ********************\\



procedure TfrmDiferencaOcorrenciaNumerosSorteios.FormShow(Sender: TObject);
begin
  mostraOcorrencias();
end;

procedure TfrmDiferencaOcorrenciaNumerosSorteios.mnItReprocessarPaginaClick(
  Sender: TObject);
begin
  mostraOcorrencias();
end;

end.
