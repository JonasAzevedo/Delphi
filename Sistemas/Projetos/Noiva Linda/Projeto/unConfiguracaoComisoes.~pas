unit unConfiguracaoComisoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, ComCtrls, StdCtrls, ExtCtrls, ToolWin, ImgList, DBXpress;

type
  TfrmConfiguracaoComisoes = class(TForm)
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    imgLista: TImageList;
    ToolBar: TToolBar;
    tlBtnEditar: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnCancelar: TToolButton;
    pnlDados: TPanel;
    Label1: TLabel;
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
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edComissaoLocSegSexHC: TEdit;
    edComissaoLocSegSexHE: TEdit;
    edComissaoLocSabHC: TEdit;
    edComissaoLocSabHE: TEdit;
    edBonificacaoLocSegSexHC: TEdit;
    edBonificacaoLocSegSexHE: TEdit;
    edBonificacaoLocSabHC: TEdit;
    edBonificacaoLocSabHE: TEdit;
    edComissaoVenSegSexHC: TEdit;
    edComissaoVenSegSexHE: TEdit;
    edComissaoVenSabHC: TEdit;
    edComissaoVenSabHE: TEdit;
    edBonificacaoVenSegSexHC: TEdit;
    edBonificacaoVenSegSexHE: TEdit;
    edBonificacaoVenSabHC: TEdit;
    edBonificacaoVenSabHE: TEdit;
    Bevel1: TBevel;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure edComissaoLocSegSexHCEnter(Sender: TObject);
    procedure edBonificacaoLocSegSexHCEnter(Sender: TObject);
    procedure edComissaoLocSegSexHEEnter(Sender: TObject);
    procedure edBonificacaoLocSegSexHEEnter(Sender: TObject);
    procedure edComissaoLocSabHCEnter(Sender: TObject);
    procedure edBonificacaoLocSabHCEnter(Sender: TObject);
    procedure edComissaoLocSabHEEnter(Sender: TObject);
    procedure edBonificacaoLocSabHEEnter(Sender: TObject);
    procedure edComissaoVenSegSexHCEnter(Sender: TObject);
    procedure edBonificacaoVenSegSexHCEnter(Sender: TObject);
    procedure edComissaoVenSegSexHEEnter(Sender: TObject);
    procedure edBonificacaoVenSegSexHEEnter(Sender: TObject);
    procedure edComissaoVenSabHCEnter(Sender: TObject);
    procedure edBonificacaoVenSabHCEnter(Sender: TObject);
    procedure edComissaoVenSabHEEnter(Sender: TObject);
    procedure edBonificacaoVenSabHEEnter(Sender: TObject);
    procedure edComissaoLocSegSexHCExit(Sender: TObject);
    procedure edBonificacaoLocSegSexHCExit(Sender: TObject);
    procedure edComissaoLocSegSexHEExit(Sender: TObject);
    procedure edBonificacaoLocSegSexHEExit(Sender: TObject);
    procedure edComissaoLocSabHCExit(Sender: TObject);
    procedure edBonificacaoLocSabHCExit(Sender: TObject);
    procedure edComissaoLocSabHEExit(Sender: TObject);
    procedure edBonificacaoLocSabHEExit(Sender: TObject);
    procedure edComissaoVenSegSexHCExit(Sender: TObject);
    procedure edBonificacaoVenSegSexHCExit(Sender: TObject);
    procedure edComissaoVenSegSexHEExit(Sender: TObject);
    procedure edBonificacaoVenSegSexHEExit(Sender: TObject);
    procedure edComissaoVenSabHCExit(Sender: TObject);
    procedure edBonificacaoVenSabHCExit(Sender: TObject);
    procedure edComissaoVenSabHEExit(Sender: TObject);
    procedure edBonificacaoVenSabHEExit(Sender: TObject);
    procedure edComissaoLocSegSexHCKeyPress(Sender: TObject;
      var Key: Char);
    procedure edBonificacaoLocSegSexHCKeyPress(Sender: TObject;
      var Key: Char);
    procedure edComissaoLocSegSexHEKeyPress(Sender: TObject;
      var Key: Char);
    procedure edBonificacaoLocSegSexHEKeyPress(Sender: TObject;
      var Key: Char);
    procedure edComissaoLocSabHCKeyPress(Sender: TObject; var Key: Char);
    procedure edBonificacaoLocSabHCKeyPress(Sender: TObject;
      var Key: Char);
    procedure edComissaoLocSabHEKeyPress(Sender: TObject; var Key: Char);
    procedure edBonificacaoLocSabHEKeyPress(Sender: TObject;
      var Key: Char);
    procedure edComissaoVenSabHEKeyPress(Sender: TObject; var Key: Char);
    procedure edBonificacaoVenSabHEKeyPress(Sender: TObject;
      var Key: Char);
    procedure edComissaoVenSabHCKeyPress(Sender: TObject; var Key: Char);
    procedure edBonificacaoVenSabHCKeyPress(Sender: TObject;
      var Key: Char);
    procedure edComissaoVenSegSexHEKeyPress(Sender: TObject;
      var Key: Char);
    procedure edBonificacaoVenSegSexHEKeyPress(Sender: TObject;
      var Key: Char);
    procedure edComissaoVenSegSexHCKeyPress(Sender: TObject;
      var Key: Char);
    procedure edBonificacaoVenSegSexHCKeyPress(Sender: TObject;
      var Key: Char);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tlBtnSalvarClick(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress
    fechar: boolean; //se pode ou não fechar tela - casos de novo/editar, em que não pode fechar

    (*PROCEDURES DE CONTROLE*)
    procedure visibilidade(opc: Integer);//quais componentes exibir/ocultar
    procedure iniciaTransacao();//dispara uma transação
    procedure carrega();//carrega dados da tabela ConfiguracaoComissao para os componentes de apresentação
  public

  end;

var
  frmConfiguracaoComisoes: TfrmConfiguracaoComisoes;

implementation

uses unDM, DB;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{carrega dados da tabela ConfiguracaoComissao para os componentes de apresentação}
procedure TfrmConfiguracaoComisoes.carrega();
begin
  DM.qryConfiguracaoComissao.Close;
  DM.qryConfiguracaoComissao.SQL.Clear;
  DM.qryConfiguracaoComissao.SQL.Add('SELECT * FROM Configuracoes_Comissao WHERE codigo=1');
  DM.qryConfiguracaoComissao.Prepared := true;
  DM.qryConfiguracaoComissao.Open;
  DM.cdsConfiguracaoComissao.Open;
  DM.cdsConfiguracaoComissao.Refresh;

  edComissaoLocSegSexHC.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoCOMISSAO_LOC_HC_SEG_SEX.AsFloat);
  edBonificacaoLocSegSexHC.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoBONIFICACAO_LOC_HC_SEG_SEX.AsFloat);
  edComissaoLocSegSexHE.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoCOMISSAO_LOC_HE_SEG_SEX.AsFloat);
  edBonificacaoLocSegSexHE.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoBONIFICACAO_LOC_HE_SEG_SEX.AsFloat);
  edComissaoLocSabHC.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoCOMISSAO_LOC_HC_SAB.AsFloat);
  edBonificacaoLocSabHC.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoBONIFICACAO_LOC_HC_SAB.AsFloat);
  edComissaoLocSabHE.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoCOMISSAO_LOC_HE_SAB.AsFloat);
  edBonificacaoLocSabHE.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoBONIFICACAO_LOC_HE_SAB.AsFloat);
  edComissaoVenSegSexHC.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoCOMISSAO_VEN_HC_SEG_SEX.AsFloat);
  edBonificacaoVenSegSexHC.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoBONIFICACAO_VEN_HC_SEG_SEX.AsFloat);
  edComissaoVenSegSexHE.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoCOMISSAO_VEN_HE_SEG_SEX.AsFloat);
  edBonificacaoVenSegSexHE.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoBONIFICACAO_VEN_HE_SEG_SEX.AsFloat);
  edComissaoVenSabHC.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoCOMISSAO_VEN_HC_SAB.AsFloat);
  edBonificacaoVenSabHC.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoBONIFICACAO_VEN_HC_SAB.AsFloat);
  edComissaoVenSabHE.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoCOMISSAO_VEN_HE_SAB.AsFloat);
  edBonificacaoVenSabHE.Text := FormatFloat('#0.00',DM.cdsConfiguracaoComissaoBONIFICACAO_VEN_HE_SAB.AsFloat);
