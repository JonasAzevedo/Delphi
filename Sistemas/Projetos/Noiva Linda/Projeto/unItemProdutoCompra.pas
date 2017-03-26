unit unItemProdutoCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, ExtCtrls, StdCtrls, ImgList, ComCtrls, ToolWin,
  AppEvnts, Buttons;

type
  TfrmProdutoCompra = class(TForm)
    grpBxDadosProduto: TGroupBox;
    lblDescricao: TLabel;
    lblNome: TLabel;
    lblValorVenda: TLabel;
    lblValorLocacao: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edNome: TEdit;
    edValorVenda: TEdit;
    edValorLocacao: TEdit;
    mmDescricao: TMemo;
    edMarca: TEdit;
    edTamanho: TEdit;
    Bevel1: TBevel;
    pnlValorPago: TPanel;
    Label1: TLabel;
    edQuantidade: TEdit;
    Label4: TLabel;
    edValorUnitario: TEdit;
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnSalvar: TToolButton;
    imgLista: TImageList;
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    Label6: TLabel;
    edTipoProduto: TEdit;
    btBtnAbreTipoProduto: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edNomeEnter(Sender: TObject);
    procedure edMarcaEnter(Sender: TObject);
    procedure mmDescricaoEnter(Sender: TObject);
    procedure edTamanhoEnter(Sender: TObject);
    procedure edValorLocacaoEnter(Sender: TObject);
    procedure edValorVendaEnter(Sender: TObject);
    procedure edQuantidadeEnter(Sender: TObject);
    procedure edValorUnitarioEnter(Sender: TObject);
    procedure edValorUnitarioExit(Sender: TObject);
    procedure edQuantidadeExit(Sender: TObject);
    procedure edValorLocacaoExit(Sender: TObject);
    procedure edValorVendaExit(Sender: TObject);
    procedure mmDescricaoExit(Sender: TObject);
    procedure edMarcaExit(Sender: TObject);
    procedure edNomeExit(Sender: TObject);
    procedure edTamanhoExit(Sender: TObject);
    procedure edTamanhoKeyPress(Sender: TObject; var Key: Char);
    procedure edValorLocacaoKeyPress(Sender: TObject; var Key: Char);
    procedure edValorVendaKeyPress(Sender: TObject; var Key: Char);
    procedure edValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure edQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure btBtnAbreTipoProdutoClick(Sender: TObject);
    procedure edTipoProdutoEnter(Sender: TObject);
    procedure edTipoProdutoExit(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress

    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
    function verificaSalva(): boolean; //verifica se os campos obrigatórios foram inseridos antes de salvar
    procedure visibilidade(opc: Integer);//quais componentes exibir/ocultar
    procedure iniciaTransacao();//dispara uma transação
    //function pegaCodigo(): Integer;//pega código do Produto, conforme letra
  public
   (*VARIÁVEIS DE CONTROLE*)
    codTipoProduto: Integer; //controle do tipo de produto
      
    codOperacao: Integer; //código da compra
  end;

var
  frmProdutoCompra: TfrmProdutoCompra;

implementation

uses unDM, unSelecionaTipoProduto;

{$R *.dfm}

{pega código do Produto, conforme letra}
{function TfrmProdutoCompra.pegaCodigo(): Integer;
var
  letra: Integer;
  cod: Integer;
begin
  DM.qryCodigoProduto.Close;
  DM.qryCodigoProduto.SQL.Clear;
  DM.qryCodigoProduto.SQL.Add('SELECT * FROM Codigo_Produto c WHERE c.codigo=1');
  DM.qryCodigoProduto.Prepared := true;
  DM.qryCodigoProduto.Open;
  DM.cdsCodigoProduto.Open;
  DM.cdsCodigoProduto.Refresh;

  letra := cbBxLetraCodigo.ItemIndex;
  case letra of
    0: cod := DM.cdsCodigoProdutoA.AsInteger;
    1: cod := DM.cdsCodigoProdutoB.AsInteger;
    2: cod := DM.cdsCodigoProdutoC.AsInteger;
    3: cod := DM.cdsCodigoProdutoD.AsInteger;
    4: cod := DM.cdsCodigoProdutoE.AsInteger;
    5: cod := DM.cdsCodigoProdutoF.AsInteger;
    6: cod := DM.cdsCodigoProdutoG.AsInteger;
    7: cod := DM.cdsCodigoProdutoH.AsInteger;
    8: cod := DM.cdsCodigoProdutoI.AsInteger;
    9: cod := DM.cdsCodigoProdutoJ.AsInteger;
    10: cod := DM.cdsCodigoProdutoL.AsInteger;
    11: cod := DM.cdsCodigoProdutoM.AsInteger;
    12: cod := DM.cdsCodigoProdutoN.AsInteger;
    13: cod := DM.cdsCodigoProdutoO.AsInteger;
    14: cod := DM.cdsCodigoProdutoP.AsInteger;
    15: cod := DM.cdsCodigoProdutoQ.AsInteger;
    16: cod := DM.cdsCodigoProdutoR.AsInteger;
    17: cod := DM.cdsCodigoProdutoS.AsInteger;
    18: cod := DM.cdsCodigoProdutoT.AsInteger;
    19: cod := DM.cdsCodigoProdutoU.AsInteger;
    20: cod := DM.cdsCodigoProdutoV.AsInteger;
    21: cod := DM.cdsCodigoProdutoX.AsInteger;
    22: cod := DM.cdsCodigoProdutoZ.AsInteger;
    23: cod := DM.cdsCodigoProdutoY.AsInteger;
    24: cod := DM.cdsCodigoProdutoW.AsInteger;
    25: cod := DM.cdsCodigoProdutoK.AsInteger;
  end;

  inc(cod);

  Result := cod;
end;
}
(*PROCEDURES DE CONTROLE*)

{dispara uma transação}
procedure TfrmProdutoCompra.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

{limpar componentes}
procedure TfrmProdutoCompra.limpar();
begin
  edTipoProduto.Clear;
  Self.codTipoProduto := 0;
  edNome.Clear;
  edMarca.Clear;
  edTamanho.Clear;
  mmDescricao.Clear;
  edValorLocacao.Clear;
  edValorVenda.Clear;
  edQuantidade.Text := '1';
  edValorUnitario.Clear;
end;

{verifica se os campos obrigatórios foram inseridos antes de salvar}
function TfrmProdutoCompra.verificaSalva(): boolean;
var
  campos: String;
  retorno: boolean;
  qtde: Integer;
  vlrUnitario: Real;
begin

  campos := '';
  retorno := true;

  if (edNome.Text = '')then
    campos := 'Nome';

  if (Self.codTipoProduto=0) then
    begin
    if (campos='') then
      campos := 'Tipo de Produto'
    else
      campos := campos + ', Tipo de Produto';
    end;

  try
    qtde := StrToInt(edQuantidade.Text)
  except
    qtde := 0;
  end;
  if (qtde=0) then
    begin
    if(campos = '')then
      campos := 'Quantidade'
    else
      campos := campos + ', Quantidade';
    end;

  try
    vlrUnitario := StrToFloat(edValorUnitario.Text)
  except
    vlrUnitario := 0;
  end;
  if (vlrUnitario=0) then
    begin
    if(campos = '')then
      campos := 'Valor Unitário'
    else
      campos := campos + ', Valor Unitário';
    end;

  if (campos <> '') then
    begin
    MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
    retorno := false;
    end;

    Result := retorno;
end;


{quais componentes exibir/ocultar}
 procedure TfrmProdutoCompra.visibilidade(opc: Integer);
begin

  {
  1 = novo
  21 = salvar
  41 = cancelar
  }

  case opc of
    {novo}
    1: begin
       grpBxDadosProduto.Enabled := true;
       tlBtnNovo.Enabled := false;
       tlBtnSalvar.Enabled := true;
       btBtnAbreTipoProduto.SetFocus;
       end;

    {salvar}
    21: begin
       grpBxDadosProduto.Enabled := false;
       tlBtnNovo.Enabled := true;
       tlBtnSalvar.Enabled := false;
       end;

    {cancelar}
    41: begin
        grpBxDadosProduto.Enabled := false;
        tlBtnNovo.Enabled := true;
        tlBtnSalvar.Enabled := false;
        end;
  end;//case
end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmProdutoCompra.Button1Click(Sender: TObject);
var
  cod: Integer;
  qtde: Integer;
  i: Integer;
begin
  try
    iniciaTransacao();
    qtde := StrToInt(edQuantidade.Text);
    DM.SQLConnection.StartTransaction(transacao);
    //laço para inserir todos produtos deste tipo - quantidade
    for i:=1 to qtde do
      begin
      DM.qryProduto.Close;
      DM.qryProduto.SQL.Clear;
      DM.qryProduto.SQL.Add('INSERT INTO Produto (nome,marca,tamanho,descricao,valor_locacao,valor_venda,valor_pago,status) ');
      DM.qryProduto.SQL.Add('VALUES (:nom,:mar,:tam,:des,:valLoc,:valVen,:valPag,:sta)');

      DM.qryProduto.ParamByName('nom').AsString := edNome.Text;
      DM.qryProduto.ParamByName('mar').AsString := edMarca.Text;
      if (edTamanho.Text <> '') then
        DM.qryProduto.ParamByName('tam').AsInteger := StrToInt(edTamanho.Text)
      else
        DM.qryProduto.ParamByName('tam').AsInteger := 0;
      DM.qryProduto.ParamByName('des').AsString := mmDescricao.Text;
      if (edValorLocacao.Text <> '') then
        DM.qryProduto.ParamByName('valLoc').AsFloat := StrToFloat(edValorLocacao.Text)
      else
        DM.qryProduto.ParamByName('valLoc').AsFloat := 0;
      if (edValorVenda.Text <> '') then
        DM.qryProduto.ParamByName('valVen').AsFloat := StrToFloat(edValorVenda.Text)
      else
        DM.qryProduto.ParamByName('valVen').AsFloat := 0;
      if (edValorUnitario.Text <> '') then
        DM.qryProduto.ParamByName('valPag').AsFloat := StrToFloat(edValorUnitario.Text)
      else
        DM.qryProduto.ParamByName('valPag').AsFloat := 0;
      DM.qryProduto.ParamByName('sta').AsInteger := 0;

      DM.qryProduto.Prepared := true;
      DM.qryProduto.ExecSQL();

      //pegando código do produto
      DM.qryProduto.Close;
      DM.qryProduto.SQL.Clear;
      DM.qryProduto.SQL.Add('SELECT * FROM Produto p ORDER BY p.codigo');
      DM.qryProduto.Prepared := true;
      DM.qryProduto.Open;
      DM.cdsProduto.Open;
      DM.cdsProduto.Refresh;
      cod := DM.cdsProdutoCODIGO.AsInteger;

      //inserindo intem da compra
      DM.qryItemCompra.Close;
      DM.qryItemCompra.SQL.Clear;
      DM.qryItemCompra.SQL.Add('INSERT INTO Item_Compra(cod_compra,cod_produto,valor_total) ');
      DM.qryItemCompra.SQL.Add('VALUES (:codCom,:codPro,:valTot)');
      DM.qryItemCompra.ParamByName('codCom').AsInteger := Self.codOperacao;
      DM.qryItemCompra.ParamByName('codPro').AsInteger := cod;
      DM.qryItemCompra.ParamByName('valTot').AsFloat := StrToFloat(edValorUnitario.Text);
      DM.qryItemCompra.Prepared := true;
      DM.qryItemCompra.ExecSQL();

      end; //for

    DM.SQLConnection.Commit(transacao);
    MessageDlg('Produto salvo com sucesso!',mtInformation,[mbOk],0);
  except
    DM.SQLConnection.Rollback(transacao);
    MessageDlg('Produto não pode ser inserido!',mtInformation,[mbOK],0);
  end;
end;

procedure TfrmProdutoCompra.tlBtnSalvarClick(Sender: TObject);
var
  cod: Integer;
  qtde: Integer;
  i: Integer;
  codLetra: Integer;
begin
  if (verificaSalva()=true)then
    begin
    try
      iniciaTransacao();
      qtde := StrToInt(edQuantidade.Text);
      DM.SQLConnection.StartTransaction(transacao);
      //laço para inserir todos produtos deste tipo - quantidade
      for i:=1 to qtde do
        begin
        DM.qryProduto.Close;
        DM.qryProduto.SQL.Clear;
        DM.qryProduto.SQL.Add('INSERT INTO Produto (cod_tipo_produto,nome,marca,tamanho,descricao,valor_locacao,valor_venda,valor_pago,status) ');
        DM.qryProduto.SQL.Add('VALUES (:co_ti_pr,:nom,:mar,:tam,:des,:valLoc,:valVen,:valPag,:sta)');

        DM.qryProduto.ParamByName('co_ti_pr').AsInteger := Self.codTipoProduto;
        DM.qryProduto.ParamByName('nom').AsString := edNome.Text;
        DM.qryProduto.ParamByName('mar').AsString := edMarca.Text;
        if (edTamanho.Text <> '') then
          DM.qryProduto.ParamByName('tam').AsInteger := StrToInt(edTamanho.Text)
        else
          DM.qryProduto.ParamByName('tam').AsInteger := 0;
        DM.qryProduto.ParamByName('des').AsString := mmDescricao.Text;
        if (edValorLocacao.Text <> '') then
          DM.qryProduto.ParamByName('valLoc').AsFloat := StrToFloat(edValorLocacao.Text)
        else
          DM.qryProduto.ParamByName('valLoc').AsFloat := 0;
        if (edValorVenda.Text <> '') then
          DM.qryProduto.ParamByName('valVen').AsFloat := StrToFloat(edValorVenda.Text)
        else
          DM.qryProduto.ParamByName('valVen').AsFloat := 0;
        if (edValorUnitario.Text <> '') then
          DM.qryProduto.ParamByName('valPag').AsFloat := StrToFloat(edValorUnitario.Text)
        else
          DM.qryProduto.ParamByName('valPag').AsFloat := 0;
        DM.qryProduto.ParamByName('sta').AsInteger := 0;

        DM.qryProduto.Prepared := true;
        DM.qryProduto.ExecSQL();

        //pegando código do produto
        DM.qryProduto.Close;
        DM.qryProduto.SQL.Clear;
        DM.qryProduto.SQL.Add('SELECT * FROM Produto p ORDER BY p.codigo');
        DM.qryProduto.Prepared := true;
        DM.qryProduto.Open;
        DM.cdsProduto.Open;
        DM.cdsProduto.Refresh;
        DM.cdsProduto.Last;
        cod := DM.cdsProdutoCODIGO.AsInteger;

        //inserindo intem da compra
        DM.qryItemCompra.Close;
        DM.qryItemCompra.SQL.Clear;
        DM.qryItemCompra.SQL.Add('INSERT INTO Item_Compra(cod_compra,cod_produto,valor_total) ');
        DM.qryItemCompra.SQL.Add('VALUES (:codCom,:codPro,:valTot)');
        DM.qryItemCompra.ParamByName('codCom').AsInteger := Self.codOperacao;
        DM.qryItemCompra.ParamByName('codPro').AsInteger := cod;
        DM.qryItemCompra.ParamByName('valTot').AsFloat := StrToFloat(edValorUnitario.Text);
        DM.qryItemCompra.Prepared := true;
        DM.qryItemCompra.ExecSQL();
        end; //for

      DM.SQLConnection.Commit(transacao);
      MessageDlg('Produto salvo com sucesso!',mtInformation,[mbOk],0);
      StatusBar.Panels[1].Text := 'OPERAÇÃO = Salvar';
      visibilidade(21);
    except
      DM.SQLConnection.Rollback(transacao);
      MessageDlg('Produto não pode ser inserido!',mtInformation,[mbOK],0);
    end;
    end;
end;

procedure TfrmProdutoCompra.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';
  visibilidade(1);
end;

procedure TfrmProdutoCompra.FormShow(Sender: TObject);
begin
  limpar();

  StatusBar.Panels[1].Text := '';
  visibilidade(41);
end;

procedure TfrmProdutoCompra.edNomeEnter(Sender: TObject);
begin
  edNome.Color := clMoneyGreen;
end;

procedure TfrmProdutoCompra.edMarcaEnter(Sender: TObject);
begin
  edMarca.Color := clMoneyGreen;
end;

procedure TfrmProdutoCompra.mmDescricaoEnter(Sender: TObject);
begin
  mmDescricao.Color := clMoneyGreen;
end;

procedure TfrmProdutoCompra.edTamanhoEnter(Sender: TObject);
begin
  edTamanho.Color := clMoneyGreen;
end;

procedure TfrmProdutoCompra.edValorLocacaoEnter(Sender: TObject);
begin
  edValorLocacao.Color := clMoneyGreen;
end;

procedure TfrmProdutoCompra.edValorVendaEnter(Sender: TObject);
begin
  edValorVenda.Color := clMoneyGreen;
end;

procedure TfrmProdutoCompra.edQuantidadeEnter(Sender: TObject);
begin
  edQuantidade.Color := clMoneyGreen;
end;

procedure TfrmProdutoCompra.edValorUnitarioEnter(Sender: TObject);
begin
  edValorUnitario.Color := clMoneyGreen;
end;

procedure TfrmProdutoCompra.edValorUnitarioExit(Sender: TObject);
begin
  try
    edValorUnitario.Text := FormatFloat('#0.00',StrToFloat(edValorUnitario.Text));
  except
  end;

  edValorUnitario.Color := clWindow;
end;

procedure TfrmProdutoCompra.edQuantidadeExit(Sender: TObject);
begin
  edQuantidade.Color := clWindow;
end;

procedure TfrmProdutoCompra.edValorLocacaoExit(Sender: TObject);
begin
  try
    edValorLocacao.Text := FormatFloat('#0.00',StrToFloat(edValorLocacao.Text));
  except
  end;
  edValorLocacao.Color := clWindow;
end;

procedure TfrmProdutoCompra.edValorVendaExit(Sender: TObject);
begin
  try
    edValorVenda.Text := FormatFloat('#0.00',StrToFloat(edValorVenda.Text));
  except
  end;

  edValorVenda.Color := clWindow;
end;

procedure TfrmProdutoCompra.mmDescricaoExit(Sender: TObject);
begin
  mmDescricao.Color := clWindow;
end;

procedure TfrmProdutoCompra.edMarcaExit(Sender: TObject);
begin
  edMarca.Color := clWindow;
end;

procedure TfrmProdutoCompra.edNomeExit(Sender: TObject);
begin
  edNome.Color := clWindow;
end;

procedure TfrmProdutoCompra.edTamanhoExit(Sender: TObject);
begin
  edTamanho.Color := clWindow;
end;

procedure TfrmProdutoCompra.edTamanhoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Key in['0'..'9',Chr(8)])then
    Key:= #0;
end;

procedure TfrmProdutoCompra.edValorLocacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmProdutoCompra.edValorVendaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmProdutoCompra.edValorUnitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmProdutoCompra.edQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Key in['0'..'9',Chr(8)])then
    Key:= #0;
end;

procedure TfrmProdutoCompra.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmProdutoCompra.btBtnAbreTipoProdutoClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaTipoProduto,frmSelecionaTipoProduto);
  frmSelecionaTipoProduto.tela := 'tipoProduto';
  frmSelecionaTipoProduto.ShowModal;
  frmSelecionaTipoProduto.Free;
end;

procedure TfrmProdutoCompra.edTipoProdutoEnter(Sender: TObject);
begin
  edTipoProduto.Color := clMoneyGreen;
end;

procedure TfrmProdutoCompra.edTipoProdutoExit(Sender: TObject);
begin
  edTipoProduto.Color := clWindow;
end;

end.
