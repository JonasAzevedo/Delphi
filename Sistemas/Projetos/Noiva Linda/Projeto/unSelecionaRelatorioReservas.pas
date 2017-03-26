unit unSelecionaRelatorioReservas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, RpCon, RpConDS, RpBase, RpSystem, RpDefine, RpRave,
  DBClient, Provider, DB, SqlExpr, AppEvnts, ComCtrls, StdCtrls, Mask,
  Buttons, ExtCtrls;

type
  TfrmSelecionaRelatorioReservas = class(TForm)
    pnlVenda: TPanel;
    Label3: TLabel;
    Label10: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label11: TLabel;
    Bevel1: TBevel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label1: TLabel;
    edCliente: TEdit;
    btBtnNova: TBitBtn;
    edValorTotalReserva1: TEdit;
    mEdDataInicio1: TMaskEdit;
    btBtnGerar: TBitBtn;
    edValorTotalReserva2: TEdit;
    mEdDataInicio2: TMaskEdit;
    btBtnAbreCliente: TBitBtn;
    rdBtnReservaResumo: TRadioButton;
    rdBtnReservasDetalhado: TRadioButton;
    mEdDataFinal1: TMaskEdit;
    mEdDataFinal2: TMaskEdit;
    ckBxMasculino: TCheckBox;
    ckBxFeminino: TCheckBox;
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    qryReservaResumo: TSQLQuery;
    dspReservaResumo: TDataSetProvider;
    cdsReservaResumo: TClientDataSet;
    RvProject: TRvProject;
    RvSystem: TRvSystem;
    rvDtStConQryReservaResumo: TRvDataSetConnection;
    rvDtStConQryProdutosRes: TRvDataSetConnection;
    qryProduto: TSQLQuery;
    dspProduto: TDataSetProvider;
    cdsProduto: TClientDataSet;
    qryProdutocod_Item: TIntegerField;
    qryProdutoCOD_RESERVA: TIntegerField;
    qryProdutoVALOR_TOTAL: TFMTBCDField;
    qryProdutocod_Produto: TIntegerField;
    qryProdutocod2_Produto: TStringField;
    qryProdutoNOME: TStringField;
    qryProdutoDESCRICAO: TStringField;
    qryProdutoMARCA: TStringField;
    qryProdutoTAMANHO: TIntegerField;
    qryProdutoTIPO: TStringField;
    cdsProdutocod_Item: TIntegerField;
    cdsProdutoCOD_RESERVA: TIntegerField;
    cdsProdutoVALOR_TOTAL: TFMTBCDField;
    cdsProdutocod_Produto: TIntegerField;
    cdsProdutocod2_Produto: TStringField;
    cdsProdutoNOME: TStringField;
    cdsProdutoDESCRICAO: TStringField;
    cdsProdutoMARCA: TStringField;
    cdsProdutoTAMANHO: TIntegerField;
    cdsProdutoTIPO: TStringField;
    qryReservaResumoCODIGO: TIntegerField;
    qryReservaResumoDATA_INICIO: TSQLTimeStampField;
    qryReservaResumoDATA_FINAL: TSQLTimeStampField;
    qryReservaResumoSEXO: TStringField;
    qryReservaResumoOBSERVACOES: TStringField;
    qryReservaResumoVALOR_TOTAL: TFMTBCDField;
    qryReservaResumoVALOR_PAGO: TFMTBCDField;
    qryReservaResumoValor_Resta: TFMTBCDField;
    qryReservaResumoNOME: TStringField;
    cdsReservaResumoCODIGO: TIntegerField;
    cdsReservaResumoDATA_INICIO: TSQLTimeStampField;
    cdsReservaResumoDATA_FINAL: TSQLTimeStampField;
    cdsReservaResumoSEXO: TStringField;
    cdsReservaResumoOBSERVACOES: TStringField;
    cdsReservaResumoVALOR_TOTAL: TFMTBCDField;
    cdsReservaResumoVALOR_PAGO: TFMTBCDField;
    cdsReservaResumoValor_Resta: TFMTBCDField;
    cdsReservaResumoNOME: TStringField;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edClienteEnter(Sender: TObject);
    procedure edClienteExit(Sender: TObject);
    procedure btBtnAbreClienteClick(Sender: TObject);
    procedure mEdDataInicio1Enter(Sender: TObject);
    procedure mEdDataInicio2Enter(Sender: TObject);
    procedure mEdDataFinal1Enter(Sender: TObject);
    procedure mEdDataFinal2Enter(Sender: TObject);
    procedure edValorTotalReserva1Enter(Sender: TObject);
    procedure edValorTotalReserva2Enter(Sender: TObject);
    procedure mEdDataInicio1Exit(Sender: TObject);
    procedure mEdDataInicio2Exit(Sender: TObject);
    procedure mEdDataFinal1Exit(Sender: TObject);
    procedure mEdDataFinal2Exit(Sender: TObject);
    procedure edValorTotalReserva1KeyPress(Sender: TObject; var Key: Char);
    procedure edValorTotalReserva2KeyPress(Sender: TObject; var Key: Char);
    procedure edValorTotalReserva1Exit(Sender: TObject);
    procedure edValorTotalReserva2Exit(Sender: TObject);
    procedure btBtnNovaClick(Sender: TObject);
    procedure btBtnGerarClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
  private
    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
  public
    codCliente: Integer; //controle do Cliente
  end;

