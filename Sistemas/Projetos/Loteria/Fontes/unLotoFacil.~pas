unit unLotoFacil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DBXpress, Mask, ComCtrls, ToolWin,
  ImgList, Menus;

type
  TfrmCadastroLotoFacil = class(TForm)
    StatusBar: TStatusBar;
    pnlPesquisar: TPanel;
    pnlDados: TPanel;
    tlBarOpcoes: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnEditar: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnExcluir: TToolButton;
    tlBtnCancelar: TToolButton;
    ImageList: TImageList;
    Label18: TLabel;
    btBtnNavegaPrimeiro: TBitBtn;
    btBtnNavegaAnterior: TBitBtn;
    btBtnNavegaProximo: TBitBtn;
    btBtnNavegaUltimo: TBitBtn;
    Label26: TLabel;
    ppMnMostrarTodos: TPopupMenu;
    ppMnItMostrarTodosOsSorteios: TMenuItem;
    pnlDadosSorteio: TPanel;
    Label7: TLabel;
    edSorteio: TEdit;
    Label17: TLabel;
    mEdData: TMaskEdit;
    bvlDivisao1: TBevel;
    pnlNumeros: TPanel;
    Label11: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edN5: TEdit;
    edN4: TEdit;
    edN3: TEdit;
    edN2: TEdit;
    edN1: TEdit;
    edN11: TEdit;
    edN6: TEdit;
    edN12: TEdit;
    edN7: TEdit;
    edN13: TEdit;
    edN8: TEdit;
    edN14: TEdit;
    edN9: TEdit;
    edN10: TEdit;
    edN15: TEdit;
    Label27: TLabel;
    pnlGanhadores: TPanel;
    Label19: TLabel;
    Label20: TLabel;
    ed15AcertoGanhadores: TEdit;
    Label21: TLabel;
    ed14AcertoGanhadores: TEdit;
    Label22: TLabel;
    ed13AcertoGanhadores: TEdit;
    Label23: TLabel;
    ed12AcertoGanhadores: TEdit;
    Label24: TLabel;
    ed11AcertoGanhadores: TEdit;
    bvlDivisao2: TBevel;
    Label28: TLabel;
    ed15AcertoPremio: TEdit;
    ed14AcertoPremio: TEdit;
    ed11AcertoPremio: TEdit;
    ed12AcertoPremio: TEdit;
    ed13AcertoPremio: TEdit;
    btBtnPesquisarSorteio: TBitBtn;
    edPesquisaSorteio: TEdit;
    Label25: TLabel;
    ppMnModoCapturaNumeros: TPopupMenu;
    mnItCapturaManual: TMenuItem;
    mnItCapturaSite: TMenuItem;
    mnItModoCapturaDados: TMenuItem;
    mnItDivisao: TMenuItem;
    bvlDivisao3: TBevel;
    procedure edN1KeyPress(Sender: TObject; var Key: Char);
    procedure edN2KeyPress(Sender: TObject; var Key: Char);
    procedure edN3KeyPress(Sender: TObject; var Key: Char);
    procedure edN4KeyPress(Sender: TObject; var Key: Char);
    procedure edN5KeyPress(Sender: TObject; var Key: Char);
    procedure edN6KeyPress(Sender: TObject; var Key: Char);
    procedure edN7KeyPress(Sender: TObject; var Key: Char);
    procedure edN8KeyPress(Sender: TObject; var Key: Char);
    procedure edN9KeyPress(Sender: TObject; var Key: Char);
    procedure edN10KeyPress(Sender: TObject; var Key: Char);
    procedure edN11KeyPress(Sender: TObject; var Key: Char);
    procedure edN12KeyPress(Sender: TObject; var Key: Char);
    procedure edN13KeyPress(Sender: TObject; var Key: Char);
    procedure edN14KeyPress(Sender: TObject; var Key: Char);
    procedure edN15KeyPress(Sender: TObject; var Key: Char);
    procedure ed15AcertoGanhadoresKeyPress(Sender: TObject; var Key: Char);
    procedure ed14AcertoGanhadoresKeyPress(Sender: TObject; var Key: Char);
    procedure ed13AcertoGanhadoresKeyPress(Sender: TObject; var Key: Char);
    procedure ed12AcertoGanhadoresKeyPress(Sender: TObject; var Key: Char);
    procedure ed11AcertoGanhadoresKeyPress(Sender: TObject; var Key: Char);
    procedure edSorteioKeyPress(Sender: TObject; var Key: Char);
    procedure edN1Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure edSorteioEnter(Sender: TObject);
    procedure mEdDataEnter(Sender: TObject);
    procedure edN1Enter(Sender: TObject);
    procedure edN2Enter(Sender: TObject);
    procedure edN3Enter(Sender: TObject);
    procedure edN4Enter(Sender: TObject);
    procedure edN5Enter(Sender: TObject);
    procedure edN6Enter(Sender: TObject);
    procedure edN7Enter(Sender: TObject);
    procedure edN8Enter(Sender: TObject);
    procedure edN9Enter(Sender: TObject);
    procedure edN10Enter(Sender: TObject);
    procedure edN11Enter(Sender: TObject);
    procedure edN12Enter(Sender: TObject);
    procedure edN13Enter(Sender: TObject);
    procedure edN14Enter(Sender: TObject);
    procedure edN15Enter(Sender: TObject);
    procedure ed15AcertoGanhadoresEnter(Sender: TObject);
    procedure ed14AcertoGanhadoresEnter(Sender: TObject);
    procedure ed13AcertoGanhadoresEnter(Sender: TObject);
    procedure ed12AcertoGanhadoresEnter(Sender: TObject);
    procedure ed11AcertoGanhadoresEnter(Sender: TObject);
    procedure ed11AcertoGanhadoresExit(Sender: TObject);
    procedure ed12AcertoGanhadoresExit(Sender: TObject);
    procedure ed13AcertoGanhadoresExit(Sender: TObject);
    procedure ed14AcertoGanhadoresExit(Sender: TObject);
    procedure ed15AcertoGanhadoresExit(Sender: TObject);
    procedure edSorteioExit(Sender: TObject);
    procedure mEdDataExit(Sender: TObject);
    procedure edN2Exit(Sender: TObject);
    procedure edN3Exit(Sender: TObject);
    procedure edN4Exit(Sender: TObject);
    procedure edN5Exit(Sender: TObject);
    procedure edN6Exit(Sender: TObject);
    procedure edN7Exit(Sender: TObject);
    procedure edN8Exit(Sender: TObject);
    procedure edN9Exit(Sender: TObject);
    procedure edN10Exit(Sender: TObject);
    procedure edN11Exit(Sender: TObject);
    procedure edN12Exit(Sender: TObject);
    procedure edN13Exit(Sender: TObject);
    procedure edN14Exit(Sender: TObject);
    procedure edN15Exit(Sender: TObject);
    procedure edPesquisaSorteioEnter(Sender: TObject);
    procedure edPesquisaSorteioExit(Sender: TObject);
    procedure edPesquisaSorteioKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnNavegaPrimeiroClick(Sender: TObject);
    procedure btBtnNavegaAnteriorClick(Sender: TObject);
    procedure btBtnNavegaProximoClick(Sender: TObject);
    procedure btBtnNavegaUltimoClick(Sender: TObject);
    procedure btBtnPesquisarSorteioClick(Sender: TObject);
    procedure ppMnItMostrarTodosOsSorteiosClick(Sender: TObject);
    procedure ed15AcertoPremioEnter(Sender: TObject);
    procedure ed14AcertoPremioEnter(Sender: TObject);
    procedure ed13AcertoPremioEnter(Sender: TObject);
    procedure ed12AcertoPremioEnter(Sender: TObject);
    procedure ed11AcertoPremioEnter(Sender: TObject);
    procedure ed11AcertoPremioExit(Sender: TObject);
    procedure ed12AcertoPremioExit(Sender: TObject);
    procedure ed13AcertoPremioExit(Sender: TObject);
    procedure ed14AcertoPremioExit(Sender: TObject);
    procedure ed15AcertoPremioExit(Sender: TObject);
    procedure ed15AcertoPremioKeyPress(Sender: TObject; var Key: Char);
    procedure ed14AcertoPremioKeyPress(Sender: TObject; var Key: Char);
    procedure ed13AcertoPremioKeyPress(Sender: TObject; var Key: Char);
    procedure ed12AcertoPremioKeyPress(Sender: TObject; var Key: Char);
    procedure ed11AcertoPremioKeyPress(Sender: TObject; var Key: Char);
    procedure mnItCapturaSiteClick(Sender: TObject);
    procedure mnItCapturaManualClick(Sender: TObject);
    procedure edGanhadoresKeyPress(Sender: TObject; var Key: Char);
  private
    Transacao: TTransactionDesc;
    opcaoSalvar: Integer;
    fechar: boolean;

    procedure limpar();
    function verificaSalva(): boolean;
    procedure visibilidade(i: Integer);
    procedure iniciaTransacao();
    procedure carrega();
    procedure mostraTodasLotoFacil();
  public

  end;

