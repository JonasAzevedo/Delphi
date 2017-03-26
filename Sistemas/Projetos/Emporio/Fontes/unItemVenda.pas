unit unItemVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AppEvnts, ComCtrls, ImgList, ToolWin, Buttons,DBXpress,
  FMTBcd, DB, SqlExpr, DBClient, Provider, ACBrBase, ACBrBAL;

type
  TfrmItemVenda = class(TForm)
    ApplicationEvents: TApplicationEvents;
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    imgLista: TImageList;
    tlBtnCancelar: TToolButton;
    StatusBar: TStatusBar;
    grpBxDadosItemVenda: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edProduto: TEdit;
    lblProduto: TLabel;
    edQuantidade: TEdit;
    edValor: TEdit;
    btBtnAbreProduto: TBitBtn;
    qryProduto: TSQLQuery;
    dspProduto: TDataSetProvider;
    qryProdutoCODIGO: TIntegerField;
    qryProdutoNOME: TStringField;
    qryProdutoDESCRICAO: TStringField;
    qryProdutoVALOR_PAGO: TFMTBCDField;
    qryProdutoVALOR_VENDA: TFMTBCDField;
    qryProdutoESTOQUE: TFMTBCDField;
    cdsProduto: TClientDataSet;
    cdsProdutoCODIGO: TIntegerField;
    cdsProdutoNOME: TStringField;
    cdsProdutoDESCRICAO: TStringField;
    cdsProdutoVALOR_PAGO: TFMTBCDField;
    cdsProdutoVALOR_VENDA: TFMTBCDField;
    cdsProdutoESTOQUE: TFMTBCDField;
    tlBtnSalvar: TToolButton;
    lblValorVenda: TLabel;
    ACBrBAL: TACBrBAL;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure edProdutoEnter(Sender: TObject);
    procedure edQuantidadeEnter(Sender: TObject);
    procedure edValorEnter(Sender: TObject);
    procedure edProdutoExit(Sender: TObject);
    procedure edQuantidadeExit(Sender: TObject);
    procedure edValorExit(Sender: TObject);
    procedure edQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edValorKeyPress(Sender: TObject; var Key: Char);
    procedure btBtnAbreProdutoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure ACBrBALLePeso(Peso: Double; Resposta: String);
  private
    (*VARI�VEIS DE CONTROLE*)
    Transacao: TTransactionDesc;//transa��es - deve-se adicionar a uses DBXpress
    fechar: boolean; //se pode ou n�o fechar tela - casos de novo/editar, em que n�o pode fechar

    //balan�a
    usaBalanca: boolean;
    timeOut : Integer ;

    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
    function verificaSalva(): boolean; //verifica se os campos obrigat�rios foram inseridos antes de salvar
    procedure visibilidade(opc: Integer);//quais componentes exibir/ocultar
    procedure iniciaTransacao();//dispara uma transa��o
    procedure calcularValorItem(); //calcula valor do item da venda

    //balan�a
    Function Converte( cmd : String) : String;
    procedure balanca();
  public
   (*VARI�VEIS DE CONTROLE*)
    operacao: String; //recebe valor para saber em que modo inicia a tela

    codProduto: Integer; //c�digo do produto da venda
    nomeProduto: String; //nome do produto da venda
    estoqueProduto: Real; //quantidade em estoque do produto da venda
    valorProduto: Real; //valor da venda do produto

    (*PROCEDURES DE CONTROLE*)
    procedure pegaProduto();//pega produto do item da venda
  end;

var
  frmItemVenda: TfrmItemVenda;

implementation

uses unDataModule, unSelecionaProduto, unVenda;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

