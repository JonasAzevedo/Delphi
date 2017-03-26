unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, FMTBcd, DB, SqlExpr, DBClient, Provider, ComCtrls,
  StdCtrls, ExtCtrls, Buttons, AppEvnts, jpeg, ShellApi;

type
  TfrmPrincipal = class(TForm)
    MainMenu: TMainMenu;
    mnArquivo: TMenuItem;
    mnCadastros: TMenuItem;
    mnCliente: TMenuItem;
    mnFornecedor: TMenuItem;
    mnProduto: TMenuItem;
    mnOperacoes: TMenuItem;
    mnLocacao: TMenuItem;
    mnFinanceiro: TMenuItem;
    mnContasReceber: TMenuItem;
    mnContasPagar: TMenuItem;
    mnRelatorios: TMenuItem;
    mnConfiguracoes: TMenuItem;
    mnUsuarios: TMenuItem;
    mnLocacoes: TMenuItem;
    qryLocacoesPendentes: TSQLQuery;
    qryLocacoesPendentesCODIGO: TIntegerField;
    qryLocacoesPendentesCLIENTE: TStringField;
    qryLocacoesPendentesDATA_INICIO: TSQLTimeStampField;
    qryLocacoesPendentesDATA_FINAL: TSQLTimeStampField;
    qryLocacoesPendentesVALOR_TOTAL: TFMTBCDField;
    dspLocacoesPendentes: TDataSetProvider;
    cdsLocacoesPendentes: TClientDataSet;
    cdsLocacoesPendentesCODIGO: TIntegerField;
    cdsLocacoesPendentesCLIENTE: TStringField;
    cdsLocacoesPendentesDATA_INICIO: TSQLTimeStampField;
    cdsLocacoesPendentesDATA_FINAL: TSQLTimeStampField;
    cdsLocacoesPendentesVALOR_TOTAL: TFMTBCDField;
    dsLocacoesPendentes: TDataSource;
    mnReserva: TMenuItem;
    mnNovaLocacao: TMenuItem;
    mnRetornoLocacao: TMenuItem;
    mnNovaReserva: TMenuItem;
    mnRealizarReserva: TMenuItem;
    mnVenda: TMenuItem;
    mnNovaVenda: TMenuItem;
    N1: TMenuItem;
    mnEntradasFinanceiras: TMenuItem;
    Compra1: TMenuItem;
    NovaCompra1: TMenuItem;
    mnSaidasFinanceiras: TMenuItem;
    StatusBar: TStatusBar;
    mnCompras: TMenuItem;
    qryReservasPendentes: TSQLQuery;
    dspReservasPendentes: TDataSetProvider;
    cdsReservasPendentes: TClientDataSet;
    dsReservasPendentes: TDataSource;
    Timer: TTimer;
    ApplicationEvents: TApplicationEvents;
    N2: TMenuItem;
    qryBaixaReserva: TSQLQuery;
    dspBaixaReserva: TDataSetProvider;
    cdsBaixaReserva: TClientDataSet;
    dsBaixaReserva: TDataSource;
    qryBaixaReservaCODIGO: TIntegerField;
    qryBaixaReservaNOME: TStringField;
    qryBaixaReservaDATA_INICIO: TSQLTimeStampField;
    qryBaixaReservaDATA_FINAL: TSQLTimeStampField;
    qryBaixaReservaVALOR_TOTAL: TFMTBCDField;
    qryBaixaReservaVALOR_PAGO: TFMTBCDField;
    cdsBaixaReservaCODIGO: TIntegerField;
    cdsBaixaReservaNOME: TStringField;
    cdsBaixaReservaDATA_INICIO: TSQLTimeStampField;
    cdsBaixaReservaDATA_FINAL: TSQLTimeStampField;
    cdsBaixaReservaVALOR_TOTAL: TFMTBCDField;
    cdsBaixaReservaVALOR_PAGO: TFMTBCDField;
    ReservasPendentes1: TMenuItem;
    Timer1: TTimer;
    imgFundo: TImage;
    N3: TMenuItem;
    ResumodeHoje1: TMenuItem;
    mnReservas: TMenuItem;
    mnVendas: TMenuItem;
    Sobre1: TMenuItem;
    Sobre2: TMenuItem;
    mnComissoes: TMenuItem;
    ipodeProdutos1: TMenuItem;
    qryReservasPendentesCODIGO: TIntegerField;
    qryReservasPendentesCOD_FUNCIONARIO: TIntegerField;
    qryReservasPendentesSEXO: TStringField;
    qryReservasPendentesCODCLIENTE: TIntegerField;
    qryReservasPendentesCLIENTE: TStringField;
    qryReservasPendentesDATA_INICIO: TSQLTimeStampField;
    qryReservasPendentesDATA_FINAL: TSQLTimeStampField;
    qryReservasPendentesVALOR_TOTAL: TFMTBCDField;
    qryReservasPendentesOBSERVACOES: TStringField;
    cdsReservasPendentesCODIGO: TIntegerField;
    cdsReservasPendentesCOD_FUNCIONARIO: TIntegerField;
    cdsReservasPendentesSEXO: TStringField;
    cdsReservasPendentesCODCLIENTE: TIntegerField;
    cdsReservasPendentesCLIENTE: TStringField;
    cdsReservasPendentesDATA_INICIO: TSQLTimeStampField;
    cdsReservasPendentesDATA_FINAL: TSQLTimeStampField;
    cdsReservasPendentesVALOR_TOTAL: TFMTBCDField;
    cdsReservasPendentesOBSERVACOES: TStringField;
    N5: TMenuItem;
    mnComissoesRel: TMenuItem;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnClienteClick(Sender: TObject);
    procedure mnFornecedorClick(Sender: TObject);
    procedure mnProdutoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnUsuariosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnLocacoesClick(Sender: TObject);
    procedure mnNovaLocacaoClick(Sender: TObject);
    procedure RetornoLocao1Click(Sender: TObject);
    procedure mnNovaReservaClick(Sender: TObject);
    procedure mnNovaVendaClick(Sender: TObject);
    procedure mnContasReceberClick(Sender: TObject);
    procedure mnEntradasFinanceirasClick(Sender: TObject);
    procedure NovaCompra1Click(Sender: TObject);
    procedure mnContasPagarClick(Sender: TObject);
    procedure mnSaidasFinanceirasClick(Sender: TObject);
    procedure mnComprasClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure mnRealizarReservaClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure ReservasPendentes1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ResumodeHoje1Click(Sender: TObject);
    procedure mnReservasClick(Sender: TObject);
    procedure mnVendasClick(Sender: TObject);
    procedure Sobre2Click(Sender: TObject);
    procedure mnComissoesClick(Sender: TObject);
    procedure ipodeProdutos1Click(Sender: TObject);
    procedure mnComissoesRelClick(Sender: TObject);
  private
    (*VARIÁVEIS ESPECÍFICAS*)

    (*PROCEDURES ESPECÍFICAS*)
    procedure devolucoesLocacao(modoInicia: String); //pega as locações que devem ser devolvidas amanhã, ou já venceu
    procedure chamaHelp();
  public
    //controle do usuário
    codUsuario: Integer;
    nomeUsuario: String;

   (*PROCEDURES ESPECÍFICAS*)
    procedure reservasPendentes(modoInicia: String); //reservas a serem realizadas
    procedure baixaReservas(modoInicia: String); //realiza baixa nas reservas
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses unMurro, unCliente, unFornecedor, unProduto, unLocacao,
  unRetornoLocacao, unUsuario, unLogin, unDM,
  unSelecionaRelatorioOperacoes, unVerLocacoesPendentesVencendo, unReserva,
  unVenda, unContaReceber, unSelecionaRelatorioEntradasFinanceiras,
  unCompra, unContaPagar, unSelecionaRelatorioSaidasFinanceiras,
  unVerReservasPendentes, unBaixaReservas, unOperacoesHoje, unSobre,
  unConfiguracaoComisoes, unTipoProduto, unSelecionaRelatorioCompras,
  unSelecionaRelatorioLocacoes, unSelecionaRelatorioReservas,
  unSelecionaRelatorioVendas, unSelecionaRelatorioComissoes;