end;

{dispara uma transação}
procedure TfrmConfiguracaoComisoes.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

{quais componentes exibir/ocultar}
 procedure TfrmConfiguracaoComisoes.visibilidade(opc: Integer);
begin

  {
  11 = editar
  21 = salvar
  41 = cancelar
  }

  case opc of
    {editar}
    11:  begin
        pnlDados.Enabled := true;
        tlBtnEditar.Enabled := false;
        tlBtnSalvar.Enabled := true;
        tlBtnCancelar.Enabled := true;
        edComissaoLocSegSexHC.SetFocus;
        end;

    {salvar}
    21: begin
        pnlDados.Enabled := false;
        tlBtnEditar.Enabled := true;
        tlBtnSalvar.Enabled := false;
        tlBtnCancelar.Enabled := false;
        end;

    {cancelar}
    41: begin
        pnlDados.Enabled := false;
        tlBtnEditar.Enabled := true;
        tlBtnSalvar.Enabled := false;
        tlBtnCancelar.Enabled := false;
        end;
  end;//case
end;

(*FIM PROCEDURES DE CONTROLE*)


procedure TfrmConfiguracaoComisoes.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmConfiguracaoComisoes.edComissaoLocSegSexHCEnter(
  Sender: TObject);
begin
  edComissaoLocSegSexHC.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoLocSegSexHCEnter(
  Sender: TObject);
