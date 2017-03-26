unit unImportaCSV_LotoFacil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, ExtCtrls, StdCtrls, Buttons, ComCtrls;

type
  TfrmImportaDadosLotoFacil = class(TForm)
    Label1: TLabel;
    bvlDivisao: TBevel;
    StatusBar: TStatusBar;
    edArquivoCSV: TEdit;
    btBtnAbrirArquivoCSV: TBitBtn;
    pnlImportar: TPanel;
    Label2: TLabel;
    lblTotalRegistros: TLabel;
    Label3: TLabel;
    edDelimitador: TEdit;
    btBtnImportar: TBitBtn;
    ApplicationEvents: TApplicationEvents;
    opDlgArquivoCSV: TOpenDialog;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edArquivoCSVChange(Sender: TObject);
    procedure edDelimitadorKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnImportarClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure btBtnAbrirArquivoCSVClick(Sender: TObject);
  private
    (*PROCEDURES DE CONTROLE*)
    procedure limpar();
  public
    (*VARIÁVEIS DE CONTROLE*)
    operacao: String;
  end;

var
  frmImportaDadosLotoFacil: TfrmImportaDadosLotoFacil;

implementation

uses unDM;

{$R *.dfm}


{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}

(*PROCEDURES DE CONTROLE*)

procedure TfrmImportaDadosLotoFacil.limpar();
begin
  edArquivoCSV.Clear;
  opDlgArquivoCSV.FileName := '';
  edDelimitador.Clear;
  lblTotalRegistros.Caption := '';
end;

(*FIM PROCEDURES DE CONTROLE*)

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}

procedure TfrmImportaDadosLotoFacil.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key=#27) then
    Self.Close;
end;

procedure TfrmImportaDadosLotoFacil.FormShow(Sender: TObject);
begin
  Self.limpar();
end;

procedure TfrmImportaDadosLotoFacil.edArquivoCSVChange(Sender: TObject);
begin
  if (edArquivoCSV.Text <> '') then
    begin
    pnlImportar.Enabled := true;
    end
  else
    pnlImportar.Enabled := false;
end;

procedure TfrmImportaDadosLotoFacil.edDelimitadorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
    btBtnImportarClick(Sender);
end;

procedure TfrmImportaDadosLotoFacil.btBtnImportarClick(Sender: TObject);
var
  //abrir .CSV
  F: TextFile;
  linha: String;
  //delimitador de campo
  delimitador: String[1];
  //gravar no bruto
  sorteio: Integer;
  data: TDate;
  numero: array[1..15] of Integer;
  acerto: array[11..15] of Integer;
  premio_acerto: array[11..15] of Double;
  //controle de leitura do .CSV e gravação no bd
  tamanho: Integer;
  pos: Integer;
  str: String;
  campo: Integer;
  //total de registros inseridos
  total: Integer;