{$R *.dfm}

(*PROCEDURES ESPECÍFICAS*)

//chama o help do programa
procedure TfrmPrincipal.ChamaHelp();
var
  caminho: String;
begin
  caminho := ExtractFilePath(ParamStr(0));
//  caminho := caminho + 'Help\ajuda.chm';
//  ShellExecute(0,nil,PChar(caminho),nil ,nil,SW_NORMAL);

  ShellExecute(0,nil,PChar(caminho + 'ajuda.chm'),nil ,nil,SW_NORMAL);
end;


//realiza baixa nas reservas
procedure TfrmPrincipal.baixaReservas(modoInicia: String);
begin
  qryBaixaReserva.Close;
  qryBaixaReserva.SQL.Clear;
  qryBaixaReserva.SQL.Add('SELECT r.codigo,c.nome,r.data_inicio,r.data_final,r.valor_total,r.valor_pago ');
  qryBaixaReserva.SQL.Add('FROM reserva r,cliente c ');
  qryBaixaReserva.SQL.Add('WHERE CAST (r.data_inicio AS DATE) < current_date ');
  qryBaixaReserva.SQL.Add('AND r.status=0 AND r.cod_cliente=c.codigo');
  qryBaixaReserva.Prepared := true;
  qryBaixaReserva.Open;
  cdsBaixaReserva.Open;
  cdsBaixaReserva.Refresh;

  if(modoInicia='inicial')then
    begin
    if(cdsBaixaReserva.RecordCount>0)then
      begin
      MessageDlg('Há '+IntToStr(cdsBaixaReserva.RecordCount)+ ' reserva(s) já vencida(s)',mtConfirmation,[mbOK],0);
      Application.CreateForm(TfrmBaixaReservas,frmBaixaReservas);
      frmBaixaReservas.ShowModal;
      frmBaixaReservas.Free;
      end;
    end;