begin
  edBonificacaoLocSegSexHC.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edComissaoLocSegSexHEEnter(
  Sender: TObject);
begin
  edComissaoLocSegSexHE.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoLocSegSexHEEnter(
  Sender: TObject);
begin
  edBonificacaoLocSegSexHE.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edComissaoLocSabHCEnter(
  Sender: TObject);
begin
  edComissaoLocSabHC.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoLocSabHCEnter(
  Sender: TObject);
begin
  edBonificacaoLocSabHC.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edComissaoLocSabHEEnter(
  Sender: TObject);
begin
  edComissaoLocSabHE.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoLocSabHEEnter(
  Sender: TObject);
begin
  edBonificacaoLocSabHE.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edComissaoVenSegSexHCEnter(
  Sender: TObject);
begin
  edComissaoVenSegSexHC.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoVenSegSexHCEnter(
  Sender: TObject);
begin
  edBonificacaoVenSegSexHC.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edComissaoVenSegSexHEEnter(
  Sender: TObject);
begin
  edComissaoVenSegSexHE.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoVenSegSexHEEnter(
  Sender: TObject);
begin
  edBonificacaoVenSegSexHE.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edComissaoVenSabHCEnter(
  Sender: TObject);
begin
  edComissaoVenSabHC.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoVenSabHCEnter(
  Sender: TObject);
begin
  edBonificacaoVenSabHC.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edComissaoVenSabHEEnter(
  Sender: TObject);
begin
  edComissaoVenSabHE.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoVenSabHEEnter(
  Sender: TObject);
begin
  edBonificacaoVenSabHE.Color := clMoneyGreen;
end;

procedure TfrmConfiguracaoComisoes.edComissaoLocSegSexHCExit(
  Sender: TObject);
begin
  if (edComissaoLocSegSexHC.Text = '') then
    edComissaoLocSegSexHC.Text := '0,00'
  else
    begin
    try
      edComissaoLocSegSexHC.Text := FormatFloat('#0.00',StrToFloat(edComissaoLocSegSexHC.Text));
    except
    end;
    end;

  edComissaoLocSegSexHC.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoLocSegSexHCExit(
  Sender: TObject);
