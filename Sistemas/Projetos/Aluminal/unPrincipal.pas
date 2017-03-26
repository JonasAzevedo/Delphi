unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AdvMenus, StdCtrls, AppEvnts, ImgList, ComCtrls, ToolWin,
  ExtCtrls, vCal, PlannerCal, Grids, Calendar, Buttons, DBClient, Provider,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, AdvPanel,
  AdvGlowButton, Mask, plsTMaskEdit, unFuncoes;

type
  TfrmPrincipal = class(TForm)
    mmMenu: TAdvMainMenu;
    mmCadastro: TMenuItem;
    mmPedido: TMenuItem;
    tlBtnPrincipal: TToolBar;
    imgPrincipal: TImageList;
    ApplicationEvents: TApplicationEvents;
    tlBtnFechar: TToolButton;
    tlBtnPedido: TToolButton;
    StatusBar: TStatusBar;
    zQryHistoricoParcelaPedido: TZQuery;
    zQryHistoricoParcelaPedidoCODIGO: TIntegerField;
    zQryHistoricoParcelaPedidoDATA_CADASTRO: TDateTimeField;
    zQryHistoricoParcelaPedidoCOD_PEDIDO: TIntegerField;
    zQryHistoricoParcelaPedidoVALOR_TOTAL: TFloatField;
    zQryHistoricoParcelaPedidoVALOR_PARCELA: TFloatField;
    zQryHistoricoParcelaPedidoDATA_VCTO: TDateField;
    zQryHistoricoParcelaPedidoDATA_PGTO: TDateField;
    zQryHistoricoParcelaPedidoDESCRICAO: TStringField;
    dspHistoricoParcelaPedido: TDataSetProvider;
    cdsHistoricoParcelaPedido: TClientDataSet;
    cdsHistoricoParcelaPedidoCODIGO: TIntegerField;
    cdsHistoricoParcelaPedidoDATA_CADASTRO: TDateTimeField;
    cdsHistoricoParcelaPedidoCOD_PEDIDO: TIntegerField;
    cdsHistoricoParcelaPedidoVALOR_TOTAL: TFloatField;
    cdsHistoricoParcelaPedidoVALOR_PARCELA: TFloatField;
    cdsHistoricoParcelaPedidoDATA_VCTO: TDateField;
    cdsHistoricoParcelaPedidoDATA_PGTO: TDateField;
    cdsHistoricoParcelaPedidoDESCRICAO: TStringField;
    pnlStyler: TAdvPanelStyler;
    pnlHistorico: TAdvPanel;
    lblTotalParcelaPedido: TLabel;
    lblInfParcelaPedido: TLabel;
    calendario: TPlannerCalendar;
    mmDescricaoProdutos: TMenuItem;
    btnListarHistorico: TAdvGlowButton;
    Timer: TTimer;
    mmSobre: TMenuItem;
    mmSobre2: TMenuItem;
    pnlPesquisa: TPanel;
    edDataInicioPesquisa: TPlsMaskEdit;
    edDataFinalPesquisa: TPlsMaskEdit;
    btnPesquisar: TAdvGlowButton;
    lblIntervaloPesquisa: TLabel;
    lblPesquisar: TLabel;
    procedure mmPedidoClick(Sender: TObject);
    procedure tlBtnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mmDescricaoProdutosClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure mmSobre2Click(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnListarHistoricoClick(Sender: TObject);
    procedure lblTotalParcelaPedidoClick(Sender: TObject);
  private
    FbPodeEncerrar: Boolean;
    FoFuncoes: TFuncoes;
    
    procedure AtualizarHistorico(pbIntervaloDatas:Boolean);
    procedure CalcularWidthStatusBar;
  public
    procedure SetFbPodeEncerrar(pbPode:Boolean);
    function GetFbPodeEncerrar: Boolean;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses unCadPedido, unPagamentoPedido, unConstantes, unDM, unCadDescricaoProdutos2,
unSobre, unVisualizarParcelas;

{$R *.dfm}

procedure TfrmPrincipal.SetFbPodeEncerrar(pbPode: Boolean);
begin
  Self.FbPodeEncerrar := pbPode;
end;

function TfrmPrincipal.GetFbPodeEncerrar: Boolean;
begin
  Result := FbPodeEncerrar;
end;

procedure TfrmPrincipal.AtualizarHistorico(pbIntervaloDatas:Boolean);
begin
  //parcelas do pedido.
  cdsHistoricoParcelaPedido.Close;
  zQryHistoricoParcelaPedido.Close;
  zQryHistoricoParcelaPedido.SQL.Clear;
  zQryHistoricoParcelaPedido.SQL.Add('SELECT * FROM pagamento_pedido ');
  if pbIntervaloDatas then
  begin
    zQryHistoricoParcelaPedido.SQL.Add('WHERE data_vcto BETWEEN :dataInicio AND :dataFinal ');
    zQryHistoricoParcelaPedido.ParamByName('dataInicio').AsDate := StrToDate(edDataInicioPesquisa.Text);
    zQryHistoricoParcelaPedido.ParamByName('dataFinal').AsDate := StrToDate(edDataFinalPesquisa.Text);
  end
  else
  begin
    zQryHistoricoParcelaPedido.SQL.Add('WHERE data_vcto = :data_vcto ');
    zQryHistoricoParcelaPedido.ParamByName('data_vcto').AsDate := calendario.Date;
  end;
  zQryHistoricoParcelaPedido.SQL.Add('AND data_pgto IS NULL');
  zQryHistoricoParcelaPedido.Open;
  cdsHistoricoParcelaPedido.Open;
  lblTotalParcelaPedido.Caption := IntToStr(cdsHistoricoParcelaPedido.RecordCount);
end;

procedure TfrmPrincipal.CalcularWidthStatusBar;
var
  nWidth: Integer;
  nWidth1,nWidth2, nWidth3: Integer;
begin
  nWidth := Self.Width;

  nWidth1 := Round(((nWidth / 100) * 68)); //68% da statusBar.
  nWidth2 := Round(((nWidth / 100) * 17)); //17% da statusBar.
  nWidth3 := Round(((nWidth / 100) * 15)); //15% da statusBar.
  StatusBar.Panels[0].Width := nWidth1;
  StatusBar.Panels[1].Width := nWidth2;
  StatusBar.Panels[2].Width := nWidth3;
end;

procedure TfrmPrincipal.mmPedidoClick(Sender: TObject);
var
  frmPedido: TfrmCadPedido;
begin
  Application.CreateForm(TfrmCadPedido, frmPedido);
  frmPedido.Show;
end;

procedure TfrmPrincipal.tlBtnFecharClick(Sender: TObject);
begin
  if GetFbPodeEncerrar then
    Application.Terminate;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FoFuncoes := TFuncoes.Create;
  SetFbPodeEncerrar(True);
  CalcularWidthStatusBar;
  edDataInicioPesquisa.Text := DateToStr(Now - 7);
  edDataFinalPesquisa.Text := DateToStr(Now);
  AtualizarHistorico(True);
end;

procedure TfrmPrincipal.mmDescricaoProdutosClick(Sender: TObject);
var
  frmCadDescricaoProdutos2: TfrmCadDescricaoProdutos2;
begin
  Application.CreateForm(TfrmCadDescricaoProdutos2, frmCadDescricaoProdutos2);
  frmCadDescricaoProdutos2.Show;
end;

procedure TfrmPrincipal.TimerTimer(Sender: TObject);
begin
  StatusBar.Panels[2].Text := FormatDateTime('dddd, dd "de" mmmm "de" yyyy " - " hh:nn:ss', Now);
end;

procedure TfrmPrincipal.mmSobre2Click(Sender: TObject);
var
  frmSobre: TfrmSobre;
begin
  Application.CreateForm(TfrmSobre, frmSobre);
  frmSobre.ShowModal;
end;

procedure TfrmPrincipal.btnPesquisarClick(Sender: TObject);
begin
  if not(FoFuncoes.validarData(edDataInicioPesquisa.Text)) then
  begin
    MessageDlg('Verifique a data de início antes de pesquisar', mtInformation, [mbOK], 0);
    FoFuncoes.focarComponente(edDataInicioPesquisa);
    Exit;
  end;

  if not(FoFuncoes.validarData(edDataFinalPesquisa.Text)) then
  begin
    MessageDlg('Verifique a data final antes de pesquisar', mtInformation, [mbOK], 0);
    FoFuncoes.focarComponente(edDataFinalPesquisa);
    Exit;
  end;

  AtualizarHistorico(True);
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoFuncoes);
end;