end;

//reservas a serem realizadas
procedure TfrmPrincipal.reservasPendentes(modoInicia: String);
begin
  qryReservasPendentes.Close;
  qryReservasPendentes.SQL.Clear;
  qryReservasPendentes.SQL.Add('SELECT r.codigo,r.cod_funcionario,r.sexo, c.codigo AS codCliente,c.nome AS Cliente,r.data_inicio,r.data_final,r.valor_total,r.observacoes ');
  qryReservasPendentes.SQL.Add('FROM reserva r,cliente c ');
  qryReservasPendentes.SQL.Add('WHERE r.cod_cliente=c.codigo ');
  qryReservasPendentes.SQL.Add('AND r.status=0 ');
  qryReservasPendentes.SQL.Add('AND CAST(r.data_inicio AS Date) = current_date');
  qryReservasPendentes.SQL.Add('ORDER BY r.data_inicio');
  qryReservasPendentes.Prepared := true;
  qryReservasPendentes.Open;
  cdsReservasPendentes.Open;
  cdsReservasPendentes.Refresh;
  if(cdsReservasPendentes.RecordCount > 0)then
    begin
    if(modoInicia='inicial')then
      begin
      if(MessageDlg('Há '+IntToStr(cdsReservasPendentes.RecordCount)+ ' reservas pendentes.'+#13+'Deseja visualizá-las?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
        begin
        Application.CreateForm(TfrmReservasPendentes,frmReservasPendentes);
        frmReservasPendentes.tela := 'realizar';
        frmReservasPendentes.ShowModal;
        frmReservasPendentes.Free;
        end
      end
    else if(modoInicia='jaAbriu')then
      begin
      Application.CreateForm(TfrmReservasPendentes,frmReservasPendentes);
      frmReservasPendentes.tela := 'realizar';
      frmReservasPendentes.ShowModal;
      frmReservasPendentes.Free;
      end
    else if(modoInicia='jaAbriuSemMostrar')then
      begin
      frmOperacoesHoje.mmReservasHoje.Clear;
      cdsReservasPendentes.First;
      while(not(cdsReservasPendentes.Eof))do
        begin
        frmOperacoesHoje.mmReservasHoje.Lines.Add('CLIENTE: '+cdsReservasPendentesCLIENTE.AsString);
        frmOperacoesHoje.mmReservasHoje.Lines.Add('INÍCIO: '+cdsReservasPendentesDATA_INICIO.AsString);
        frmOperacoesHoje.mmReservasHoje.Lines.Add('TÉRMINO: '+cdsReservasPendentesDATA_FINAL.AsString);
        frmOperacoesHoje.mmReservasHoje.Lines.Add('VALOR TOTAL: '+FormatFloat('#0.00',cdsReservasPendentesVALOR_TOTAL.AsFloat));
        frmOperacoesHoje.mmReservasHoje.Lines.Add(' ');
        cdsReservasPendentes.Next;
        end;
      frmOperacoesHoje.lblTotalReservas.Caption := IntToStr(cdsReservasPendentes.RecordCount);
      end;
    end;
end;

//pega as locações que devem ser devolvidas amanhã, ou já venceu
procedure TfrmPrincipal.devolucoesLocacao(modoInicia: String);
begin
  qryLocacoesPendentes.Close;
  qryLocacoesPendentes.SQL.Clear;
  qryLocacoesPendentes.SQL.Add('SELECT l.codigo,c.nome AS Cliente,l.data_inicio,l.data_final,l.valor_total ');
  qryLocacoesPendentes.SQL.Add('FROM locacao l,cliente c ');
  qryLocacoesPendentes.SQL.Add('WHERE l.cod_cliente=c.codigo ');
  qryLocacoesPendentes.SQL.Add('AND l.status=0 ');
  qryLocacoesPendentes.SQL.Add('AND (l.data_final-current_timestamp < 1) ');
  qryLocacoesPendentes.SQL.Add('ORDER BY l.data_final ');
  qryLocacoesPendentes.Prepared := true;
  qryLocacoesPendentes.Open;
  cdsLocacoesPendentes.Open;
  cdsLocacoesPendentes.Refresh;
  if (cdsLocacoesPendentes.RecordCount > 0) then
    begin
    if(modoInicia='inicial')then
      begin
      if(MessageDlg('Há '+IntToStr(cdsLocacoesPendentes.RecordCount)+ ' locações pendentes ou vencendo.'+#13+'Deseja visualizá-las?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
        begin
        Application.CreateForm(TfrmLocacoesPendentesVencendo,frmLocacoesPendentesVencendo);
        frmLocacoesPendentesVencendo.ShowModal;
        frmLocacoesPendentesVencendo.Free;
        end;
      end
    else if(modoInicia='jaAbriu')then
      begin
      Application.CreateForm(TfrmLocacoesPendentesVencendo,frmLocacoesPendentesVencendo);
      frmLocacoesPendentesVencendo.ShowModal;
      frmLocacoesPendentesVencendo.Free;
      end
    else if(modoInicia='jaAbriuSemMostrar')then
      begin
      frmOperacoesHoje.mmLocacoesDevolucao.Clear;
      cdsLocacoesPendentes.First;
      while(not(cdsLocacoesPendentes.Eof))do
        begin
        frmOperacoesHoje.mmLocacoesDevolucao.Lines.Add('CLIENTE: '+cdsLocacoesPendentesCLIENTE.AsString);
        frmOperacoesHoje.mmLocacoesDevolucao.Lines.Add('INÍCIO: '+cdsLocacoesPendentesDATA_INICIO.AsString);
        frmOperacoesHoje.mmLocacoesDevolucao.Lines.Add('TÉRMINO: '+cdsLocacoesPendentesDATA_FINAL.AsString);
        frmOperacoesHoje.mmLocacoesDevolucao.Lines.Add('VALOR TOTAL: '+FormatFloat('#0.00',cdsLocacoesPendentesVALOR_TOTAL.AsFloat));
        frmOperacoesHoje.mmLocacoesDevolucao.Lines.Add(' ');
        cdsLocacoesPendentes.Next;
        end;
      frmOperacoesHoje.lblTotalLocacoes.Caption := IntToStr(cdsLocacoesPendentes.RecordCount);
      end;
    end;
end;

(*FIM PROCEDURES ESPECÍFICAS*)


procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=122) then
    begin
    Application.CreateForm(TfrmMurro,frmMurro);
    frmMurro.ShowModal;
    frmMurro.Close;
    end;

  if (key=112) then
    ChamaHelp();
end;

procedure TfrmPrincipal.mnClienteClick(Sender: TObject);
begin
  Application.CreateForm(TfrmCliente,frmCliente);
  frmCliente.ShowModal;
  frmCliente.Free;
end;

procedure TfrmPrincipal.mnFornecedorClick(Sender: TObject);
begin
  Application.CreateForm(TfrmFornecedor,frmFornecedor);
  frmFornecedor.ShowModal;
  frmFornecedor.Free;
end;

procedure TfrmPrincipal.mnProdutoClick(Sender: TObject);
begin
  Application.CreateForm(TfrmProduto,frmProduto);
  frmProduto.ShowModal;
  frmProduto.Free;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  ShortDateFormat := 'dd/mm/yyyy';
  LongDateFormat := 'dd/mm/yyyy';
  DateSeparator := '/';
  ShortTimeFormat := 'hh:mm:ss';
  LongTimeFormat := 'hh:mm:ss';
  TimeSeparator := ':';

  Application.CreateForm(TfrmLogin,frmLogin);
  frmLogin.ShowModal;
  frmLogin.Free;
end;

procedure TfrmPrincipal.mnUsuariosClick(Sender: TObject);
begin
  Application.CreateForm(TfrmUsuario,frmUsuario);
  frmUsuario.ShowModal;
  frmUsuario.Free;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  //usuário administrador
  if (DM.cdsUsuarioCODIGO.AsInteger = 1) then
    mnUsuarios.Enabled := true
  else
    mnUsuarios.Enabled := false;

  //verificando as locações
  devolucoesLocacao('inicial');
  //verificando se há reservas
  reservasPendentes('inicial');
  //dar baixa nas reservas
  baixaReservas('inicial');
  //dados do usuário
  Self.codUsuario := DM.cdsUsuarioCODIGO.AsInteger;
  Self.nomeUsuario := DM.cdsUsuarioNOME.AsString;
  StatusBar.Panels[1].Text := IntToStr(Self.codUsuario)+' - '+Self.nomeUsuario;
end;

procedure TfrmPrincipal.mnLocacoesClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaRelatorioLocacoes ,frmSelecionaRelatorioLocacoes);
  frmSelecionaRelatorioLocacoes.ShowModal;
  frmSelecionaRelatorioLocacoes.Free;
end;

procedure TfrmPrincipal.mnNovaLocacaoClick(Sender: TObject);
begin
  Application.CreateForm(TfrmLocacao,frmLocacao);
  frmLocacao.ShowModal;
  frmLocacao.Free;
end;

procedure TfrmPrincipal.RetornoLocao1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmRetornoLocacao,frmRetornoLocacao);
  frmRetornoLocacao.ShowModal;
  frmRetornoLocacao.Free;
end;

procedure TfrmPrincipal.mnNovaReservaClick(Sender: TObject);
begin
  Application.CreateForm(TfrmReserva,frmReserva);
  frmReserva.ShowModal;
  frmReserva.Free;
end;

procedure TfrmPrincipal.mnNovaVendaClick(Sender: TObject);
begin
  Application.CreateForm(TfrmVenda,frmVenda);
  frmVenda.ShowModal;
  frmVenda.Free;
end;

procedure TfrmPrincipal.mnContasReceberClick(Sender: TObject);
begin
  Application.CreateForm(TfrmContaReceber,frmContaReceber);
  frmContaReceber.ShowModal;
  frmContaReceber.Free;
end;

procedure TfrmPrincipal.mnEntradasFinanceirasClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaRelatorioEntradasFinanceiras,frmSelecionaRelatorioEntradasFinanceiras);
  frmSelecionaRelatorioEntradasFinanceiras.ShowModal;
  frmSelecionaRelatorioEntradasFinanceiras.Free;
