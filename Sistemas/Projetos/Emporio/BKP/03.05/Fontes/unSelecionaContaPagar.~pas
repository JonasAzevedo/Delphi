unit unSelecionaContaPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, Buttons, ComCtrls, FMTBcd, DB, DBClient,
  Provider, SqlExpr, AppEvnts;

type
  TfrmSelecionaContaPagar = class(TForm)
    GroupBox1: TGroupBox;
    edFornecedor: TEdit;
    edProduto: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btBtnSelecionaFornecedor: TBitBtn;
    btBtnSelecionaProduto: TBitBtn;
    Label4: TLabel;
    mEdDataInicial: TMaskEdit;
    mEdDataFinal: TMaskEdit;
    Label5: TLabel;
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    btBtnGerarRelatorio: TBitBtn;
    qryContaPagar: TSQLQuery;
    dspContaPagar: TDataSetProvider;
    cdsContaPagar: TClientDataSet;
    dsContaPagar: TDataSource;
    qryContaPagarCODIGO: TIntegerField;
    qryContaPagarPRODUTO: TStringField;
    qryContaPagarFORNECEDOR: TStringField;
    qryContaPagarDATA: TDateField;
    qryContaPagarQUANTIDADE: TFMTBCDField;
    qryContaPagarVALOR_TOTAL: TFMTBCDField;
    qryContaPagarVALOR_PAGO: TFMTBCDField;
    cdsContaPagarCODIGO: TIntegerField;
    cdsContaPagarPRODUTO: TStringField;
    cdsContaPagarFORNECEDOR: TStringField;
    cdsContaPagarDATA: TDateField;
    cdsContaPagarQUANTIDADE: TFMTBCDField;
    cdsContaPagarVALOR_TOTAL: TFMTBCDField;
    cdsContaPagarVALOR_PAGO: TFMTBCDField;
    qrySoma: TSQLQuery;
    qrySomaTOTAL: TFMTBCDField;
    qrySomaPAGO: TFMTBCDField;
    dspSoma: TDataSetProvider;
    cdsSoma: TClientDataSet;
    cdsSomaTOTAL: TFMTBCDField;
    cdsSomaPAGO: TFMTBCDField;
    dsSoma: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure btBtnSelecionaFornecedorClick(Sender: TObject);
    procedure btBtnSelecionaProdutoClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure btBtnGerarRelatorioClick(Sender: TObject);
  private

    procedure limpar();//limpa componentes de apresentação
  public
    //variáveis para pesquisar por Contas à Pagar
    codFornecedor: Integer;
    codProduto: Integer;
  end;

var
  frmSelecionaContaPagar: TfrmSelecionaContaPagar;

implementation

uses unSelecionaFornecedor, unSelecionaProduto, unDataModule,
  unRelatorioContasPagar;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{limpa componentes de apresentação}
procedure TfrmSelecionaContaPagar.limpar();
begin
  edFornecedor.Clear;
  edProduto.Clear;
  mEdDataInicial.Clear;
  mEdDataFinal.Clear;
  codFornecedor := 0;
  codProduto := 0;
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaContaPagar.FormShow(Sender: TObject);
begin
  limpar();
end;

procedure TfrmSelecionaContaPagar.btBtnSelecionaFornecedorClick(
  Sender: TObject);
begin
  frmSelecionaFornecedor.tela := 'relatorioContaPagar';
  frmSelecionaFornecedor.ShowModal;
end;

procedure TfrmSelecionaContaPagar.btBtnSelecionaProdutoClick(
  Sender: TObject);
begin
  frmSelecionaProduto.tela := 'relatorioContaPagar';
  frmSelecionaProduto.ShowModal;
end;

procedure TfrmSelecionaContaPagar.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaContaPagar.btBtnGerarRelatorioClick(
  Sender: TObject);
begin
  if (mEdDataInicial.Text = '  /  /    ')and(mEdDataFinal.Text <> '  /  /    ')then
     ShowMessage('Confira as datas!')
  else if (mEdDataInicial.Text <> '  /  /    ')and(mEdDataFinal.Text = '  /  /    ')then
     ShowMessage('Confira as datas!')
                                                                          
  else
    begin
    qryContaPagar.Close;
    qryContaPagar.SQL.Clear;
    qryContaPagar.SQL.Add('SELECT c.codigo,p.nome AS Produto,f.razao_social AS Fornecedor,c.data,c.quantidade,c.valor_total,c.valor_pago ');
    qryContaPagar.SQL.Add('FROM Compra c, Produto p, Fornecedor f ');
    qryContaPagar.SQL.Add('WHERE c.pago = 2 AND c.cod_produto = p.codigo AND c.cod_fornecedor = f.codigo ');

    qrySoma.Close;
    qrySoma.SQL.Clear;
    qrySoma.SQL.Add('SELECT SUM(c.valor_total)AS Total, SUM(c.valor_pago) AS Pago ');
    qrySoma.SQL.Add('FROM Compra c, Fornecedor f, Produto p ');
    qrySoma.SQL.Add('WHERE c.pago = 2 AND c.cod_produto = p.codigo AND c.cod_fornecedor = f.codigo ');

    if (codFornecedor <> 0) then
      begin
      qryContaPagar.SQL.Add('AND f.codigo=:codFor ');
      qryContaPagar.ParamByName('codFor').AsInteger := codFornecedor;
      qrySoma.SQL.Add('AND f.codigo=:codFor ');
      qrySoma.ParamByName('codFor').AsInteger := codFornecedor;
      end;
    if (codProduto <> 0) then
      begin
      qryContaPagar.SQL.Add('AND p.codigo=:codPro ');
      qryContaPagar.ParamByName('codPro').AsInteger := codProduto;
      qrySoma.SQL.Add('AND p.codigo=:codPro ');
      qrySoma.ParamByName('codPro').AsInteger := codProduto;
      end;
    if ((mEdDataInicial.Text <> '  /  /    ')and(mEdDataFinal.Text <> '  /  /    '))then
      begin
      qryContaPagar.SQL.Add('AND c.data BETWEEN :dtIni AND :dtFin ');
      qryContaPagar.ParamByName('dtIni').AsDate := StrToDate(mEdDataInicial.Text);
      qryContaPagar.ParamByName('dtFin').AsDate := StrToDate(mEdDataFinal.Text);
      qrySoma.SQL.Add('AND c.data BETWEEN :dtIni AND :dtFin ');
      qrySoma.ParamByName('dtIni').AsDate := StrToDate(mEdDataInicial.Text);
      qrySoma.ParamByName('dtFin').AsDate := StrToDate(mEdDataFinal.Text);
      end;
    qryContaPagar.Prepared := true;
    qryContaPagar.Open;
    cdsContaPagar.Refresh;
    qrySoma.Prepared := true;
    qrySoma.Open;
    cdsSoma.Refresh;
    end;

    relatorioContasPagar.Prepare;
    relatorioContasPagar.Preview;
end;

end.