var
  frmCadastroLotoFacil: TfrmCadastroLotoFacil;

implementation

uses unDM, unCapturarNumerosSite;

{$R *.dfm}

{ TfrmLotoFacil }

(* MINHAS PROCEDURES *)
procedure TfrmCadastroLotoFacil.mostraTodasLotoFacil();
begin
  DM.zQryLotoFacil.Close;
  DM.zQryLotoFacil.SQL.Clear;
  DM.zQryLotoFacil.SQL.Add('SELECT * FROM LotoFacil l ORDER BY l.sorteio');
  DM.zQryLotoFacil.Open;
//  DM.zQryLotoFacil.First;
end;

procedure TfrmCadastroLotoFacil.visibilidade(i: Integer);
begin
  {
  1 = novo
  11 = editar
  21 = salvar
  31 = excluir
  41 = cancelar
  }

  case i of
    {novo}
    1: begin
       pnlDados.Enabled := true;
       //dbGrdInformacaoVersoes.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edSorteio.SetFocus;
       end;

    {editar}
    11: begin
       pnlDados.Enabled := true;
       //dbGrdInformacaoVersoes.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edSorteio.SetFocus;
       end;

    {salvar}
    21: begin
       pnlDados.Enabled := false;
       //dbGrdInformacaoVersoes.Enabled := true;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;
       if (DM.zQryLotoFacil.RecordCount > 0) then
         begin
         tlBtnEditar.Enabled := true;
         tlBtnExcluir.Enabled := true;
         end
       else
         begin
         tlBtnEditar.Enabled := false;
         tlBtnExcluir.Enabled := false;
         end;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;
       end;

    {excluir}
    31: begin
        pnlDados.Enabled := false;
        pnlPesquisar.Enabled := true;
        tlBtnNovo.Enabled := true;
        tlBtnSalvar.Enabled := false;
        if (DM.zQryLotoFacil.RecordCount > 0) then
          begin
          //dbGrdInformacaoVersoes.Enabled := true;
          tlBtnEditar.Enabled := true;
          tlBtnExcluir.Enabled := true;
          end
        else
          begin
          //dbGrdInformacaoVersoes.Enabled := false;
          tlBtnEditar.Enabled := false;
          tlBtnExcluir.Enabled := false;
          end;
        tlBtnCancelar.Enabled := false;
        end;

    {cancelar}
    41: begin
       pnlDados.Enabled := false;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;
       if (DM.zQryLotoFacil.RecordCount > 0) then
         begin
         //dbGrdInformacaoVersoes.Enabled := true;
         tlBtnEditar.Enabled := true;
         tlBtnExcluir.Enabled := true;
         end
       else
         begin
         //dbGrdInformacaoVersoes.Enabled := false;
         tlBtnEditar.Enabled := false;
         tlBtnExcluir.Enabled := false;
         end;
       end;
  end;//case