end;

procedure TfrmPrincipal.NovaCompra1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmCompra,frmCompra);
  frmCompra.ShowModal;
  frmCompra.Free;              
end;

procedure TfrmPrincipal.mnContasPagarClick(Sender: TObject);
begin
  Application.CreateForm(TfrmContaPagar,frmContaPagar);
  frmContaPagar.ShowModal;
  frmContaPagar.Free;
end;

procedure TfrmPrincipal.mnSaidasFinanceirasClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaRelatorioSaidasFinanceiras,frmSelecionaRelatorioSaidasFinanceiras);
  frmSelecionaRelatorioSaidasFinanceiras.ShowModal;
  frmSelecionaRelatorioSaidasFinanceiras.Free;    
end;

procedure TfrmPrincipal.mnComprasClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaRelatorioCompras,frmSelecionaRelatorioCompras);
  frmSelecionaRelatorioCompras.ShowModal;
  frmSelecionaRelatorioCompras.Free;
end;

procedure TfrmPrincipal.TimerTimer(Sender: TObject);
begin
  //verificando as locações
  devolucoesLocacao('inicial');
  //verificando se há reservas
  reservasPendentes('inicial');
end;

procedure TfrmPrincipal.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmPrincipal.mnRealizarReservaClick(Sender: TObject);
begin
  //verificando se há reservas
  reservasPendentes('jaAbriu');