var
  frmSelecionaRelatorioReservas: TfrmSelecionaRelatorioReservas;

implementation

uses unSelecionaCliente, unRelatorioLocacaoResumo,
  unRelatorioReservaResumo;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)
procedure TfrmSelecionaRelatorioReservas.limpar();
begin
  Self.codCliente := 0;
  rdBtnReservaResumo.Checked := true;
  rdBtnReservasDetalhado.Checked := false;
  edCliente.Clear;
  ckBxMasculino.Checked := true;
  ckBxFeminino.Checked := true;
  mEdDataInicio1.Clear;
  mEdDataInicio2.Clear;
  mEdDataFinal1.Clear;
  mEdDataFinal2.Clear;
  edValorTotalReserva1.Clear;
  edValorTotalReserva2.Clear;
end;
(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaRelatorioReservas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=27) then
    Self.Close;
end;

procedure TfrmSelecionaRelatorioReservas.FormShow(Sender: TObject);
begin
  Self.limpar();
end;

procedure TfrmSelecionaRelatorioReservas.edClienteEnter(Sender: TObject);
begin
  edCliente.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioReservas.edClienteExit(Sender: TObject);
begin
  edCliente.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioReservas.btBtnAbreClienteClick(
  Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaCliente,frmSelecionaCliente);
  frmSelecionaCliente.tela := 'relatorioReserva';
  frmSelecionaCliente.ShowModal;
  frmSelecionaCliente.Free;
end;

procedure TfrmSelecionaRelatorioReservas.mEdDataInicio1Enter(
  Sender: TObject);
begin
  mEdDataInicio1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioReservas.mEdDataInicio2Enter(
  Sender: TObject);
begin
  mEdDataInicio2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioReservas.mEdDataFinal1Enter(
  Sender: TObject);
begin
  mEdDataFinal1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioReservas.mEdDataFinal2Enter(
  Sender: TObject);
begin
  mEdDataFinal2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioReservas.edValorTotalReserva1Enter(
  Sender: TObject);
begin
  edValorTotalReserva1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioReservas.edValorTotalReserva2Enter(
  Sender: TObject);
begin
  edValorTotalReserva2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioReservas.mEdDataInicio1Exit(
  Sender: TObject);
begin
  mEdDataInicio1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioReservas.mEdDataInicio2Exit(
  Sender: TObject);
begin
  mEdDataInicio2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioReservas.mEdDataFinal1Exit(
  Sender: TObject);
begin
  mEdDataFinal1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioReservas.mEdDataFinal2Exit(
  Sender: TObject);
begin
  mEdDataFinal2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioReservas.edValorTotalReserva1KeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmSelecionaRelatorioReservas.edValorTotalReserva2KeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmSelecionaRelatorioReservas.edValorTotalReserva1Exit(
  Sender: TObject);
begin
  try
    edValorTotalReserva1.Text := FormatFloat('#0.00',StrToFloat(edValorTotalReserva1.Text));
  except
  end;

  edValorTotalReserva1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioReservas.edValorTotalReserva2Exit(
  Sender: TObject);
begin
  try
    edValorTotalReserva2.Text := FormatFloat('#0.00',StrToFloat(edValorTotalReserva2.Text));
  except
  end;

  edValorTotalReserva2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioReservas.btBtnNovaClick(Sender: TObject);
begin
  Self.limpar();
end;

procedure TfrmSelecionaRelatorioReservas.btBtnGerarClick(Sender: TObject);
var
  continua: boolean;
