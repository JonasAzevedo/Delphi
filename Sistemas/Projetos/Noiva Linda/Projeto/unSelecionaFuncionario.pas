unit unSelecionaFuncionario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids,
  DBGrids;

type
  TfrmSelecionaFuncionario = class(TForm)
    grpBxFuncionarios: TGroupBox;
    DBGridFuncionarios: TDBGrid;
    grpBxPesquisa: TGroupBox;
    rdBtnCodigo: TRadioButton;
    rdBtnNome: TRadioButton;
    edPesquisa: TEdit;
    btBtnPesquisar: TBitBtn;
    pnlDivisao: TPanel;
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosFuncionarios: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnNomeClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaEnter(Sender: TObject);
    procedure edPesquisaExit(Sender: TObject);
    procedure edPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure ppMnMostrarTodosFuncionariosClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure DBGridFuncionariosCellClick(Column: TColumn);
    procedure DBGridFuncionariosExit(Sender: TObject);
    procedure DBGridFuncionariosDblClick(Sender: TObject);
  private

  public
    tela:String;//tela que chamou esta

    procedure mostraTodosFuncionarios();//exibe todos os Funcionários
  end;

var
  frmSelecionaFuncionario: TfrmSelecionaFuncionario;

implementation

uses unDM, unLocacao, unVenda, unReserva, unSelecionaRelatorioComissoes;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{exibe todos os Funcionários}
procedure TfrmSelecionaFuncionario.mostraTodosFuncionarios();
begin
  DM.qryUsuario.Close;
  DM.qryUsuario.SQL.Clear;
  DM.qryUsuario.SQL.Add('SELECT * From Usuario u ORDER BY u.codigo');
  DM.qryUsuario.Prepared := true;
  DM.qryUsuario.Open;

  DM.cdsUsuario.Open;
  DM.cdsUsuario.Refresh;
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaFuncionario.FormShow(Sender: TObject);
begin
  mostraTodosFuncionarios();
  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaFuncionario.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmSelecionaFuncionario.rdBtnNomeClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmSelecionaFuncionario.edPesquisaChange(Sender: TObject);
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

procedure TfrmSelecionaFuncionario.edPesquisaEnter(Sender: TObject);
begin
  edPesquisa.Color := clMoneyGreen;
end;

procedure TfrmSelecionaFuncionario.edPesquisaExit(Sender: TObject);
begin
  edPesquisa.Color := clWindow;
end;

procedure TfrmSelecionaFuncionario.edPesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=13) then
    btBtnPesquisarClick(Sender);
end;

procedure TfrmSelecionaFuncionario.edPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmSelecionaFuncionario.ppMnMostrarTodosFuncionariosClick(
  Sender: TObject);
begin
  mostraTodosFuncionarios();
end;

procedure TfrmSelecionaFuncionario.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaFuncionario.btBtnPesquisarClick(Sender: TObject);
begin
 {código}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.qryUsuario.Close;
    DM.qryUsuario.SQL.Clear;
    DM.qryUsuario.SQL.Add('SELECT * FROM Usuario u WHERE u.codigo = :cod');
    DM.qryUsuario.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.qryUsuario.Prepared := true;
    DM.qryUsuario.Open;

    DM.cdsUsuario.Open;
    DM.cdsUsuario.Refresh;

    if(DM.cdsUsuario.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Usuário encontrado com o código ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosFuncionarios();
      end;

    DM.cdsUsuario.Open;
    DM.cdsUsuario.Refresh;
    DM.cdsUsuario.Last;
    end;

  {nome}
  if (rdBtnNome.Checked = true) then
    begin
    DM.qryUsuario.Close;
    DM.qryUsuario.SQL.Clear;
    DM.qryUsuario.SQL.Add('SELECT * FROM Usuario u WHERE u.nome LIKE  ' + QuotedStr('%' + edPesquisa.Text + '%'));
    DM.qryUsuario.Prepared := true;
    DM.qryUsuario.Open;

    DM.cdsUsuario.Open;
    DM.cdsUsuario.Refresh;

    if(DM.cdsUsuario.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Usuário encontrado com os caracteres ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosFuncionarios();
      end;

    DM.cdsUsuario.Open;
    DM.cdsUsuario.Refresh;
    DM.cdsUsuario.Last;
    end;

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaFuncionario.DBGridFuncionariosCellClick(
  Column: TColumn);
begin
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Navegação';
end;

procedure TfrmSelecionaFuncionario.DBGridFuncionariosExit(Sender: TObject);
begin
  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaFuncionario.DBGridFuncionariosDblClick(
  Sender: TObject);
begin
  if (tela = 'locacao') then
    begin
    frmLocacao.codFuncionario := DM.cdsUsuarioCODIGO.AsInteger;
    frmLocacao.edFuncionario.Text := DM.cdsUsuarioNOME.AsString;
    end
  else if (tela = 'venda') then
    begin
    frmVenda.codFuncionario := DM.cdsUsuarioCODIGO.AsInteger;
    frmVenda.edFuncionario.Text := DM.cdsUsuarioNOME.AsString;
    end
  else if (tela = 'reserva') then
    begin
    frmReserva.codFuncionario := DM.cdsUsuarioCODIGO.AsInteger;
    frmReserva.edFuncionario.Text := DM.cdsUsuarioNOME.AsString;
    end
  else if (tela = 'relatorioComissoes') then
    begin
    frmSelecionaRelatorioComissoes.codFuncionario := DM.cdsUsuarioCODIGO.AsInteger;
    frmSelecionaRelatorioComissoes.edFuncionario.Text := DM.cdsUsuarioNOME.AsString;
    end;

  Self.Close;
end;

end.
