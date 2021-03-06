unit unSelecionaCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr, Menus, AppEvnts,
  ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids;

type
  TfrmSelecionaCompra = class(TForm)
    grpBxCompras: TGroupBox;
    DBGridCompras: TDBGrid;
    grpBxPesquisa: TGroupBox;
    rdBtnCodigo: TRadioButton;
    rdBtnNome: TRadioButton;
    edPesquisa: TEdit;
    btBtnPesquisar: TBitBtn;
    pnlDivisao: TPanel;
    StatusBar: TStatusBar;
    btBtnSelecionarCompra: TBitBtn;
    btBtnMostrarTodasCompras: TBitBtn;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodasCompras: TMenuItem;
    qryCompra: TSQLQuery;
    dspCompra: TDataSetProvider;
    cdsCompra: TClientDataSet;
    dsCompra: TDataSource;
    qryCompraCODIGO: TIntegerField;
    qryCompraFORNECEDOR: TStringField;
    qryCompraDATA: TDateField;
    qryCompraQUANTIDADE: TFMTBCDField;
    qryCompraVALOR_UNITARIO: TFMTBCDField;
    qryCompraVALOR_TOTAL: TFMTBCDField;
    qryCompraVALOR_PAGO: TFMTBCDField;
    cdsCompraCODIGO: TIntegerField;
    cdsCompraFORNECEDOR: TStringField;
    cdsCompraDATA: TDateField;
    cdsCompraQUANTIDADE: TFMTBCDField;
    cdsCompraVALOR_UNITARIO: TFMTBCDField;
    cdsCompraVALOR_TOTAL: TFMTBCDField;
    cdsCompraVALOR_PAGO: TFMTBCDField;
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnNomeClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure ppMnMostrarTodasComprasClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure DBGridComprasCellClick(Column: TColumn);
    procedure DBGridComprasExit(Sender: TObject);
    procedure btBtnMostrarTodasComprasClick(Sender: TObject);
    procedure btBtnSelecionarCompraClick(Sender: TObject);
  private
    //vari�veis para controle da Compra
    codigo: Integer;

    procedure limpar();//limpa componentes de apresenta��o
  public
    tela: String;//tela que chamou esta
    procedure mostraTodasCompras();//exibe todas as Compras
  end;

var
  frmSelecionaCompra: TfrmSelecionaCompra;

implementation

uses unSelecionaSaida;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{limpa componentes de apresenta��o}
procedure TfrmSelecionaCompra.limpar();
begin
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;
end;

{exibe todas as Compras}
procedure TfrmSelecionaCompra.mostraTodasCompras();
begin
  qryCompra.Close;
  qryCompra.SQL.Clear;
  qryCompra.SQL.Add('SELECT c.codigo, f.razao_social AS Fornecedor,c.data,c.quantidade,c.valor_unitario,c.valor_total,c.valor_pago ');
  qryCompra.SQL.Add('FROM compra c, fornecedor f WHERE c.cod_fornecedor = f.codigo');
  qryCompra.Prepared := true;
  qryCompra.Open;

  cdsCompra.Active := false;
  cdsCompra.Active := true;
  cdsCompra.Refresh;

  limpar();
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaCompra.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmSelecionaCompra.rdBtnNomeClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmSelecionaCompra.edPesquisaChange(Sender: TObject);
begin
  if (edPesquisa.Text = '')then
    btBtnPesquisar.Enabled := false;

  if(edPesquisa.Text <> '')then
    begin
    if((rdBtnCodigo.Checked = true)or(rdBtnNome.Checked = true))then
      btBtnPesquisar.Enabled := true
    else
      btBtnPesquisar.Enabled := false;
    end;
end;

procedure TfrmSelecionaCompra.edPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmSelecionaCompra.btBtnPesquisarClick(Sender: TObject);
begin
 {c�digo}
  if (rdBtnCodigo.Checked = true) then
    begin
    qryCompra.Close;
    qryCompra.SQL.Clear;
    qryCompra.SQL.Add('SELECT c.codigo, f.razao_social AS Fornecedor,c.data,c.quantidade,c.valor_unitario,c.valor_total,c.valor_pago ');
    qryCompra.SQL.Add('FROM compra c, fornecedor f WHERE c.cod_fornecedor = f.codigo AND c.codigo=:cod');
    qryCompra.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    qryCompra.Prepared := true;
    qryCompra.Open;

    cdsCompra.Refresh;

    if(cdsCompra.RecordCount = 0)then
      begin
      MessageDlg('Nenhuma Compra encontrada com o c�digo ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodasCompras();
      end;

    cdsCompra.Refresh;
    cdsCompra.Last;
    end;

  {fornecedor}
  if (rdBtnNome.Checked = true) then
    begin
    qryCompra.Close;
    qryCompra.SQL.Clear;
    qryCompra.SQL.Add('SELECT c.codigo, f.razao_social AS Fornecedor,c.data,c.quantidade,c.valor_unitario,c.valor_total,c.valor_pago ');
    qryCompra.SQL.Add('FROM compra c, fornecedor f WHERE c.cod_fornecedor = f.codigo AND f.razao_social = :raz');
    qryCompra.ParamByName('raz').AsString := edPesquisa.Text;
    qryCompra.Prepared := true;
    qryCompra.Open;

    cdsCompra.Refresh;

    if(cdsCompra.RecordCount = 0)then
      begin
      MessageDlg('Nenhuma Compra encontrada com o Fornecedor ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodasCompras();
      end;

    cdsCompra.Refresh;
    cdsCompra.Last;
    end;

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaCompra.ppMnMostrarTodasComprasClick(
  Sender: TObject);
begin
  mostraTodasCompras();
end;

procedure TfrmSelecionaCompra.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaCompra.DBGridComprasCellClick(Column: TColumn);
begin
  Self.codigo := cdsCompraCODIGO.AsInteger;

  StatusBar.Panels[1].Text := 'OPERA��O = Navega��o';
end;

procedure TfrmSelecionaCompra.DBGridComprasExit(Sender: TObject);
begin
  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaCompra.btBtnMostrarTodasComprasClick(
  Sender: TObject);
begin
  mostraTodasCompras();
end;

procedure TfrmSelecionaCompra.btBtnSelecionarCompraClick(Sender: TObject);
begin
  cdsCompra.Refresh;
  Self.codigo := cdsCompraCODIGO.AsInteger;

  if (tela = 'relatorioSaida') then
    begin
    frmSelecionaSaida.codCompra := Self.codigo;
    frmSelecionaSaida.edCompra.Text := IntToStr(Self.codigo);
    end;

  Self.Close;
end;

end.