end;

procedure TfrmPrincipal.Label1Click(Sender: TObject);
begin
  //verificando se há reservas
  reservasPendentes('jaAbriu');
end;

procedure TfrmPrincipal.Label2Click(Sender: TObject);
begin
  //verificando as locações
  devolucoesLocacao('jaAbriu');
end;

procedure TfrmPrincipal.ReservasPendentes1Click(Sender: TObject);
begin
  qryReservasPendentes.Close;
  qryReservasPendentes.SQL.Clear;
  qryReservasPendentes.SQL.Add('SELECT r.codigo,r.cod_funcionario,r.sexo, c.codigo AS codCliente,c.nome AS Cliente,r.data_inicio,r.data_final,r.valor_total, r.observacoes ');
  qryReservasPendentes.SQL.Add('FROM reserva r,cliente c ');
  qryReservasPendentes.SQL.Add('WHERE r.cod_cliente=c.codigo ');
  qryReservasPendentes.SQL.Add('AND r.status=0 ');
  qryReservasPendentes.SQL.Add('AND r.data_inicio >= current_timestamp ');
  qryReservasPendentes.SQL.Add('ORDER BY r.data_inicio');
  qryReservasPendentes.Prepared := true;
  qryReservasPendentes.Open;
  cdsReservasPendentes.Open;
  cdsReservasPendentes.Refresh;

  Application.CreateForm(TfrmReservasPendentes,frmReservasPendentes);
  frmReservasPendentes.tela := 'visualizar';
  frmReservasPendentes.ShowModal;
  frmReservasPendentes.Free;
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  //aspresentando data e hora
  StatusBar.Panels[2].Text := DateTimeToStr(Now);
