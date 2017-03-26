unit unSelecionaRelatorioLocacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, StdCtrls, ComCtrls, RpCon, RpConDS, RpBase, RpSystem,
  RpDefine, RpRave, DBClient, Provider, DB, SqlExpr, AppEvnts, Mask,
  Buttons, ExtCtrls;

type
  TfrmSelecionaRelatorioLocacoes = class(TForm)
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
    edCliente: TEdit;
    btBtnNova: TBitBtn;
    edValorTotalLocacao1: TEdit;
    mEdDataInicio1: TMaskEdit;
    btBtnGerar: TBitBtn;
    edValorTotalLocacao2: TEdit;
    mEdDataInicio2: TMaskEdit;
    btBtnAbreCliente: TBitBtn;
    rdBtnLocacaoResumo: TRadioButton;
    rdBtnLocacaoDetalhado: TRadioButton;
    mEdDataFinal1: TMaskEdit;
    mEdDataFinal2: TMaskEdit;
    ApplicationEvents: TApplicationEvents;
    qryLocacaoResumo: TSQLQuery;
    dspLocacaoResumo: TDataSetProvider;
    cdsLocacaoResumo: TClientDataSet;
    RvProject: TRvProject;
    RvSystem: TRvSystem;
    rvDtStConQryLocacaoResumo: TRvDataSetConnection;
    rvDtStConQryProdutosLoc: TRvDataSetConnection;
    qryProduto: TSQLQuery;
    dspProduto: TDataSetProvider;
    cdsProduto: TClientDataSet;
    StatusBar: TStatusBar;
    Label1: TLabel;
    ckBxMasculino: TCheckBox;
    ckBxFeminino: TCheckBox;
    cdsLocacaoResumoCODIGO: TIntegerField;
    cdsLocacaoResumoDATA_INICIO: TSQLTimeStampField;
    cdsLocacaoResumoDATA_FINAL: TSQLTimeStampField;
    cdsLocacaoResumoSEXO: TStringField;
    cdsLocacaoResumoOBSERVACOES: TStringField;
    cdsLocacaoResumoVALOR_TOTAL: TFMTBCDField;
    cdsLocacaoResumoVALOR_PAGO: TFMTBCDField;
    cdsLocacaoResumoValor_Resta: TFMTBCDField;
    cdsLocacaoResumoSTATUS: TIntegerField;
    cdsLocacaoResumoNOME: TStringField;
    qryProdutocod_Item: TIntegerField;
    qryProdutoCOD_LOCACAO: TIntegerField;
    qryProdutoVALOR_TOTAL: TFMTBCDField;
    qryProdutocod_Produto: TIntegerField;
    qryProdutocod2_Produto: TStringField;
    qryProdutoNOME: TStringField;
    qryProdutoDESCRICAO: TStringField;
    qryProdutoMARCA: TStringField;
    qryProdutoTAMANHO: TIntegerField;
    qryProdutoTIPO: TStringField;
    cdsProdutocod_Item: TIntegerField;
    cdsProdutoCOD_LOCACAO: TIntegerField;
    cdsProdutoVALOR_TOTAL: TFMTBCDField;
    cdsProdutocod_Produto: TIntegerField;
    cdsProdutocod2_Produto: TStringField;
    cdsProdutoNOME: TStringField;
    cdsProdutoDESCRICAO: TStringField;
    cdsProdutoMARCA: TStringField;
    cdsProdutoTAMANHO: TIntegerField;
    cdsProdutoTIPO: TStringField;
    Label2: TLabel;
    ckBxFinalizado: TCheckBox;
    ckBxAberta: TCheckBox;
    qryLocacaoResumoCODIGO: TIntegerField;
    qryLocacaoResumoDATA_INICIO: TSQLTimeStampField;
    qryLocacaoResumoDATA_FINAL: TSQLTimeStampField;
    qryLocacaoResumoSEXO: TStringField;
    qryLocacaoResumoOBSERVACOES: TStringField;
    qryLocacaoResumoVALOR_TOTAL: TFMTBCDField;
    qryLocacaoResumoVALOR_PAGO: TFMTBCDField;
    qryLocacaoResumoValor_Resta: TFMTBCDField;
    qryLocacaoResumoSTATUS: TIntegerField;
    qryLocacaoResumoNOME: TStringField;
    procedure ApplicationEventsHint(Sender: TObject);
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
    procedure edValorTotalLocacao1Enter(Sender: TObject);
    procedure edValorTotalLocacao2Enter(Sender: TObject);
    procedure edValorTotalLocacao1KeyPress(Sender: TObject; var Key: Char);
    procedure edValorTotalLocacao2KeyPress(Sender: TObject; var Key: Char);
    procedure edValorTotalLocacao2Exit(Sender: TObject);
    procedure edValorTotalLocacao1Exit(Sender: TObject);
    procedure btBtnNovaClick(Sender: TObject);
    procedure mEdDataInicio1Exit(Sender: TObject);
    procedure mEdDataInicio2Exit(Sender: TObject);
    procedure mEdDataFinal1Exit(Sender: TObject);
    procedure mEdDataFinal2Exit(Sender: TObject);
    procedure btBtnGerarClick(Sender: TObject);
  private
    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
  public
    codCliente: Integer; //controle do Cliente
  end;

