unit unSelecionaSaida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, Mask, StdCtrls, Buttons, DB, DBClient, Provider,
  SqlExpr, AppEvnts, ComCtrls;

type
  TfrmSelecionaSaida = class(TForm)
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    qrySaida: TSQLQuery;
    dspSaida: TDataSetProvider;
    cdsSaida: TClientDataSet;
    dsSaida: TDataSource;
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
    edCompra: TEdit;
    edFornecedor: TEdit;
    btBtnSelecionaCompra: TBitBtn;
    btBtnSelecionaFornecedor: TBitBtn;
    mEdDataInicial: TMaskEdit;
    mEdDataFinal: TMaskEdit;
    btBtnGerarRelatorio: TBitBtn;
    qrySaidaCODIGOCOMPRA: TIntegerField;
    qrySaidaFORNECEDOR: TStringField;
    qrySaidaDATA: TDateField;
    qrySaidaVALOR: TFMTBCDField;
    cdsSaidaCODIGOCOMPRA: TIntegerField;
    cdsSaidaFORNECEDOR: TStringField;
    cdsSaidaDATA: TDateField;
    cdsSaidaVALOR: TFMTBCDField;
    qrySomaVALOR: TFMTBCDField;
    cdsSomaVALOR: TFMTBCDField;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure btBtnSelecionaCompraClick(Sender: TObject);
    procedure btBtnSelecionaFornecedorClick(Sender: TObject);
    procedure btBtnGerarRelatorioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    procedure limpar();//limpa componentes de apresentação
  public
    //variáveis para pesquisar por Saídas
    codCompra: Integer;
    codFornecedor: Integer;
  end;

var
  frmSelecionaSaida: TfrmSelecionaSaida;

implementation

uses unSelecionaFornecedor, unSelecionaCompra, unRelatorioSaida;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{limpa componentes de apresentação}
procedure TfrmSelecionaSaida.limpar();
begin
  edCompra.Clear;
  edFornecedor.Clear;
  mEdDataInicial.Clear;
  mEdDataFinal.Clear;
  codCompra := 0;
  codFornecedor := 0;
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaSaida.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaSaida.btBtnSelecionaCompraClick(Sender: TObject);
begin
  frmSelecionaCompra.tela := 'relatorioSaida';
  frmSelecionaCompra.ShowModal;
end;

procedure TfrmSelecionaSaida.btBtnSelecionaFornecedorClick(
  Sender: TObject);
begin
  frmSelecionaFornecedor.tela := 'relatorioSaida';
  frmSelecionaFornecedor.ShowModal;
end;

procedure TfrmSelecionaSaida.btBtnGerarRelatorioClick(Sender: TObject);
begin
  if (mEdDataInicial.Text = '  /  /    ')and(mEdDataFinal.Text <> '  /  /    ')then
     ShowMessage('Confira as datas!')
  else if (mEdDataInicial.Text <> '  /  /    ')and(mEdDataFinal.Text = '  /  /    ')then
     ShowMessage('Confira as datas!')
                                                                          
  else
    begin
    qrySaida.Close;
    qrySaida.SQL.Clear;
    qrySaida.SQL.Add('SELECT c.codigo AS CodigoCompra,f.razao_social AS Fornecedor,s.data,s.valor ');
    qrySaida.SQL.Add('FROM compra c, saida s, fornecedor f ');
    qrySaida.SQL.Add('WHERE c.codigo = s.cod_compra AND c.cod_fornecedor = f.codigo');

    qrySoma.Close;
    qrySoma.SQL.Clear;
    qrySoma.SQL.Add('SELECT SUM(s.valor) AS Valor ');
    qrySoma.SQL.Add('FROM compra c, saida s,fornecedor f ');
    qrySoma.SQL.Add('WHERE s.cod_compra = c.codigo AND c.cod_fornecedor = f.codigo ');

    if (codCompra <> 0) then
      begin
      qrySaida.SQL.Add('AND c.codigo=:codCom ');
      qrySaida.ParamByName('codCom').AsInteger := codCompra;
      qrySoma.SQL.Add('AND c.codigo=:codCom');
      qrySoma.ParamByName('codCom').AsInteger := codCompra;
      end;
    if (codFornecedor <> 0) then
      begin
      qrySaida.SQL.Add('AND f.codigo=:codFor ');
      qrySaida.ParamByName('codFor').AsInteger := codFornecedor;
      qrySoma.SQL.Add('AND f.codigo=:codFor ');
      qrySoma.ParamByName('codFor').AsInteger := codFornecedor;
      end;
    if ((mEdDataInicial.Text <> '  /  /    ')and(mEdDataFinal.Text <> '  /  /    '))then
      begin
      qrySaida.SQL.Add('AND s.data BETWEEN :dtIni AND :dtFin ');
      qrySaida.ParamByName('dtIni').AsDate := StrToDate(mEdDataInicial.Text);
      qrySaida.ParamByName('dtFin').AsDate := StrToDate(mEdDataFinal.Text);
      qrySoma.SQL.Add('AND s.data BETWEEN :dtIni AND :dtFin ');
      qrySoma.ParamByName('dtIni').AsDate := StrToDate(mEdDataInicial.Text);
      qrySoma.ParamByName('dtFin').AsDate := StrToDate(mEdDataFinal.Text);
      end;
    qrySaida.SQL.Add('ORDER BY c.codigo');
    qrySaida.Prepared := true;
    qrySaida.Open;
    cdsSaida.Refresh;
    qrySoma.Prepared := true;
    qrySoma.Open;
    cdsSoma.Refresh;

    if(cdsSaida.RecordCount > 0)then
      begin
      relatorioSaida.Prepare;
      relatorioSaida.Preview;
      end
    else
      MessageDlg('Nenhuma Saída Financeira encontrada!',mtInformation,[mbOK],0);

    limpar();
    end;
end;

procedure TfrmSelecionaSaida.FormShow(Sender: TObject);
begin
  limpar();
end;

end.
