unit unSelecionaFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids,
  DBGrids;

type
  TfrmSelecionaFornecedor = class(TForm)
    grpBxFornecedores: TGroupBox;
    DBGridFornecedores: TDBGrid;
    btBtnNovoFornecedor: TBitBtn;
    grpBxPesquisa: TGroupBox;
    rdBtnCodigo: TRadioButton;
    rdBtnRazaoSocial: TRadioButton;
    edPesquisa: TEdit;
    btBtnPesquisar: TBitBtn;
    pnlDivisao: TPanel;
    StatusBar: TStatusBar;
    btBtnSelecionarFornecedor: TBitBtn;
    btBtnMostrarTodosFornecedores: TBitBtn;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosFornecedores: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnRazaoSocialClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure DBGridFornecedoresCellClick(Column: TColumn);
    procedure DBGridFornecedoresExit(Sender: TObject);
    procedure btBtnSelecionarFornecedorClick(Sender: TObject);
    procedure btBtnMostrarTodosFornecedoresClick(Sender: TObject);
    procedure btBtnNovoFornecedorClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
  private
    //variáveis para controle do Fornecedor
    codigo: Integer;
    razao_social: String;

    procedure limpar();//limpa componentes de apresentação
  public
    tela: String;//tela que chamou esta
    procedure mostraTodosFornecedores();//exibe todos os Fornecedores
  end;

var
  frmSelecionaFornecedor: TfrmSelecionaFornecedor;

implementation

uses unCompra, unFornecedor, unDataModule, unSelecionaContaPagar;

{$R *.dfm}


(*PROCEDURES DE CONTROLE*)

{limpa componentes de apresentação}
procedure TfrmSelecionaFornecedor.limpar();
begin
  rdBtnCodigo.Checked := false;
  rdBtnRazaoSocial.Checked := false;
  edPesquisa.Clear;
end;

{exibe todos os Fornecedores}
procedure TfrmSelecionaFornecedor.mostraTodosFornecedores();
begin
  DM.qryFornecedor.Close;
  DM.qryFornecedor.SQL.Clear;
  DM.qryFornecedor.SQL.Add('SELECT * From Fornecedor f ORDER BY f.codigo');
  DM.qryFornecedor.Prepared := true;
  DM.qryFornecedor.Open;

  DM.cdsFornecedor.Active := false;
  DM.cdsFornecedor.Active := true;
  DM.cdsFornecedor.Refresh;

  limpar();
end;

(*FIM PROCEDURES DE CONTROLE*)


procedure TfrmSelecionaFornecedor.FormShow(Sender: TObject);
begin
  mostraTodosFornecedores();
  StatusBar.Panels[1].Text := '';
  limpar();

  if (tela = 'compra')then
    btBtnNovoFornecedor.Visible := true
  else if (tela = 'relatorioContaPagar')then
    btBtnNovoFornecedor.Visible := false;    
end;

procedure TfrmSelecionaFornecedor.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';  
end;

procedure TfrmSelecionaFornecedor.rdBtnRazaoSocialClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';  
end;

procedure TfrmSelecionaFornecedor.edPesquisaChange(Sender: TObject);
begin
  if (edPesquisa.Text = '')then
    btBtnPesquisar.Enabled := false;

  if(edPesquisa.Text <> '')then
    begin
    if((rdBtnCodigo.Checked = true)or(rdBtnRazaoSocial.Checked = true))then
      btBtnPesquisar.Enabled := true
    else
      btBtnPesquisar.Enabled := false;
    end;
end;

procedure TfrmSelecionaFornecedor.edPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmSelecionaFornecedor.btBtnPesquisarClick(Sender: TObject);
begin
 {código}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.qryFornecedor.Close;
    DM.qryFornecedor.SQL.Clear;
    DM.qryFornecedor.SQL.Add('SELECT * FROM Fornecedor f WHERE f.codigo = :cod');
    DM.qryFornecedor.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.qryFornecedor.Prepared := true;
    DM.qryFornecedor.Open;

    DM.cdsFornecedor.Refresh;

    if(DM.cdsFornecedor.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Fornecedor encontrado com o código ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosFornecedores();
      end;

    DM.cdsFornecedor.Refresh;
    DM.cdsFornecedor.Last;
    end;

  {nome}
  if (rdBtnRazaoSocial.Checked = true) then
    begin
    DM.qryFornecedor.Close;
    DM.qryFornecedor.SQL.Clear;
    DM.qryFornecedor.SQL.Add('SELECT * FROM Fornecedor f WHERE f.razao_social LIKE  ' + QuotedStr('%' + edPesquisa.Text + '%'));
    DM.qryFornecedor.Prepared := true;
    DM.qryFornecedor.Open;

    DM.cdsFornecedor.Refresh;

    if(DM.cdsFornecedor.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Fornecedor encontrado com os caracteres ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosFornecedores();
      end;

    DM.cdsFornecedor.Refresh;
    DM.cdsFornecedor.Last;
    end;

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaFornecedor.DBGridFornecedoresCellClick(
  Column: TColumn);
begin
  Self.codigo := DM.cdsFornecedorCODIGO.AsInteger;
  Self.razao_social := DM.cdsFornecedorRAZAO_SOCIAL.AsString;

  StatusBar.Panels[1].Text := 'OPERAÇÃO = Navegação';
end;

procedure TfrmSelecionaFornecedor.DBGridFornecedoresExit(Sender: TObject);
begin
  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaFornecedor.btBtnSelecionarFornecedorClick(
  Sender: TObject);
begin
  DM.cdsFornecedor.Refresh;
  Self.codigo := DM.cdsFornecedorCODIGO.AsInteger;
  Self.razao_social := DM.cdsFornecedorRAZAO_SOCIAL.AsString;

  if (tela = 'compra') then
    begin
    frmCompra.codFornecedor := Self.codigo;
    frmCompra.nomeFornecedor := Self.razao_social;
    frmCompra.edFornecedor.Text := Self.razao_social;
    end
  else if (tela = 'relatorioContaPagar') then
    begin
    frmSelecionaContaPagar.codFornecedor := Self.codigo;
    frmSelecionaContaPagar.edFornecedor.Text := Self.razao_social;
    end;

  Self.Close;
end;

procedure TfrmSelecionaFornecedor.btBtnMostrarTodosFornecedoresClick(
  Sender: TObject);
begin
  mostraTodosFornecedores();
end;

procedure TfrmSelecionaFornecedor.btBtnNovoFornecedorClick(
  Sender: TObject);
begin
  StatusBar.Panels[1].Text := 'Cadastro de um Novo Fornecedor';
  limpar();

  frmFornecedor.operacao := 'novo';
  frmFornecedor.ShowModal;
end;


procedure TfrmSelecionaFornecedor.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

end.