begin
  if (edBonificacaoLocSegSexHC.Text = '') then
    edBonificacaoLocSegSexHC.Text := '0,00'
  else
    begin
    try
      edBonificacaoLocSegSexHC.Text := FormatFloat('#0.00',StrToFloat(edBonificacaoLocSegSexHC.Text));
    except
    end;
    end;

  edBonificacaoLocSegSexHC.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edComissaoLocSegSexHEExit(
  Sender: TObject);
begin
  if (edComissaoLocSegSexHE.Text = '') then
    edComissaoLocSegSexHE.Text := '0,00'
  else
    begin
    try
      edComissaoLocSegSexHE.Text := FormatFloat('#0.00',StrToFloat(edComissaoLocSegSexHE.Text));
    except
    end;
    end;

  edComissaoLocSegSexHE.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoLocSegSexHEExit(
  Sender: TObject);
begin
  if (edBonificacaoLocSegSexHE.Text = '') then
    edBonificacaoLocSegSexHE.Text := '0,00'
  else
    begin
    try
      edBonificacaoLocSegSexHE.Text := FormatFloat('#0.00',StrToFloat(edBonificacaoLocSegSexHE.Text));
    except
    end;
    end;

  edBonificacaoLocSegSexHE.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edComissaoLocSabHCExit(Sender: TObject);
begin
  if (edComissaoLocSabHC.Text = '') then
    edComissaoLocSabHC.Text := '0,00'
  else
    begin
    try
      edComissaoLocSabHC.Text := FormatFloat('#0.00',StrToFloat(edComissaoLocSabHC.Text));
    except
    end;
    end;

  edComissaoLocSabHC.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoLocSabHCExit(
  Sender: TObject);
begin
  if (edBonificacaoLocSabHC.Text = '') then
    edBonificacaoLocSabHC.Text := '0,00'
  else
    begin
    try
      edBonificacaoLocSabHC.Text := FormatFloat('#0.00',StrToFloat(edBonificacaoLocSabHC.Text));
    except
    end;
    end;

  edBonificacaoLocSabHC.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edComissaoLocSabHEExit(Sender: TObject);
begin
  if (edComissaoLocSabHE.Text = '') then
    edComissaoLocSabHE.Text := '0,00'
  else
    begin
    try
      edComissaoLocSabHE.Text := FormatFloat('#0.00',StrToFloat(edComissaoLocSabHE.Text));
    except
    end;
    end;

  edComissaoLocSabHE.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoLocSabHEExit(
  Sender: TObject);
begin
  if (edBonificacaoLocSabHE.Text = '') then
    edBonificacaoLocSabHE.Text := '0,00'
  else
    begin
    try
      edBonificacaoLocSabHE.Text := FormatFloat('#0.00',StrToFloat(edBonificacaoLocSabHE.Text));
    except
    end;
    end;

  edBonificacaoLocSabHE.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edComissaoVenSegSexHCExit(
  Sender: TObject);
begin
  if (edComissaoVenSegSexHC.Text = '') then
    edComissaoVenSegSexHC.Text := '0,00'
  else
    begin
    try
      edComissaoVenSegSexHC.Text := FormatFloat('#0.00',StrToFloat(edComissaoVenSegSexHC.Text));
    except
    end;
    end;

  edComissaoVenSegSexHC.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoVenSegSexHCExit(
  Sender: TObject);
begin
  if (edBonificacaoVenSegSexHC.Text = '') then
    edBonificacaoVenSegSexHC.Text := '0,00'
  else
    begin
    try
      edBonificacaoVenSegSexHC.Text := FormatFloat('#0.00',StrToFloat(edBonificacaoVenSegSexHC.Text));
    except
    end;
    end;

  edBonificacaoVenSegSexHC.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edComissaoVenSegSexHEExit(
  Sender: TObject);
begin
  if (edComissaoVenSegSexHE.Text = '') then
    edComissaoVenSegSexHE.Text := '0,00'
  else
    begin
    try
      edComissaoVenSegSexHE.Text := FormatFloat('#0.00',StrToFloat(edComissaoVenSegSexHE.Text));
    except
    end;
    end;

  edComissaoVenSegSexHE.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoVenSegSexHEExit(
  Sender: TObject);