begin
  continua := true;
  //verificando se pode-se realizar pesquisa
  if ((ckBxMasculino.Checked=false)and(ckBxFeminino.Checked=false))then
    begin
    MessageDlg('Selecione pelo menos um Sexo!',mtInformation,[mbOK],0);
    continua := false;
    end;

  if(continua=true)then
    begin
    qryReservaResumo.Close;
    qryReservaResumo.SQL.Clear;
    qryReservaResumo.SQL.Add('SELECT r.codigo,r.data_inicio,r.data_final,r.sexo,r.observacoes,r.valor_total,r.valor_pago, ');
    qryReservaResumo.SQL.Add('(r.valor_total-r.valor_pago) AS "Valor_Resta",c.nome ');
    qryReservaResumo.SQL.Add('FROM reserva r, cliente c ');
    qryReservaResumo.SQL.Add('WHERE r.cod_cliente=c.codigo ');

    //cliente
    if (Self.codCliente<>0) then
      begin
      qryReservaResumo.SQL.Add('AND r.cod_cliente=:codCli ');
      qryReservaResumo.ParamByName('codCli').AsInteger := Self.codCliente;
      end;
    //sexo
    if ((ckBxMasculino.Checked=true)and(ckBxFeminino.Checked=false))then
      begin
      qryReservaResumo.SQL.Add('AND r.sexo=:sex ');
      qryReservaResumo.ParamByName('sex').AsString := 'Masculino';
      end
    else if ((ckBxMasculino.Checked=false)and(ckBxFeminino.Checked=true))then
      begin
      qryReservaResumo.SQL.Add('AND r.sexo=:sex ');
      qryReservaResumo.ParamByName('sex').AsString := 'Feminino';
      end
    else if ((ckBxMasculino.Checked=true)and(ckBxFeminino.Checked=true))then
      begin
      qryReservaResumo.SQL.Add('AND ((r.sexo=:sex1)OR(r.sexo=:sex2)) ');
      qryReservaResumo.ParamByName('sex1').AsString := 'Masculino';
      qryReservaResumo.ParamByName('sex2').AsString := 'Feminino';
      end;
    //data início
    if ((mEdDataInicio1.Text <> '  /  /    ')and(mEdDataInicio2.Text <> '  /  /    '))then
      begin
      qryReservaResumo.SQL.Add('AND CAST (r.data_inicio AS DATE) BETWEEN :dtIni1 AND :dtIni2 ');
      qryReservaResumo.ParamByName('dtIni1').AsDate := StrToDate(mEdDataInicio1.Text);
      qryReservaResumo.ParamByName('dtIni2').AsDate := StrToDate(mEdDataInicio2.Text);
      end;
    //data final
    if ((mEdDataFinal1.Text <> '  /  /    ')and(mEdDataFinal2.Text <> '  /  /    '))then
      begin
      qryReservaResumo.SQL.Add('AND CAST (r.data_final AS DATE) BETWEEN :dtFin1 AND :dtFin2 ');
      qryReservaResumo.ParamByName('dtFin1').AsDate := StrToDate(mEdDataFinal1.Text);
      qryReservaResumo.ParamByName('dtFin2').AsDate := StrToDate(mEdDataFinal2.Text);
      end;
    //valor total
    if ((edValorTotalReserva1.Text <> '')and(edValorTotalReserva2.Text <> ''))then
      begin
      qryReservaResumo.SQL.Add('AND r.valor_total BETWEEN :valTot1 AND :valTot2 ');
      qryReservaResumo.ParamByName('valTot1').AsFloat := StrToFloat(edValorTotalReserva1.Text);
      qryReservaResumo.ParamByName('valTot2').AsFloat := StrToFloat(edValorTotalReserva2.Text);
      end;

    qryReservaResumo.SQL.Add('ORDER BY r.data_inicio');

    qryReservaResumo.Prepared := true;
    qryReservaResumo.Open;
    cdsReservaResumo.Open;
    cdsReservaResumo.Refresh;

    if (cdsReservaResumo.RecordCount <> 0) then
      begin
      if (rdBtnReservaResumo.Checked=true) then
        begin
        Application.CreateForm(TqckRepRelatorioReservaResumo,qckRepRelatorioReservaResumo);
        qckRepRelatorioReservaResumo.qrLblRegistros.Caption := IntToStr(cdsReservaResumo.RecordCount);
        qckRepRelatorioReservaResumo.Prepare;
        qckRepRelatorioReservaResumo.Preview;
        qckRepRelatorioReservaResumo.Free;
        end
      else if (rdBtnReservasDetalhado.Checked=true) then
        begin
        RvProject.ProjectFile := 'C:\Noiva Linda\Relatórios\rave_reservas_com_itens.rav';
        RvProject.Execute;
        end;
      end
    else
      MessageDlg('Nenhum Registro encontrado!',mtInformation,[mbOK],0);
    end;
end;


procedure TfrmSelecionaRelatorioReservas.ApplicationEventsHint(
  Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

end.