var
  frmSelecionaRelatorioLocacoes: TfrmSelecionaRelatorioLocacoes;

implementation

uses unSelecionaCliente, unRelatorioLocacaoResumo;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)
procedure TfrmSelecionaRelatorioLocacoes.limpar();
begin
  Self.codCliente := 0;
  rdBtnLocacaoResumo.Checked := true;
  rdBtnLocacaoDetalhado.Checked := false;
  edCliente.Clear;
  ckBxMasculino.Checked := true;
  ckBxFeminino.Checked := true;
  mEdDataInicio1.Clear;
  mEdDataInicio2.Clear;
  mEdDataFinal1.Clear;
  mEdDataFinal2.Clear;
  edValorTotalLocacao1.Clear;
  edValorTotalLocacao2.Clear;
  ckBxFinalizado.Checked := true;
  ckBxAberta.Checked := true;
end;
(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaRelatorioLocacoes.ApplicationEventsHint(
  Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaRelatorioLocacoes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=27) then
    Self.Close;
end;

procedure TfrmSelecionaRelatorioLocacoes.FormShow(Sender: TObject);
begin
  Self.limpar();
end;

procedure TfrmSelecionaRelatorioLocacoes.edClienteEnter(Sender: TObject);
begin
  edCliente.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioLocacoes.edClienteExit(Sender: TObject);
begin
  edCliente.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioLocacoes.btBtnAbreClienteClick(
  Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaCliente,frmSelecionaCliente);
  frmSelecionaCliente.tela := 'relatorioLocacao';
  frmSelecionaCliente.ShowModal;
  frmSelecionaCliente.Free;
end;

procedure TfrmSelecionaRelatorioLocacoes.mEdDataInicio1Enter(
  Sender: TObject);
begin
  mEdDataInicio1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioLocacoes.mEdDataInicio2Enter(
  Sender: TObject);
begin
  mEdDataInicio2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioLocacoes.mEdDataFinal1Enter(
  Sender: TObject);
begin
  mEdDataFinal1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioLocacoes.mEdDataFinal2Enter(
  Sender: TObject);
begin
  mEdDataFinal2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioLocacoes.edValorTotalLocacao1Enter(
  Sender: TObject);
begin
  edValorTotalLocacao1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioLocacoes.edValorTotalLocacao2Enter(
  Sender: TObject);
begin
  edValorTotalLocacao2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioLocacoes.edValorTotalLocacao1KeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmSelecionaRelatorioLocacoes.edValorTotalLocacao2KeyPress(
  Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmSelecionaRelatorioLocacoes.edValorTotalLocacao2Exit(
  Sender: TObject);
begin
  try
    edValorTotalLocacao2.Text := FormatFloat('#0.00',StrToFloat(edValorTotalLocacao2.Text));
  except
  end;

  edValorTotalLocacao2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioLocacoes.edValorTotalLocacao1Exit(
  Sender: TObject);
begin
  try
    edValorTotalLocacao1.Text := FormatFloat('#0.00',StrToFloat(edValorTotalLocacao1.Text));
  except
  end;

  edValorTotalLocacao1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioLocacoes.btBtnNovaClick(Sender: TObject);
begin
  Self.limpar();
end;

procedure TfrmSelecionaRelatorioLocacoes.mEdDataInicio1Exit(
  Sender: TObject);
begin
  mEdDataInicio1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioLocacoes.mEdDataInicio2Exit(
  Sender: TObject);
begin
  mEdDataInicio2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioLocacoes.mEdDataFinal1Exit(
  Sender: TObject);
begin
  mEdDataFinal1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioLocacoes.mEdDataFinal2Exit(
  Sender: TObject);
begin
  mEdDataFinal2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioLocacoes.btBtnGerarClick(Sender: TObject);
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
  if ((ckBxFinalizado.Checked=false)and(ckBxAberta.Checked=false))then
    begin
    MessageDlg('Selecione pelo menos um Status!',mtInformation,[mbOK],0);
    continua := false;
    end;

  if(continua=true)then
    begin
    qryLocacaoResumo.Close;
    qryLocacaoResumo.SQL.Clear;
    qryLocacaoResumo.SQL.Add('SELECT l.codigo,l.data_inicio,l.data_final,l.sexo,l.observacoes,l.valor_total,l.valor_pago, ');
    qryLocacaoResumo.SQL.Add('(l.valor_total-l.valor_pago) AS "Valor_Resta",l.status,c.nome ');
    qryLocacaoResumo.SQL.Add('FROM locacao l, cliente c ');
    qryLocacaoResumo.SQL.Add('WHERE l.cod_cliente=c.codigo ');
    //cliente
    if (Self.codCliente<>0) then
      begin
      qryLocacaoResumo.SQL.Add('AND l.cod_cliente=:codCli ');
      qryLocacaoResumo.ParamByName('codCli').AsInteger := Self.codCliente;
      end;
    //sexo
    if ((ckBxMasculino.Checked=true)and(ckBxFeminino.Checked=false))then
      begin
      qryLocacaoResumo.SQL.Add('AND l.sexo=:sex ');
      qryLocacaoResumo.ParamByName('sex').AsString := 'Masculino';
      end
    else if ((ckBxMasculino.Checked=false)and(ckBxFeminino.Checked=true))then
      begin
      qryLocacaoResumo.SQL.Add('AND l.sexo=:sex ');
      qryLocacaoResumo.ParamByName('sex').AsString := 'Feminino';
      end
    else if ((ckBxMasculino.Checked=true)and(ckBxFeminino.Checked=true))then
      begin
      qryLocacaoResumo.SQL.Add('AND ((l.sexo=:sex1)OR(l.sexo=:sex2)) ');
      qryLocacaoResumo.ParamByName('sex1').AsString := 'Masculino';
      qryLocacaoResumo.ParamByName('sex2').AsString := 'Feminino';
      end;
    //data início
    if ((mEdDataInicio1.Text <> '  /  /    ')and(mEdDataInicio2.Text <> '  /  /    '))then
      begin
      qryLocacaoResumo.SQL.Add('AND CAST (l.data_inicio AS DATE) BETWEEN :dtIni1 AND :dtIni2 ');
      qryLocacaoResumo.ParamByName('dtIni1').AsDate := StrToDate(mEdDataInicio1.Text);
      qryLocacaoResumo.ParamByName('dtIni2').AsDate := StrToDate(mEdDataInicio2.Text);
      end;
    //data final
    if ((mEdDataFinal1.Text <> '  /  /    ')and(mEdDataFinal2.Text <> '  /  /    '))then
      begin
      qryLocacaoResumo.SQL.Add('AND CAST (l.data_final AS DATE) BETWEEN :dtFin1 AND :dtFin2 ');
      qryLocacaoResumo.ParamByName('dtFin1').AsDate := StrToDate(mEdDataFinal1.Text);
      qryLocacaoResumo.ParamByName('dtFin2').AsDate := StrToDate(mEdDataFinal2.Text);
      end;
    //valor total
    if ((edValorTotalLocacao1.Text <> '')and(edValorTotalLocacao2.Text <> ''))then
      begin
      qryLocacaoResumo.SQL.Add('AND l.valor_total BETWEEN :valTot1 AND :valTot2 ');
      qryLocacaoResumo.ParamByName('valTot1').AsFloat := StrToFloat(edValorTotalLocacao1.Text);
      qryLocacaoResumo.ParamByName('valTot2').AsFloat := StrToFloat(edValorTotalLocacao2.Text);
      end;
    //status
    if ((ckBxFinalizado.Checked=true)and(ckBxAberta.Checked=false))then
      begin
      qryLocacaoResumo.SQL.Add('AND l.status=:sta ');
      qryLocacaoResumo.ParamByName('sta').AsInteger := 1;
      end
    else if ((ckBxFinalizado.Checked=false)and(ckBxAberta.Checked=true))then
      begin
      qryLocacaoResumo.SQL.Add('AND l.status=:sta ');
      qryLocacaoResumo.ParamByName('sta').AsInteger := 0;
      end;
    //não precisa pesquisar caso Finalizado e Pendente estejam selecionados

    qryLocacaoResumo.SQL.Add('ORDER BY l.data_inicio');

    qryLocacaoResumo.Prepared := true;
    qryLocacaoResumo.Open;
    cdsLocacaoResumo.Open;
    cdsLocacaoResumo.Refresh;

    if (cdsLocacaoResumo.RecordCount <> 0) then
      begin
      if (rdBtnLocacaoResumo.Checked=true) then
        begin
        Application.CreateForm(TqckRepRelatorioLocacaoResumo,qckRepRelatorioLocacaoResumo);
        qckRepRelatorioLocacaoResumo.qrLblRegistros.Caption := IntToStr(cdsLocacaoResumo.RecordCount);
        qckRepRelatorioLocacaoResumo.Prepare;
        qckRepRelatorioLocacaoResumo.Preview;
        qckRepRelatorioLocacaoResumo.Free;
        end
      else if (rdBtnLocacaoDetalhado.Checked=true) then
        begin
        RvProject.ProjectFile := 'C:\Noiva Linda\Relatórios\rave_locacoes_com_itens.rav';
        RvProject.Execute;
        end;
      end
    else
      MessageDlg('Nenhum Registro encontrado!',mtInformation,[mbOK],0);
    end;
end;

end.