begin
  if (edBonificacaoVenSegSexHE.Text = '') then
    edBonificacaoVenSegSexHE.Text := '0,00'
  else
    begin
    try
      edBonificacaoVenSegSexHE.Text := FormatFloat('#0.00',StrToFloat(edBonificacaoVenSegSexHE.Text));
    except
    end;
    end;

  edBonificacaoVenSegSexHE.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edComissaoVenSabHCExit(Sender: TObject);
begin
  if (edComissaoVenSabHC.Text = '') then
    edComissaoVenSabHC.Text := '0,00'
  else
    begin
    try
      edComissaoVenSabHC.Text := FormatFloat('#0.00',StrToFloat(edComissaoVenSabHC.Text));
    except
    end;
    end;

  edComissaoVenSabHC.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoVenSabHCExit(
  Sender: TObject);
begin
  if (edBonificacaoVenSabHC.Text = '') then
    edBonificacaoVenSabHC.Text := '0,00'
  else
    begin
    try
      edBonificacaoVenSabHC.Text := FormatFloat('#0.00',StrToFloat(edBonificacaoVenSabHC.Text));
    except
    end;
    end;

  edBonificacaoVenSabHC.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edComissaoVenSabHEExit(Sender: TObject);
begin
  if (edComissaoVenSabHE.Text = '') then
    edComissaoVenSabHE.Text := '0,00'
  else
    begin
    try
      edComissaoVenSabHE.Text := FormatFloat('#0.00',StrToFloat(edComissaoVenSabHE.Text));
    except
    end;
    end;

  edComissaoVenSabHE.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoVenSabHEExit(
  Sender: TObject);
begin
  if (edBonificacaoVenSabHE.Text = '') then
    edBonificacaoVenSabHE.Text := '0,00'
  else
    begin
    try
      edBonificacaoVenSabHE.Text := FormatFloat('#0.00',StrToFloat(edBonificacaoVenSabHE.Text));
    except
    end;
    end;

  edBonificacaoVenSabHE.Color := clWindow;
end;

procedure TfrmConfiguracaoComisoes.edComissaoLocSegSexHCKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoLocSegSexHCKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edComissaoLocSegSexHEKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoLocSegSexHEKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edComissaoLocSabHCKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoLocSabHCKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edComissaoLocSabHEKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoLocSabHEKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edComissaoVenSabHEKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoVenSabHEKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edComissaoVenSabHCKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoVenSabHCKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edComissaoVenSegSexHEKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoVenSegSexHEKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edComissaoVenSegSexHCKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.edBonificacaoVenSegSexHCKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmConfiguracaoComisoes.tlBtnEditarClick(Sender: TObject);
begin
  {preparando}
  visibilidade(11);
  fechar := false;
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Edição';
end;

procedure TfrmConfiguracaoComisoes.tlBtnCancelarClick(Sender: TObject);
begin
  carrega();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmConfiguracaoComisoes.FormShow(Sender: TObject);
begin
  carrega();

  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmConfiguracaoComisoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (fechar = false) then
    begin
    MessageDlg('Salve ou cancele antes o processo que se encontra em operação!',mtInformation,[mbOK],0);
    Action := caNone;
    end;
end;

