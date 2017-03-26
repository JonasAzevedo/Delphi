unit unSelecionaVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids,
  DBGrids, FMTBcd, DB, DBClient, Provider, SqlExpr;

type
  TfrmSelecionaVenda = class(TForm)
    grpBxVendas: TGroupBox;
    DBGridVendas: TDBGrid;
    grpBxPesquisa: TGroupBox;
    rdBtnCodigo: TRadioButton;
    rdBtnNome: TRadioButton;
    edPesquisa: TEdit;
    btBtnPesquisar: TBitBtn;
    pnlDivisao: TPanel;
    StatusBar: TStatusBar;
    btBtnSelecionarVenda: TBitBtn;
    btBtnMostrarTodasVendas: TBitBtn;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosClientes: TMenuItem;
    qryVenda: TSQLQuery;
    qryVendaCODIGO: TIntegerField;
    qryVendaNOME: TStringField;
    qryVendaDATA: TDateField;
    qryVendaVALOR_TOTAL: TFMTBCDField;
    qryVendaVALOR_PAGO: TFMTBCDField;
    qryVendaVALOR_LIQUIDO: TFMTBCDField;
    dspVenda: TDataSetProvider;
    cdsVenda: TClientDataSet;
    cdsVendaCODIGO: TIntegerField;
    cdsVendaNOME: TStringField;
    cdsVendaDATA: TDateField;
    cdsVendaVALOR_TOTAL: TFMTBCDField;
    cdsVendaVALOR_PAGO: TFMTBCDField;
    cdsVendaVALOR_LIQUIDO: TFMTBCDField;
    dsVenda: TDataSource;
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnNomeClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure ppMnMostrarTodosClientesClick(Sender: TObject);
    procedure btBtnMostrarTodasVendasClick(Sender: TObject);
    procedure DBGridVendasCellClick(Column: TColumn);
    procedure DBGridVendasExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBtnSelecionarVendaClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
  private
    //variáveis para controle da Venda
    codigo: Integer;

    procedure limpar();//limpa componentes de apresentação
  public
    tela: String;//tela que chamou esta
    procedure mostraTodasVendas();//exibe todas as Vendas
  end;

var
  frmSelecionaVenda: TfrmSelecionaVenda;

implementation

uses unDataModule, unSelecionaEntradas;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{limpa componentes de apresentação}
procedure TfrmSelecionaVenda.limpar();
begin
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;
end;

{exibe todas as Vendas}
procedure TfrmSelecionaVenda.mostraTodasVendas();
begin
  qryVenda.Close;
  qryVenda.SQL.Clear;
  qryVenda.SQL.Add('SELECT v.codigo,c.nome,v.data,v.valor_total,v.valor_pago,v.valor_liquido ');
  qryVenda.SQL.Add('FROM venda v,cliente c WHERE v.cod_cliente = c.codigo');
  qryVenda.Prepared := true;
  qryVenda.Open;

  cdsVenda.Active := false;
  cdsVenda.Active := true;
  cdsVenda.Refresh;

  limpar();
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaVenda.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmSelecionaVenda.rdBtnNomeClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmSelecionaVenda.edPesquisaChange(Sender: TObject);
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

procedure TfrmSelecionaVenda.edPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmSelecionaVenda.btBtnPesquisarClick(Sender: TObject);
begin
 {código}
  if (rdBtnCodigo.Checked = true) then
    begin
    qryVenda.Close;
    qryVenda.SQL.Clear;
    qryVenda.SQL.Add('SELECT v.codigo,c.nome,v.data,v.valor_total,v.valor_pago,v.valor_liquido ');
    qryVenda.SQL.Add('FROM venda v,cliente c WHERE v.cod_cliente = c.codigo AND v.codigo=:cod');
    qryVenda.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    qryVenda.Prepared := true;
    qryVenda.Open;

    cdsVenda.Refresh;

    if(cdsVenda.RecordCount = 0)then
      begin
      MessageDlg('Nenhuma Venda encontrada com o código ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodasVendas();
      end;

    DM.cdsVenda.Refresh;
    DM.cdsVenda.Last;
    end;

  {cliente}
  if (rdBtnNome.Checked = true) then
    begin
    qryVenda.Close;
    qryVenda.SQL.Clear;
    qryVenda.SQL.Add('SELECT v.codigo,c.nome,v.data,v.valor_total,v.valor_pago,v.valor_liquido ');
    qryVenda.SQL.Add('FROM venda v,cliente c WHERE v.cod_cliente = c.codigo AND c.nome = :nom');
    qryVenda.ParamByName('nom').AsString := edPesquisa.Text;
    qryVenda.Prepared := true;
    qryVenda.Open;

    cdsVenda.Refresh;

    if(cdsVenda.RecordCount = 0)then
      begin
      MessageDlg('Nenhuma Venda encontrada com o Cliente ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodasVendas();
      end;

    cdsVenda.Refresh;
    cdsVenda.Last;
    end;

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaVenda.ppMnMostrarTodosClientesClick(
  Sender: TObject);
begin
  mostraTodasVendas();
end;

procedure TfrmSelecionaVenda.btBtnMostrarTodasVendasClick(Sender: TObject);
begin
  mostraTodasVendas();
end;

procedure TfrmSelecionaVenda.DBGridVendasCellClick(Column: TColumn);
begin
  Self.codigo := cdsVendaCODIGO.AsInteger;

  StatusBar.Panels[1].Text := 'OPERAÇÃO = Navegação';
end;

procedure TfrmSelecionaVenda.DBGridVendasExit(Sender: TObject);
begin
  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaVenda.FormShow(Sender: TObject);
begin
  mostraTodasVendas();
  StatusBar.Panels[1].Text := '';
  limpar();
end;

procedure TfrmSelecionaVenda.btBtnSelecionarVendaClick(Sender: TObject);
begin
  cdsVenda.Refresh;
  Self.codigo := cdsVendaCODIGO.AsInteger;

  if (tela = 'relatorioEntrada') then
    begin
    frmSelecionaEntrada.codVenda := Self.codigo;
    frmSelecionaEntrada.edVenda.Text := IntToStr(Self.codigo);
    end;

  Self.Close;
end;

procedure TfrmSelecionaVenda.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

end.
