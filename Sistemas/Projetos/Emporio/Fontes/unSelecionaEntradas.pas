unit unSelecionaEntradas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr, AppEvnts, ComCtrls,
  Mask, StdCtrls, Buttons;

type
  TfrmSelecionaEntrada = class(TForm)
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    qryEntrada: TSQLQuery;
    dspEntrada: TDataSetProvider;
    cdsEntrada: TClientDataSet;
    dsEntrada: TDataSource;
    qrySoma: TSQLQuery;
    dspSoma: TDataSetProvider;
    cdsSoma: TClientDataSet;
    dsSoma: TDataSource;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edVenda: TEdit;
    edCliente: TEdit;
    btBtnSelecionaVenda: TBitBtn;
    btBtnSelecionaCliente: TBitBtn;
    mEdDataInicial: TMaskEdit;
    mEdDataFinal: TMaskEdit;
    btBtnGerarRelatorio: TBitBtn;
    qryEntradaCODIGOVENDA: TIntegerField;
    qryEntradaDATA: TDateField;
    qryEntradaVALOR_BRUTO: TFMTBCDField;
    qryEntradaVALOR_LIQUIDO: TFMTBCDField;
    qryEntradaCLIENTE: TStringField;
    cdsEntradaCODIGOVENDA: TIntegerField;
    cdsEntradaDATA: TDateField;
    cdsEntradaVALOR_BRUTO: TFMTBCDField;
    cdsEntradaVALOR_LIQUIDO: TFMTBCDField;
    cdsEntradaCLIENTE: TStringField;
    qrySomaVALORBRUTO: TFMTBCDField;
    qrySomaVALORLIQUIDO: TFMTBCDField;
    cdsSomaVALORBRUTO: TFMTBCDField;
    cdsSomaVALORLIQUIDO: TFMTBCDField;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBtnSelecionaVendaClick(Sender: TObject);
    procedure btBtnSelecionaClienteClick(Sender: TObject);
    procedure btBtnGerarRelatorioClick(Sender: TObject);
  private

    procedure limpar();//limpa componentes de apresentação
  public
    //variáveis para pesquisar por Entradas
    codVenda: Integer;
    codCliente: Integer;
  end;

var
  frmSelecionaEntrada: TfrmSelecionaEntrada;

implementation

uses unSelecionaVenda, unSelecionaCliente, unRelatorioEntrada;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{limpa componentes de apresentação}
procedure TfrmSelecionaEntrada.limpar();
begin
  edVenda.Clear;
  edCliente.Clear;
  mEdDataInicial.Clear;
  mEdDataFinal.Clear;
  codVenda := 0;
  codCliente := 0;
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaEntrada.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaEntrada.FormShow(Sender: TObject);
begin
  limpar();
end;

procedure TfrmSelecionaEntrada.btBtnSelecionaVendaClick(Sender: TObject);
begin
  frmSelecionaVenda.tela := 'relatorioEntrada';
  frmSelecionaVenda.ShowModal;
end;

procedure TfrmSelecionaEntrada.btBtnSelecionaClienteClick(Sender: TObject);
begin
  frmSelecionaCliente.tela := 'relatorioEntrada';
  frmSelecionaCliente.ShowModal;
end;

procedure TfrmSelecionaEntrada.btBtnGerarRelatorioClick(Sender: TObject);
begin
  if (mEdDataInicial.Text = '  /  /    ')and(mEdDataFinal.Text <> '  /  /    ')then
     ShowMessage('Confira as datas!')
  else if (mEdDataInicial.Text <> '  /  /    ')and(mEdDataFinal.Text = '  /  /    ')then
     ShowMessage('Confira as datas!')
                                                                          
  else
    begin
    qryEntrada.Close;
    qryEntrada.SQL.Clear;
    qryEntrada.SQL.Add('SELECT v.codigo AS CodigoVenda,e.data,e.valor_bruto,e.valor_liquido,c.nome AS Cliente ');
    qryEntrada.SQL.Add('FROM venda v, entrada e, cliente c ');
    qryEntrada.SQL.Add('WHERE v.codigo = e.cod_venda AND v.cod_cliente = c.codigo ');

    qrySoma.Close;
    qrySoma.SQL.Clear;
    qrySoma.SQL.Add('SELECT SUM(e.valor_bruto) AS ValorBruto,SUM(e.valor_liquido) AS ValorLiquido ');
    qrySoma.SQL.Add('FROM venda v, entrada e, cliente c ');
    qrySoma.SQL.Add('WHERE v.codigo = e.cod_venda AND v.cod_cliente = c.codigo ');

    if (codVenda <> 0) then
      begin
      qryEntrada.SQL.Add('AND v.codigo=:codVen ');
      qryEntrada.ParamByName('codVen').AsInteger := codVenda;
      qrySoma.SQL.Add('AND v.codigo=:codVen ');
      qrySoma.ParamByName('codVen').AsInteger := codVenda;
      end;
    if (codCliente <> 0) then
      begin
      qryEntrada.SQL.Add('AND c.codigo=:codCli ');
      qryEntrada.ParamByName('codCli').AsInteger := codCliente;
      qrySoma.SQL.Add('AND c.codigo=:codCli ');
      qrySoma.ParamByName('codCli').AsInteger := codCliente;
      end;
    if ((mEdDataInicial.Text <> '  /  /    ')and(mEdDataFinal.Text <> '  /  /    '))then
      begin
      qryEntrada.SQL.Add('AND e.data BETWEEN :dtIni AND :dtFin ');
      qryEntrada.ParamByName('dtIni').AsDate := StrToDate(mEdDataInicial.Text);
      qryEntrada.ParamByName('dtFin').AsDate := StrToDate(mEdDataFinal.Text);
      qrySoma.SQL.Add('AND e.data BETWEEN :dtIni AND :dtFin ');
      qrySoma.ParamByName('dtIni').AsDate := StrToDate(mEdDataInicial.Text);
      qrySoma.ParamByName('dtFin').AsDate := StrToDate(mEdDataFinal.Text);
      end;
    qryEntrada.SQL.Add('ORDER BY v.codigo');
    qryEntrada.Prepared := true;
    qryEntrada.Open;
    cdsEntrada.Refresh;
    qrySoma.Prepared := true;
    qrySoma.Open;
    cdsSoma.Refresh;

    if(cdsEntrada.RecordCount > 0)then
      begin
      relatorioEntrada.Prepare;
      relatorioEntrada.Preview;
      end
    else
      MessageDlg('Nenhuma Entrada Financeira encontrada!',mtInformation,[mbOK],0);

    limpar();
    end;
end;

end.
