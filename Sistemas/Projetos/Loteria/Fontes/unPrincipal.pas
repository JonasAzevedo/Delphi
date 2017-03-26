unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, AdvMemo, AdvGlassButton, ExtCtrls,
  Menus, AdvGlowButton;

type
  TfrmPrincipal = class(TForm)
    pgCtrl: TPageControl;
    tbShtLotoFacil: TTabSheet;
    StatusBar: TStatusBar;
    grpBxEstatisticas: TGroupBox;
    advMmNrosMaisAparacem: TAdvMemo;
    advMmNrosMaisAparacemSorteio5ou0: TAdvMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    mmSugestaoNrosMaisAparacem: TMemo;
    mmSugestaoNrosMaisAparacemSorteio5ou0: TMemo;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    advMmOcorrenciaUltimos10Sorteios: TAdvMemo;
    Label10: TLabel;
    Label11: TLabel;
    advMmUltimoSorteio: TAdvMemo;
    advMmNaoUltimoSorteio: TAdvMemo;
    mmApostar9: TMemo;
    mmApostar6: TMemo;
    mmSelecaoIgualdade9: TMemo;
    lblSelecaoSugestao9: TLabel;
    mmSelecaoIgualdade6: TMemo;
    lblSelecaoSugestao6: TLabel;
    bvlDivisao1: TBevel;
    bvlDivisao2: TBevel;
    PopupMenu: TPopupMenu;
    mnItReprocessarPagina: TMenuItem;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    pnlOpcoes: TPanel;
    AdvGlwBtnSorteio: TAdvGlowButton;
    advGlwBtnOcorrenciasRepeticoes: TAdvGlowButton;
    advGlwBtnPesquisarNumerosSorteados: TAdvGlowButton;
    advGlwBtnOcorrenciasSorteios: TAdvGlowButton;
    Label16: TLabel;
    btnImportarCSV: TButton;
    advGlwBtnApostar: TAdvGlowButton;
    procedure btbtnCadastroSorteioLotoFacilClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure mnItReprocessarPaginaClick(Sender: TObject);
    procedure AdvGlwBtnSorteioClick(Sender: TObject);
    procedure advGlwBtnOcorrenciasRepeticoesClick(Sender: TObject);
    procedure advGlwBtnPesquisarNumerosSorteadosClick(Sender: TObject);
    procedure advGlwBtnOcorrenciasSorteiosClick(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure btnImportarCSVClick(Sender: TObject);
    procedure advGlwBtnApostarClick(Sender: TObject);
  private
    //MINHAS PROCEDURES
    procedure numerosMaisSorteados();
    procedure numerosMaisSorteadosConcursoFinal5ou0();
    procedure ocorrenciasUltimos10Sorteios();
  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses unLotoFacil, unDM, unImportaCSV_LotoFacil,
  unDiferencaOcorrenciaNumeroSorteio, unVerificaOcorrenciaSorteio,
  unOcorrenciasSorteio, unSobre, unApostaLotoFacil;

{$R *.dfm}

//******************** MINHAS PROCEDURES ********************\\

procedure TfrmPrincipal.numerosMaisSorteados();
var
    numeros: array[1..25] of Integer; //números não ordenados
    i: Integer; //incrementador de for
    //ordenação
    vlr: Integer; //recebe maior números, testado a cada loop do for
    ii: Integer;  //incrementador de for
    p: Integer;   //controle - se for primeiro loop recebe o número
    x: Integer;   //variável auxiliar para saber qual o número atual que será incluso na ordenação
    nrosOrdenados: array[1..25] of Integer; //números ordenados
    qtdeOrdenados: array[1..25] of Integer; //quantidade de ocorrência de cada número
    excluiOrdenacao: array[1..25] of Integer; //exclui número para incluir na ordenação - já incluso nos números ordenados
    //sugestão
    linha: String; //linha com 5 números - total de 3
    n: Integer; //número atual
    sugestao: array[1..15] of Integer; //15 números que mais sairam - jogo
    nrosSugestao: array[1..15] of Integer; //15 números que mais sairam ordenados - jogo
    excluiSugestao: array[1..15] of Integer; //exclui número para incluir na ordenação - já incluso nos números de sugestão
begin
  //nºs que mais aparecem
  for i:=1 to 25 do
    begin
    numeros[i] := 0;
    nrosOrdenados[i] := 0;
    qtdeOrdenados[i] := 0;
    excluiOrdenacao[i] := 0;
    if(i<=15)then
      begin
      sugestao[i] := 0;
      excluiSugestao[i] := 0;
      nrosSugestao[i] := 0;
      end;
    end;

    DM.zQryLotoFacil.Close;
    DM.zQryLotoFacil.SQL.Clear;
    DM.zQryLotoFacil.SQL.Add('SELECT * FROM LotoFacil ORDER BY sorteio');
    DM.zQryLotoFacil.Open;
    DM.zQryLotoFacil.Refresh;
    if(DM.zQryLotoFacil.RecordCount<>0)then
      begin
      DM.zQryLotoFacil.First;
      while(not(DM.zQryLotoFacil.Eof))do
        begin
        inc(numeros[DM.zQryLotoFacilN1.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN2.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN3.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN4.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN5.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN6.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN7.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN8.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN9.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN10.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN11.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN12.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN13.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN14.AsInteger]);
        inc(numeros[DM.zQryLotoFacilN15.AsInteger]);
        DM.zQryLotoFacil.Next;
        end;
      end;

    //ordenando valores
    for i:=1 to 25 do //pegar os 25 nºs
      begin
      vlr := 0;
      p := 0;
      for ii:=1 to 25 do
        begin
        if(excluiOrdenacao[ii]=0)then //se nro ainda nao foi incluido na ordenaçao
          begin
          if(p=0)then
            begin
            vlr := numeros[ii];
            inc(p);
            x := ii;
            end
          else
            begin
            if(numeros[ii] > vlr)then
              begin
              vlr := numeros[ii];
              x := ii;
              end;
            end;
          end;
        end;
      nrosOrdenados[i] := x;
      qtdeOrdenados[i] := vlr;
      excluiOrdenacao[x] := vlr;
      end;

    advMmNrosMaisAparacem.Clear;
    for i:=1 to 25 do
      begin
      advMmNrosMaisAparacem.Lines.Add(IntToStr(nrosOrdenados[i]) + ' -> ' + IntToStr(qtdeOrdenados[i]));
      //15 primeiros vai para sugestão de jogo
      if(i<=15)then
        sugestao[i] := nrosOrdenados[i];
      end;

    //ordenando sugestão
    for i:=1 to 15 do //pegar os 15 nºs
      begin
      vlr := 0;
      p := 0;
      for ii:=1 to 15 do
        begin
        if(excluiSugestao[ii]=0)then //se nro ainda nao foi incluido na ordenaçao
          begin
          if(p=0)then
            begin
            vlr := sugestao[ii];
            inc(p);
            x := ii;
            end
          else
            begin
            if(sugestao[ii] < vlr)then
              begin
              vlr := sugestao[ii];
              x := ii;
              end;
            end;
          end;
        end;
      nrosSugestao[i] := vlr;
      excluiSugestao[x] := vlr;
      end;

    //sugestão
    mmSugestaoNrosMaisAparacem.Clear;
    n := 1;
    for i:=1 to 3 do
      begin
      linha := '';
      for ii:=1 to 5 do
        begin
        linha := linha + IntToStr(nrosSugestao[n]);
        if(ii<5)then
          linha := linha + ' - ';
        inc(n);
        end;
      mmSugestaoNrosMaisAparacem.Lines.Add(linha);
      end;
end;

procedure TfrmPrincipal.numerosMaisSorteadosConcursoFinal5ou0();
var
    numeros: array[1..25] of Integer;
    i: Integer;
    //ordenação
    vlr: Integer; //recebe maior números, testado a cada loop do for
    ii: Integer;  //incrementador de for
    p: Integer;   //controle - se for primeiro loop recebe o número
    x: Integer;   //variável auxiliar para saber qual o número atual que será incluso na ordenação
    nrosOrdenados: array[1..25] of Integer; //números ordenados
    qtdeOrdenados: array[1..25] of Integer; //quantidade de ocorrência de cada número
    excluiOrdenacao: array[1..25] of Integer; //exclui número para incluir na ordenação - já incluso nos números ordenados
    //sugestão
    linha: String; //linha com 5 números - total de 3
    n: Integer; //número atual
    sugestao: array[1..15] of Integer; //15 números que mais sairam - jogo
    nrosSugestao: array[1..15] of Integer; //15 números que mais sairam ordenados - jogo
    excluiSugestao: array[1..15] of Integer; //exclui número para incluir na ordenação - já incluso nos números de sugestão
begin
  //nºs que mais aparecem - sorteio final 0 ou 5
  for i:=1 to 25 do
    begin
    numeros[i] := 0;
    nrosOrdenados[i] := 0;
    qtdeOrdenados[i] := 0;
    excluiOrdenacao[i] := 0;
    if(i<=15)then
      begin
      sugestao[i] := 0;
      excluiSugestao[i] := 0;
      nrosSugestao[i] := 0;
      end;
    end;

    DM.zQryLotoFacil.Close;
    DM.zQryLotoFacil.SQL.Clear;
    DM.zQryLotoFacil.SQL.Add('SELECT * FROM LotoFacil ORDER BY sorteio');
    DM.zQryLotoFacil.Open;
    DM.zQryLotoFacil.Refresh;
    if(DM.zQryLotoFacil.RecordCount<>0)then
      begin
      DM.zQryLotoFacil.First;
      while(not(DM.zQryLotoFacil.Eof))do
        begin
        //so pega os sorteios com finais 5 ou zero
        if(DM.zQryLotoFacilSORTEIO.AsInteger mod 5 = 0)then
          begin
          inc(numeros[DM.zQryLotoFacilN1.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN2.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN3.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN4.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN5.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN6.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN7.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN8.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN9.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN10.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN11.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN12.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN13.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN14.AsInteger]);
          inc(numeros[DM.zQryLotoFacilN15.AsInteger]);
          end;
        DM.zQryLotoFacil.Next;
        end;
      end;

    //ordenando valores
    for i:=1 to 25 do //pegar os 25 nºs
      begin
      vlr := 0;
      p := 0;
      for ii:=1 to 25 do
        begin
        if(excluiOrdenacao[ii]=0)then //se nro ainda nao foi incluido na ordenaçao
          begin
          if(p=0)then
            begin
            vlr := numeros[ii];
            inc(p);
            x := ii;
            end
          else
            begin
            if(numeros[ii] > vlr)then
              begin
              vlr := numeros[ii];
              x := ii;
              end;
            end;
          end;
        end;
      nrosOrdenados[i] := x;
      qtdeOrdenados[i] := vlr;
      excluiOrdenacao[x] := vlr;
      end;

    advMmNrosMaisAparacemSorteio5ou0.Clear;
    for i:=1 to 25 do
      begin
      advMmNrosMaisAparacemSorteio5ou0.Lines.Add(IntToStr(nrosOrdenados[i]) + ' -> ' + IntToStr(qtdeOrdenados[i]));
      //15 primeiros vai para sugestão de jogo
      if(i<=15)then
        sugestao[i] := nrosOrdenados[i];
      end;

    //ordenando sugestão
    for i:=1 to 15 do //pegar os 15 nºs
      begin
      vlr := 0;
      p := 0;
      for ii:=1 to 15 do
        begin
        if(excluiSugestao[ii]=0)then //se nro ainda nao foi incluido na ordenaçao
          begin
          if(p=0)then
            begin
            vlr := sugestao[ii];
            inc(p);
            x := ii;
            end
          else
            begin
            if(sugestao[ii] < vlr)then
              begin
              vlr := sugestao[ii];
              x := ii;
              end;
            end;
          end;
        end;
      nrosSugestao[i] := vlr;
      excluiSugestao[x] := vlr;
      end;

    //sugestão
    mmSugestaoNrosMaisAparacemSorteio5ou0.Clear;
    n := 1;
    for i:=1 to 3 do
      begin
      linha := '';
      for ii:=1 to 5 do
        begin
        linha := linha + IntToStr(nrosSugestao[n]);
        if(ii<5)then
          linha := linha + ' - ';
        inc(n);
        end;
      mmSugestaoNrosMaisAparacemSorteio5ou0.Lines.Add(linha);
      end;
end;

procedure TfrmPrincipal.ocorrenciasUltimos10Sorteios();
var
    numeros: array[1..25] of Integer;
    i: Integer;
    //ordenação
    vlr: Integer; //recebe maior números, testado a cada loop do for
    ii: Integer;  //incrementador de for
    p: Integer;   //controle - se for primeiro loop recebe o número
    x: Integer;   //variável auxiliar para saber qual o número atual que será incluso na ordenação
    nrosOrdenados: array[1..25] of Integer; //números ordenados
    qtdeOrdenados: array[1..25] of Integer; //quantidade de ocorrência de cada número
    excluiOrdenacao: array[1..25] of Integer; //exclui número para incluir na ordenação - já incluso nos números ordenados
    //último sorteio
    temNumero: boolean;
    nrosSorteados: array[1..15] of Integer; //números sorteados
    nrosNaoSorteados: array[1..10] of Integer; //números não sorteados
    //sugestão
    nrosSairamUltimoSorteio: array[1..15] of Integer; //números sorteados no último concurso
    qtdeSairamUltimoSorteio: array[1..15] of Integer; //números sorteados no último concurso
    nrosNaoSairamUltimoSorteio: array[1..10] of Integer; //números não sorteados no último concurso
    qtdeNaoSairamUltimoSorteio: array[1..10] of Integer; //números não sorteados no último concurso
    totNrosSorteados: Integer; //deve ser 15 - (9)
    totNrosNaoSorteados: Integer; //deve ser 10 - (6)
    totSugestao9,totSugestao9IguaisUltimo,totSugestao9DiferentesUltimo: Integer;
    totSugestao6,totSugestao6IguaisUltimo,totSugestao6DiferentesUltimo: Integer;
    dif: Integer;
begin
  //pega os números que mais sairam nos últimos sorteios
  advMmUltimoSorteio.Clear;
  advMmNaoUltimoSorteio.Clear;
  lblSelecaoSugestao9.Caption := '';
  lblSelecaoSugestao6.Caption := '';
  mmApostar9.Clear;
  mmSelecaoIgualdade9.Clear;
  mmApostar6.Clear;
  mmSelecaoIgualdade6.Clear;
  
  totNrosSorteados :=  0;
  totNrosNaoSorteados := 0;
  totSugestao9 := 0;
  totSugestao9IguaisUltimo := 0;
  totSugestao9DiferentesUltimo := 0;
  totSugestao6 := 0;
  totSugestao6IguaisUltimo := 0;
  totSugestao6DiferentesUltimo := 0;
  for i:=1 to 25 do
    begin
    numeros[i] := 0;
    nrosOrdenados[i] := 0;
    qtdeOrdenados[i] := 0;
    excluiOrdenacao[i] := 0;
    if(i <= 10)then
      begin
      nrosNaoSorteados[i] := 0;
      nrosNaoSairamUltimoSorteio[i] := 0;
      qtdeNaoSairamUltimoSorteio[i] := 0;
      end;
    if(i <= 15)then
      begin
      nrosSorteados[i] := 0;
      nrosSairamUltimoSorteio[i] := 0;
      qtdeSairamUltimoSorteio[i] := 0;
      end;
    end;

  DM.zQryLotoFacil.Close;
  DM.zQryLotoFacil.SQL.Clear;
  DM.zQryLotoFacil.SQL.Add('SELECT FIRST 10 * FROM LotoFacil ORDER BY sorteio DESC'); //pega últimos 10 sorteios
  DM.zQryLotoFacil.Open;
  DM.zQryLotoFacil.Refresh;
  if(DM.zQryLotoFacil.RecordCount<>0)then
    begin
    DM.zQryLotoFacil.First;
    while(not(DM.zQryLotoFacil.Eof))do
      begin
      inc(numeros[DM.zQryLotoFacilN1.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN2.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN3.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN4.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN5.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN6.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN7.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN8.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN9.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN10.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN11.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN12.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN13.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN14.AsInteger]);
      inc(numeros[DM.zQryLotoFacilN15.AsInteger]);
      DM.zQryLotoFacil.Next;
      end;
    end;

  //memo1.Clear;
  //for i:=1 to 25 do
  //  memo1.Lines.Add(IntToStr(i) + ' = ' + IntToStr(numeros[i]));

  //ordenando valores
  for i:=1 to 25 do //pegar os 25 números
    begin
    vlr := 0;
    p := 0;
    for ii:=1 to 25 do
      begin
      if(excluiOrdenacao[ii]=0)then //se número ainda não foi incluido na ordenaçao
        begin
        if(p=0)then
          begin
          vlr := numeros[ii];
          inc(p);
          x := ii;
          end
        else
          begin
          if(numeros[ii] > vlr)then
            begin
            vlr := numeros[ii];
            x := ii;
            end;
          end;
        end;
      end;
    nrosOrdenados[i] := x;
    qtdeOrdenados[i] := vlr;
    excluiOrdenacao[x] := vlr;
    end;

  //mostrando números
  advMmOcorrenciaUltimos10Sorteios.Clear;
  for i:=1 to 25 do
    advMmOcorrenciaUltimos10Sorteios.Lines.Add(IntToStr(nrosOrdenados[i]) + ' -> ' + IntToStr(qtdeOrdenados[i]));

  //pega último sorteio
  advMmNaoUltimoSorteio.Clear;
  advMmUltimoSorteio.Clear;   
  DM.zQryLotoFacil.Close;
  DM.zQryLotoFacil.SQL.Clear;
  DM.zQryLotoFacil.SQL.Add('SELECT FIRST 1 * FROM LotoFacil ORDER BY sorteio DESC'); //pega últimos 10 sorteios
  DM.zQryLotoFacil.Open;
  DM.zQryLotoFacil.Refresh;
  if(DM.zQryLotoFacil.RecordCount<>0)then
    begin
    DM.zQryLotoFacil.First;
    while(not(DM.zQryLotoFacil.Eof))do
      begin
      for i:=1 to 25 do
        begin
        temNumero := false;
        if(DM.zQryLotoFacilN1.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN2.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN3.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN4.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN5.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN6.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN7.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN8.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN9.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN10.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN11.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN12.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN13.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN14.AsInteger  = i)then
          temNumero := true;
        if(DM.zQryLotoFacilN15.AsInteger  = i)then
          temNumero := true;
        //apresentando número - se saiu ou não no sorteio
        if(temNumero)then
          advMmUltimoSorteio.Lines.Add(IntToStr(i))
        else
          advMmNaoUltimoSorteio.Lines.Add(IntToStr(i));
        end;
      DM.zQryLotoFacil.Next;
      end;
    end
    //if(DM.zQryLotoFacil.RecordCount<>0)then
    else
    begin
      for i:=1 to 25 do
      begin
        advMmUltimoSorteio.Lines.Add(IntToStr(i));
        advMmNaoUltimoSorteio.Lines.Add(IntToStr(i));
      end;
    end;

  //montando array com números sorteados e com números não sorteados
  for i:=1 to 15 do
    begin
    nrosSorteados[i] := StrToInt(advMmUltimoSorteio.Lines.Strings[i-1]);
    if(i <= 10)then
      nrosNaoSorteados[i] := StrToInt(advMmNaoUltimoSorteio.Lines.Strings[i-1]);
    end;

  //processando números para próximo sorteio
  for i:=1 to 25 do
    begin
      for ii:=1 to 15 do
        begin
        if(nrosOrdenados[i] = nrosSorteados[ii])then //números sorteados
          begin
          inc(totNrosSorteados);
          nrosSairamUltimoSorteio[totNrosSorteados] := nrosOrdenados[i];
          qtdeSairamUltimoSorteio[totNrosSorteados] := qtdeOrdenados[i];
          end;
        if(ii <= 10)then //números não sorteados
          begin
          if(nrosOrdenados[i] = nrosNaoSorteados[ii])then
            begin
            inc(totNrosNaoSorteados);
            nrosNaoSairamUltimoSorteio[totNrosNaoSorteados] := nrosOrdenados[i];
            qtdeNaoSairamUltimoSorteio[totNrosNaoSorteados] := qtdeOrdenados[i];
            end;
          end;
        end;
    end;

  //exibindo sugestão
  //9 números sorteados no último concurso
  for i:=1 to 15 do
    begin
    if((qtdeSairamUltimoSorteio[i] <> qtdeSairamUltimoSorteio[9])and(totSugestao9 < 9))then //verifica igualdade para selecionar últimos números
      begin
      mmApostar9.Lines.Add(IntToStr(nrosSairamUltimoSorteio[i]) + ' -> ' + IntToStr(qtdeSairamUltimoSorteio[i]));
      inc(totSugestao9DiferentesUltimo);
      end;
    if(qtdeSairamUltimoSorteio[i] = qtdeSairamUltimoSorteio[9])then
      begin
      mmSelecaoIgualdade9.Lines.Add(IntToStr(nrosSairamUltimoSorteio[i]) + ' -> ' + IntToStr(qtdeSairamUltimoSorteio[i]));
      inc(totSugestao9IguaisUltimo);
      end;
    inc(totSugestao9);
    end;

  //selecionar x de nºs iguais
  if(totSugestao9IguaisUltimo > 0)then
    begin
    dif := 9 - totSugestao9DiferentesUltimo;
    if(dif <> totSugestao9IguaisUltimo)then
      begin
      lblSelecaoSugestao9.Visible := true;
      lblSelecaoSugestao9.Caption := 'e ' + IntToStr(dif) + ' dos ' + IntToStr(totSugestao9IguaisUltimo) + ' nº:';
      end
    else
      begin
      mmApostar9.Lines.Add(mmSelecaoIgualdade9.Text);
      mmSelecaoIgualdade9.Clear;
      lblSelecaoSugestao9.Visible := false;
      end;
    end
  else
    lblSelecaoSugestao9.Visible := false;

  //6 números não sorteados no último concurso
  for i:=1 to 10 do
    begin
    if((qtdeNaoSairamUltimoSorteio[i] <> qtdeNaoSairamUltimoSorteio[6])and(totSugestao6 < 6))then //verifica igualdade para selecionar últimos números
      begin
      mmApostar6.Lines.Add(IntToStr(nrosNaoSairamUltimoSorteio[i]) + ' -> ' + IntToStr(qtdeNaoSairamUltimoSorteio[i]));
      inc(totSugestao6DiferentesUltimo);
      end;
    if(qtdeNaoSairamUltimoSorteio[i] = qtdeNaoSairamUltimoSorteio[6])then
      begin
      mmSelecaoIgualdade6.Lines.Add(IntToStr(nrosNaoSairamUltimoSorteio[i]) + ' -> ' + IntToStr(qtdeNaoSairamUltimoSorteio[i]));
      inc(totSugestao6IguaisUltimo);
      end;
    inc(totSugestao6);
    end;

  //selecionar x de nºs iguais
  if(totSugestao6IguaisUltimo > 0)then
    begin
    dif := 6 - totSugestao6DiferentesUltimo;
    if(dif <> totSugestao6IguaisUltimo)then
      begin
      lblSelecaoSugestao6.Visible := true;
      lblSelecaoSugestao6.Caption := 'e ' + IntToStr(dif) + ' dos ' + IntToStr(totSugestao6IguaisUltimo) + ' nº:';
      end
    else
      begin
      mmApostar6.Lines.Add(mmSelecaoIgualdade6.Text);
      mmSelecaoIgualdade6.Clear;
      lblSelecaoSugestao6.Visible := false;
      end;
    end
  else
    lblSelecaoSugestao6.Visible := false;
end;

//******************** FIM PROCEDURES ********************\\

procedure TfrmPrincipal.btbtnCadastroSorteioLotoFacilClick(Sender: TObject);
begin
  frmCadastroLotoFacil.ShowModal;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  ShortDateFormat := 'dd/mm/yyyy';
  LongDateFormat := 'dd/mm/yyyy';
  DateSeparator := '/';
  ShortTimeFormat := 'hh:mm:ss';
  LongTimeFormat := 'hh:mm:ss';
  TimeSeparator := ':';
end;

procedure TfrmPrincipal.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ShowMessage(IntToStr(key));
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  numerosMaisSorteados();
  numerosMaisSorteadosConcursoFinal5ou0();
  ocorrenciasUltimos10Sorteios();
end;

procedure TfrmPrincipal.mnItReprocessarPaginaClick(Sender: TObject);
begin
  numerosMaisSorteados();
  numerosMaisSorteadosConcursoFinal5ou0();
  ocorrenciasUltimos10Sorteios();
end;

procedure TfrmPrincipal.AdvGlwBtnSorteioClick(Sender: TObject);
begin
  frmCadastroLotoFacil.ShowModal;
end;

procedure TfrmPrincipal.advGlwBtnOcorrenciasRepeticoesClick(Sender: TObject);
begin
  frmDiferencaOcorrenciaNumerosSorteios.ShowModal;
end;

procedure TfrmPrincipal.advGlwBtnPesquisarNumerosSorteadosClick(
  Sender: TObject);
begin
  frmVerificaOcorrenciaSorteio.ShowModal;
end;

procedure TfrmPrincipal.advGlwBtnOcorrenciasSorteiosClick(Sender: TObject);
begin
  frmOcorrenciasSorteio.ShowModal;
end;

procedure TfrmPrincipal.Label16Click(Sender: TObject);
begin
  frmSobre.ShowModal;
end;

procedure TfrmPrincipal.btnImportarCSVClick(Sender: TObject);
begin
    frmImportaDadosLotoFacil.ShowModal;
end;

procedure TfrmPrincipal.advGlwBtnApostarClick(Sender: TObject);
begin
  Application.CreateForm(TfrmApostaLotoFacil,frmApostaLotoFacil);
  frmApostaLotoFacil.ShowModal;
  FreeAndNil(frmApostaLotoFacil);
end;

end.