end;
procedure TfrmCadastroLotoFacil.carrega();
begin
  Self.limpar();
  
  edSorteio.Text := DM.zQryLotoFacilSORTEIO.AsString;
  mEdData.Text := DM.zQryLotoFacilDATA.AsString;
  edN1.Text := DM.zQryLotoFacilN1.AsString;
  edN2.Text := DM.zQryLotoFacilN2.AsString;
  edN3.Text := DM.zQryLotoFacilN3.AsString;
  edN4.Text := DM.zQryLotoFacilN4.AsString;
  edN5.Text := DM.zQryLotoFacilN5.AsString;
  edN6.Text := DM.zQryLotoFacilN6.AsString;
  edN7.Text := DM.zQryLotoFacilN7.AsString;
  edN8.Text := DM.zQryLotoFacilN8.AsString;
  edN9.Text := DM.zQryLotoFacilN9.AsString;
  edN10.Text := DM.zQryLotoFacilN10.AsString;
  edN11.Text := DM.zQryLotoFacilN11.AsString;
  edN12.Text := DM.zQryLotoFacilN12.AsString;
  edN13.Text := DM.zQryLotoFacilN13.AsString;
  edN14.Text := DM.zQryLotoFacilN14.AsString;
  edN15.Text := DM.zQryLotoFacilN15.AsString;
  ed15AcertoGanhadores.Text := DM.zQryLotoFacilACERTO15.AsString;
  ed14AcertoGanhadores.Text := DM.zQryLotoFacilACERTO14.AsString;
  ed13AcertoGanhadores.Text := DM.zQryLotoFacilACERTO13.AsString;
  ed12AcertoGanhadores.Text := DM.zQryLotoFacilACERTO12.AsString;
  ed11AcertoGanhadores.Text := DM.zQryLotoFacilACERTO11.AsString;
  ed15AcertoPremio.Text := DM.zQryLotoFacilPREMIO_ACERTO15.AsString;
  ed14AcertoPremio.Text := DM.zQryLotoFacilPREMIO_ACERTO14.AsString;
  ed13AcertoPremio.Text := DM.zQryLotoFacilPREMIO_ACERTO13.AsString;
  ed12AcertoPremio.Text := DM.zQryLotoFacilPREMIO_ACERTO12.AsString;
  ed11AcertoPremio.Text := DM.zQryLotoFacilPREMIO_ACERTO11.AsString;
end;

procedure TfrmCadastroLotoFacil.iniciaTransacao();
begin
  Transacao.TransactionID:= 1;
  Transacao.IsolationLevel:=  xilReadCommitted;
end;

procedure TfrmCadastroLotoFacil.limpar();
var
  i: Integer;
begin
  for i:=0 to ComponentCount-1 do
    begin
    if(Components[i] is TEdit)then
      TEdit(Components[i]).Clear;
    if(Components[i] is TMaskEdit)then
      TMaskEdit(Components[i]).Clear;
    end;
end;

function TfrmCadastroLotoFacil.verificaSalva(): boolean;
var
  n: array[1..15] of Integer;
  i: Integer;
  repetidos: String;
  foraEscopo: String;
  continua: boolean;
  achouForaEscopo: boolean;
  outrosDados: String;
  erroOutrosDados: boolean;
