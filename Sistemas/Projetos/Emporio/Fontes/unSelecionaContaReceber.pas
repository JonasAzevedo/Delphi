unit unSelecionaContaReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr, AppEvnts, ComCtrls,
  Mask, StdCtrls, Buttons;

type
  TfrmSelecionaContaReceber = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edCliente: TEdit;
    btBtnSelecionaCliente: TBitBtn;
    mEdDataInicial: TMaskEdit;
    mEdDataFinal: TMaskEdit;
    btBtnGerarRelatorio: TBitBtn;
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    qryContaReceber: TSQLQuery;
    dspContaReceber: TDataSetProvider;
    cdsContaReceber: TClientDataSet;
    dsContaReceber: TDataSource;
    qrySoma: TSQLQuery;
    dspSoma: TDataSetProvider;
    cdsSoma: TClientDataSet;
    dsSoma: TDataSource;
    qryContaReceberCODIGO: TIntegerField;
    qryContaReceberCLIENTE: TStringField;
    qryContaReceberDATA: TDateField;
    qryContaReceberVALOR_TOTAL: TFMTBCDField;
    qryContaReceberVALOR_PAGO: TFMTBCDField;
    qryContaReceberVALOR_LIQUIDO: TFMTBCDField;
    cdsContaReceberCODIGO: TIntegerField;
    cdsContaReceberCLIENTE: TStringField;
    cdsContaReceberDATA: TDateField;
    cdsContaReceberVALOR_TOTAL: TFMTBCDField;
    cdsContaReceberVALOR_PAGO: TFMTBCDField;
    cdsContaReceberVALOR_LIQUIDO: TFMTBCDField;
    qrySomaTOTAL: TFMTBCDField;
    qrySomaPAGO: TFMTBCDField;
    qrySomaLIQUIDO: TFMTBCDField;
    cdsSomaTOTAL: TFMTBCDField;
    cdsSomaPAGO: TFMTBCDField;
    cdsSomaLIQUIDO: TFMTBCDField;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBtnGerarRelatorioClick(Sender: TObject);
    procedure btBtnSelecionaClienteClick(Sender: TObject);
  private

    procedure limpar();//limpa componentes de apresentação
  public
    //variáveis para pesquisar por Contas à Receber
    codCliente: Integer;
  end;

var
  frmSelecionaContaReceber: TfrmSelecionaContaReceber;

implementation

uses unRelatorioContasReceber, unSelecionaCliente;



{$R *.dfm}


(*PROCEDURES DE CONTROLE*)

{limpa componentes de apresentação}
procedure TfrmSelecionaContaReceber.limpar();
begin
  edCliente.Clear;
  mEdDataInicial.Clear;
  mEdDataFinal.Clear;
  codCliente := 0;
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaContaReceber.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaContaReceber.FormShow(Sender: TObject);
begin
  limpar();
end;

procedure TfrmSelecionaContaReceber.btBtnGerarRelatorioClick(
  Sender: TObject);
begin
  if (mEdDataInicial.Text = '  /  /    ')and(mEdDataFinal.Text <> '  /  /    ')then
     ShowMessage('Confira as datas!')
  else if (mEdDataInicial.Text <> '  /  /    ')and(mEdDataFinal.Text = '  /  /    ')then
     ShowMessage('Confira as datas!')
                                                                          
  else
    begin
    qryContaReceber.Close;
    qryContaReceber.SQL.Clear;
    qryContaReceber.SQL.Add('SELECT c.codigo,c.nome AS Cliente,v.data,v.valor_total,v.valor_pago,v.valor_liquido ');
    qryContaReceber.SQL.Add('FROM venda v, cliente c ');
    qryContaReceber.SQL.Add('WHERE v.pago = 2 AND v.cod_cliente = c.codigo ');

    qrySoma.Close;
    qrySoma.SQL.Clear;
    qrySoma.SQL.Add('SELECT SUM(v.valor_total)AS Total, SUM(v.valor_pago) AS Pago, SUM(v.valor_liquido) AS Liquido ');
    qrySoma.SQL.Add('FROM venda v,cliente c ');
    qrySoma.SQL.Add('WHERE v.pago = 2 AND v.cod_cliente = c.codigo ');

    if (codCliente <> 0) then
      begin
      qryContaReceber.SQL.Add('AND c.codigo=:codCli ');
      qryContaReceber.ParamByName('codCli').AsInteger := codCliente;
      qrySoma.SQL.Add('AND c.codigo=:codCli ');
      qrySoma.ParamByName('codCli').AsInteger := codCliente;
      end;
    if ((mEdDataInicial.Text <> '  /  /    ')and(mEdDataFinal.Text <> '  /  /    '))then
      begin
      qryContaReceber.SQL.Add('AND v.data BETWEEN :dtIni AND :dtFin ');
      qryContaReceber.ParamByName('dtIni').AsDate := StrToDate(mEdDataInicial.Text);
      qryContaReceber.ParamByName('dtFin').AsDate := StrToDate(mEdDataFinal.Text);
      qrySoma.SQL.Add('AND v.data BETWEEN :dtIni AND :dtFin ');
      qrySoma.ParamByName('dtIni').AsDate := StrToDate(mEdDataInicial.Text);
      qrySoma.ParamByName('dtFin').AsDate := StrToDate(mEdDataFinal.Text);
      end;
    qryContaReceber.Prepared := true;
    qryContaReceber.Open;
    cdsContaReceber.Refresh;
    qrySoma.Prepared := true;
    qrySoma.Open;
    cdsSoma.Refresh;

    if (cdsContaReceber.RecordCount > 0) then
      begin
      relatorioContasReceber.Prepare;
      relatorioContasReceber.Preview;
      end
    else
      MessageDlg('Nenhuma Conta à Receber encontrada!',mtInformation,[mbOK],0);

    limpar();
    end;    
end;

procedure TfrmSelecionaContaReceber.btBtnSelecionaClienteClick(
  Sender: TObject);
begin
  frmSelecionaCliente.tela := 'relatorioContaReceber';
  frmSelecionaCliente.ShowModal;
end;

end.
