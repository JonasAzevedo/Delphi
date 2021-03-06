unit unSelecionaTipoProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids,
  DBGrids;

type
  TfrmSelecionaTipoProduto = class(TForm)
    grpBxTiposProduto: TGroupBox;
    DBGridTiposProduto: TDBGrid;
    btBtnNovoTipoProduto: TBitBtn;
    grpBxPesquisa: TGroupBox;
    rdBtnCodigo: TRadioButton;
    rdBtnNome: TRadioButton;
    edPesquisa: TEdit;
    btBtnPesquisar: TBitBtn;
    pnlDivisao: TPanel;
    StatusBar: TStatusBar;
    btBtnSelecionarTipoProduto: TBitBtn;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosTiposProduto: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnNomeClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaEnter(Sender: TObject);
    procedure edPesquisaExit(Sender: TObject);
    procedure edPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure ppMnMostrarTodosTiposProdutoClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure DBGridTiposProdutoCellClick(Column: TColumn);
    procedure DBGridTiposProdutoExit(Sender: TObject);
    procedure btBtnNovoTipoProdutoClick(Sender: TObject);
    procedure DBGridTiposProdutoDblClick(Sender: TObject);
  private

  public
    tela:String;//tela que chamou esta

    procedure mostraTodosTiposProduto();//exibe todos os Tipos de Produto
  end;

var
  frmSelecionaTipoProduto: TfrmSelecionaTipoProduto;

implementation

uses unDM, unTipoProduto, unProduto, unItemProdutoCompra;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{exibe todos os Tipos de Produto}
procedure TfrmSelecionaTipoProduto.mostraTodosTiposProduto();
begin
  DM.qryTipoProduto.Close;
  DM.qryTipoProduto.SQL.Clear;
  DM.qryTipoProduto.SQL.Add('SELECT * From Tipo_Produto t ORDER BY t.codigo');
  DM.qryTipoProduto.Prepared := true;
  DM.qryTipoProduto.Open;

  DM.cdsTipoProduto.Open;
  DM.cdsTipoProduto.Refresh;
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaTipoProduto.FormShow(Sender: TObject);
begin
  mostraTodosTiposProduto();  
  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaTipoProduto.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmSelecionaTipoProduto.rdBtnNomeClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmSelecionaTipoProduto.edPesquisaChange(Sender: TObject);
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

procedure TfrmSelecionaTipoProduto.edPesquisaEnter(Sender: TObject);
begin
  edPesquisa.Color := clMoneyGreen;
end;

procedure TfrmSelecionaTipoProduto.edPesquisaExit(Sender: TObject);
begin
  edPesquisa.Color := clWindow;
end;

procedure TfrmSelecionaTipoProduto.edPesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=13) then
    btBtnPesquisarClick(Sender);
end;

procedure TfrmSelecionaTipoProduto.edPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmSelecionaTipoProduto.ppMnMostrarTodosTiposProdutoClick(
  Sender: TObject);
begin
  mostraTodosTiposProduto();
end;

procedure TfrmSelecionaTipoProduto.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaTipoProduto.btBtnPesquisarClick(Sender: TObject);
begin
 {c�digo}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.qryTipoProduto.Close;
    DM.qryTipoProduto.SQL.Clear;
    DM.qryTipoProduto.SQL.Add('SELECT * FROM Tipo_Produto t WHERE t.codigo = :cod');
    DM.qryTipoProduto.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.qryTipoProduto.Prepared := true;
    DM.qryTipoProduto.Open;

    DM.cdsTipoProduto.Open;
    DM.cdsTipoProduto.Refresh;

    if(DM.cdsTipoProduto.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Tipo de Produto encontrado com o c�digo ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosTiposProduto();
      end;

    DM.cdsTipoProduto.Open;
    DM.cdsTipoProduto.Refresh;
    DM.cdsTipoProduto.Last;
    end;

  {nome}
  if (rdBtnNome.Checked = true) then
    begin
    DM.qryTipoProduto.Close;
    DM.qryTipoProduto.SQL.Clear;
    DM.qryTipoProduto.SQL.Add('SELECT * FROM Tipo_Produto t WHERE t.tipo LIKE  ' + QuotedStr('%' + edPesquisa.Text + '%'));
    DM.qryTipoProduto.Prepared := true;
    DM.qryTipoProduto.Open;

    DM.cdsTipoProduto.Open;
    DM.cdsTipoProduto.Refresh;

    if(DM.cdsTipoProduto.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Tipo de Produto encontrado com os caracteres ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosTiposProduto();
      end;

    DM.cdsTipoProduto.Open;
    DM.cdsTipoProduto.Refresh;
    DM.cdsTipoProduto.Last;
    end;

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaTipoProduto.DBGridTiposProdutoCellClick(
  Column: TColumn);
begin
  StatusBar.Panels[1].Text := 'OPERA��O = Navega��o';
end;

procedure TfrmSelecionaTipoProduto.DBGridTiposProdutoExit(Sender: TObject);
begin
  StatusBar.Panels[1].Text := '';
end;

procedure TfrmSelecionaTipoProduto.btBtnNovoTipoProdutoClick(
  Sender: TObject);
begin
  StatusBar.Panels[1].Text := 'Cadastro de um Novo Tipo de Produto';

  Application.CreateForm(TfrmTipoProduto,frmTipoProduto);
  frmTipoProduto.operacao := 'novo';
  frmTipoProduto.ShowModal;
  frmTipoProduto.Free;
end;

procedure TfrmSelecionaTipoProduto.DBGridTiposProdutoDblClick(
  Sender: TObject);
begin
  if(tela='produto')then
    begin
    frmProduto.codTipoProduto := DM.cdsTipoProdutoCODIGO.AsInteger;
    frmProduto.edTipoProduto.Text := DM.cdsTipoProdutoTIPO.AsString;
    end
  else if(tela='tipoProduto')then
    begin
    frmProdutoCompra.codTipoProduto := DM.cdsTipoProdutoCODIGO.AsInteger;
    frmProdutoCompra.edTipoProduto.Text := DM.cdsTipoProdutoTIPO.AsString;
    end;
    
  Self.Close;
end;

end.