begin
  continua := true;

  //pegando números
  try
    n[1] := StrToInt(edN1.Text);
    n[2] := StrToInt(edN2.Text);
    n[3] := StrToInt(edN3.Text);
    n[4] := StrToInt(edN4.Text);
    n[5] := StrToInt(edN5.Text);
    n[6] := StrToInt(edN6.Text);
    n[7] := StrToInt(edN7.Text);
    n[8] := StrToInt(edN8.Text);
    n[9] := StrToInt(edN9.Text);
    n[10] := StrToInt(edN10.Text);
    n[11] := StrToInt(edN11.Text);
    n[12] := StrToInt(edN12.Text);
    n[13] := StrToInt(edN13.Text);
    n[14] := StrToInt(edN14.Text);
    n[15] := StrToInt(edN15.Text);
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

  //verificando demais dados
  if(continua=true)then
    begin
    outrosDados := '';
    erroOutrosDados := false;
    if(edSorteio.Text='')then
      begin
      outrosDados := outrosDados + 'sorteio';
      erroOutrosDados := true;
      end;
    if(mEdData.Text = '  /  /    ')then
      begin
      if(erroOutrosDados=false)then
        outrosDados := outrosDados + 'data'
      else
        outrosDados := outrosDados + ', data';
      erroOutrosDados := true;
      end;
    if(ed15AcertoGanhadores.Text = '')then
      begin
      if(erroOutrosDados=false)then
        outrosDados := outrosDados + 'Ganhador 15 acertos'
      else
        outrosDados := outrosDados + ',Ganhador 15 acertos';
      erroOutrosDados := true;
      end;
    if(ed14AcertoGanhadores.Text = '')then
      begin
      if(erroOutrosDados=false)then
        outrosDados := outrosDados + 'Ganhador 14 acertos'
      else
        outrosDados := outrosDados + ',Ganhador 14 acertos';
      erroOutrosDados := true;
      end;
    if(ed13AcertoGanhadores.Text = '')then
      begin
      if(erroOutrosDados=false)then
        outrosDados := outrosDados + 'Ganhador 13 acertos'
      else
        outrosDados := outrosDados + ',Ganhador 13 acertos';
      erroOutrosDados := true;
      end;
    if(ed12AcertoGanhadores.Text = '')then
      begin
      if(erroOutrosDados=false)then
        outrosDados := outrosDados + 'Ganhador 12 acertos'
      else
        outrosDados := outrosDados + ',Ganhador 12 acertos';
      erroOutrosDados := true;
      end;
    if(ed11AcertoGanhadores.Text = '')then
      begin
      if(erroOutrosDados=false)then
        outrosDados := outrosDados + 'Ganhador 11 acertos'
      else
        outrosDados := outrosDados + ',Ganhador 11 acertos';
      erroOutrosDados := true;
      end;
    if(ed15AcertoPremio.Text = '')then
      begin
      if(erroOutrosDados=false)then
        outrosDados := outrosDados + 'Prêmio 15 acertos'
      else
        outrosDados := outrosDados + ',Prêmio 15 acertos';
      erroOutrosDados := true;
      end;
    if(ed14AcertoPremio.Text = '')then
      begin
      if(erroOutrosDados=false)then
        outrosDados := outrosDados + 'Prêmio 14 acertos'
      else
        outrosDados := outrosDados + ',Prêmio 14 acertos';
      erroOutrosDados := true;
      end;
    if(ed13AcertoPremio.Text = '')then
      begin
      if(erroOutrosDados=false)then
        outrosDados := outrosDados + 'Prêmio 13 acertos'
      else
        outrosDados := outrosDados + ',Prêmio 13 acertos';
      erroOutrosDados := true;
      end;
    if(ed12AcertoPremio.Text = '')then
      begin
      if(erroOutrosDados=false)then
        outrosDados := outrosDados + 'Prêmio 12 acertos'
      else
        outrosDados := outrosDados + ',Prêmio 12 acertos';
      erroOutrosDados := true;
      end;
    if(ed11AcertoPremio.Text = '')then
      begin
      if(erroOutrosDados=false)then
        outrosDados := outrosDados + 'Prêmio 11 acertos'
      else
        outrosDados := outrosDados + ',Prêmio 11 acertos';
      erroOutrosDados := true;
      end;
    if(erroOutrosDados=true)then
      begin
      MessageDlg('Verifique os seguintes campos: ' + outrosDados, mtInformation, [mbOK], 0);
      continua := false;
      end;
    end;

  Result := continua;
end;

(* FIM MINHAS PROCEDURES *)

procedure TfrmCadastroLotoFacil.edN1KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN2KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN3KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN4KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN5KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN6KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN7KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN8KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN9KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN10KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN11KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN12KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN13KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN14KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN15KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.ed15AcertoGanhadoresKeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.ed14AcertoGanhadoresKeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.ed13AcertoGanhadoresKeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.ed12AcertoGanhadoresKeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.ed11AcertoGanhadoresKeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edSorteioKeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.edN1Exit(Sender: TObject);
begin
  edN1.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.FormShow(Sender: TObject);