begin
  Screen.Cursor := crHourGlass;

  //pega o delimitador de campo
  delimitador := edDelimitador.Text;
  total := 0;

  if (delimitador <> '') then
    begin //delimitador
    try
      DM.ZConnection.StartTransaction();
      //pega o arquivo .CSV
      AssignFile(F,edArquivoCSV.Text);
      Reset(F);
      //repita até o final do arquivo
      while (not Eof(F)) do
        begin //arquivo
        Readln(F,linha);

        //passando valores para os campos a serem gravados na tabela bruto
        tamanho := length(linha); //pega tamanho total da linha .CSV
        str:=''; //valor do campo
        campo := 1; //qual campo gravará
        pos := 1; //posição de leitura da linha
        for pos:=1 to tamanho do
          begin //for
          if (linha[pos] <> delimitador) then
            str := str + linha[pos];
          if((linha[pos] = delimitador)or(pos=tamanho)) then
            begin //gravando valores nas variáveis
              begin
              case campo of
                1: sorteio := StrToInt(str);
                2: data := StrToDate(str);
                3: numero[1] := StrToInt(str);
                4: numero[2] := StrToInt(str);
                5: numero[3] := StrToInt(str);
                6: numero[4] := StrToInt(str);
                7: numero[5] := StrToInt(str);
                8: numero[6] := StrToInt(str);
                9: numero[7] := StrToInt(str);
                10: numero[8] := StrToInt(str);
                11: numero[9] := StrToInt(str);
                12: numero[10] := StrToInt(str);
                13: numero[11] := StrToInt(str);
                14: numero[12] := StrToInt(str);
                15: numero[13] := StrToInt(str);
                16: numero[14] := StrToInt(str);
                17: numero[15] := StrToInt(str);
                18: str := str;//arrecadaçao total
                19: begin
                    str := StringReplace(str,'.','',[rfReplaceAll]);
                    acerto[15] := StrToInt(str);
                    end;
                20: begin
                    str := StringReplace(str,'.','',[rfReplaceAll]);
                    acerto[14] := StrToInt(str);
                    end;
                21: begin
                    str := StringReplace(str,'.','',[rfReplaceAll]);
                    acerto[13] := StrToInt(str);
                    end;
                22: begin
                    str := StringReplace(str,'.','',[rfReplaceAll]);
                    acerto[12] := StrToInt(str);
                    end;
                23: begin
                    str := StringReplace(str,'.','',[rfReplaceAll]);
                    acerto[11] := StrToInt(str);
                    end;
                24: begin
                    str := StringReplace(str,'.','',[rfReplaceAll]);
                    premio_acerto[15] := StrToFloat(str);
                    end;
                25: begin
                    str := StringReplace(str,'.','',[rfReplaceAll]);
                    premio_acerto[14] := StrToFloat(str);
                    end;
                26: begin
                    str := StringReplace(str,'.','',[rfReplaceAll]);
                    premio_acerto[13] := StrToFloat(str);
                    end;
                27: begin
                    str := StringReplace(str,'.','',[rfReplaceAll]);
                    premio_acerto[12] := StrToFloat(str);
                    end;
                28: begin
                    str := StringReplace(str,'.','',[rfReplaceAll]);
                    premio_acerto[11] := StrToFloat(str);
                    end;
              end; //case
              inc(campo);
              str := '';
              end; //else
            end; //gravando valores nas variáveis
          end; //for

        //gravando dados no bd - tabela lotofacil
        DM.zQryLotoFacil.Close;
        DM.zQryLotoFacil.SQL.Clear;
        DM.zQryLotoFacil.SQL.Add('INSERT INTO lotofacil(sorteio,data,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15,acerto15,');
        DM.zQryLotoFacil.SQL.Add('acerto14,acerto13,acerto12,acerto11,premio_acerto15,premio_acerto14,premio_acerto13,premio_acerto12,');
        DM.zQryLotoFacil.SQL.Add('premio_acerto11) VALUES(:sor,:dat,:n1,:n2,:n3,:n4,:n5,:n6,:n7,:n8,:n9,:n10,:n11,:n12,:n13,:n14,:n15,:ace15,');
        DM.zQryLotoFacil.SQL.Add(':ace14,:ace13,:ace12,:ace11,:pre_ace15,:pre_ace14,:pre_ace13,:pre_ace12,:pre_ace11)');
        DM.zQryLotoFacil.ParamByName('sor').AsInteger := sorteio;
        DM.zQryLotoFacil.ParamByName('dat').AsDate := data;
        DM.zQryLotoFacil.ParamByName('n1').AsInteger := numero[1];
        DM.zQryLotoFacil.ParamByName('n2').AsInteger := numero[2];
        DM.zQryLotoFacil.ParamByName('n3').AsInteger := numero[3];
        DM.zQryLotoFacil.ParamByName('n4').AsInteger := numero[4];
        DM.zQryLotoFacil.ParamByName('n5').AsInteger := numero[5];
        DM.zQryLotoFacil.ParamByName('n6').AsInteger := numero[6];
        DM.zQryLotoFacil.ParamByName('n7').AsInteger := numero[7];
        DM.zQryLotoFacil.ParamByName('n8').AsInteger := numero[8];
        DM.zQryLotoFacil.ParamByName('n9').AsInteger := numero[9];
        DM.zQryLotoFacil.ParamByName('n10').AsInteger := numero[10];
        DM.zQryLotoFacil.ParamByName('n11').AsInteger := numero[11];
        DM.zQryLotoFacil.ParamByName('n12').AsInteger := numero[12];
        DM.zQryLotoFacil.ParamByName('n13').AsInteger := numero[13];
        DM.zQryLotoFacil.ParamByName('n14').AsInteger := numero[14];
        DM.zQryLotoFacil.ParamByName('n15').AsInteger := numero[15];
        DM.zQryLotoFacil.ParamByName('ace15').AsInteger := acerto[15];
        DM.zQryLotoFacil.ParamByName('ace14').AsInteger := acerto[14];
        DM.zQryLotoFacil.ParamByName('ace13').AsInteger := acerto[13];
        DM.zQryLotoFacil.ParamByName('ace12').AsInteger := acerto[12];
        DM.zQryLotoFacil.ParamByName('ace11').AsInteger := acerto[11];
        DM.zQryLotoFacil.ParamByName('pre_ace15').AsFloat := premio_acerto[15];
        DM.zQryLotoFacil.ParamByName('pre_ace14').AsFloat := premio_acerto[14];
        DM.zQryLotoFacil.ParamByName('pre_ace13').AsFloat := premio_acerto[13];
        DM.zQryLotoFacil.ParamByName('pre_ace12').AsFloat := premio_acerto[12];
        DM.zQryLotoFacil.ParamByName('pre_ace11').AsFloat := premio_acerto[11];
        DM.zQryLotoFacil.ExecSQL;

        inc(total);
        lblTotalRegistros.Caption := IntToStr(total);

        end; //arquivo
        CloseFile(F);
        DM.ZConnection.Commit();
        MessageDlg('Dados importados com sucesso!',mtInformation,[mbOK],0);
        Self.Close;
      except
        DM.ZConnection.Rollback();
        MessageDlg('Dados não puderam ser importados!',mtError,[mbOK],0);
      end;

      end //delimitador
  else
    MessageDlg('Digite o delimitador de campo!',mtInformation,[mbOK],0);

  Screen.Cursor := crDefault;   
end;


procedure TfrmImportaDadosLotoFacil.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text:=Application.Hint;
end;

procedure TfrmImportaDadosLotoFacil.btBtnAbrirArquivoCSVClick(
  Sender: TObject);
begin
  if (opDlgArquivoCSV.Execute) then
    begin
    pnlImportar.Enabled := true;
    edArquivoCSV.Text := opDlgArquivoCSV.FileName;
    end
  else
    pnlImportar.Enabled := false;
end;

end.
