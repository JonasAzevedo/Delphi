unit unLocacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, AppEvnts, ImgList, ComCtrls, StdCtrls, ToolWin, ExtCtrls,
  Buttons, DBXpress, SQLTimSt, Grids, DBGrids, FMTBcd, DB, DBClient,
  Provider, SqlExpr;

type
  TfrmLocacao = class(TForm)
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnCancelar: TToolButton;
    grpBxDadosLocacao: TGroupBox;
    lblCodigo: TLabel;
    lblObservacao: TLabel;
    lblNome: TLabel;
    lblUF: TLabel;
    lblCidade: TLabel;
    edCodigo: TEdit;
    edCliente: TEdit;
    mmObservacao: TMemo;
    StatusBar: TStatusBar;
    imgLista: TImageList;
    ApplicationEvents: TApplicationEvents;
    mEdDataInicio: TMaskEdit;
    mEdDataFinal: TMaskEdit;
    lblInfValorTotal: TLabel;
    btBtnAbreCliente: TBitBtn;
    qryItens: TSQLQuery;
    dspItens: TDataSetProvider;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    grpBxItensLocacao: TGroupBox;
    dbGrdItensLocacao: TDBGrid;
    pnlBotoesItensLocacao: TPanel;
    btBtnInserirItem: TBitBtn;
    btBtnExcluirItem: TBitBtn;
    lblValorTotal: TLabel;
    qryValorTotal: TSQLQuery;
    dspValorTotal: TDataSetProvider;
    cdsValorTotal: TClientDataSet;
    dsValorTotal: TDataSource;
    qryValorTotalTotal: TFMTBCDField;
    cdsValorTotalTotal: TFMTBCDField;
    qryItensCODIGO: TIntegerField;
    qryItenscodProduto: TIntegerField;
    qryItensProduto: TStringField;
    qryItensQUANTIDADE: TIntegerField;
    qryItensVALOR_UNITARIO: TFMTBCDField;
    qryItensVALOR_TOTAL: TFMTBCDField;
    cdsItensCODIGO: TIntegerField;
    cdsItenscodProduto: TIntegerField;
    cdsItensProduto: TStringField;
    cdsItensQUANTIDADE: TIntegerField;
    cdsItensVALOR_UNITARIO: TFMTBCDField;
    cdsItensVALOR_TOTAL: TFMTBCDField;
    ToolButton1: TToolButton;
    tlBtnFinalizar: TToolButton;
    rdGrpSexo: TRadioGroup;
    Label1: TLabel;
    edFuncionario: TEdit;
    btBtnAbreFuncionario: TBitBtn;
    btBtnConfirmar: TBitBtn;
    procedure edClienteEnter(Sender: TObject);
    procedure mEdDataInicioEnter(Sender: TObject);
    procedure mEdDataFinalEnter(Sender: TObject);
    procedure mmObservacaoEnter(Sender: TObject);
    procedure mmObservacaoExit(Sender: TObject);
    procedure mEdDataInicioExit(Sender: TObject);
    procedure mEdDataFinalExit(Sender: TObject);
    procedure edClienteExit(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure btBtnAbreClienteClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure edValorTotalKeyPress(Sender: TObject; var Key: Char);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btBtnInserirItemClick(Sender: TObject);
    procedure btBtnExcluirItemClick(Sender: TObject);
    procedure tlBtnFinalizarClick(Sender: TObject);
    procedure btBtnAbreFuncionarioClick(Sender: TObject);
    procedure edFuncionarioEnter(Sender: TObject);
    procedure edFuncionarioExit(Sender: TObject);
    procedure btBtnConfirmarClick(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress
    fechar: boolean; //se pode ou não fechar tela - casos de novo/editar, em que não pode fechar
    valorTotal: Real; //valor total da locação

    (*PROCEDURES DE CONTROLE*)
    function verificaSalva(): boolean; //verifica se os campos obrigatórios foram inseridos antes de salvar
    procedure visibilidade(opc: Integer);//quais componentes exibir/ocultar
    procedure iniciaTransacao();//dispara uma transação

    (*PROCEDURES ESPECÍFICAS*)
    procedure pegaItens(); //pega itens da locação atual
  public
    codCliente: Integer; //controle do cliente
    codFuncionario: Integer; //controle do funcionário
    operacao: String; //recebe valor para saber em que modo inicia a tela

    procedure limpar();//limpar componentes
  end;

var
  frmLocacao: TfrmLocacao;

implementation

uses unSelecionaCliente, unDM, unSelecionaProduto, unValorPago,
  unSelecionaFuncionario, unPrincipal;

{$R *.dfm}

(*PROCEDURES ESPECÍFICAS*)

//pega itens da locação atual
procedure TfrmLocacao.pegaItens();
begin
  //itens da locação
  qryItens.Close;
  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT i.codigo,p.codigo AS "codProduto",p.nome AS "Produto", i.quantidade,i.valor_unitario,i.valor_total ');
  qryItens.SQL.Add('FROM produto p, item_locacao i');
  qryItens.SQL.Add('WHERE i.cod_produto=p.codigo AND i.cod_locacao=:codLoc');
  qryItens.ParamByName('codLoc').AsInteger := StrToInt(edCodigo.Text);
  qryItens.Prepared := true;
  qryItens.Open;
  cdsItens.Open;
  cdsItens.Refresh;
  if (cdsItens.RecordCount=0) then
    btBtnExcluirItem.Enabled := false
  else
    btBtnExcluirItem.Enabled := true;

  //valor total da locação
  qryValorTotal.Close;
  qryValorTotal.SQL.Clear;
  qryValorTotal.SQL.Add('SELECT SUM (i.valor_total) AS "Total" ');
  qryValorTotal.SQL.Add('FROM produto p, item_locacao i ');
  qryValorTotal.SQL.Add('WHERE i.cod_produto=p.codigo AND i.cod_locacao=:codLoc');
  qryValorTotal.ParamByName('codLoc').AsInteger := StrToInt(edCodigo.Text);
  qryValorTotal.Prepared := true;
  qryValorTotal.Open;
  cdsValorTotal.Open;
  cdsValorTotal.Refresh;

  lblValorTotal.Caption := FormatFloat('#0.00',cdsValorTotalTotal.AsFloat);
end;
(*FIM PROCEDURES ESPECÍFICAS*)


(*PROCEDURES DE CONTROLE*)

{dispara uma transação}
procedure TfrmLocacao.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

{limpar componentes}
procedure TfrmLocacao.limpar();
begin
  codCliente := 0;
  codFuncionario := 0;
  valorTotal := 0;

  edCodigo.Clear;
  edFuncionario.Clear;
  edCliente.Clear;
  rdGrpSexo.ItemIndex := -1;
  mEdDataInicio.Clear;
  mEdDataFinal.Clear;
  mmObservacao.Clear;
  lblValorTotal.Caption :=  '0,00';

  qryItens.Close;
  cdsItens.Close;
end;

{verifica se os campos obrigatórios foram inseridos antes de salvar}
function TfrmLocacao.verificaSalva(): boolean;
var
  campos: String;
  retorno: boolean;
  dtIni,dtFin: TDateTime;
begin

  campos := '';
  retorno := true;

  dtIni := StrToDateTime(mEdDataInicio.Text);
  dtFin := StrToDateTime(mEdDataFinal.Text);

  //Data Final menor que a Data de Início
  if (retorno=true)then
    begin
    if (dtFin <= dtIni) then
      begin
      MessageDlg('A Data Final deve ser maior que a Data de Início!',mtInformation,[mbOK],0);
      retorno := false;
      mEdDataFinal.SetFocus;
      end;
    end;

  campos := '';
  retorno := true;

  if (codCliente = 0)then
    campos := 'Cliente';

  if (rdGrpSexo.ItemIndex=-1) then
    begin
    if (campos = '') then
      campos := 'Sexo'
    else
      campos := campos + ', Sexo';
    end;


  if (mEdDataInicio.Text = '  /  /       :  ') then
    begin
    if (campos = '') then
      campos := 'Data de Início'
    else
      campos := campos + ', Data de Início';
    end;

  if (mEdDataFinal.Text = '  /  /       :  ') then
    begin
    if (campos = '') then
      campos := 'Data Final'
    else
      campos := campos + ', Data Final';
    end;

  if (campos <> '') then
    begin
    MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
    retorno := false;
    end;

  Result := retorno;
end;

{quais componentes exibir/ocultar}
 procedure TfrmLocacao.visibilidade(opc: Integer);
begin

  {
  1 = novo
  21 = salvar
  41 = cancelar
  }

  case opc of
    {novo}
    1:  begin
        grpBxDadosLocacao.Enabled := true;
        grpBxItensLocacao.Enabled := false;
        tlBtnNovo.Enabled := false;
        btBtnConfirmar.Enabled := true;
        tlBtnCancelar.Enabled := true;
        tlBtnFinalizar.Enabled := false;
        rdGrpSexo.ItemIndex := 0;
        mEdDataInicio.Text := DateTimeToStr(Now);
        mEdDataFinal.Text := DateTimeToStr(Now+2);
        btBtnAbreFuncionario.SetFocus;
        end;

    {salvar}
    21: begin
        grpBxDadosLocacao.Enabled := false;
        grpBxItensLocacao.Enabled := true;
        tlBtnNovo.Enabled := false;
        btBtnConfirmar.Enabled := false;
        tlBtnCancelar.Enabled := true;
        tlBtnFinalizar.Enabled := true;
        end;

    {cancelar}
    41: begin
        grpBxDadosLocacao.Enabled := false;
        grpBxItensLocacao.Enabled := false;
        tlBtnNovo.Enabled := true;
        btBtnConfirmar.Enabled := false;
        tlBtnCancelar.Enabled := false;
        tlBtnFinalizar.Enabled := false;
        end;
  end;//case
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmLocacao.edClienteEnter(Sender: TObject);
begin
  edCliente.Color := clMoneyGreen;
end;

procedure TfrmLocacao.mEdDataInicioEnter(Sender: TObject);
begin
  mEdDataInicio.Color := clMoneyGreen;
end;

procedure TfrmLocacao.mEdDataFinalEnter(Sender: TObject);
begin
  mEdDataFinal.Color := clMoneyGreen;
end;

procedure TfrmLocacao.mmObservacaoEnter(Sender: TObject);
begin
  mmObservacao.Color := clMoneyGreen;
end;

procedure TfrmLocacao.mmObservacaoExit(Sender: TObject);
begin
  mmObservacao.Color := clWindow;
end;

procedure TfrmLocacao.mEdDataInicioExit(Sender: TObject);
begin
  mEdDataInicio.Color := clWindow;
  mEdDataFinal.Text := DateTimeToStr(StrToDateTime(mEdDataInicio.Text)+2);  
end;

procedure TfrmLocacao.mEdDataFinalExit(Sender: TObject);
begin
  mEdDataFinal.Color := clWindow;
end;

procedure TfrmLocacao.edClienteExit(Sender: TObject);
begin
  edCliente.Color := clWindow;
end;

procedure TfrmLocacao.edCodigoExit(Sender: TObject);
begin
  edCodigo.Color := clWindow;
end;

procedure TfrmLocacao.btBtnAbreClienteClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaCliente,frmSelecionaCliente);
  frmSelecionaCliente.tela := 'locacao';
  frmSelecionaCliente.ShowModal;
  frmSelecionaCliente.Free;
end;

procedure TfrmLocacao.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmLocacao.edValorTotalKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmLocacao.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  fechar := false;
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';
  visibilidade(1);
  //usuário
  edFuncionario.Text := frmPrincipal.nomeUsuario;
  Self.codFuncionario := frmPrincipal.codUsuario;  
end;

procedure TfrmLocacao.tlBtnCancelarClick(Sender: TObject);
begin
  if (edCodigo.Text <> '') then
    begin
    try
      iniciaTransacao();
      DM.SQLConnection.StartTransaction(transacao);

      //alterando status do produto
      DM.qryItemLocacao.Close;
      DM.qryItemLocacao.SQL.Clear;
      DM.qryItemLocacao.SQL.Add('SELECT * FROM Item_Locacao WHERE cod_locacao=:codLoc');
      DM.qryItemLocacao.ParamByName('codLoc').AsInteger := StrToInt(edCodigo.Text);
      DM.qryItemLocacao.Prepared := true;
      DM.qryItemLocacao.Open;
      DM.cdsItemLocacao.Open;
      DM.cdsItemLocacao.Refresh;
      DM.cdsItemLocacao.First;
      if (DM.cdsItemLocacao.RecordCount <> 0) then
        begin
        while(not(DM.cdsItemLocacao.Eof)) do
          begin
          DM.qryProduto.Close;
          DM.qryProduto.SQL.Clear;
          DM.qryProduto.SQL.Add('UPDATE PRODUTO SET status=0 WHERE codigo=:cod');
          DM.qryProduto.ParamByName('cod').AsInteger := DM.cdsItemLocacaoCOD_PRODUTO.AsInteger;
          DM.qryProduto.Prepared := true;
          DM.qryProduto.ExecSQL();
          DM.cdsItemLocacao.Next;
          end;
        end;

      //deletando itens da locação
      DM.qryItemLocacao.Close;
      DM.qryItemLocacao.SQL.Clear;
      DM.qryItemLocacao.SQL.Add('DELETE FROM Item_Locacao WHERE cod_locacao=:codLoc');
      DM.qryItemLocacao.ParamByName('codLoc').AsInteger := StrToInt(edCodigo.Text);
      DM.qryItemLocacao.Prepared := true;
      DM.qryItemLocacao.ExecSQL();

      //deletando locação
      DM.qryLocacao.Close;
      DM.qryLocacao.SQL.Clear;
      DM.qryLocacao.SQL.Add('DELETE FROM Locacao WHERE codigo=:cod ');
      DM.qryLocacao.ParamByName('cod').AsInteger := StrToInt(edCodigo.Text);
      DM.qryLocacao.Prepared := true;
      DM.qryLocacao.ExecSQL();

      DM.SQLConnection.Commit(transacao);
      MessageDlg('Locação cancelada com sucesso!',mtInformation,[mbOk],0);
      limpar();
      StatusBar.Panels[1].Text := '';
      fechar := true;
      visibilidade(41);
    except
      MessageDlg('Locação não pode ser cancelada!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
      DM.SQLConnection.Rollback(transacao);
    end;
    end
  else
    begin
    limpar();
    StatusBar.Panels[1].Text := '';
    fechar := true;
    visibilidade(41);
    end;
end;

procedure TfrmLocacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ((fechar = false)or(tlBtnFinalizar.Enabled=true)) then
    begin
    MessageDlg('Finalize ou cancele a locação!',mtInformation,[mbOK],0);
    Action := caNone;
    end

  else
  operacao := '';
end;

procedure TfrmLocacao.FormShow(Sender: TObject);
begin
  if(operacao<>'reserva')then
    begin
    limpar();
    fechar := true;
    visibilidade(41);
    end;

  if(operacao='reserva')then
      pegaItens();

  if (operacao = 'novo') then
    tlBtnNovoClick(Sender);

  StatusBar.Panels[1].Text := '';
end;

procedure TfrmLocacao.btBtnInserirItemClick(Sender: TObject);
begin
 Application.CreateForm(TfrmSelecionaProduto,frmSelecionaProduto);
  frmSelecionaProduto.tela := 'locacao';
  frmSelecionaProduto.codOperacao := StrToInt(edCodigo.Text);
  frmSelecionaProduto.datIni := StrToDateTime(mEdDataInicio.Text);
  frmSelecionaProduto.datFin := StrToDateTime(mEdDataFinal.Text);
  frmSelecionaProduto.ShowModal;
  frmSelecionaProduto.Free;

  pegaItens();
end;

procedure TfrmLocacao.btBtnExcluirItemClick(Sender: TObject);
var
  produto: String;
begin
  produto := cdsItensProduto.AsString;

  if(cdsItens.RecordCount <> 0)then
    begin
    if (MessageDlg('Deseja deletar o Produto '+produto+' da locação atual?',mtConfirmation,[mbYes,mbNo],0)=mrYes) then
      begin
      try
        iniciaTransacao();
        DM.SQLConnection.StartTransaction(transacao);

        DM.qryProduto.Close;
        DM.qryProduto.SQL.Clear;
        DM.qryProduto.SQL.Add('UPDATE Produto SET status=0 WHERE codigo=:cod');
        DM.qryProduto.ParamByName('cod').AsInteger := cdsItenscodProduto.AsInteger;
        DM.qryProduto.Prepared := true;
        DM.qryProduto.ExecSQL();

        DM.qryItemLocacao.Close;
        DM.qryItemLocacao.SQL.Clear;
        DM.qryItemLocacao.SQL.Add('DELETE FROM Item_Locacao l WHERE l.codigo=:cod');
        DM.qryItemLocacao.ParamByName('cod').AsInteger := cdsItensCODIGO.AsInteger;
        DM.qryItemLocacao.Prepared := true;
        DM.qryItemLocacao.ExecSQL();

        DM.SQLConnection.Commit(transacao);
        MessageDlg('Produto '+produto+' deletado com sucesso!',mtInformation,[mbOK],0);
      except
        DM.SQLConnection.Rollback(transacao);
        MessageDlg('Produto '+produto+' não pode ser deletado!',mtError,[mbOK],0);
      end;
      end;
    end
  else
    MessageDlg('Não há produtos na locação para serem deletados!',mtInformation,[mbOK],0);
  pegaItens();
end;

procedure TfrmLocacao.tlBtnFinalizarClick(Sender: TObject);
begin
  pegaItens();
  if(cdsItens.RecordCount=0)then
    MessageDlg('Não há nenhum item na Locação!',mtInformation,[mbOK],0)
  else
    begin
    Application.CreateForm(TfrmValorPago,frmValorPago);

    frmValorPago.tela := 'locacao';
    //código locação
    frmValorPago.codOperacao := StrToInt(edCodigo.Text);
    frmValorPago.codCliente := Self.codCliente;
    frmValorPago.codFuncionario := Self.codFuncionario;
    frmValorPago.lblFuncionario.Caption := edFuncionario.Text;
    frmValorPago.lblInfOperacao.Caption := 'LOCAÇÃO:';
    frmValorPago.lblOperacao.Caption := edCodigo.Text;
    //valor total locação
    frmValorPago.edValorTotal.Text := lblValorTotal.Caption;
    frmValorPago.vlrTotal := StrToFloat(lblValorTotal.Caption);

    frmValorPago.ShowModal;
    frmValorPago.Free;
    fechar := true;
    visibilidade(41);
    Self.Close;
    end;
end;

procedure TfrmLocacao.btBtnAbreFuncionarioClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaFuncionario,frmSelecionaFuncionario);
  frmSelecionaFuncionario.tela := 'locacao';
  frmSelecionaFuncionario.ShowModal;
  frmSelecionaFuncionario.Free;
end;

procedure TfrmLocacao.edFuncionarioEnter(Sender: TObject);
begin
  edFuncionario.Color := clMoneyGreen;
end;

procedure TfrmLocacao.edFuncionarioExit(Sender: TObject);
begin
  edFuncionario.Color := clWindow;
end;

procedure TfrmLocacao.btBtnConfirmarClick(Sender: TObject);
begin
  if (verificaSalva = true) then
    begin
    try
    iniciaTransacao();
    DM.SQLConnection.StartTransaction(transacao);

    DM.qryLocacao.Close;
    DM.qryLocacao.SQL.Clear;
    //sem funcionário
    if (Self.codFuncionario=0)then
      begin
      DM.qryLocacao.SQL.Add('INSERT INTO Locacao (data_locacao,cod_cliente,sexo,data_inicio,data_final,observacoes,status) ');
      DM.qryLocacao.SQL.Add('VALUES (:datLoc,:codCli,:sex,:datIni,:datFin,:obs,:sta)');
      end
    else
    //com funcionário
      begin
      DM.qryLocacao.SQL.Add('INSERT INTO Locacao (cod_funcionario,data_locacao,cod_cliente,sexo,data_inicio,data_final,observacoes,status) ');
      DM.qryLocacao.SQL.Add('VALUES (:codFun,:datLoc,:codCli,:sex,:datIni,:datFin,:obs,:sta)');
      DM.qryLocacao.ParamByName('codFun').AsInteger := Self.codFuncionario;
      end;

    DM.qryLocacao.ParamByName('datLoc').AsSQLTimeStamp := DateTimeToSQLTimeStamp(Now);
    DM.qryLocacao.ParamByName('codCli').AsInteger := codCliente;
    case rdGrpSexo.ItemIndex of
      0: DM.qryLocacao.ParamByName('sex').AsString := 'Masculino';
      1:  DM.qryLocacao.ParamByName('sex').AsString := 'Feminino';
    end;
    DM.qryLocacao.ParamByName('datIni').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataInicio.Text);
    DM.qryLocacao.ParamByName('datFin').AsSQLTimeStamp := StrToSQLTimeStamp(mEdDataFinal.Text);
    DM.qryLocacao.ParamByName('obs').AsString := mmObservacao.Text;
    DM.qryLocacao.ParamByName('sta').AsInteger := 0; //aberta

    DM.qryLocacao.Prepared := true;
    DM.qryLocacao.ExecSQL();

    DM.SQLConnection.Commit(transacao);
    MessageDlg('Locação salva com sucesso!',mtInformation,[mbOk],0);

    //pegando úlitma locação
    DM.qryLocacao.Close;
    DM.qryLocacao.SQL.Clear;
    DM.qryLocacao.SQL.Add('SELECT * FROM Locacao l ORDER BY l.codigo');
    DM.qryLocacao.Prepared := true;
    DM.qryLocacao.Open;
    DM.cdsLocacao.Open;
    DM.cdsLocacao.Refresh;
    DM.cdsLocacao.Last;
    edCodigo.Text := DM.cdsLocacaoCODIGO.AsString;
    except
      MessageDlg('Locação não pode ser salva!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
      DM.SQLConnection.Rollback(transacao);
    end;

    StatusBar.Panels[1].Text := 'OPERAÇÃO = Salvar';
    visibilidade(21);
    end;
end;

end.