begin
  limpar();
  try
    mostraTodasLotoFacil();
    DM.zQryLotoFacil.First;
    carrega();
  except
  end;

  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmCadastroLotoFacil.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  visibilidade(1);
  limpar();
  fechar := false;
  opcaoSalvar := 1;//novo
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';
end;

procedure TfrmCadastroLotoFacil.tlBtnSalvarClick(Sender: TObject);
begin
  if (verificaSalva = true) then
    begin
    case opcaoSalvar of
      1: begin //novo
         try
           iniciaTransacao();
           DM.ZConnection.StartTransaction();

           DM.zQryLotoFacil.Close;
           DM.zQryLotoFacil.SQL.Clear;
           DM.zQryLotoFacil.SQL.Add('INSERT INTO LotoFacil (sorteio,data,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15,');
           DM.zQryLotoFacil.SQL.Add('acerto15,acerto14,acerto13,acerto12,acerto11,premio_acerto15,premio_acerto14,premio_acerto13,');
           DM.zQryLotoFacil.SQL.Add('premio_acerto12,premio_acerto11) ');
           DM.zQryLotoFacil.SQL.Add('VALUES (:s,:d,:n1,:n2,:n3,:n4,:n5,:n6,:n7,:n8,:n9,:n10,:n11,:n12,:n13,:n14,:n15,');
           DM.zQryLotoFacil.SQL.Add(':a15,:a14,:a13,:a12,:a11,:p15,:p14,:p13,:p12,:p11)');
           DM.zQryLotoFacil.ParamByName('s').AsInteger := StrToInt(edSorteio.Text);
           DM.zQryLotoFacil.ParamByName('d').AsDate := StrToDate(mEdData.Text);
           DM.zQryLotoFacil.ParamByName('n1').AsInteger := StrToInt(edN1.Text);
           DM.zQryLotoFacil.ParamByName('n2').AsInteger := StrToInt(edN2.Text);
           DM.zQryLotoFacil.ParamByName('n3').AsInteger := StrToInt(edN3.Text);
           DM.zQryLotoFacil.ParamByName('n4').AsInteger := StrToInt(edN4.Text);
           DM.zQryLotoFacil.ParamByName('n5').AsInteger := StrToInt(edN5.Text);
           DM.zQryLotoFacil.ParamByName('n6').AsInteger := StrToInt(edN6.Text);
           DM.zQryLotoFacil.ParamByName('n7').AsInteger := StrToInt(edN7.Text);
           DM.zQryLotoFacil.ParamByName('n8').AsInteger := StrToInt(edN8.Text);
           DM.zQryLotoFacil.ParamByName('n9').AsInteger := StrToInt(edN9.Text);
           DM.zQryLotoFacil.ParamByName('n10').AsInteger := StrToInt(edN10.Text);
           DM.zQryLotoFacil.ParamByName('n11').AsInteger := StrToInt(edN11.Text);
           DM.zQryLotoFacil.ParamByName('n12').AsInteger := StrToInt(edN12.Text);
           DM.zQryLotoFacil.ParamByName('n13').AsInteger := StrToInt(edN13.Text);
           DM.zQryLotoFacil.ParamByName('n14').AsInteger := StrToInt(edN14.Text);
           DM.zQryLotoFacil.ParamByName('n15').AsInteger := StrToInt(edN15.Text);
           DM.zQryLotoFacil.ParamByName('a15').AsInteger := StrToInt(ed15AcertoGanhadores.Text);
           DM.zQryLotoFacil.ParamByName('a14').AsInteger := StrToInt(ed14AcertoGanhadores.Text);
           DM.zQryLotoFacil.ParamByName('a13').AsInteger := StrToInt(ed13AcertoGanhadores.Text);
           DM.zQryLotoFacil.ParamByName('a12').AsInteger := StrToInt(ed12AcertoGanhadores.Text);
           DM.zQryLotoFacil.ParamByName('a11').AsInteger := StrToInt(ed11AcertoGanhadores.Text);
           DM.zQryLotoFacil.ParamByName('p15').AsFloat := StrToFloat(ed15AcertoPremio.Text);
           DM.zQryLotoFacil.ParamByName('p14').AsFloat := StrToFloat(ed14AcertoPremio.Text);
           DM.zQryLotoFacil.ParamByName('p13').AsFloat := StrToFloat(ed13AcertoPremio.Text);
           DM.zQryLotoFacil.ParamByName('p12').AsFloat := StrToFloat(ed12AcertoPremio.Text);
           DM.zQryLotoFacil.ParamByName('p11').AsFloat := StrToFloat(ed11AcertoPremio.Text);
           DM.zQryLotoFacil.ExecSQL();

           DM.ZConnection.Commit();
           MessageDlg('Sorteio salvo com sucesso!',mtInformation,[mbOK],0);
         except
           DM.ZConnection.Rollback();
           MessageDlg('Sorteio não pode ser salvo!',mtInformation,[mbOK],0);
         end;
         end;

      2: begin //editar
         try
           iniciaTransacao();
           DM.ZConnection.StartTransaction();

           DM.zQryLotoFacil.Close;
           DM.zQryLotoFacil.SQL.Clear;
           DM.zQryLotoFacil.SQL.Add('UPDATE LotoFacil SET data=:d,n1=:n1,n2=:n2,n3=:n3,n4=:n4,n5=:n5,n6=:n6,n7=:n7,n8=:n8,n9=:n9, ');
           DM.zQryLotoFacil.SQL.Add('n10=:n10,n11=:n11,n12=:n12,n13=:n13,n14=:n14,n15=:n15,acerto15=:a15,acerto14=:a14,acerto13=:a13, ');
           DM.zQryLotoFacil.SQL.Add('acerto12=:a12,acerto11=:a11,premio_acerto15=:p15,premio_acerto14=:p14,premio_acerto13=:p13, ');
           DM.zQryLotoFacil.SQL.Add('premio_acerto12=:p12,premio_acerto11=:p11 WHERE sorteio=:s');
           DM.zQryLotoFacil.ParamByName('s').AsInteger := StrToInt(edSorteio.Text);
           DM.zQryLotoFacil.ParamByName('d').AsDate := StrToDate(mEdData.Text);
           DM.zQryLotoFacil.ParamByName('n1').AsInteger := StrToInt(edN1.Text);
           DM.zQryLotoFacil.ParamByName('n2').AsInteger := StrToInt(edN2.Text);
           DM.zQryLotoFacil.ParamByName('n3').AsInteger := StrToInt(edN3.Text);
           DM.zQryLotoFacil.ParamByName('n4').AsInteger := StrToInt(edN4.Text);
           DM.zQryLotoFacil.ParamByName('n5').AsInteger := StrToInt(edN5.Text);
           DM.zQryLotoFacil.ParamByName('n6').AsInteger := StrToInt(edN6.Text);
           DM.zQryLotoFacil.ParamByName('n7').AsInteger := StrToInt(edN7.Text);
           DM.zQryLotoFacil.ParamByName('n8').AsInteger := StrToInt(edN8.Text);
           DM.zQryLotoFacil.ParamByName('n9').AsInteger := StrToInt(edN9.Text);
           DM.zQryLotoFacil.ParamByName('n10').AsInteger := StrToInt(edN10.Text);
           DM.zQryLotoFacil.ParamByName('n11').AsInteger := StrToInt(edN11.Text);
           DM.zQryLotoFacil.ParamByName('n12').AsInteger := StrToInt(edN12.Text);
           DM.zQryLotoFacil.ParamByName('n13').AsInteger := StrToInt(edN13.Text);
           DM.zQryLotoFacil.ParamByName('n14').AsInteger := StrToInt(edN14.Text);
           DM.zQryLotoFacil.ParamByName('n15').AsInteger := StrToInt(edN15.Text);
           DM.zQryLotoFacil.ParamByName('a15').AsInteger := StrToInt(ed15AcertoGanhadores.Text);
           DM.zQryLotoFacil.ParamByName('a14').AsInteger := StrToInt(ed14AcertoGanhadores.Text);
           DM.zQryLotoFacil.ParamByName('a13').AsInteger := StrToInt(ed13AcertoGanhadores.Text);
           DM.zQryLotoFacil.ParamByName('a12').AsInteger := StrToInt(ed12AcertoGanhadores.Text);
           DM.zQryLotoFacil.ParamByName('a11').AsInteger := StrToInt(ed11AcertoGanhadores.Text);
           DM.zQryLotoFacil.ParamByName('p15').AsFloat := StrToFloat(ed15AcertoPremio.Text);
           DM.zQryLotoFacil.ParamByName('p14').AsFloat := StrToFloat(ed14AcertoPremio.Text);
           DM.zQryLotoFacil.ParamByName('p13').AsFloat := StrToFloat(ed13AcertoPremio.Text);
           DM.zQryLotoFacil.ParamByName('p12').AsFloat := StrToFloat(ed12AcertoPremio.Text);
           DM.zQryLotoFacil.ParamByName('p11').AsFloat := StrToFloat(ed11AcertoPremio.Text);
           DM.zQryLotoFacil.ExecSQL();

           DM.ZConnection.Commit();
           MessageDlg('Sorteio editado com sucesso!',mtInformation,[mbOK],0);
         except
           DM.ZConnection.Rollback();
           MessageDlg('Sorteio não pode ser editado!',mtInformation,[mbOK],0);
         end;
         end;
    end;//case
      {selecionando todos Loto Fácil}
      mostraTodasLotoFacil();
      {atualizando ClientDataSet}
      DM.zQryLotoFacil.Last;
      carrega();
      StatusBar.Panels[1].Text := 'OPERAÇÃO = Salvar';
      visibilidade(21);
      fechar := true;
      //caso tela auxiliar chamou cliente para fazer novo cadastro
    end;//if