end;

procedure TfrmPrincipal.ResumodeHoje1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmOperacoesHoje,frmOperacoesHoje);

  frmOperacoesHoje.lblTotalLocacoes.Caption := '0';
  frmOperacoesHoje.lblTotalReservas.Caption := '0';    

  //verificando as locações
  devolucoesLocacao('jaAbriuSemMostrar');
  //verificando se há reservas
  reservasPendentes('jaAbriuSemMostrar');
  //dar baixa nas reservas
  baixaReservas('jaAbriuSemMostrar');

  frmOperacoesHoje.Show;
end;

procedure TfrmPrincipal.mnReservasClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaRelatorioReservas ,frmSelecionaRelatorioReservas);
  frmSelecionaRelatorioReservas.ShowModal;
  frmSelecionaRelatorioReservas.Free;
end;

procedure TfrmPrincipal.mnVendasClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaRelatorioVendas ,frmSelecionaRelatorioVendas);
  frmSelecionaRelatorioVendas.ShowModal;
  frmSelecionaRelatorioVendas.Free;
end;

procedure TfrmPrincipal.Sobre2Click(Sender: TObject);
begin
  Application.CreateForm(TfrmSobre,frmSobre);
  frmSobre.ShowModal;
  frmSobre.Free;
end;

procedure TfrmPrincipal.mnComissoesClick(Sender: TObject);
begin
  Application.CreateForm(TfrmConfiguracaoComisoes,frmConfiguracaoComisoes);
  frmConfiguracaoComisoes.ShowModal;
  frmConfiguracaoComisoes.Free;
end;

procedure TfrmPrincipal.ipodeProdutos1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmTipoProduto,frmTipoProduto);
  frmTipoProduto.ShowModal;
 frmTipoProduto.Free;
end;

procedure TfrmPrincipal.mnComissoesRelClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaRelatorioComissoes ,frmSelecionaRelatorioComissoes);
  frmSelecionaRelatorioComissoes.ShowModal;
  frmSelecionaRelatorioComissoes.Free;
end;

end.