//BALAN�A
procedure TfrmItemVenda.balanca();
begin
   //ATIVANDO BALAN�A

   // se houver conec��o aberta, Fecha a conec��o
   if acbrBal.Ativo then
     ACBrBAL.Desativar;

   //selecionando configura��es da balan�a
   DM.qryBalanca.Close;
   DM.qryBalanca.SQL.Clear;
   DM.qryBalanca.SQL.Add('SELECT * FROM Balanca WHERE codigo=1');
   DM.qryBalanca.Prepared := true;
   DM.qryBalanca.Open;

   DM.cdsBalanca.Refresh;
   if (DM.cdsBalanca.RecordCount > 0)then
     begin
     //modelo
     if(DM.cdsBalancaBALANCA.AsString = 'Filizola')then
       ACBrBAL.Modelo := TACBrBALModelo(balFilizola)
     else if(DM.cdsBalancaBALANCA.AsString = 'Toledo')then
       ACBrBAL.Modelo := TACBrBALModelo(balToledo);
     //porta serial
     ACBrBAL.Device.Porta := DM.cdsBalancaPORTA_SERIAL.AsString;
     //velocidade
     ACBrBAL.Device.Baud := DM.cdsBalancaVELOCIDADE.AsInteger;
     //data bits
     ACBrBAL.Device.Data := DM.cdsBalancaDATA_BITS.AsInteger;
     //paridade
     if(DM.cdsBalancaPARIDADE.AsString='none')then
       ACBrBAL.Device.Parity := TACBrSerialParity(pNone)
     else if(DM.cdsBalancaPARIDADE.AsString='odd')then
       ACBrBAL.Device.Parity := TACBrSerialParity(pOdd)
     else if(DM.cdsBalancaPARIDADE.AsString='even')then
       ACBrBAL.Device.Parity := TACBrSerialParity(pEven)
     else if(DM.cdsBalancaPARIDADE.AsString='mark')then
       ACBrBAL.Device.Parity := TACBrSerialParity(pMark)
     else if(DM.cdsBalancaPARIDADE.AsString='space')then
       ACBrBAL.Device.Parity := TACBrSerialParity(pSpace);
     //stop bits
     if(DM.cdsBalancaSTOP_BITS.AsString='s1')then
       ACBrBAL.Device.Stop := TACBrSerialStop(s1)
     else if(DM.cdsBalancaSTOP_BITS.AsString='s1,5')then
       ACBrBAL.Device.Stop := TACBrSerialStop(s1emeio)
     else if(DM.cdsBalancaSTOP_BITS.AsString='s2')then
       ACBrBAL.Device.Stop := TACBrSerialStop(s2);
     //handShake
     if (DM.cdsBalancaHANDSHAKING.AsString='Nenhum')then
       ACBrBAL.Device.HandShake := TACBrHandShake(hsNenhum)
     else if (DM.cdsBalancaHANDSHAKING.AsString='XON/XOFF')then
       ACBrBAL.Device.HandShake := TACBrHandShake(hsXON_XOFF)
     else if (DM.cdsBalancaHANDSHAKING.AsString='RTS/CTS')then
       ACBrBAL.Device.HandShake := TACBrHandShake(hsRTS_CTS)
     else if (DM.cdsBalancaHANDSHAKING.AsString='DTR/DSR')then
       ACBrBAL.Device.HandShake := TACBrHandShake(hsDTR_DSR);
     //time out
     timeOut := DM.cdsBalancaTIME_OUT.AsInteger;
     //monitora
     if (DM.cdsBalancaMONITORA.AsInteger=1)then
       ACBrBAL.MonitorarBalanca := true
     else
       ACBrBAL.MonitorarBalanca := false;

     //conecta com a balan�a
     if (DM.cdsBalancaATIVA.AsInteger=1)then
       begin
       ACBrBAL.Ativar;
       usaBalanca := true;
       end
     else
       usaBalanca := false;
     end;
end;

function TfrmItemVenda.Converte(cmd: String): String;
var A : Integer ;
begin
  Result := '' ;
  For A := 1 to length( cmd ) do
  begin
     if not (cmd[A] in ['A'..'Z','a'..'z','0'..'9',
                        ' ','.',',','/','?','<','>',';',':',']','[','{','}',
                        '\','|','=','+','-','_',')','(','*','&','^','%','$',
                        '#','@','!','~',']' ]) then
        Result := Result + '#' + IntToStr(ord( cmd[A] )) + ' '
     else
        Result := Result + cmd[A] + ' ';
  end ;
end;

//FIM BALAN�A

{calcula valor do item da venda}
procedure TfrmItemVenda.calcularValorItem();
var
  qtde: Real;
  total: Real;
begin
   qtde := StrToFloat(edQuantidade.Text);
   total := qtde * valorProduto;
   edValor.Text := FormatFloat('#0.00',total);
end;

{pega produto do item da venda}
procedure TfrmItemVenda.pegaProduto();
begin
  //procurando por produto
  qryProduto.Close;
  qryProduto.SQL.Clear;
  qryProduto.SQL.Add('SELECT * FROM Produto p WHERE p.codigo=:cod');
  qryProduto.ParamByName('cod').AsInteger := StrToInt(edProduto.Text);
  qryProduto.Prepared := true;
  qryProduto.Open;

  cdsProduto.Refresh;

  if (cdsProduto.RecordCount > 0) then
    begin
    codProduto := cdsProdutoCODIGO.AsInteger;
    lblProduto.Caption := cdsProdutoNOME.AsString;
    estoqueProduto := cdsProdutoESTOQUE.AsFloat;
    valorProduto := cdsProdutoVALOR_VENDA.AsFloat;
    lblValorVenda.Caption := 'x   '+FormatFloat('#0.00',valorProduto);
    if (estoqueProduto >= 1) then
      edQuantidade.Text := '1,00'
    else
      edQuantidade.Text := FormatFloat('#0.00',estoqueProduto);
    end
  else
    begin
    MessageDlg('Nenhum Produto encontrado com o c�digo '+edProduto.Text,mtInformation,[mbOK],0);
    lblProduto.Caption := '';
    edProduto.SetFocus;
    end;