end;

procedure TfrmCadastroLotoFacil.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (fechar = false) then
    begin
    MessageDlg('Salve ou cancele antes o processo que se encontra em operação!',mtInformation,[mbOK],0);
    Action := caNone;
    end
  else
    begin
    if(frmCapturarNumerosSite <> nil)then
      FreeAndNil(frmCapturarNumerosSite);
    end;
end;

procedure TfrmCadastroLotoFacil.tlBtnEditarClick(Sender: TObject);
begin
  {preparando}
  visibilidade(11);
  edSorteio.SetFocus;
  opcaoSalvar := 2;//editar
  fechar := false;
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Edição';
end;

procedure TfrmCadastroLotoFacil.tlBtnExcluirClick(Sender: TObject);
var
  sorteio: Integer;
begin
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Excluir';

  if (MessageDlg('Deseja deletar o Sorteio da Loto Fácil Nº ' +#13 + DM.zQryLotoFacilSORTEIO.AsString + '?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
    try
      sorteio := StrToInt(edSorteio.Text);

      iniciaTransacao();
      DM.ZConnection.StartTransaction();
      (*deletando*)
      DM.zQryLotoFacil.Close;
      DM.zQryLotoFacil.SQL.Clear;
      DM.zQryLotoFacil.SQL.Add('DELETE FROM LotoFacil l WHERE l.sorteio=:sor');
      DM.zQryLotoFacil.ParamByName('sor').AsInteger := sorteio;
      DM.zQryLotoFacil.ExecSQL();

      DM.ZConnection.Commit();

      {selecionando todos Loto Fácil}
      mostraTodasLotoFacil();
      {atualizando ClientDataSet}
      DM.zQryLotoFacil.Last;
      carrega();
      StatusBar.Panels[1].Text := '';
      visibilidade(31);
      fechar := true;
    except
      MessageDlg('Sorteio da Loto Fácil não pode ser deletado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
      DM.ZConnection.Rollback();
    end;
    end
  else
    begin
    {selecionando todos Loto Fácil}
    mostraTodasLotoFacil();
    {atualizando ClientDataSet}
    DM.zQryLotoFacil.Last;
    carrega();
    StatusBar.Panels[1].Text := '';
    visibilidade(31);
    fechar := true;
    end;
end;

procedure TfrmCadastroLotoFacil.tlBtnCancelarClick(Sender: TObject);
begin
  limpar();
  mostraTodasLotoFacil();
  DM.zQryLotoFacil.Last;
  carrega();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmCadastroLotoFacil.edSorteioEnter(Sender: TObject);
begin
  edSorteio.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.mEdDataEnter(Sender: TObject);
begin
  mEdData.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN1Enter(Sender: TObject);
begin
  edN1.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN2Enter(Sender: TObject);
begin
  edN2.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN3Enter(Sender: TObject);
begin
  edN3.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN4Enter(Sender: TObject);
begin
  edN4.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN5Enter(Sender: TObject);
begin
  edN5.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN6Enter(Sender: TObject);
begin
  edN6.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN7Enter(Sender: TObject);
begin
  edN7.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN8Enter(Sender: TObject);
begin
  edN8.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN9Enter(Sender: TObject);
begin
  edN9.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN10Enter(Sender: TObject);
begin
  edN10.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN11Enter(Sender: TObject);
begin
  edN11.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN12Enter(Sender: TObject);
begin
  edN12.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN13Enter(Sender: TObject);
begin
  edN13.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN14Enter(Sender: TObject);
begin
  edN14.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edN15Enter(Sender: TObject);
begin
  edN15.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.ed15AcertoGanhadoresEnter(Sender: TObject);
begin
  ed15AcertoGanhadores.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.ed14AcertoGanhadoresEnter(Sender: TObject);
begin
  ed14AcertoGanhadores.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.ed13AcertoGanhadoresEnter(Sender: TObject);
begin
  ed13AcertoGanhadores.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.ed12AcertoGanhadoresEnter(Sender: TObject);
begin
  ed12AcertoGanhadores.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.ed11AcertoGanhadoresEnter(Sender: TObject);
begin
  ed11AcertoGanhadores.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.ed11AcertoGanhadoresExit(Sender: TObject);
begin
  ed11AcertoGanhadores.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.ed12AcertoGanhadoresExit(Sender: TObject);
begin
  ed12AcertoGanhadores.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.ed13AcertoGanhadoresExit(Sender: TObject);
begin
  ed13AcertoGanhadores.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.ed14AcertoGanhadoresExit(Sender: TObject);
begin
  ed14AcertoGanhadores.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.ed15AcertoGanhadoresExit(Sender: TObject);
begin
  ed15AcertoGanhadores.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edSorteioExit(Sender: TObject);
begin
  edSorteio.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.mEdDataExit(Sender: TObject);
begin
  mEdData.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN2Exit(Sender: TObject);
begin
  edN2.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN3Exit(Sender: TObject);
begin
  edN3.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN4Exit(Sender: TObject);
begin
  edN4.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN5Exit(Sender: TObject);
begin
  edN5.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN6Exit(Sender: TObject);
begin
  edN6.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN7Exit(Sender: TObject);
begin
  edN7.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN8Exit(Sender: TObject);
begin
  edN8.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN9Exit(Sender: TObject);
begin
  edN9.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN10Exit(Sender: TObject);
begin
  edN10.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN11Exit(Sender: TObject);
begin
  edN11.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN12Exit(Sender: TObject);
begin
  edN12.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN13Exit(Sender: TObject);
begin
  edN13.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN14Exit(Sender: TObject);
begin
  edN14.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edN15Exit(Sender: TObject);
begin
  edN15.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edPesquisaSorteioEnter(Sender: TObject);
begin
  edPesquisaSorteio.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.edPesquisaSorteioExit(Sender: TObject);
begin
  edPesquisaSorteio.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.edPesquisaSorteioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.btBtnNavegaPrimeiroClick(Sender: TObject);
begin
  DM.zQryLotoFacil.First;
  carrega();
end;

procedure TfrmCadastroLotoFacil.btBtnNavegaAnteriorClick(Sender: TObject);
begin
  DM.zQryLotoFacil.Prior;
  carrega();
end;

procedure TfrmCadastroLotoFacil.btBtnNavegaProximoClick(Sender: TObject);
begin
  DM.zQryLotoFacil.Next;
  carrega();
end;

procedure TfrmCadastroLotoFacil.btBtnNavegaUltimoClick(Sender: TObject);
begin
  DM.zQryLotoFacil.Last;
  carrega();
end;

procedure TfrmCadastroLotoFacil.btBtnPesquisarSorteioClick(
  Sender: TObject);
begin
  if(edPesquisaSorteio.Text <> '')then
    begin
    DM.zQryLotoFacil.Close;
    DM.zQryLotoFacil.SQL.Clear;
    DM.zQryLotoFacil.SQL.Add('SELECT * FROM LotoFacil l WHERE l.sorteio=:sor');
    DM.zQryLotoFacil.ParamByName('sor').AsInteger := StrToInt(edPesquisaSorteio.Text);
    DM.zQryLotoFacil.Open;
    DM.zQryLotoFacil.Refresh;
    if(DM.zQryLotoFacil.RecordCount <> 0)then
      carrega()
    else
      begin
      MessageDlg('Nenhum sorteio encontrado com este número!', mtInformation, [mbOK], 0);
      edPesquisaSorteio.SetFocus;
      end;
    end
  else
    begin
    MessageDlg('Digite um número de Sorteio para realizar a pesquisa!', mtInformation, [mbOK], 0);
    edPesquisaSorteio.SetFocus;
    end;
end;

procedure TfrmCadastroLotoFacil.ppMnItMostrarTodosOsSorteiosClick(
  Sender: TObject);
begin
  mostraTodasLotoFacil();
  carrega();
end;

procedure TfrmCadastroLotoFacil.ed15AcertoPremioEnter(Sender: TObject);
begin
  ed15AcertoPremio.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.ed14AcertoPremioEnter(Sender: TObject);
begin
  ed14AcertoPremio.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.ed13AcertoPremioEnter(Sender: TObject);
begin
  ed13AcertoPremio.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.ed12AcertoPremioEnter(Sender: TObject);
begin
  ed12AcertoPremio.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.ed11AcertoPremioEnter(Sender: TObject);
begin
  ed11AcertoPremio.Color := clMoneyGreen;
end;

procedure TfrmCadastroLotoFacil.ed11AcertoPremioExit(Sender: TObject);
begin
  ed11AcertoPremio.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.ed12AcertoPremioExit(Sender: TObject);
begin
  ed12AcertoPremio.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.ed13AcertoPremioExit(Sender: TObject);
begin
  ed13AcertoPremio.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.ed14AcertoPremioExit(Sender: TObject);
begin
  ed14AcertoPremio.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.ed15AcertoPremioExit(Sender: TObject);
begin
  if (ed15AcertoPremio.Text <> '') then
    begin
    try
      ed15AcertoPremio.Text := FormatFloat('#0.00',StrToFloat(ed15AcertoPremio.Text));
    except
    end;
    end;
  ed15AcertoPremio.Color := clWindow;
end;

procedure TfrmCadastroLotoFacil.ed15AcertoPremioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',',',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.ed14AcertoPremioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',',',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.ed13AcertoPremioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',',',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.ed12AcertoPremioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',',',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.ed11AcertoPremioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',',',Chr(8)]))then
    key := #0;
end;

procedure TfrmCadastroLotoFacil.mnItCapturaSiteClick(Sender: TObject);
begin
  if(frmCapturarNumerosSite = nil)then
    begin
    Application.CreateForm(TfrmCapturarNumerosSite,frmCapturarNumerosSite);
    frmCapturarNumerosSite.jogo := 'lotoFacil';
    frmCapturarNumerosSite.Show;
    mnItCapturaSite.Checked := true;
    mnItCapturaManual.Checked := false;
    end;
end;

procedure TfrmCadastroLotoFacil.mnItCapturaManualClick(Sender: TObject);
begin
  if(frmCapturarNumerosSite <> nil)then
    begin
    FreeAndNil(frmCapturarNumerosSite);
    mnItCapturaManual.Checked := true;
    mnItCapturaSite.Checked := false;
    end;
end;

procedure TfrmCadastroLotoFacil.edGanhadoresKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in['0'..'9',Chr(8)]))then
    key := #0;
end;

end.