procedure TfrmConfiguracaoComisoes.tlBtnSalvarClick(Sender: TObject);
begin
  try
    iniciaTransacao();
    DM.SQLConnection.StartTransaction(transacao);

    DM.qryConfiguracaoComissao.Close;
    DM.qryConfiguracaoComissao.SQL.Clear;
    DM.qryConfiguracaoComissao.SQL.Add('UPDATE Configuracoes_Comissao SET COMISSAO_LOC_HC_SEG_SEX=:c1,COMISSAO_LOC_HE_SEG_SEX=:c2, ');
    DM.qryConfiguracaoComissao.SQL.Add('COMISSAO_LOC_HC_SAB=:c3,COMISSAO_LOC_HE_SAB=:c4,COMISSAO_VEN_HC_SEG_SEX=:c5,COMISSAO_VEN_HE_SEG_SEX=:c6, ');
    DM.qryConfiguracaoComissao.SQL.Add('COMISSAO_VEN_HC_SAB=:c7,COMISSAO_VE_HE_SAB=:c8,BONIFICACAO_LOC_HC_SEG_SEX=:b1,BONIFICACAO_LOC_HE_SEG_SEX=:b2, ');
    DM.qryConfiguracaoComissao.SQL.Add('BONIFICACAO_LOC_HC_SAB=:b3,BONIFICACAO_LOC_HE_SAB=:b4,BONIFICACAO_VEN_HC_SEG_SEX=:b5, ');
    DM.qryConfiguracaoComissao.SQL.Add('BONIFICACAO_VEN_HE_SEG_SEX=:b6,BONIFICACAO_VEN_HC_SAB=:b7,BONIFICACAO_VE_HE_SAB=:b8 ');
    DM.qryConfiguracaoComissao.SQL.Add('WHERE CODIGO=:cod');
    DM.qryConfiguracaoComissao.ParamByName('c1').AsFloat := StrToFloat(edComissaoLocSegSexHC.Text);
    DM.qryConfiguracaoComissao.ParamByName('c2').AsFloat := StrToFloat(edComissaoLocSegSexHE.Text);
    DM.qryConfiguracaoComissao.ParamByName('c3').AsFloat := StrToFloat(edComissaoLocSabHC.Text);
    DM.qryConfiguracaoComissao.ParamByName('c4').AsFloat := StrToFloat(edComissaoLocSabHE.Text);
    DM.qryConfiguracaoComissao.ParamByName('c5').AsFloat := StrToFloat(edComissaoVenSegSexHC.Text);
    DM.qryConfiguracaoComissao.ParamByName('c6').AsFloat := StrToFloat(edComissaoVenSegSexHE.Text);
    DM.qryConfiguracaoComissao.ParamByName('c7').AsFloat := StrToFloat(edComissaoVenSabHC.Text);
    DM.qryConfiguracaoComissao.ParamByName('c8').AsFloat := StrToFloat(edComissaoVenSabHE.Text);
    DM.qryConfiguracaoComissao.ParamByName('b1').AsFloat := StrToFloat(edBonificacaoLocSegSexHC.Text);
    DM.qryConfiguracaoComissao.ParamByName('b2').AsFloat := StrToFloat(edBonificacaoLocSegSexHE.Text);
    DM.qryConfiguracaoComissao.ParamByName('b3').AsFloat := StrToFloat(edBonificacaoLocSabHC.Text);
    DM.qryConfiguracaoComissao.ParamByName('b4').AsFloat := StrToFloat(edBonificacaoLocSabHE.Text);
    DM.qryConfiguracaoComissao.ParamByName('b5').AsFloat := StrToFloat(edBonificacaoVenSegSexHC.Text);
    DM.qryConfiguracaoComissao.ParamByName('b6').AsFloat := StrToFloat(edBonificacaoVenSegSexHE.Text);
    DM.qryConfiguracaoComissao.ParamByName('b7').AsFloat := StrToFloat(edBonificacaoVenSabHC.Text);
    DM.qryConfiguracaoComissao.ParamByName('b8').AsFloat := StrToFloat(edBonificacaoVenSabHE.Text);
    DM.qryConfiguracaoComissao.ParamByName('cod').AsInteger := 1;
    DM.qryConfiguracaoComissao.Prepared := true;
    DM.qryConfiguracaoComissao.ExecSQL();

    DM.SQLConnection.Commit(transacao);
    visibilidade(21);
    fechar := true;
    carrega();
    MessageDlg('Configuração das Comissões salva com sucesso!',mtInformation,[mbOK],0);
  except
    MessageDlg('Configuração das Comissões não pode ser salva!',mtError,[mbOK],0);
    DM.SQLConnection.Rollback(transacao);
  end;                                                                                 
end;

end.