procedure TfrmPrincipal.btnListarHistoricoClick(Sender: TObject);
begin
  AtualizarHistorico(False);
end;

procedure TfrmPrincipal.lblTotalParcelaPedidoClick(Sender: TObject);
var
  FoFrmVisualizarParcelas: TfrmVisualizarParcelas;
  lstCodigoParcelas: TStringList;

  procedure PegarCodigoParcelas;
  begin
    cdsHistoricoParcelaPedido.First;
    while not(cdsHistoricoParcelaPedido.Eof) do
    begin
      lstCodigoParcelas.Append(cdsHistoricoParcelaPedido.FieldByName('codigo').AsString);
      cdsHistoricoParcelaPedido.Next;
    end;
  end;

begin
  if (cdsHistoricoParcelaPedido.Active) and (not(cdsHistoricoParcelaPedido.IsEmpty)) then
  begin
    lstCodigoParcelas := TStringList.Create;
    PegarCodigoParcelas;
    FoFrmVisualizarParcelas := TfrmVisualizarParcelas.Create(nil);
    try
      FoFrmVisualizarParcelas.PassaParametro(sPRM_TELA_PAI, integer(Self));
      FoFrmVisualizarParcelas.PassaParametro(sPRM_PESQUISAR_PARCELAS_PARAMETRO,
        lstCodigoParcelas.CommaText);
      FoFrmVisualizarParcelas.Show;
    finally
      //FreeAndNil(FoFrmVisualizarParcelas);
      FreeAndNil(lstCodigoParcelas);
    end;
  end
  else
    MessageDlg('Não há parcelas para serem exibidas.', mtInformation, [mbOK], 0);
end;

end.