end;

procedure TfrmItemVenda.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

procedure TfrmItemVenda.limpar();

begin
  grpBxDadosItemVenda.Enabled := true;
  edProduto.Clear;
  edQuantidade.Clear;
  edValor.Clear;
  lblProduto.Caption := '';
  lblValorVenda.Caption := '';
  codProduto := 0;
  nomeProduto := '';
  estoqueProduto := 0;
end;

{verifica se os campos obrigat�rios foram inseridos antes de salvar}
function TfrmItemVenda.verificaSalva(): boolean;
var
  campos: String;
  continua: boolean;
  total: Real;
begin
    campos := '';
    continua := true;

    //caso a venda tenha valor total igual � zero
    total :=  StrToFloat(edValor.Text);
    if (total = 0) then
      begin
      if (MessageDlg('Item da Venda possui valor total igual � R$0,00.'+#13+'Deseja continuar assim mesmo?',mtConfirmation,[mbYes,mbNo],0)=mrNo) then
        begin
        continua := false;
        Result := false;
        end;
      end;

    //caso a venda tenha quantidade igual � zero
    total :=  StrToFloat(edQuantidade.Text);
    if (total = 0) then
      begin
      if (MessageDlg('Item da Venda possui quantidade igual � 0,00.'+#13+'Deseja continuar assim mesmo?',mtConfirmation,[mbYes,mbNo],0)=mrNo) then
        begin
        continua := false;
        Result := false;
        end;
      end;

    //verificando campos
    if (continua = true) then
      begin
      if (codProduto = 0)then
        campos := 'Produto';
      if (edQuantidade.Text = '')then
        begin
        if (campos = '')then
            campos := 'Quantidade'
          else
            campos := campos + ', Quantidade';
        end;
      if (edValor.Text = '')then
        begin
        if (campos = '')then
            campos := 'Valor'
          else
            campos := campos + ', Valor';
        end;

      if (campos <> '') then
        begin
        MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
        Result := false;
        end
      else
        Result := true;
    end;
end;

//quais componentes exibir/ocultar
procedure TfrmItemVenda.visibilidade(opc: Integer);
begin
//cuidar na visibilidade - caso pessoa jur�dica e f�sica

  {a seq��ncia n�merica pula de 10 em 10 - 1,2,3....11,12,13...
  1 = novo
  21 = salvar
  41 = cancelar
  }

  case opc of
    {novo}
    1: begin
       grpBxDadosItemVenda.Enabled := true;
       tlBtnNovo.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnCancelar.Enabled := true;
       end;

    {salvar}
    21: begin
       grpBxDadosItemVenda.Enabled := false;
       tlBtnNovo.Enabled := true;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;
       end;

    {cancelar}
    41: begin
       grpBxDadosItemVenda.Enabled := false;
       tlBtnNovo.Enabled := true;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;
       end;

  end;//case


end;          

(*FIM PROCEDURES DE CONTROLE*)



procedure TfrmItemVenda.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmItemVenda.edProdutoEnter(Sender: TObject);
begin
  edProduto.Color := clMedGray;
end;

procedure TfrmItemVenda.edQuantidadeEnter(Sender: TObject);
begin
  edQuantidade.Color := clMedGray;

  if (usaBalanca = true) then
    ACBrBAL.LePeso(TimeOut);
end;

procedure TfrmItemVenda.edValorEnter(Sender: TObject);
begin
  edValor.Color := clMedGray;
end;

procedure TfrmItemVenda.edProdutoExit(Sender: TObject);
begin
  edProduto.Color := clWindow;
  pegaProduto();
end;

procedure TfrmItemVenda.edQuantidadeExit(Sender: TObject);
var
  valor: Real;
begin
  try
    valor := StrToFloat(edQuantidade.Text);

    if (valor > estoqueProduto)then
      begin
      MessageDlg('O Produto s� possui '+ FormatFloat('#0.000',estoqueProduto) + ' em estoque!',mtInformation,[mbOK],0);
      if (estoqueProduto > 0) then
        edQuantidade.Text := '1,00'
      else
        edQuantidade.Text := FormatFloat('#0.000',estoqueProduto);
      end
    else
      edQuantidade.Text := FormatFloat('#0.000',valor);
      
    calcularValorItem();
  except
  end;

  edQuantidade.Color := clWindow;
end;

procedure TfrmItemVenda.edValorExit(Sender: TObject);
var
  valor: Real;
begin
  try
    valor := StrToFloat(edValor.Text);
    edValor.Text := FormatFloat('#0.00',valor);
  except
  end;

  edValor.Color := clWindow;
end;

procedure TfrmItemVenda.edQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmItemVenda.edProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9'])then
    Key:= #0;
end;

procedure TfrmItemVenda.edValorKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmItemVenda.btBtnAbreProdutoClick(Sender: TObject);
begin
  frmSelecionaProduto.btBtnSelecionarProduto.Caption := 'Selecionar Produto da Venda';
  frmSelecionaProduto.tela := 'venda';
  frmSelecionaProduto.ShowModal;
end;

procedure TfrmItemVenda.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (fechar = false) then
    begin
    MessageDlg('Salve ou cancele antes o processo que se encontra em opera��o!',mtInformation,[mbOK],0);
    Action := caNone;
    end

  else
    begin
    operacao := '';
    frmVenda.pegaItensVenda();
    end;
end;

procedure TfrmItemVenda.FormShow(Sender: TObject);
begin
  limpar();
  fechar := true;

  StatusBar.Panels[1].Text := '';
  visibilidade(41);

  //configura��es da balan�a
  balanca();

  if (operacao = 'novo') then
    tlBtnNovoClick(Sender);
end;

procedure TfrmItemVenda.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  visibilidade(1);
  StatusBar.Panels[1].Text := 'OPERA��O = Novo';
  fechar := false;

  edProduto.SetFocus;
end;

procedure TfrmItemVenda.tlBtnCancelarClick(Sender: TObject);
begin
  limpar();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmItemVenda.tlBtnSalvarClick(Sender: TObject);
var
  novoEstoque: Real;
  vPago,vBruto,vLiquido: Real;
begin
  btBtnAbreProduto.SetFocus;
  if (verificaSalva() = true) then
    begin
      try
      iniciaTransacao();
      DM.SQLConnection.StartTransaction(transacao);

      //salvando item da venda
      DM.qryItemVenda.Close;
      DM.qryItemVenda.SQL.Clear;
      DM.qryItemVenda.SQL.Add('INSERT INTO Item_Venda (cod_venda,cod_produto,quantidade,valor) ');
      DM.qryItemVenda.SQL.Add('VALUES(:codVen,:codPro,:qua,:val)');
      DM.qryItemVenda.ParamByName('codVen').AsInteger := frmVenda.codVenda;
      DM.qryItemVenda.ParamByName('codPro').AsInteger := codProduto;
      DM.qryItemVenda.ParamByName('qua').AsFloat := StrToFloat(edQuantidade.Text);
      DM.qryItemVenda.ParamByName('val').AsFloat := StrToFloat(edValor.Text);
      DM.qryItemVenda.Prepared := true;
      DM.qryItemVenda.ExecSQL();

      //alterando estoque do produto
      novoEstoque := estoqueProduto - StrToFloat(edQuantidade.Text);
      DM.qryProduto.Close;
      DM.qryProduto.SQL.Clear;
      DM.qryProduto.SQL.Add('UPDATE Produto p SET p.estoque=:est WHERE p.codigo=:cod');
      DM.qryProduto.ParamByName('est').AsFloat := novoEstoque;
      DM.qryProduto.ParamByName('cod').AsInteger := codProduto;
      DM.qryProduto.Prepared := true;
      DM.qryProduto.ExecSQL();

      //valores referentes � entradas
      vBruto := StrToFloat(edValor.Text);
      vPago := cdsProdutoVALOR_PAGO.AsFloat * StrToFloat(edQuantidade.Text);
      vLiquido := vBruto - vPago;

      frmVenda.valorBruto := frmVenda.valorBruto + StrToFloat(edValor.Text);
      frmVenda.valorLiquido := frmVenda.valorLiquido + vLiquido;

      DM.SQLConnection.Commit(transacao);
      fechar := true;
      visibilidade(21);
      except
        MessageDlg('Item da Venda n�o pode ser salvo!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
        DM.SQLConnection.Rollback(transacao);
      end;

  end;//if

  StatusBar.Panels[1].Text := 'OPERA��O = Salvar';
end;

procedure TfrmItemVenda.ACBrBALLePeso(Peso: Double; Resposta: String);
var
 valid : integer;
begin
   if (Peso > 0) then
     edQuantidade.Text := FormatFloat('#0.000',Peso)
   else
     edQuantidade.Text := '0,000';
end;

end.