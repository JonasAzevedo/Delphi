unit unSelecionaCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids,
  DBGrids;

type
  TfrmSelecionaCliente = class(TForm)
    grpBxClientes: TGroupBox;
    DBGridFornecedores: TDBGrid;
    btBtnNovoCliente: TBitBtn;
    grpBxPesquisa: TGroupBox;
    rdBtnCodigo: TRadioButton;
    rdBtnNome: TRadioButton;
    edPesquisa: TEdit;
    btBtnPesquisar: TBitBtn;
    pnlDivisao: TPanel;
    StatusBar: TStatusBar;
    btBtnSelecionarCliente: TBitBtn;
    btBtnMostrarTodosClientes: TBitBtn;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosClientes: TMenuItem;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnNomeClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure DBGridFornecedoresCellClick(Column: TColumn);
    procedure DBGridFornecedoresExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBtnSelecionarClienteClick(Sender: TObject);
    procedure btBtnMostrarTodosClientesClick(Sender: TObject);
    procedure btBtnNovoClienteClick(Sender: TObject);
    procedure ppMnMostrarTodosClientesClick(Sender: TObject);
  private
    //variáveis para controle do Cliente
    codigo: Integer;
    nome: String;

    procedure limpar();//limpa componentes de apresentação
  public
    tela: String;//tela que chamou esta
    procedure mostraTodosClientes();//exibe todos os Clientes
  end;

var
  frmSelecionaCliente: TfrmSelecionaCliente;

implementation

uses unDataModule, unVenda, unCliente;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{limpa componentes de apresentação}
procedure TfrmSelecionaCliente.limpar();
begin
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;
end;

{exibe todos os Clientes}
procedure TfrmSelecionaCliente.mostraTodosClientes();
begin
  DM.qryCliente.Close;
  DM.qryCliente.SQL.Clear;
  DM.qryCliente.SQL.Add('SELECT * From Cliente c ORDER BY c.codigo');
  DM.qryCliente.Prepared := true;
  DM.qryCliente.Open;

  DM.cdsCliente.Active := false;
  DM.cdsCliente.Active := true;
  DM.cdsCliente.Refresh;

  limpar();
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaCliente.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaCliente.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';  
end;

procedure TfrmSelecionaCliente.rdBtnNomeClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';  
end;

procedure TfrmSelecionaCliente.edPesquisaChange(Sender: TObject);
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

procedure TfrmSelecionaCliente.edPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmSelecionaCliente.btBtnPesquisarClick(Sender: TObject);
begin
 {código}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.qryCliente.Close;
    DM.qryCliente.SQL.Clear;
    DM.qryCliente.SQL.Add('SELECT * FROM Cliente c WHERE c.codigo = :cod');
    DM.qryCliente.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.qryCliente.Prepared := true;
    DM.qryCliente.Open;

    DM.cdsCliente.Refresh;

    if(DM.cdsCliente.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Cliente encontrado com o código ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosClientes();
      end;

    DM.cdsCliente.Refresh;
    DM.cdsCliente.Last;
    end;

  {nome}
  if (rdBtnNome.Checked = true) then
    begin
    DM.qryCliente.Close;
    DM.qryCliente.SQL.Clear;
    DM.qryCliente.SQL.Add('SELECT * FROM Cliente c WHERE c.nome LIKE  ' + QuotedStr('%' + edPesquisa.Text + '%'));
    DM.qryCliente.Prepared := true;
    DM.qryCliente.Open;

    DM.cdsCliente.Refresh;

    if(DM.cdsCliente.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Cliente encontrado com os caracteres ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosClientes();
      end;

    DM.cdsCliente.Refresh;
    DM.cdsCliente.Last;
    end;

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaCliente.DBGridFornecedoresCellClick(
  Column: TColumn);
begin
  Self.codigo := DM.cdsClienteCODIGO.AsInteger;
  Self.nome := DM.cdsClienteNOME.AsString;

  StatusBar.Panels[1].Text := 'OPERAÇÃO = Navegação';
end;

procedure TfrmSelecionaCliente.DBGridFornecedoresExit(Sender: TObject);
begin
  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaCliente.FormShow(Sender: TObject);
begin
  mostraTodosClientes();
  StatusBar.Panels[1].Text := '';
  limpar();

  if (tela = 'venda')then
    btBtnNovoCliente.Visible := true;
end;

procedure TfrmSelecionaCliente.btBtnSelecionarClienteClick(
  Sender: TObject);
begin
  DM.cdsCliente.Refresh;
  Self.codigo := DM.cdsClienteCODIGO.AsInteger;
  Self.nome := DM.cdsClienteNOME.AsString;

  if (tela = 'venda') then
    begin
    frmVenda.codCliente := Self.codigo;
    frmVenda.nomeCliente := Self.nome;
    frmVenda.edCliente.Text := Self.nome;
    end;

  Self.Close;
end;

procedure TfrmSelecionaCliente.btBtnMostrarTodosClientesClick(
  Sender: TObject);
begin
  mostraTodosClientes();
end;

procedure TfrmSelecionaCliente.btBtnNovoClienteClick(Sender: TObject);
begin
  StatusBar.Panels[1].Text := 'Cadastro de um Novo Cliente';
  limpar();

  frmCliente.operacao := 'novo';
  frmCliente.ShowModal;
end;

procedure TfrmSelecionaCliente.ppMnMostrarTodosClientesClick(
  Sender: TObject);
begin
  mostraTodosClientes();
end;

end.
