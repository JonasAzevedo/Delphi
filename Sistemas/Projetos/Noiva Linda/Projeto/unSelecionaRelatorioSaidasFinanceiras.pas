unit unSelecionaRelatorioSaidasFinanceiras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DBClient, Provider, DB, SqlExpr, AppEvnts, StdCtrls,
  Buttons, ComCtrls, Mask, SqlTimSt, ExtCtrls;

type
  TfrmSelecionaRelatorioSaidasFinanceiras = class(TForm)
    lblData: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    mEdDataSaida1: TMaskEdit;
    mEdDataSaida2: TMaskEdit;
    StatusBar: TStatusBar;
    btBtnGerar: TBitBtn;
    btBtnNova: TBitBtn;
    ckBxCompras: TCheckBox;
    ApplicationEvents: TApplicationEvents;
    qryRelatorioSaidaFinanceira: TSQLQuery;
    dspRelatorioSaidaFinanceira: TDataSetProvider;
    cdsRelatorioSaidaFinanceira: TClientDataSet;
    qryRelatorioSaidaFinanceiraCODIGO: TIntegerField;
    qryRelatorioSaidaFinanceiraCOD_COMPRA: TIntegerField;
    qryRelatorioSaidaFinanceiraCOD_FORNECEDOR: TIntegerField;
    qryRelatorioSaidaFinanceiraTIPO: TStringField;
    qryRelatorioSaidaFinanceiraVALOR: TFMTBCDField;
    qryRelatorioSaidaFinanceiraDATA: TSQLTimeStampField;
    qryRelatorioSaidaFinanceiraOBSERVACAO: TStringField;
    qryRelatorioSaidaFinanceiraRAZAO_SOCIAL: TStringField;
    cdsRelatorioSaidaFinanceiraCODIGO: TIntegerField;
    cdsRelatorioSaidaFinanceiraCOD_COMPRA: TIntegerField;
    cdsRelatorioSaidaFinanceiraCOD_FORNECEDOR: TIntegerField;
    cdsRelatorioSaidaFinanceiraTIPO: TStringField;
    cdsRelatorioSaidaFinanceiraVALOR: TFMTBCDField;
    cdsRelatorioSaidaFinanceiraDATA: TSQLTimeStampField;
    cdsRelatorioSaidaFinanceiraOBSERVACAO: TStringField;
    cdsRelatorioSaidaFinanceiraRAZAO_SOCIAL: TStringField;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure btBtnGerarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes

  public
    { Public declarations }
  end;

var
  frmSelecionaRelatorioSaidasFinanceiras: TfrmSelecionaRelatorioSaidasFinanceiras;

implementation

uses unResumoRelatorio;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)
procedure TfrmSelecionaRelatorioSaidasFinanceiras.limpar();
begin
  ckBxCompras.Checked := true;
  mEdDataSaida1.Clear;
  mEdDataSaida2.Clear;
end;

(*FIM PROCEDURES DE CONTROLE*)



procedure TfrmSelecionaRelatorioSaidasFinanceiras.ApplicationEventsHint(
  Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaRelatorioSaidasFinanceiras.btBtnGerarClick(
  Sender: TObject);
var
  pesquisarPor: String;
  valorTotal: Real;
begin
  qryRelatorioSaidaFinanceira.Close;
  qryRelatorioSaidaFinanceira.SQL.Clear;
  qryRelatorioSaidaFinanceira.SQL.Add('SELECT s.*,f.razao_social ');
  qryRelatorioSaidaFinanceira.SQL.Add('FROM saida_financeira s, fornecedor f ');
  qryRelatorioSaidaFinanceira.SQL.Add('WHERE s.cod_fornecedor=f.codigo ');
  //data da saída
  if((mEdDataSaida1.Text <> '  /  /    ')and(mEdDataSaida2.Text <> '  /  /    '))then
    begin
    qryRelatorioSaidaFinanceira.SQL.Add('AND CAST (s.data AS DATE) BETWEEN :dtSai1 AND :dtSai2 ');
    qryRelatorioSaidaFinanceira.ParamByName('dtSai1').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataSaida1.Text);
    qryRelatorioSaidaFinanceira.ParamByName('dtSai2').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataSaida2.Text);
    end;
  qryRelatorioSaidaFinanceira.SQL.Add('ORDER BY s.data,s.tipo');
  qryRelatorioSaidaFinanceira.Prepared := true;
  qryRelatorioSaidaFinanceira.Open;
  cdsRelatorioSaidaFinanceira.Open;
  cdsRelatorioSaidaFinanceira.Refresh;

  if(cdsRelatorioSaidaFinanceira.RecordCount<>0) then
    begin
    Application.CreateForm(TfrmResumoRelatorio,frmResumoRelatorio);
    frmResumoRelatorio.Caption := 'NOIVA LINDA --> Saídas Financeiras'; //título form
    if (ckBxCompras.Checked=true) then //pesquisa por
      pesquisarPor := 'Compras';
    frmResumoRelatorio.lblPesquisaPor.Caption := pesquisarPor;
    if ((mEdDataSaida1.Text<>'  /  /    ')and(mEdDataSaida2.Text<>'  /  /    '))then //período
      frmResumoRelatorio.lblPeriodo.Caption := mEdDataSaida1.Text + ' - ' + mEdDataSaida2.Text
    else
      frmResumoRelatorio.lblPeriodo.Caption := 'Todos';

    valorTotal := 0; //Valor Total
    cdsRelatorioSaidaFinanceira.First;
    while (not(cdsRelatorioSaidaFinanceira.Eof)) do
      begin
      valorTotal := valorTotal + cdsRelatorioSaidaFinanceiraVALOR.AsFloat;
      cdsRelatorioSaidaFinanceira.Next;
      end;
    frmResumoRelatorio.lblValorTotal.Caption := FormatFloat('#0.00',valorTotal);
    frmResumoRelatorio.lblTotalRegistros.Caption := IntToStr(cdsRelatorioSaidaFinanceira.RecordCount);

    frmResumoRelatorio.ShowModal;
    frmResumoRelatorio.Free;
    end
  else
    begin
    MessageDlg('Nenhuma Saída Financeira encontrada!',mtInformation,[mbOK],0);
    btBtnNova.SetFocus;
    end;
end;

procedure TfrmSelecionaRelatorioSaidasFinanceiras.FormKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key=27) then
    Self.Close;
end;

end.
