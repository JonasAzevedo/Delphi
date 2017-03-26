unit unCadPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvPageControl, ComCtrls, StdCtrls, AdvGroupBox, plsEdit, Mask,
  plsTMaskEdit, plsComboBox, plsMemo, AdvGlowButton, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Provider, DB, DBClient, ExtCtrls,
  jpeg, Buttons, unFuncoes, unLocalizarCliente, unLocalizarDescricaoProdutos, unLocalizarPedido,
  unFrmBasico, ImgList, AppEvnts, AdvPanel, unCliente, Grids, DBGrids,
  ToolWin, Menus;

type
  TfrmCadPedido = class(TFrmBasico)
    imgBotoes: TImageList;
    ApplicationEvents: TApplicationEvents;
    cdsItensPedidoUnidadeComboBox: TClientDataSet;
    cdsItensPedidoUnidadeComboBoxunidade: TStringField;
    cdsItensPedido: TClientDataSet;
    cdsItensPedidoquantidade: TIntegerField;
    cdsItensPedidounidade: TStringField;
    cdsItensPedidodescricao: TStringField;
    cdsItensPedidocomplemento: TStringField;
    cdsItensPedidounidadeCombo: TStringField;
    dsItensPedido: TDataSource;
    cdsItensPedidostatus: TIntegerField;
    pmRelatoriosPedido: TPopupMenu;
    mitRelatorioPedido: TMenuItem;
    pgCtrlPedido: TAdvPageControl;
    tbCliente: TAdvTabSheet;
    grpBxEndereco: TGroupBox;
    lblEnderecoEstado: TLabel;
    lblEnderecoBairro: TLabel;
    lblEnderecoRua: TLabel;
    lblEnderecoCEP: TLabel;
    lblEnderecoComplemento: TLabel;
    lbllblEnderecoCidade: TLabel;
    lblEnderecoNumero: TLabel;
    cbBxEnderecoEstado: TPlsComboBox;
    edEnderecoBairro: TPlsEdit;
    edEnderecoRua: TPlsEdit;
    medEnderecoCEP: TPlsMaskEdit;
    mmEnderecoComplemento: TPlsMemo;
    edEnderecoCidade: TPlsEdit;
    edEnderecoNumero: TPlsEdit;
    sbCliente: TStatusBar;
    pnlDadosCliente: TPanel;
    lblCodigo: TLabel;
    lblNome: TLabel;
    lblCPF: TLabel;
    lblDataNascimento: TLabel;
    lblEmail: TLabel;
    lblTelefone1: TLabel;
    lblTelefone2: TLabel;
    lblCNPJ: TLabel;
    lblIdentidade: TLabel;
    lblProfissao: TLabel;
    lblData: TLabel;
    edEmail: TPlsEdit;
    medTelefone1: TPlsMaskEdit;
    medTelefone2: TPlsMaskEdit;
    edProfissao: TPlsEdit;
    medCNPJ: TPlsMaskEdit;
    edIdentidade: TPlsEdit;
    medDataNascimento: TPlsMaskEdit;
    medCPF: TPlsMaskEdit;
    edNome: TPlsEdit;
    edCodigo: TPlsEdit;
    edData: TPlsEdit;
    tlBotoesCliente: TToolBar;
    tlBtnNovoCliente: TToolButton;
    tlBtnEditarCliente: TToolButton;
    tlBtnExcluirCliente: TToolButton;
    tlBtnSalvarCliente: TToolButton;
    tlBtnRestaurarCliente: TToolButton;
    tlBtnLimparCliente: TToolButton;
    pnlSeparaDadosEndereco: TPanel;
    tbPedido: TAdvTabSheet;
    sbPedido: TStatusBar;
    pnlTopo: TPanel;
    lblNumeroPedido: TLabel;
    lblClientePedido: TLabel;
    lblNomeClientePedido: TLabel;
    lblValorTotalPedido: TLabel;
    lblInfStatusPedido: TLabel;
    lblStatusPedido: TLabel;
    lblTotalPedidosCliente: TLabel;
    edCodigoPedido: TPlsEdit;
    edValorTotalPedido: TPlsEdit;
    grpBxEnderecoEntrega: TGroupBox;
    lblEnderecoEstadoEntrega: TLabel;
    lblEnderecoBairroEntrega: TLabel;
    lblEnderecoRuaEntrega: TLabel;
    lblEnderecoCEPEntrega: TLabel;
    lblEnderecoComplementoEntrega: TLabel;
    lbllblEnderecoCidadeEntrega: TLabel;
    lblEnderecoNumeroEntrega: TLabel;
    cbBxEnderecoEstadoEntrega: TPlsComboBox;
    edEnderecoBairroEntrega: TPlsEdit;
    edEnderecoRuaEntrega: TPlsEdit;
    medEnderecoCEPEntrega: TPlsMaskEdit;
    mmEnderecoComplementoEntrega: TPlsMemo;
    edEnderecoCidadeEntrega: TPlsEdit;
    edEnderecoNumeroEntrega: TPlsEdit;
    grpBxItensPedido: TGroupBox;
    grItensPedido: TDBGrid;
    pnlLateralDireita: TPanel;
    btnAdicionarItemPedido: TSpeedButton;
    btnDeletarItemPedido: TSpeedButton;
    grpBxOutros: TGroupBox;
    lblDescricaoPedido: TLabel;
    mmDescricaoPedido: TPlsMemo;
    tlBtnBotoesPedido: TToolBar;
    tlBtnNovoPedido: TToolButton;
    tlBtnFinalizarPedido: TToolButton;
    tlBtnLimparPedido: TToolButton;
    tlBtnRelatoriosPedido: TToolButton;
    cdsItensPedidovalor_unitario: TStringField;
    cdsItensPedidovalor_total: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure edNomeExit(Sender: TObject);
    procedure medCPFExit(Sender: TObject);
    procedure edIdentidadeExit(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure medDataNascimentoExit(Sender: TObject);
    procedure edProfissaoExit(Sender: TObject);
    procedure edEmailExit(Sender: TObject);
    procedure medTelefone1Exit(Sender: TObject);
    procedure medTelefone2Exit(Sender: TObject);
    procedure cbBxEnderecoEstadoExit(Sender: TObject);
    procedure edEnderecoCidadeExit(Sender: TObject);
    procedure edEnderecoBairroExit(Sender: TObject);
    procedure edEnderecoRuaExit(Sender: TObject);
    procedure edEnderecoNumeroExit(Sender: TObject);
    procedure medEnderecoCEPExit(Sender: TObject);
    procedure mmEnderecoComplementoExit(Sender: TObject);
    procedure medCNPJExit(Sender: TObject);
    procedure pgCtrlPedidoChange(Sender: TObject);
    procedure btnNovoPedido1Click(Sender: TObject);
    procedure grItensPedidoColExit(Sender: TObject);
    procedure grItensPedidoColEnter(Sender: TObject);
    procedure btnAdicionarItemPedidoClick(Sender: TObject);
    procedure btnDeletarItemPedidoClick(Sender: TObject);
    procedure edCodigoPedidoExit(Sender: TObject);
    procedure grItensPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure lblClientePedidoClick(Sender: TObject);
    procedure tlBtnNovoClienteClick(Sender: TObject);
    procedure tlBtnEditarClienteClick(Sender: TObject);
    procedure tlBtnExcluirClienteClick(Sender: TObject);
    procedure tlBtnSalvarClienteClick(Sender: TObject);
    procedure tlBtnRestaurarClienteClick(Sender: TObject);
    procedure tlBtnLimparClienteClick(Sender: TObject);
    procedure tlBtnNovoPedidoClick(Sender: TObject);
    procedure tlBtnFinalizarPedidoClick(Sender: TObject);
    procedure mitRelatorioPedidoClick(Sender: TObject);
    procedure pgCtrlPedidoChanging(Sender: TObject; var AllowChange: Boolean);
    procedure tlBtnLimparPedidoClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure lblTotalPedidosClienteClick(Sender: TObject);
    procedure grItensPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FoCliente: TCliente;
    FnStatusTela: integer;
    FnPedido_CodCliente: Integer;
    FoFuncoes: TFuncoes;
    FoTelaLocalizarCliente: TfrmLocalizarCliente;
    FoTelaLocalizarDescricaoProdutos: TfrmLocalizarDescricaoProdutos;
    FoTelaLocalizarPedido: TfrmLocalizarPedido;

    FbAlterouClienteDepoisSalvar: Boolean;
    FbPodeChamarTelaLocalizarCliente: Boolean;
    FbPodeChamarTelaLocalizarPedido: Boolean;
    FsValorItemPedidoEntrar: String;

    procedure LimparClienteTela;
    procedure LimparPedidoTela;
    procedure LimparCliente;
    procedure LimparPedido;

    function VerificarConsistenciaAntesSalvarCliente: Boolean;
    function VerificarConsistenciaAntesSalvarPedido: Boolean;
    function ValidarClienteAntesSalvar(var psCamposErro:string): Boolean;
    function ValidarPedidoAntesSalvar(var psCamposErro:string): Boolean;
    procedure CarregarObjetoCliente(pvDados: OleVariant);
    procedure CarregarClienteTela;
    procedure ChamarTelaLocalizarCliente(psCampo, psValor: string; pnTipoCadastro: integer);
    procedure ChamarTelaLocalizarDescricaoProdutos(psCampo, psValor: string; const pbValidaRetornouRegistros: Boolean = True);
    procedure ChamarTelaLocalizarPedido(psCampo, psValor: string);
    function GetTipoOperacaoSalvar: Integer;
    procedure VerificarAlterouClienteDepoisSalvar(psCampo, psValor: string);
    procedure EditarCliente;
    procedure CriarDataSetsItensPedido;
    procedure CarregarDescricaoProdutos;
    procedure CarregarPedidoVisualizacao(pnCodPedido: Integer);
    procedure ChamarTelaPagamentoPedido(pnCodPedido: Integer);
    procedure CalcularValorTotalDoItem;
    procedure PegarDadosClienteDaAbaCliente;
  protected
    procedure HabilitarTela(pnStatus: Integer); override;
  public
    procedure PassaParametro(const psParametro: string; const pvValor: OleVariant); override;
  end;

implementation

uses unConstantes, unDM, unRelatorioPedido, unPagamentoPedido;

const
  //index das tabSheet do componente pgCtrlPedido.
  nCLIENTE = 0;
  nPEDIDO = 1;

  nSTATUS_TELA_INICIAL_CLIENTE = 1;

  nSTATUS_TELA_CLIENTE_NOVO = 11;
  nSTATUS_TELA_CLIENTE_EDITAR = 12;
  nSTATUS_TELA_CLIENTE_EXCLUIR = 13;
  nSTATUS_TELA_CLIENTE_SALVAR = 14;
  nSTATUS_TELA_CLIENTE_RESTAURAR = 15;
  nSTATUS_TELA_CLIENTE_LOCALIZOU = 16;

  nSTATUS_TELA_INICIAL_PEDIDO = 17;
  nSTATUS_TELA_PEDIDO_NOVO = 18;
  nSTATUS_TELA_PEDIDO_VISUALIZAR = 19;

  //SelectedIndex do grItensPedido
  nIDX_QTDE = 0;
  nIDX_UNIDADE = 1;
  nIDX_DESCRICAO = 2;
  nIDX_VLR_UNITARIO = 3;
  nIDX_VLR_TOTAL = 4;
  nIDX_COMPLEMENTO = 5;

{$R *.dfm}

{ TfrmCadPedido }

procedure TfrmCadPedido.PassaParametro(const psParametro: string; const pvValor: OleVariant);
var
  oCdsAux: TClientDataSet;

begin
  inherited;

  if psParametro = sPRM_SELECIONOU_REGISTRO_TELA_LOCALIZAR then
  begin
    if (pvValor[0] = sLOCALIZAR_CLIENTE) then
    begin
      oCdsAux := TClientDataSet.Create(nil);
      try
        oCdsAux.Data := pvValor[1];
        //página do cliente.
        if (pgCtrlPedido.ActivePageIndex = nCLIENTE) then
        begin
          CarregarObjetoCliente(oCdsAux.Data);
          CarregarClienteTela;
          FnStatusTela := nSTATUS_TELA_CLIENTE_LOCALIZOU;
          HabilitarTela(FnStatusTela);
        end

        //página do pedido.
        else if (pgCtrlPedido.ActivePageIndex = nPEDIDO) then
        begin
          FnPedido_CodCliente := oCdsAux.FieldByName('codigo').AsInteger;
          lblNomeClientePedido.Caption := oCdsAux.FieldByName('nome').AsString;
        end;
        
      finally
        FreeAndNil(oCdsAux);
      end;
    end

    else if (pvValor[0] = sLOCALIZAR_DESCRICAO_PRODUTOS) then
    begin
      oCdsAux := TClientDataSet.Create(nil);
      try
        oCdsAux.Data := pvValor[1];

        if not(cdsItensPedido.State in [dsInsert,dsEdit]) then
          cdsItensPedido.Edit;
          
        cdsItensPedido.FieldByName('descricao').AsString := oCdsAux.FieldByName('nome').AsString;
        cdsItensPedido.FieldByName('valor_unitario').AsString :=
          FoFuncoes.formatarValorMonetario(oCdsAux.FieldByName('valor').AsString);
        CalcularValorTotalDoItem;
      finally
        FreeAndNil(oCdsAux);
      end;
    end

    else if (pvValor[0] = sLOCALIZAR_PEDIDO) then
    begin
      oCdsAux := TClientDataSet.Create(nil);
      FbPodeChamarTelaLocalizarPedido := False;
      try
        oCdsAux.Data := pvValor[1];
        if (not (oCdsAux.IsEmpty)) then
          CarregarPedidoVisualizacao(oCdsAux.FieldByName('codigo').AsInteger);
      finally
        FreeAndNil(oCdsAux);
        FbPodeChamarTelaLocalizarPedido := True;        
      end;
    end;
  end

  else if psParametro = sPRM_NAO_SELECIONOU_REGISTRO_TELA_LOCALIZAR then
  begin
    if (pvValor = sLOCALIZAR_DESCRICAO_PRODUTOS) then
    begin
      cdsItensPedido.FieldByName('descricao').AsString := STRING_INDEFINIDO;
      cdsItensPedido.FieldByName('valor_unitario').AsString := STRING_INDEFINIDO;
    end;
  end;
end;

procedure TfrmCadPedido.LimparCliente;
begin
  LimparPedido;
  
  FnStatusTela := nSTATUS_TELA_INICIAL_CLIENTE;
  FbAlterouClienteDepoisSalvar := False;
  LimparClienteTela;
  FoCliente.Limpar;
  HabilitarTela(FnStatusTela);
end;

procedure TfrmCadPedido.LimparPedido;
begin
  LimparPedidoTela;
  FnStatusTela := nSTATUS_TELA_INICIAL_PEDIDO;
  HabilitarTela(FnStatusTela);
end;

procedure TfrmCadPedido.LimparClienteTela;
begin
  edCodigo.Clear;
  edData.Clear;
  edNome.Clear;
  medCPF.Clear;
  edIdentidade.Clear;
  medCNPJ.Clear;
  medDataNascimento.Clear;
  edProfissao.Clear;
  edEmail.Clear;
  medTelefone1.Clear;
  medTelefone2.Clear;
  //endereço
  cbBxEnderecoEstado.ItemIndex := -1;
  edEnderecoCidade.Clear;
  edEnderecoBairro.Clear;
  edEnderecoRua.Clear;
  edEnderecoNumero.Clear;
  medEnderecoCEP.Clear;
  mmEnderecoComplemento.Clear;
  FnPedido_CodCliente := NUMERO_INDEFINIDO;
end;

procedure TfrmCadPedido.LimparPedidoTela;
begin
  edCodigoPedido.Clear;
  lblStatusPedido.Caption := STRING_INDEFINIDO;
  lblNomeClientePedido.Caption := STRING_INDEFINIDO;
  lblTotalPedidosCliente.Caption := STRING_INDEFINIDO;
  edValorTotalPedido.Clear;
  //endereço
  cbBxEnderecoEstadoEntrega.ItemIndex := -1;
  edEnderecoCidadeEntrega.Clear;
  edEnderecoBairroEntrega.Clear;
  edEnderecoRuaEntrega.Clear;
  edEnderecoNumeroEntrega.Clear;
  medEnderecoCEPEntrega.Clear;
  mmEnderecoComplementoEntrega.Clear;
  mmDescricaoPedido.Clear;

  if (cdsItensPedido.Active) then
    cdsItensPedido.EmptyDataSet;
end;

procedure TfrmCadPedido.HabilitarTela(pnStatus: Integer);

  procedure HabilitaCamposEnderecoCliente(pbHabilita: Boolean);
  begin
    cbBxEnderecoEstado.Enabled := pbHabilita;
    edEnderecoCidade.Enabled := pbHabilita;
    edEnderecoBairro.Enabled := pbHabilita;
    edEnderecoRua.Enabled := pbHabilita;
    edEnderecoNumero.Enabled := pbHabilita;
    medEnderecoCEP.Enabled := pbHabilita;
    mmEnderecoComplemento.Enabled := pbHabilita;
    grpBxEndereco.Enabled := pbHabilita;
  end;

  procedure HablitarCamposCliente_NovoOuEditar;
  begin
    edCodigo.Enabled := False;
    edData.Enabled := False;
    edNome.Enabled := True;
    medCPF.Enabled := True;
    edIdentidade.Enabled := True;
    medCNPJ.Enabled := True;
    medDataNascimento.Enabled := True;
    edProfissao.Enabled := True;
    edEmail.Enabled := True;
    medTelefone1.Enabled := True;
    medTelefone2.Enabled := True;
    HabilitaCamposEnderecoCliente(True);
  end;

  procedure HablitarCamposPedido_NovoOuEditar(pbHabilita: Boolean);
  var
    i: Integer;
  begin
    edCodigoPedido.Enabled := not pbHabilita;
    grpBxEnderecoEntrega.Enabled := pbHabilita;
    cbBxEnderecoEstadoEntrega.Enabled := pbHabilita;
    edEnderecoCidadeEntrega.Enabled := pbHabilita;
    edEnderecoBairroEntrega.Enabled := pbHabilita;
    edEnderecoRuaEntrega.Enabled := pbHabilita;
    edEnderecoNumeroEntrega.Enabled := pbHabilita;
    medEnderecoCEPEntrega.Enabled := pbHabilita;
    mmEnderecoComplementoEntrega.Enabled := pbHabilita;
    //itens do pedido.
    grpBxItensPedido.Enabled := True;
    grItensPedido.Enabled := True;
    grItensPedido.ReadOnly := False;
    cdsItensPedido.Active := True;
    cdsItensPedido.ReadOnly :=False;
    //colunas do grid grItensPedido.
    for i:=0 to grItensPedido.Columns.Count-1 do
      grItensPedido.Columns[i].ReadOnly := not pbHabilita;

    tlBtnNovoPedido.Enabled := not pbHabilita;
    tlBtnFinalizarPedido.Enabled := pbHabilita;

    pnlLateralDireita.Enabled := pbHabilita;

    if pbHabilita then
      btnAdicionarItemPedidoClick(Self);
  end;

begin
  FbPodeChamarTelaLocalizarCliente := False;
  try
    case pnStatus of
      nSTATUS_TELA_INICIAL_CLIENTE: begin
                              //pageControl
                              //pgCtrlPedido.Pages[nCLIENTE].Enabled := True;
                              //pgCtrlPedido.Pages[nPEDIDO].Enabled := False;
                              //pgCtrlPedido.ActivePageIndex := nCLIENTE;
                              //campos pode realizar pesquisa.
                              edCodigo.Enabled := True;
                              edNome.Enabled := True;
                              medCPF.Enabled := True;
                              edIdentidade.Enabled := True;
                              medCNPJ.Enabled := True;
                              //demais campos.
                              edData.Enabled := False;
                              medDataNascimento.Enabled := False;
                              edProfissao.Enabled := False;
                              edEmail.Enabled := False;
                              medTelefone1.Enabled := False;
                              medTelefone2.Enabled := False;
                              HabilitaCamposEnderecoCliente(False);
                              //botões cliente.
                              tlBtnNovoCliente.Enabled := True;
                              tlBtnEditarCliente.Enabled := False;
                              tlBtnExcluirCliente.Enabled := False;
                              tlBtnSalvarCliente.Enabled := False;
                              tlBtnRestaurarCliente.Enabled := False;
                              FoFuncoes.focarComponente(edCodigo);
                            end;

      nSTATUS_TELA_CLIENTE_NOVO: begin
                                   //pageControl
                                   //pgCtrlPedido.Pages[nCLIENTE].Enabled := True;
                                   //pgCtrlPedido.Pages[nPEDIDO].Enabled := False;
                                   //pgCtrlPedido.ActivePageIndex := nCLIENTE;
                                   edCodigo.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_CLIENTE,True));
                                   edData.Text := DateToStr(Now);
                                   HablitarCamposCliente_NovoOuEditar;
                                   //botões cliente.
                                   tlBtnNovoCliente.Enabled :=  False;
                                   tlBtnEditarCliente.Enabled := False;
                                   tlBtnSalvarCliente.Enabled := True;
                                   tlBtnExcluirCliente.Enabled := False;
                                   tlBtnRestaurarCliente.Enabled := False;
                                   FoFuncoes.focarComponente(edNome);
                                 end;

      nSTATUS_TELA_CLIENTE_EDITAR: begin
                                     //pageControl
                                     //pgCtrlPedido.Pages[nCLIENTE].Enabled := True;
                                     //pgCtrlPedido.Pages[nPEDIDO].Enabled := True;
                                     //pgCtrlPedido.ActivePageIndex := nCLIENTE;
                                     LimparClienteTela;
                                     CarregarClienteTela;
                                     HablitarCamposCliente_NovoOuEditar;
                                     tlBtnNovoCliente.Enabled :=  False;
                                     tlBtnEditarCliente.Enabled := False;
                                     tlBtnSalvarCliente.Enabled := True;
                                     tlBtnExcluirCliente.Enabled := True;
                                     tlBtnRestaurarCliente.Enabled := True;
                                   end;

      nSTATUS_TELA_CLIENTE_LOCALIZOU: begin
                                      end;

      nSTATUS_TELA_CLIENTE_EXCLUIR: begin
                                   end;

      nSTATUS_TELA_CLIENTE_SALVAR: begin
                                     //pageControl
                                     //pgCtrlPedido.Pages[nCLIENTE].Enabled := True;
                                     //pgCtrlPedido.Pages[nPEDIDO].Enabled := True;
                                     //pgCtrlPedido.ActivePageIndex := nCLIENTE;
                                    //campos pode realizar pesquisa.
                                    edCodigo.Enabled := True;
                                    edNome.Enabled := True;
                                    medCPF.Enabled := True;
                                    edIdentidade.Enabled := True;
                                    medCNPJ.Enabled := True;
                                    //demais campos.
                                    edData.Enabled := False;
                                    medDataNascimento.Enabled := False;
                                    edProfissao.Enabled := False;
                                    edEmail.Enabled := False;
                                    medTelefone1.Enabled := False;
                                    medTelefone2.Enabled := False;
                                    HabilitaCamposEnderecoCliente(False);
                                    //botões cliente.
                                    tlBtnNovoCliente.Enabled := True;
                                    tlBtnEditarCliente.Enabled := True;
                                    tlBtnExcluirCliente.Enabled := True;
                                    tlBtnSalvarCliente.Enabled := False;
                                    tlBtnRestaurarCliente.Enabled := True;
                                    FoFuncoes.focarComponente(edCodigo);
                                   end;

      nSTATUS_TELA_CLIENTE_RESTAURAR: begin
                                      end;
      nSTATUS_TELA_PEDIDO_NOVO: begin
                                  //pageControl
                                  //pgCtrlPedido.Pages[nCLIENTE].Enabled := False;
                                  //pgCtrlPedido.Pages[nPEDIDO].Enabled := True;
                                  //pgCtrlPedido.ActivePageIndex := nPEDIDO;
                                  edCodigoPedido.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_PEDIDO,True));
                                  HablitarCamposPedido_NovoOuEditar(True);
                                  //botões cliente.
                                  tlBtnNovoPedido.Enabled :=  True;
                                  FoFuncoes.focarComponente(grItensPedido);
                                end;
      nSTATUS_TELA_PEDIDO_VISUALIZAR: begin
                                       //pageControl
                                       //pgCtrlPedido.Pages[nCLIENTE].Enabled := True;
                                       //pgCtrlPedido.Pages[nPEDIDO].Enabled := True;
                                       //pgCtrlPedido.ActivePageIndex := nPEDIDO;
                                       edCodigoPedido.Enabled := True;
                                       HablitarCamposPedido_NovoOuEditar(False);
                                       //botões cliente.
                                       tlBtnNovoPedido.Enabled :=  True;
                                       tlBtnFinalizarPedido.Enabled :=  False;
                                       tlBtnLimparPedido.Enabled :=  True;
                                       tlBtnRelatoriosPedido.Enabled := True;
                                       //FoFuncoes.focarComponente(edCodigoPedido);
                                       FoFuncoes.focarComponente(grItensPedido);
                                      end;
      nSTATUS_TELA_INICIAL_PEDIDO: begin
                                      //pgCtrlPedido.ActivePageIndex := nPEDIDO;
                                      edCodigoPedido.Enabled := True;
                                      HablitarCamposPedido_NovoOuEditar(False);
                                      //botões cliente.
                                      tlBtnNovoPedido.Enabled := True;
                                      tlBtnFinalizarPedido.Enabled := False;
                                      tlBtnLimparPedido.Enabled := True;
                                      tlBtnRelatoriosPedido.Enabled := False;
                                      FoFuncoes.focarComponente(edCodigoPedido);
                                   end;

    end; //fim - case
  finally
    FbPodeChamarTelaLocalizarCliente := True;
  end;
end;

//verifica algumas consistências no sistema, mas não interfere no que o usuário deseja cadastrar, apenas
//faz algumas sugestões.
function TfrmCadPedido.VerificarConsistenciaAntesSalvarCliente: Boolean;
begin
  Result := True;

  //cliente com (CPF ou RG informados) e CNPJ também informado. Pessoa Física ou Jurídica?
  if((not(FoCliente.GetCPF_IsNull)) or (FoCliente.GetIdentidade <> STRING_INDEFINIDO)) and
    (not(FoCliente.GetCNPJ_IsNull)) then
    FoFuncoes.RetornarCaixaMensagem('O cliente ' + FoCliente.GetNome + ' está com o CPF ou RG e o CNPJ informados.' +
      #13 + '       Verifique a consistência dos dados.');
end;

function TfrmCadPedido.VerificarConsistenciaAntesSalvarPedido: Boolean;
begin
  Result := True;

  if (cbBxEnderecoEstado.ItemIndex = -1) and (FoFuncoes.NaoPossuiValor(edEnderecoCidadeEntrega.Text)) and
    (FoFuncoes.NaoPossuiValor(edEnderecoBairroEntrega.Text)) and (FoFuncoes.NaoPossuiValor(edEnderecoRuaEntrega.Text)) and
    (FoFuncoes.NaoPossuiValor(edEnderecoNumeroEntrega.Text)) and (FoFuncoes.NaoPossuiValor(medEnderecoCEPEntrega.Text)) and
    (FoFuncoes.NaoPossuiValor(mmEnderecoComplementoEntrega.Text)) and (FoFuncoes.NaoPossuiValor(edEnderecoCidadeEntrega.Text)) then
      Result := MessageDlg('O pedido não possui um Endereço de Entrega.'  + #13 + '    Deseja continuar?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;

  Result := MessageDlg('Ao finalizar um pedido o mesmo não pode ser alterado.' + #13
    + '                        Deseja continuar?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;      
end;

function TfrmCadPedido.ValidarClienteAntesSalvar(var psCamposErro:string): Boolean;
var
  sCampos: string;
  compFoco: TWinControl;
  sAux: String;
  bRetorno: Boolean;

  procedure DefinirCampoFoco(poCampo: TWinControl);
  begin
    if compFoco = nil then
      compFoco := poCampo;
  end;

begin
  compFoco := nil;
  sCampos := STRING_INDEFINIDO;
  bRetorno := True;

  if not (FoFuncoes.PossuiValor(FoCliente.GetNome)) then
  begin
    FoFuncoes.AdicionarValorLista('nome', sCampos);
    DefinirCampoFoco(edNome);
    bRetorno := False;
  end;

  sAux := FoFuncoes.retirarCaracteres(FoCliente.GetCPF,'.-');
  if(not(sAux = STRING_INDEFINIDO))then
  begin
    if(not(FoFuncoes.VerificaDigitoCPF(sAux)))then
    begin
      FoFuncoes.AdicionarValorLista('CPF', sCampos);
      DefinirCampoFoco(medCPF);
      bRetorno := False;
    end;
  end;

  sAux := FoFuncoes.retirarCaracteres(FoCliente.GetCNPJ,'./-');
  if(not(sAux = STRING_INDEFINIDO))then
  begin
    if(not(FoFuncoes.validarCNPJ(sAux)))then
    begin
      FoFuncoes.AdicionarValorLista('CNPJ', sCampos);
      DefinirCampoFoco(medCNPJ);
      bRetorno := False;
    end;
  end;

  sAux := FoFuncoes.retirarCaracteres(FoCliente.GetDataNascimentoAsString, '/');
  if(not(sAux = STRING_INDEFINIDO))then
  begin
    if(not(FoFuncoes.validarData(FoCliente.GetDataNascimentoAsString)))then
    begin
      FoFuncoes.AdicionarValorLista('Data de Nascimento', sCampos);
      DefinirCampoFoco(medDataNascimento);
      bRetorno := False;
    end;
  end;

  if (FoFuncoes.PossuiValor(FoCliente.GetEmail)) then
  begin
    if(not(FoFuncoes.validarEmail(FoCliente.GetEmail)))then
    begin
      FoFuncoes.AdicionarValorLista('Email', sCampos);
      DefinirCampoFoco(edEmail);
      bRetorno := False;
    end;
  end;

  sAux := FoFuncoes.retirarCaracteres(FoCliente.GetTelefone1, '()-');
  if(not(sAux = STRING_INDEFINIDO))then
  begin
    if(not(FoFuncoes.validarTelefone(FoCliente.GetTelefone1)))then
    begin
      FoFuncoes.AdicionarValorLista('Telefone 1', sCampos);
      DefinirCampoFoco(medTelefone1);
      bRetorno := False;
    end;
  end;

  sAux := FoFuncoes.retirarCaracteres(FoCliente.GetTelefone2, '()-');
  if(not(sAux = STRING_INDEFINIDO))then
  begin
    if(not(FoFuncoes.validarTelefone(FoCliente.GetTelefone2)))then
    begin
      FoFuncoes.AdicionarValorLista('Telefone 2', sCampos);
      DefinirCampoFoco(medTelefone2);
      bRetorno := False;
    end;
  end;

  sAux := FoFuncoes.retirarCaracteres(FoCliente.GetEnderecoCEP,'-');
  if(not(sAux = STRING_INDEFINIDO))then
  begin
    if(not(FoFuncoes.validarCEP(Trim(FoCliente.GetEnderecoCEP))))then
    begin
      FoFuncoes.AdicionarValorLista('CEP', sCampos);
      DefinirCampoFoco(medEnderecoCEP);
      bRetorno := False;
    end;
  end;

  //setar foco no componente que não foi validado
  if((not(bRetorno))and(compFoco is TWinControl))then
    FoFuncoes.focarComponente(compFoco);

  psCamposErro := sCampos;
  Result := bRetorno;
end;

function TfrmCadPedido.ValidarPedidoAntesSalvar(var psCamposErro:string): Boolean;
var
  sCampos: string;
  compFoco: TWinControl;
  sAux: String;
  bRetorno: Boolean;
  oCdsAux: TClientDataSet;

  procedure DefinirCampoFoco(poCampo: TWinControl);
  begin
    if compFoco = nil then
      compFoco := poCampo;
  end;

begin
  compFoco := nil;
  sCampos := STRING_INDEFINIDO;
  bRetorno := True;

  if (FnPedido_CodCliente = NUMERO_INDEFINIDO) then
  begin
    FoFuncoes.AdicionarValorLista('cliente', sCampos);
    //DefinirCampoFoco(nil);
    bRetorno := False;
  end;

  if (not(FoFuncoes.validarValorMonetario(edValorTotalPedido.Text))) then
  begin
    FoFuncoes.AdicionarValorLista('valor total', sCampos);
    DefinirCampoFoco(edValorTotalPedido);
    bRetorno := False;
  end;

  if (cdsItensPedido.IsEmpty) then
  begin
    FoFuncoes.AdicionarValorLista('itens do pedido', sCampos);
    DefinirCampoFoco(grpBxItensPedido);
    bRetorno := False;
  end
  else
  //verificar os dados dos itens do pedido.
  begin
    oCdsAux := TClientDataSet.Create(nil);
    try
      oCdsAux.Data := cdsItensPedido.Data;
      oCdsAux.First;
      while not(oCdsAux.Eof)do
      begin
        if (FoFuncoes.RetornarValorInteiro(oCdsAux.FieldByName('quantidade').AsString) = NUMERO_INDEFINIDO) or
          (FoFuncoes.NaoPossuiValor(oCdsAux.FieldByName('descricao').AsString)) or
          (not(FoFuncoes.validarValorMonetario(oCdsAux.FieldByName('valor_unitario').AsString))) or
          (not(FoFuncoes.validarValorMonetario(oCdsAux.FieldByName('valor_total').AsString))) then
        begin
          FoFuncoes.AdicionarValorLista('itens do pedido', sCampos);
          DefinirCampoFoco(grpBxItensPedido);
          bRetorno := False;
          Break;
        end;
        oCdsAux.Next;
      end;
    finally
      FreeAndNil(oCdsAux);
    end;
  end;

  //setar foco no componente que não foi validado
  if((not(bRetorno))and(compFoco is TWinControl))then
    FoFuncoes.focarComponente(compFoco);

  psCamposErro := sCampos;
  Result := bRetorno;
end;

//carrega o objeto 'FoCliente' com os dados (TclientDataSet) passado no
//parâmetro 'pvDados'.
procedure TfrmCadPedido.CarregarObjetoCliente(pvDados: OleVariant);
var
  oCdsAux: TClientDataSet;
begin
  oCdsAux := TClientDataSet.Create(nil);
  try
    oCdsAux.Data := pvDados;

    FoCliente.SetCodigo(oCdsAux.FieldByName('codigo').AsInteger);
    FoCliente.SetData(oCdsAux.FieldByName('data_cadastro').AsString);
    FoCliente.SetNome(oCdsAux.FieldByName('nome').AsString);
    FoCliente.SetCPF(oCdsAux.FieldByName('CPF').AsString);
    FoCliente.SetIdentidade(oCdsAux.FieldByName('identidade').AsString);
    FoCliente.SetCNPJ(oCdsAux.FieldByName('CNPJ').AsString);
    FoCliente.SetDataNascimento(oCdsAux.FieldByName('data_nascimento').AsString);
    FoCliente.SetProfissao(oCdsAux.FieldByName('profissao').AsString);
    FoCliente.SetEmail(oCdsAux.FieldByName('email').AsString);
    FoCliente.SetTelefone1(oCdsAux.FieldByName('telefone_1').AsString);
    FoCliente.SetTelefone2(oCdsAux.FieldByName('telefone_2').AsString);
    FoCliente.SetEnderecoEstado(oCdsAux.FieldByName('estado').AsString);
    FoCliente.SetEnderecoCidade(oCdsAux.FieldByName('cidade').AsString);
    FoCliente.SetEnderecoBairro(oCdsAux.FieldByName('bairro').AsString);
    FoCliente.SetEnderecoRua(oCdsAux.FieldByName('rua').AsString);
    FoCliente.SetEnderecoNumero(oCdsAux.FieldByName('numero').AsInteger);
    FoCliente.SetEnderecoCEP(oCdsAux.FieldByName('CEP').AsString);
    FoCliente.SetEnderecoComplemento(oCdsAux.FieldByName('complemento').AsString);
    FnPedido_CodCliente := oCdsAux.FieldByName('codigo').AsInteger;
  finally
    FreeAndNil(oCdsAux);
  end;
end;

procedure TfrmCadPedido.CarregarClienteTela;
begin
  edCodigo.Text := IntToStr(FoCliente.GetCodigo);
  edData.Text := FoCliente.GetDataAsString(False);
  edNome.Text := FoCliente.GetNome;
  medCPF.Text := FoCliente.GetCPF;
  edIdentidade.Text := FoCliente.GetIdentidade;
  medCNPJ.Text := FoCliente.GetCNPJ;
  medDataNascimento.Text := FoCliente.GetDataNascimentoAsString;
  edProfissao.Text := FoCliente.GetProfissao;
  edEmail.Text := FoCliente.GetEmail;
  medTelefone1.Text := FoCliente.GetTelefone1;
  medTelefone2.Text := FoCliente.GetTelefone2;
  cbBxEnderecoEstado.Text := FoCliente.GetEnderecoEstado;
  edEnderecoCidade.Text := FoCliente.GetEnderecoCidade;
  edEnderecoBairro.Text := FoCliente.GetEnderecoBairro;
  edEnderecoRua.Text := FoCliente.GetEnderecoRua;
  edEnderecoNumero.Text := FoCliente.GetEnderecoNumeroAsString;
  medEnderecoCEP.Text := FoCliente.GetEnderecoCEP;
  mmEnderecoComplemento.Text := FoCliente.GetEnderecoComplemento;
  FbAlterouClienteDepoisSalvar := False;
end;

procedure TfrmCadPedido.ChamarTelaLocalizarCliente(psCampo, psValor: string; pnTipoCadastro: integer);
begin
  //chamado pela página do cliente.
  if (pnTipoCadastro = nCLIENTE) then
  begin
    if (not(FnStatusTela in [nSTATUS_TELA_INICIAL_CLIENTE, nSTATUS_TELA_CLIENTE_SALVAR])) or
      (not(FbPodeChamarTelaLocalizarCliente))  then
      Exit;

    FoTelaLocalizarCliente.PassaParametro(sPRM_TELA_PAI, integer(Self));
    FoTelaLocalizarCliente.PassaParametro(sPRM_LOCALIZAR_REGISTRO_RAPIDO, True);

    if (psCampo <> STRING_INDEFINIDO) and (psValor <> STRING_INDEFINIDO) then
    begin
      FoTelaLocalizarCliente.PassaParametro(sPRM_CAMPO_PESQUISAR, psCampo);
      FoTelaLocalizarCliente.PassaParametro(sPRM_VALOR_PESQUISAR, psValor);
      FoTelaLocalizarCliente.PassaParametro(sPRM_EXECUTAR_PESQUISA, null);
    end;

    if (FoTelaLocalizarCliente.RetornarTotalRegistros <> 1) then
      FoTelaLocalizarCliente.Show;
  end
  //chamado pela página do pedido.
  else if (pnTipoCadastro = nPEDIDO) then
  begin
    FoTelaLocalizarCliente.PassaParametro(sPRM_TELA_PAI, integer(Self));
    FoTelaLocalizarCliente.PassaParametro(sPRM_LOCALIZAR_REGISTRO_RAPIDO, False);
    FoTelaLocalizarCliente.PassaParametro(sPRM_CAMPO_PESQUISAR, 'nome');
    FoTelaLocalizarCliente.PassaParametro(sPRM_VALOR_PESQUISAR, STRING_INDEFINIDO);
    FoTelaLocalizarCliente.Show;    
  end;
end;

procedure TfrmCadPedido.ChamarTelaLocalizarDescricaoProdutos(
  psCampo, psValor: string; const pbValidaRetornouRegistros: Boolean = True);
begin
  if (not(FnStatusTela in [nSTATUS_TELA_PEDIDO_NOVO])) (*or (not(FbPodeChamarTelaLocalizarCliente))*)  then
    Exit;

  FoTelaLocalizarDescricaoProdutos.PassaParametro(sPRM_TELA_PAI, integer(Self));
  FoTelaLocalizarDescricaoProdutos.PassaParametro(sPRM_LOCALIZAR_REGISTRO_RAPIDO, pbValidaRetornouRegistros);

  if (psCampo <> STRING_INDEFINIDO) then
  begin
    FoTelaLocalizarDescricaoProdutos.PassaParametro(sPRM_CAMPO_PESQUISAR, psCampo);
    if (psValor <> STRING_INDEFINIDO) then
    begin
      FoTelaLocalizarDescricaoProdutos.PassaParametro(sPRM_VALOR_PESQUISAR, psValor);
      FoTelaLocalizarDescricaoProdutos.PassaParametro(sPRM_EXECUTAR_PESQUISA, null);
    end;
  end;

  if (FoTelaLocalizarDescricaoProdutos.RetornarTotalRegistros > 1) and (pbValidaRetornouRegistros) then
    FoTelaLocalizarDescricaoProdutos.Show
  else if not (pbValidaRetornouRegistros) then
    FoTelaLocalizarDescricaoProdutos.Show;
end;

procedure TfrmCadPedido.ChamarTelaLocalizarPedido(psCampo, psValor: string);
begin
  if (FnStatusTela in [nSTATUS_TELA_PEDIDO_NOVO]) or (not(FbPodeChamarTelaLocalizarPedido)) then
    Exit;

  FoTelaLocalizarPedido.PassaParametro(sPRM_TELA_PAI, integer(Self));
  FoTelaLocalizarPedido.PassaParametro(sPRM_LOCALIZAR_REGISTRO_RAPIDO, False);

  if (psCampo <> STRING_INDEFINIDO) and (psValor <> STRING_INDEFINIDO) then
  begin
    FoTelaLocalizarPedido.PassaParametro(sPRM_CAMPO_PESQUISAR, psCampo);
    FoTelaLocalizarPedido.PassaParametro(sPRM_VALOR_PESQUISAR, psValor);
    FoTelaLocalizarPedido.PassaParametro(sPRM_EXECUTAR_PESQUISA, null);
  end;

  if (FoTelaLocalizarPedido.RetornarTotalRegistros <> 1) then
    FoTelaLocalizarPedido.Show;
end;

function TfrmCadPedido.GetTipoOperacaoSalvar: Integer;
begin
  if (FnStatusTela = nSTATUS_TELA_CLIENTE_NOVO) then
    Result := nOPERACAO_NOVO
  else if (FnStatusTela = nSTATUS_TELA_CLIENTE_EDITAR) then
    Result := nOPERACAO_EDITAR;
end;

//verifica se alterou o cliente depois de ter salvo o cliente. Necessário para habilitar/desabilitar botões de
//controle, como o próprio botão 'Salvar'.
procedure TfrmCadPedido.VerificarAlterouClienteDepoisSalvar(psCampo, psValor: string);
begin
  if not (FnStatusTela = nSTATUS_TELA_CLIENTE_SALVAR) then
    Exit;

  if (psCampo = sCLIENTE_NOME) then
  begin
    if (FoCliente.GetNome <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_CPF) then
  begin
    if (FoCliente.GetCPF = STRING_INDEFINIDO) and (psValor = sCPF_INVALIDO) then
      FbAlterouClienteDepoisSalvar := False
    else if (FoCliente.GetCPF <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_IDENTIDADE) then
  begin
    if (FoCliente.GetIdentidade <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_CNPJ) then
  begin
    if (FoCliente.GetCNPJ = STRING_INDEFINIDO) and (psValor = sCNPJ_INVALIDO) then
      FbAlterouClienteDepoisSalvar := False
    else if (FoCliente.GetCNPJ <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_DATA_NASCIMENTO) then
  begin
    if (FoCliente.GetDataNascimentoAsString = STRING_INDEFINIDO) and (psValor = sDATA_INVALIDA) then
      FbAlterouClienteDepoisSalvar := False
    else if (FoCliente.GetDataNascimentoAsString <> psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_PROFISSAO) then
  begin
    if (FoCliente.GetProfissao <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_EMAIL) then
  begin
    if (FoCliente.GetEmail <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_TELEFONE_1) then
  begin
    if (FoCliente.GetTelefone1 = STRING_INDEFINIDO) and (psValor = sTELEFONE_INVALIDO) then
      FbAlterouClienteDepoisSalvar := False
    else if (FoCliente.GetTelefone1 <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_TELEFONE_2) then
  begin
    if (FoCliente.GetTelefone2 = STRING_INDEFINIDO) and (psValor = sTELEFONE_INVALIDO) then
      FbAlterouClienteDepoisSalvar := False
    else if (FoCliente.GetTelefone2 <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_ESTADO) then
  begin
    if (FoCliente.GetEnderecoEstado <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_CIDADE) then
  begin
    if (FoCliente.GetEnderecoCidade <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_BAIRRO) then
  begin
    if (FoCliente.GetEnderecoBairro <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_RUA) then
  begin
    if (FoCliente.GetEnderecoRua <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_NUMERO) then
  begin
    if (IntToStr(FoCliente.GetEnderecoNumero) <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_CEP) then
  begin
    if (FoCliente.GetEnderecoCEP = STRING_INDEFINIDO) and (psValor = sCEP_INVALIDO) then
      FbAlterouClienteDepoisSalvar := False
    else if (FoCliente.GetEnderecoCEP <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end

  else if (psCampo = sCLIENTE_COMPLEMENTO) then
  begin
    if (FoCliente.GetEnderecoComplemento <>  psValor) then
      FbAlterouClienteDepoisSalvar := True;
  end;

  //se alterou os dados do cliente, e deve mudar algo na tela (habilitar/desabilitar), então execute.
  if (FnStatusTela = nSTATUS_TELA_CLIENTE_SALVAR) then
  begin
    if (FbAlterouClienteDepoisSalvar) then
    begin
      if (MessageDlg('Deseja editar o cliente ' + FoCliente.GetNome + '?', mtConfirmation, [mbYes,mbNo], 0)=mrYes)then
        EditarCliente;
    end;
  end;
end;

procedure TfrmCadPedido.EditarCliente;
begin
  FnStatusTela := nSTATUS_TELA_CLIENTE_EDITAR;
  FbAlterouClienteDepoisSalvar := False;
  HabilitarTela(FnStatusTela);
end;

procedure TfrmCadPedido.CriarDataSetsItensPedido;
begin
  cdsItensPedidoUnidadeComboBox.CreateDataSet;

  cdsItensPedidoUnidadeComboBox.Insert;
  cdsItensPedidoUnidadeComboBox.FieldByName('unidade').AsString := 'lt';
  cdsItensPedidoUnidadeComboBox.Post;

  cdsItensPedidoUnidadeComboBox.Insert;
  cdsItensPedidoUnidadeComboBox.FieldByName('unidade').AsString := 'kg';
  cdsItensPedidoUnidadeComboBox.Post;

  cdsItensPedido.CreateDataSet;
end;

procedure TfrmCadPedido.CarregarDescricaoProdutos;
begin
  DM.cdsDescricaoProdutos.Close;
  DM.zQryDescricaoProdutos.Close;
  DM.zQryDescricaoProdutos.SQL.Clear;
  DM.zQryDescricaoProdutos.SQL.Add('SELECT * FROM descricao_produtos ');
  DM.zQryDescricaoProdutos.SQL.Add('ORDER BY nome');
  DM.zQryDescricaoProdutos.Open;
  DM.cdsDescricaoProdutos.Open;
end;

procedure TfrmCadPedido.CarregarPedidoVisualizacao(pnCodPedido: Integer);

  procedure CarregarItensDoPedidoParaVisualizar;
  begin
    DM.cdsCarregarItemPedido.First;
    while not(DM.cdsCarregarItemPedido.Eof) do
    begin
      cdsItensPedido.Append;
      cdsItensPedido.FieldByName('quantidade').AsInteger := DM.cdsCarregarItemPedido.FieldByName('quantidade').AsInteger;
      cdsItensPedido.FieldByName('unidade').AsString := DM.cdsCarregarItemPedido.FieldByName('unidade').AsString;
      cdsItensPedido.FieldByName('descricao').AsString := DM.cdsCarregarItemPedido.FieldByName('descricao').AsString;
      cdsItensPedido.FieldByName('valor_unitario').AsString := FoFuncoes.FormatarValorMonetario(DM.cdsCarregarItemPedido.FieldByName('valor_unitario').AsString);
      cdsItensPedido.FieldByName('valor_total').AsString := FoFuncoes.FormatarValorMonetario(DM.cdsCarregarItemPedido.FieldByName('valor_total').AsString);
      cdsItensPedido.FieldByName('complemento').AsString := DM.cdsCarregarItemPedido.FieldByName('complemento').AsString;
      cdsItensPedido.FieldByName('unidadeCombo').AsString := DM.cdsCarregarItemPedido.FieldByName('unidadeCombo').AsString;
      cdsItensPedido.Post;
      DM.cdsCarregarItemPedido.Next;
    end;
    cdsItensPedido.Active := True;    
  end;

begin
  //buscando o pedido.
  DM.cdsCarregarPedido.Close;
  DM.zQryCarregarPedido.Close;
  DM.zQryCarregarPedido.SQL.Clear;
  DM.zQryCarregarPedido.SQL.Add('SELECT p.*, c.nome, e.estado, e.cidade, e.bairro, e.rua, e.numero, e.cep, e.complemento ');
  DM.zQryCarregarPedido.SQL.Add('FROM pedido p ');
  DM.zQryCarregarPedido.SQL.Add('JOIN cliente c ON p.cod_cliente = c.codigo ');
  DM.zQryCarregarPedido.SQL.Add('JOIN endereco e ON p.cod_endereco_entrega = e.codigo ');
  DM.zQryCarregarPedido.SQL.Add('WHERE p.codigo = :codigo');
  DM.zQryCarregarPedido.ParamByName('codigo').AsInteger := pnCodPedido;
  DM.zQryCarregarPedido.Open;
  DM.cdsCarregarPedido.Open;

  //buscando os itens do pedido.
  if (DM.cdsCarregarPedido.RecordCount = 1) then
  begin
    DM.cdsCarregarItemPedido.Close;
    DM.zQryCarregarItemPedido.Close;
    DM.zQryCarregarItemPedido.SQL.Clear;
    DM.zQryCarregarItemPedido.SQL.Add('SELECT i.quantidade, i.unidade, i.descricao, i.valor_unitario, i.valor_total, i.complemento, i.unidade AS unidadeCombo ');
    DM.zQryCarregarItemPedido.SQL.Add('FROM item_pedido i ');
    DM.zQryCarregarItemPedido.SQL.Add('JOIN pedido p ON i.cod_pedido = p.codigo ');
    DM.zQryCarregarItemPedido.SQL.Add('WHERE p.codigo = :codigo');
    DM.zQryCarregarItemPedido.ParamByName('codigo').AsInteger := DM.cdsCarregarPedido.FieldByName('codigo').AsInteger;
    DM.zQryCarregarItemPedido.Open;
    DM.cdsCarregarItemPedido.Open;

    //carregando o pedido.
    edCodigoPedido.Text := DM.cdsCarregarPedido.FieldByName('codigo').AsString;
    lblNomeClientePedido.Caption := DM.cdsCarregarPedido.FieldByName('nome').AsString;
    edValorTotalPedido.Text := FoFuncoes.formatarValorMonetario(DM.cdsCarregarPedido.FieldByName('valor_total').AsString);
    cbBxEnderecoEstadoEntrega.Text := DM.cdsCarregarPedido.FieldByName('estado').AsString;
    edEnderecoCidadeEntrega.Text := DM.cdsCarregarPedido.FieldByName('cidade').AsString;
    edEnderecoBairroEntrega.Text := DM.cdsCarregarPedido.FieldByName('bairro').AsString;
    edEnderecoRuaEntrega.Text := DM.cdsCarregarPedido.FieldByName('rua').AsString;
    edEnderecoNumeroEntrega.Text := DM.cdsCarregarPedido.FieldByName('numero').AsString;
    medEnderecoCEPEntrega.Text := DM.cdsCarregarPedido.FieldByName('cep').AsString;
    mmDescricaoPedido.Text := DM.cdsCarregarPedido.FieldByName('descricao').AsString;
    if (DM.cdsCarregarPedido.FieldByName('status').AsInteger = nSTATUS_PEDIDO_ABERTO) then
      lblStatusPedido.Caption := sSTATUS_PEDIDO_ABERTO
    else if (DM.cdsCarregarPedido.FieldByName('status').AsInteger = nSTATUS_PEDIDO_FINALIZADO) then
      lblStatusPedido.Caption := sSTATUS_PEDIDO_FINALIZADO
    else
      lblStatusPedido.Caption := STRING_INDEFINIDO;

    if (not (DM.cdsCarregarItemPedido.IsEmpty)) then
    begin
      CarregarItensDoPedidoParaVisualizar;
    end;

    FnStatusTela := nSTATUS_TELA_PEDIDO_VISUALIZAR;
    HabilitarTela(FnStatusTela);
  end;
end;

procedure TfrmCadPedido.ChamarTelaPagamentoPedido(pnCodPedido: Integer);
var
  frmPgtoPedido: TfrmPagamentoPedido;
  vDados: OleVariant;
begin
  frmPgtoPedido := TfrmPagamentoPedido.Create(nil);
  try
    vDados := VarArrayCreate([0, 2], varVariant);
    vDados[0] := pnCodPedido;
    vDados[1] := lblNomeClientePedido.Caption;
    vDados[2] := edValorTotalPedido.Text;
    frmPgtoPedido.PassaParametro(sPRM_DADOS_REALIZAR_PAGAMENTO_PEDIDO, vDados);
    frmPgtoPedido.ShowModal;
  finally
    FreeAndNil(frmPgtoPedido);
  end;
end;

procedure TfrmCadPedido.CalcularValorTotalDoItem;
var
  nQtde: Integer;
  nValorUnitario: Double;
  nValorTotal: Double;
  //nValorTotalPedido: Double;
  oCdsSomarTotal: TClientDataSet;
  dTotal: Currency;
begin
  if (FnStatusTela <> nSTATUS_TELA_PEDIDO_NOVO) then
    Exit;

  nQtde := FoFuncoes.RetornarValorInteiro(grItensPedido.Columns.Grid.Fields[0].Text);
  nValorUnitario := FoFuncoes.RetornarValorDouble(grItensPedido.Columns.Grid.Fields[3].Text);
  if (nQtde <> NUMERO_INDEFINIDO) and (nValorUnitario <> NUMERO_INDEFINIDO) then
  begin
    if (not(FoFuncoes.validarValorMonetario(FloatToStr(nValorUnitario)))) then
      MessageDlg('O valor Unitário não é válido.', mtInformation, [mbOK], 0)
    else
    begin
      if not (cdsItensPedido.State in [dsInsert,dsEdit]) then
        cdsItensPedido.Edit;

      grItensPedido.Columns.Grid.Fields[3].Text := FoFuncoes.formatarValorMonetario(grItensPedido.Columns.Grid.Fields[3].Text);

      //calcula o valor total.
      nValorTotal := nQtde * nValorUnitario;

      grItensPedido.Columns.Grid.Fields[4].Text := FoFuncoes.formatarValorMonetario(FloatToStr(nValorTotal));

      (*
      nValorTotalPedido := FoFuncoes.RetornarValorDouble(edValorTotalPedido.Text);
      if (nValorTotalPedido <> NUMERO_INDEFINIDO) then
        edValorTotalPedido.Text := FoFuncoes.formatarValorMonetario(FloatToStr(nValorTotalPedido + nValorTotal))
      else
        edValorTotalPedido.Text := FoFuncoes.formatarValorMonetario(FloatToStr(nValorTotal));
      *)
    end;
  end;

  //somando o total do pedido, pegando os valores do dataSet oCdsSomarTotal.
  dTotal := 0;
  oCdsSomarTotal := TClientDataSet.Create(nil);
  try
    oCdsSomarTotal.Data := cdsItensPedido.Data;
    oCdsSomarTotal.First;
    while not(oCdsSomarTotal.Eof) do
    begin
      if(FoFuncoes.validarValorMonetario(oCdsSomarTotal.FieldByName('valor_total').AsString))then
        dTotal := dTotal + StrToCurr(FoFuncoes.retirarCaracteres(oCdsSomarTotal.FieldByName('valor_total').AsString, '.'));
      oCdsSomarTotal.Next;
    end;
  finally
    edValorTotalPedido.Text := FoFuncoes.FormatarValorMonetario(CurrToStr(dTotal));
    FreeAndNil(oCdsSomarTotal);
  end;
end;

procedure TfrmCadPedido.PegarDadosClienteDaAbaCliente;
begin
  if (FoCliente.ExisteCliente) then
  begin
    lblNomeClientePedido.Caption := FoCliente.GetNome;
    lblTotalPedidosCliente.Caption := '(' + IntToStr(FoCliente.TotalPedidosDoCliente) + ' pedidos)';
    lblTotalPedidosCliente.Left := lblNomeClientePedido.Left + lblNomeClientePedido.Width + 3;

    cbBxEnderecoEstadoEntrega.Text := FoCliente.GetEnderecoEstado;
    edEnderecoCidadeEntrega.Text := FoCliente.GetEnderecoCidade;
    edEnderecoBairroEntrega.Text := FoCliente.GetEnderecoBairro;
    edEnderecoRuaEntrega.Text := FoCliente.GetEnderecoRua;
    edEnderecoNumeroEntrega.Text :=  FoCliente.GetEnderecoNumeroAsString;
    medEnderecoCEPEntrega.Text := FoCliente.GetEnderecoCEP;
    mmEnderecoComplementoEntrega.Text := FoCliente.GetEnderecoComplemento;
  end;
end;

procedure TfrmCadPedido.FormShow(Sender: TObject);
begin
  LimparClienteTela;
  FoCliente.Limpar;
end;

procedure TfrmCadPedido.FormCreate(Sender: TObject);
begin
  pgCtrlPedido.ActivePageIndex := nCLIENTE;
  FoCliente := TCliente.CriarCliente;
  FoFuncoes := TFuncoes.Create;
  FoTelaLocalizarCliente := TfrmLocalizarCliente.Create(nil);
  FoTelaLocalizarDescricaoProdutos := TfrmLocalizarDescricaoProdutos.Create(nil);
  FoTelaLocalizarPedido := TfrmLocalizarPedido.Create(nil);
  CriarDataSetsItensPedido;
  CarregarDescricaoProdutos;
  FoTelaLocalizarCliente.Hide;
  FoTelaLocalizarDescricaoProdutos.Hide;
  FoTelaLocalizarPedido.Hide;
  FnStatusTela := nSTATUS_TELA_INICIAL_CLIENTE;
  FbAlterouClienteDepoisSalvar := False;
  FbPodeChamarTelaLocalizarCliente := True;
  FbPodeChamarTelaLocalizarPedido := True;
  FnPedido_CodCliente := NUMERO_INDEFINIDO;
  FsValorItemPedidoEntrar := STRING_INDEFINIDO;
  LimparClienteTela;
  HabilitarTela(FnStatusTela);
end;

procedure TfrmCadPedido.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoCliente);
  FreeAndNil(FoFuncoes);
  FreeAndNil(FoTelaLocalizarCliente);
  FreeAndNil(FoTelaLocalizarDescricaoProdutos);
  FreeAndNil(FoTelaLocalizarPedido);
end;

procedure TfrmCadPedido.edCodigoExit(Sender: TObject);
begin
//  if edCodigo.AlterouValorCampoSairComponente then
//    ChamarTelaLocalizarCliente('cc_codigo', edCodigo.Text, nCLIENTE);
end;

procedure TfrmCadPedido.edNomeExit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_NOME, edNome.Text);

//  if edNome.AlterouValorCampoSairComponente then
//    ChamarTelaLocalizarCliente('nome', edNome.Text, nCLIENTE);
end;

procedure TfrmCadPedido.medCPFExit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_CPF, medCPF.Text);

//  if medCPF.AlterouValorCampoSairComponente then
//    ChamarTelaLocalizarCliente('cpf', medCPF.Text, nCLIENTE);
end;

procedure TfrmCadPedido.edIdentidadeExit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_IDENTIDADE, edIdentidade.Text);

//  if edIdentidade.AlterouValorCampoSairComponente then
//    ChamarTelaLocalizarCliente('identidade', edIdentidade.Text, nCLIENTE);
end;

procedure TfrmCadPedido.ApplicationEventsHint(Sender: TObject);
begin
  if (pgCtrlPedido.ActivePageIndex = nCLIENTE) then
    sbCliente.Panels[0].Text := Application.Hint

  else if (pgCtrlPedido.ActivePageIndex = nPEDIDO) then
    sbPedido.Panels[0].Text := Application.Hint;
end;

procedure TfrmCadPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //F5 - localizar.
  if (Key = VK_F5) then
  begin
    if (pgCtrlPedido.ActivePageIndex = nCLIENTE) then
    begin
      if (ActiveControl = edCodigo) then
        ChamarTelaLocalizarCliente('cc_codigo', edCodigo.Text, nCLIENTE)
      else if (ActiveControl = edNome) then
        ChamarTelaLocalizarCliente('nome', edNome.Text, nCLIENTE)
      else if (ActiveControl = medCPF) then
        ChamarTelaLocalizarCliente('cpf', medCPF.Text, nCLIENTE)
      else if (ActiveControl = edIdentidade) then
        ChamarTelaLocalizarCliente('identidade', edIdentidade.Text, nCLIENTE)
      else
        ChamarTelaLocalizarCliente(STRING_INDEFINIDO, STRING_INDEFINIDO, nCLIENTE);
    end

    else if (pgCtrlPedido.ActivePageIndex = nPEDIDO) then
    begin
      //else if (ActiveControl = edNome) then
      //  ChamarTelaLocalizarCliente('nome', mmDescricaoPedido.Text)

      //está na coluna da descrição.
      if (grItensPedido.SelectedIndex = nIDX_DESCRICAO) then
        ChamarTelaLocalizarDescricaoProdutos('nome', grItensPedido.Columns.Grid.Fields[2].Text);
    end;
  end;
end;

procedure TfrmCadPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCadPedido.medDataNascimentoExit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_DATA_NASCIMENTO, medDataNascimento.Text);
end;

procedure TfrmCadPedido.edProfissaoExit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_PROFISSAO, edProfissao.Text);
end;

procedure TfrmCadPedido.edEmailExit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_EMAIL, edEmail.Text);
end;

procedure TfrmCadPedido.medTelefone1Exit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_TELEFONE_1, medTelefone1.Text);
end;

procedure TfrmCadPedido.medTelefone2Exit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_TELEFONE_2, medTelefone2.Text);
end;

procedure TfrmCadPedido.cbBxEnderecoEstadoExit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_ESTADO, cbBxEnderecoEstado.Text);
end;

procedure TfrmCadPedido.edEnderecoCidadeExit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_CIDADE, edEnderecoCidade.Text);
end;

procedure TfrmCadPedido.edEnderecoBairroExit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_BAIRRO, edEnderecoBairro.Text);
end;

procedure TfrmCadPedido.edEnderecoRuaExit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_RUA, edEnderecoRua.Text);
end;

procedure TfrmCadPedido.edEnderecoNumeroExit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_NUMERO, edEnderecoNumero.Text);
end;

procedure TfrmCadPedido.medEnderecoCEPExit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_CEP, medEnderecoCEP.Text);
end;

procedure TfrmCadPedido.mmEnderecoComplementoExit(Sender: TObject);
begin
  VerificarAlterouClienteDepoisSalvar(sCLIENTE_COMPLEMENTO, mmEnderecoComplemento.Text);
end;

procedure TfrmCadPedido.medCNPJExit(Sender: TObject);
begin
//  if medCNPJ.AlterouValorCampoSairComponente then
//    ChamarTelaLocalizarCliente('cnpj', medCNPJ.Text, nCLIENTE);

  VerificarAlterouClienteDepoisSalvar(sCLIENTE_CNPJ, medCNPJ.Text);
end;

procedure TfrmCadPedido.pgCtrlPedidoChange(Sender: TObject);
begin
  if (pgCtrlPedido.ActivePageIndex = nPEDIDO) then
  begin
    LimparPedidoTela;
    PegarDadosClienteDaAbaCliente;
    FnStatusTela := nSTATUS_TELA_INICIAL_PEDIDO;
    HabilitarTela(FnStatusTela);
  end;
end;

procedure TfrmCadPedido.btnNovoPedido1Click(Sender: TObject);
begin
  LimparPedidoTela;
  FnStatusTela := nSTATUS_TELA_PEDIDO_NOVO;
  lblStatusPedido.Caption := sSTATUS_PEDIDO_ABERTO;
  HabilitarTela(FnStatusTela);
end;

procedure TfrmCadPedido.grItensPedidoColExit(Sender: TObject);
begin
  if (FnStatusTela in [nSTATUS_TELA_PEDIDO_VISUALIZAR]) then
    Exit;

  if not(FnStatusTela in [nSTATUS_TELA_PEDIDO_NOVO]) then
    Exit;

  //saiu da coluna da descrição.
  if (grItensPedido.SelectedIndex = nIDX_DESCRICAO) then
  begin
    if (grItensPedido.Columns.Grid.Fields[2].Text <> FsValorItemPedidoEntrar) then
      ChamarTelaLocalizarDescricaoProdutos('nome', grItensPedido.Columns.Grid.Fields[2].Text);
  end;

  //saiu da coluna quantidade ou valor unitário.
  if (grItensPedido.SelectedIndex = nIDX_QTDE) or (grItensPedido.SelectedIndex = nIDX_VLR_UNITARIO) then
  begin
    CalcularValorTotalDoItem;
  end;
end;

procedure TfrmCadPedido.grItensPedidoColEnter(Sender: TObject);
begin
  if (FnStatusTela in [nSTATUS_TELA_PEDIDO_VISUALIZAR]) then
    Exit;
    
  //entrou na coluna da descrição.
  if (grItensPedido.SelectedIndex = nIDX_DESCRICAO) then
    FsValorItemPedidoEntrar := grItensPedido.Columns.Grid.Fields[2].Text;
end;

procedure TfrmCadPedido.btnAdicionarItemPedidoClick(Sender: TObject);
begin
  cdsItensPedido.Append;
end;

procedure TfrmCadPedido.btnDeletarItemPedidoClick(Sender: TObject);
begin
  if (cdsItensPedido.Active) and (not(cdsItensPedido.IsEmpty)) then
    cdsItensPedido.Delete;
end;

procedure TfrmCadPedido.edCodigoPedidoExit(Sender: TObject);
begin
  ChamarTelaLocalizarPedido('cc_codigo', edCodigoPedido.Text);
end;

procedure TfrmCadPedido.grItensPedidoKeyPress(Sender: TObject;
  var Key: Char);
begin
  //enter.
  if (Key = #13) then
  begin
    if (grItensPedido.SelectedIndex < nIDX_COMPLEMENTO) then
      grItensPedido.SelectedIndex := grItensPedido.SelectedIndex + 1
    else if (grItensPedido.SelectedIndex <> nIDX_COMPLEMENTO) then
      if not(FnStatusTela in [nSTATUS_TELA_PEDIDO_VISUALIZAR]) then
        tlBtnNovoPedidoClick(Self);
  end;

  //coluna do valor unitário ou valor total
  if (grItensPedido.SelectedIndex = nIDX_VLR_UNITARIO) or (grItensPedido.SelectedIndex = nIDX_VLR_TOTAL) then
  begin
    if not(Key in['0'..'9',',',Chr(8)])then
      Key:= #0
  end;  
end;

procedure TfrmCadPedido.lblClientePedidoClick(Sender: TObject);
begin
  ChamarTelaLocalizarCliente('cc_codigo', edCodigo.Text, nPEDIDO);
end;

procedure TfrmCadPedido.tlBtnNovoClienteClick(Sender: TObject);
begin
  LimparClienteTela;
  FnStatusTela := nSTATUS_TELA_CLIENTE_NOVO;
  FbAlterouClienteDepoisSalvar := False;
  HabilitarTela(FnStatusTela);
end;

procedure TfrmCadPedido.tlBtnEditarClienteClick(Sender: TObject);
begin
  EditarCliente;
end;

procedure TfrmCadPedido.tlBtnExcluirClienteClick(Sender: TObject);
begin
  if not(FnStatusTela in [nSTATUS_TELA_CLIENTE_EDITAR, nSTATUS_TELA_CLIENTE_SALVAR])  then
    Exit;

  if (MessageDlg('Deseja deletar o cliente ' + FoCliente.GetNome + ' ?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    if FoCliente.Deletar then
    begin
      FnStatusTela := nSTATUS_TELA_INICIAL_CLIENTE;
      FbAlterouClienteDepoisSalvar := False;
      LimparClienteTela;
      HabilitarTela(FnStatusTela);
      FoTelaLocalizarCliente.PassaParametro(sPRM_ATUALIZAR_TELA, Null);
    end
    else
      MessageDlg('Cliente não pode ser deletado.', mtInformation, [mbOK], 0);
  end;
end;

procedure TfrmCadPedido.tlBtnSalvarClienteClick(Sender: TObject);
var
  sCamposErro: string;
begin
  FoCliente.SetNome(edNome.Text);
  FoCliente.SetCPF(medCPF.Text);
  FoCliente.SetIdentidade(edIdentidade.Text);
  FoCliente.SetCNPJ(medCNPJ.Text);
  FoCliente.SetDataNascimento(medDataNascimento.Text);
  FoCliente.SetProfissao(edProfissao.Text);
  FoCliente.SetEmail(edEmail.Text);
  FoCliente.SetTelefone1(medTelefone1.Text);
  FoCliente.SetTelefone2(medTelefone2.Text);
  FoCliente.SetEnderecoEstado(cbBxEnderecoEstado.Text);
  FoCliente.SetEnderecoCidade(edEnderecoCidade.Text);
  FoCliente.SetEnderecoBairro(edEnderecoBairro.Text);
  FoCliente.SetEnderecoRua(edEnderecoRua.Text);
  FoCliente.SetEnderecoNumero(FoFuncoes.RetornarValorInteiroString(edEnderecoNumero.Text, NUMERO_INDEFINIDO));
  FoCliente.SetEnderecoCEP(medEnderecoCEP.Text);
  FoCliente.SetEnderecoComplemento(mmEnderecoComplemento.Text);

  if not(VerificarConsistenciaAntesSalvarCliente) then
    Exit;

  if ValidarClienteAntesSalvar(sCamposErro) then
  begin
    if (FoCliente.Salvar(GetTipoOperacaoSalvar)) then
    begin
      if GetTipoOperacaoSalvar = nOPERACAO_NOVO then
        FoCliente.CarregarCliente(NUMERO_INDEFINIDO)
      else if GetTipoOperacaoSalvar = nOPERACAO_EDITAR then
        FoCliente.CarregarCliente(FoCliente.GetCodigo);

      CarregarClienteTela;

      FoTelaLocalizarCliente.PassaParametro(sPRM_ATUALIZAR_TELA, Null);
      FnStatusTela := nSTATUS_TELA_CLIENTE_SALVAR;
      FbAlterouClienteDepoisSalvar := False;
      HabilitarTela(FnStatusTela);
      //cliente inserido fica sendo o Cliente do Pedido.
      FnPedido_CodCliente := FoCliente.GetCodigo;
    end
    else
      MessageDlg('Cliente não pode ser salvo!', mtInformation, [mbOK], 0);
  end
  else
  begin
    if (sCamposErro  <> STRING_INDEFINIDO) then
      MessageDlg('Verifique os campos antes de salvar: ' + sCamposErro, mtInformation, [mbOK], 0);
  end;
end;
procedure TfrmCadPedido.tlBtnRestaurarClienteClick(Sender: TObject);
begin
  if not (FnStatusTela in [nSTATUS_TELA_CLIENTE_EDITAR, nSTATUS_TELA_CLIENTE_LOCALIZOU]) then
    Exit;

  CarregarClienteTela;
end;

procedure TfrmCadPedido.tlBtnLimparClienteClick(Sender: TObject);
begin
  LimparCliente;
end;

procedure TfrmCadPedido.tlBtnNovoPedidoClick(Sender: TObject);
begin
  LimparPedidoTela;
  FnStatusTela := nSTATUS_TELA_PEDIDO_NOVO;
  lblStatusPedido.Caption := sSTATUS_PEDIDO_ABERTO;
  HabilitarTela(FnStatusTela);
  //ação veio logo após a seleção do Cliente na página anterior.
  if (FnPedido_CodCliente <> NUMERO_INDEFINIDO) then
    lblNomeClientePedido.Caption := FoCliente.GetNome;
  PegarDadosClienteDaAbaCliente;    

  keybd_event(VK_SPACE,0,0,0);
  keybd_event(VK_SPACE,0,KEYEVENTF_KEYUP,0);
end;

procedure TfrmCadPedido.tlBtnFinalizarPedidoClick(Sender: TObject);
var
  sCamposErro: string;
  nCodEndereco: Integer;
  nCodPedido: Integer;
  dVlrPedido: Currency;
  dVlrUnitario: Currency;
  dVlrTotal: Currency;
begin
  //o pedido não vai ser criado um conjunto de dados.
  if not ValidarPedidoAntesSalvar(sCamposErro) then
  begin
    if (sCamposErro  <> STRING_INDEFINIDO) then
      MessageDlg('Verifique os campos antes de salvar: ' + sCamposErro, mtInformation, [mbOK], 0);
    Exit;
  end;
  
  if not(VerificarConsistenciaAntesSalvarPedido) then
    Exit;

  begin
    //salvando o endereço de entrega.
    try
      DM.ZConnection.StartTransaction;
      nCodEndereco := FoFuncoes.RetornarProximoCodigo(TABLE_ENDERECO,True);
      DM.cdsEndereco.Close;
      DM.zQryEndereco.Close;
      DM.zQryEndereco.SQL.Clear;
      DM.zQryEndereco.SQL.Add('INSERT INTO endereco (estado, cidade, bairro, rua, numero, cep, complemento) ');
      DM.zQryEndereco.SQL.Add('VALUES (:estado, :cidade, :bairro, :rua, :numero, :cep, :complemento)');
      DM.zQryEndereco.ParamByName('estado').AsString := cbBxEnderecoEstadoEntrega.Text;
      DM.zQryEndereco.ParamByName('cidade').AsString := edEnderecoCidadeEntrega.Text;
      DM.zQryEndereco.ParamByName('bairro').AsString := edEnderecoBairroEntrega.Text;
      DM.zQryEndereco.ParamByName('rua').AsString := edEnderecoRuaEntrega.Text;
      if (Trim(edEnderecoNumeroEntrega.Text) <> STRING_INDEFINIDO) then
        DM.zQryEndereco.ParamByName('numero').AsInteger := StrToInt(edEnderecoNumeroEntrega.Text)
      else
        DM.zQryEndereco.ParamByName('numero').Clear;
      if (FoFuncoes.validarCEP(medEnderecoCEPEntrega.Text)) then
        DM.zQryEndereco.ParamByName('cep').AsString := medEnderecoCEPEntrega.Text
      else
        DM.zQryEndereco.ParamByName('cep').Clear;
      DM.zQryEndereco.ParamByName('complemento').AsString := mmEnderecoComplementoEntrega.Text;
      DM.zQryEndereco.ExecSQL;

      DM.ZConnection.Commit;
    except
      MessageDlg('Endereço não pode ser salvo.', mtInformation, [mbOK], 0);
      DM.ZConnection.Rollback;
      Exit;
    end;

    //salvando o pedido.
    try
      try
        dVlrPedido := StrToCurr(FoFuncoes.retirarCaracteres(edValorTotalPedido.Text, '.'));
      except
        dVlrPedido := NUMERO_INDEFINIDO;
      end;

      DM.ZConnection.StartTransaction;
      nCodPedido :=  FoFuncoes.RetornarProximoCodigo(TABLE_PEDIDO ,True);
      DM.cdsPedido.Close;
      DM.zQryPedido.Close;
      DM.zQryPedido.SQL.Clear;
      DM.zQryPedido.SQL.Add('INSERT INTO pedido (cod_cliente, cod_endereco_entrega, descricao, valor_total, status)' );
      DM.zQryPedido.SQL.Add('VALUES (:cod_cliente, :cod_endereco_entrega, :descricao, :valor_total, :status)');
      DM.zQryPedido.ParamByName('cod_cliente').AsInteger := FnPedido_CodCliente;
      DM.zQryPedido.ParamByName('cod_endereco_entrega').AsInteger := nCodEndereco;
      DM.zQryPedido.ParamByName('descricao').AsString := mmDescricaoPedido.Text;
      DM.zQryPedido.ParamByName('valor_total').AsCurrency := dVlrPedido;
      DM.zQryPedido.ParamByName('status').AsInteger := nSTATUS_PEDIDO_FINALIZADO;
      DM.zQryPedido.ExecSQL;

     DM.ZConnection.Commit;
    except
      MessageDlg('Pedido não pode ser salvo.', mtInformation, [mbOK], 0);
      DM.ZConnection.Rollback;
      Exit;
    end;

    //salvando os itens do pedido.
    try
      try
        dVlrUnitario := StrToCurr(FoFuncoes.retirarCaracteres(cdsItensPedido.FieldByName('valor_unitario').AsString, '.'));
        dVlrTotal := StrToCurr(FoFuncoes.retirarCaracteres(cdsItensPedido.FieldByName('valor_total').AsString, '.'));
      except
        dVlrUnitario := NUMERO_INDEFINIDO;
        dVlrTotal := NUMERO_INDEFINIDO;
      end;

      DM.ZConnection.StartTransaction;
      cdsItensPedido.First;
      while not(cdsItensPedido.Eof) do
      begin
        DM.cdsItemPedido.Close;
        DM.zQryItemPedido.Close;
        DM.zQryItemPedido.SQL.Clear;
        DM.zQryItemPedido.SQL.Add('INSERT INTO item_pedido (cod_pedido, quantidade, unidade, descricao, valor_unitario, valor_total, complemento) ');
        DM.zQryItemPedido.SQL.Add('VALUES (:cod_pedido, :quantidade, :unidade, :descricao, :valor_unitario, :valor_total, :complemento) ');
        DM.zQryItemPedido.ParamByName('cod_pedido').AsInteger := nCodPedido;
        DM.zQryItemPedido.ParamByName('quantidade').AsInteger := cdsItensPedido.FieldByName('quantidade').AsInteger;
        DM.zQryItemPedido.ParamByName('unidade').AsString := UpperCase(cdsItensPedido.FieldByName('unidade').AsString);
        DM.zQryItemPedido.ParamByName('descricao').AsString := UpperCase(cdsItensPedido.FieldByName('descricao').AsString);
        DM.zQryItemPedido.ParamByName('valor_unitario').AsCurrency := dVlrUnitario;
        DM.zQryItemPedido.ParamByName('valor_total').AsCurrency := dVlrTotal;
        DM.zQryItemPedido.ParamByName('complemento').AsString := cdsItensPedido.FieldByName('complemento').AsString;
        DM.zQryItemPedido.ExecSQL;

        cdsItensPedido.Next;
      end;

      DM.ZConnection.Commit;

      FnStatusTela := nSTATUS_TELA_PEDIDO_VISUALIZAR;
      lblStatusPedido.Caption := sSTATUS_PEDIDO_FINALIZADO;
      HabilitarTela(FnStatusTela);

      ChamarTelaPagamentoPedido(nCodPedido);
    except
      MessageDlg('Item do Pedido não pode ser salvo.', mtInformation, [mbOK], 0);
      DM.ZConnection.Rollback;
      Exit;
    end;
  end;
end;

procedure TfrmCadPedido.mitRelatorioPedidoClick(Sender: TObject);
var
  frmRelatorio: TfrmRelatorioPedido;
begin
  Application.CreateForm(TfrmRelatorioPedido, frmRelatorio);
  frmRelatorio.PassaParametro(sPRM_CODIGO_PEDIDO, edCodigoPedido.Text);
  frmRelatorio.PassaParametro(sPRM_BUSCAR_PEDIDO, null);
  frmRelatorio.PassaParametro(sPRM_BUSCAR_ITENS_PEDIDO, null);
  if frmRelatorio.ExistemItensPedido then
    frmRelatorio.rlRelatorio.Preview;
end;

procedure TfrmCadPedido.pgCtrlPedidoChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if (pgCtrlPedido.ActivePageIndex = nCLIENTE) then
  begin
    if (FnStatusTela in [nSTATUS_TELA_CLIENTE_NOVO, nSTATUS_TELA_CLIENTE_EDITAR]) then
    begin
      if (MessageDlg('Deseja cancelar a edição do cliente, e abrir a tela de Pedidos?',
        mtConfirmation, [mbYes,mbNo], 0) = mrYes) then
      begin
        LimparCliente;
        AllowChange := False;
        //pgCtrlPedido.ActivePageIndex := nPEDIDO;
//        FoFuncoes.focarComponente(edCodigoPedido);
      end
      else
      begin
        AllowChange := False;
        //pgCtrlPedido.ActivePageIndex := nCLIENTE
      end;
    end;
  end

  else if (pgCtrlPedido.ActivePageIndex = nPEDIDO) then
  begin
    if (FnStatusTela in [nSTATUS_TELA_PEDIDO_NOVO]) then
    begin
      if (MessageDlg('Deseja cancelar o cadastro do pedido, e abrir a tela de Clientes?',
        mtConfirmation, [mbYes,mbNo], 0) = mrYes) then
      begin
        LimparPedido;
        //pgCtrlPedido.ActivePageIndex := nCLIENTE
        FoFuncoes.focarComponente(edCodigo);
      end
      else
      begin
        AllowChange := False;
        //pgCtrlPedido.ActivePageIndex := nPEDIDO
      end;
    end;
  end
end;

procedure TfrmCadPedido.tlBtnLimparPedidoClick(Sender: TObject);
begin
  LimparPedido;
end;

procedure TfrmCadPedido.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  // Ctrl pressionada...
  if (GetKeyState(VK_CONTROL) < 0) and (Msg.Message = WM_KEYDOWN) then
  begin
    //cadastrando Cliente
    if (pgCtrlPedido.ActivePageIndex = nCLIENTE) then
    begin
      //tecla 'P' = Altera o foco para a página de Pedido
      if (Msg.wParam = Ord('P')) or (Msg.wParam = Ord('Z')) then
        pgCtrlPedido.ActivePageIndex := nPEDIDO

      //tecla 'N' = Novo Cliente
      else if (Msg.wParam = Ord('N')) then
        tlBtnNovoClienteClick(Self)

      //tecla 'E' = Editar Cliente
      else if (Msg.wParam = Ord('E')) then
        tlBtnEditarClienteClick(Self)

      //tecla 'X' = Excluir Cliente
      else if (Msg.wParam = Ord('C')) then
        tlBtnExcluirClienteClick(Self)

      //tecla 'S' = Salvar Cliente
      else if (Msg.wParam = Ord('S')) then
        tlBtnSalvarClienteClick(Self)

      //tecla 'L' = Limpar Cliente
      else if (Msg.wParam = Ord('L')) then
        tlBtnLimparClienteClick(Self);
    end
    //cadastrando Cliente
    else if (pgCtrlPedido.ActivePageIndex = nPEDIDO) then
    begin
      //tecla 'C' = Altera o foco para a página de Cliente
      if (Msg.wParam = Ord('C')) or (Msg.wParam = Ord('Z')) then
        pgCtrlPedido.ActivePageIndex := nCLIENTE

      //tecla 'N' = Novo Pedido
      else if (Msg.wParam = Ord('N')) then
        tlBtnNovoPedidoClick(Self)

      //tecla 'F' = Finalizar Pedido
      else if (Msg.wParam = Ord('F')) then
        tlBtnFinalizarPedidoClick(Self)

      //tecla 'L' = Limpar Pedido
      else if (Msg.wParam = Ord('L')) then
        tlBtnLimparPedidoClick(Self);
    end;
  end;
end;

procedure TfrmCadPedido.lblTotalPedidosClienteClick(Sender: TObject);
begin
  ChamarTelaLocalizarPedido('nome', lblNomeClientePedido.Caption);
end;

procedure TfrmCadPedido.grItensPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not(FnStatusTela in [nSTATUS_TELA_PEDIDO_NOVO]) then
    Exit;

  //coluna da unidade.
  if (grItensPedido.SelectedIndex = nIDX_UNIDADE) then
  begin
    if (Key = 32) then //pressionou espaço.
    begin
      keybd_event(VK_MENU,0,0,0);
      keybd_event(VK_DOWN,0,0,0);
      keybd_event(VK_DOWN,0,KEYEVENTF_KEYUP,0);
      keybd_event(VK_MENU,0,KEYEVENTF_KEYUP,0);
    end;
  end

  //coluna da descrição.
  else if (grItensPedido.SelectedIndex = nIDX_DESCRICAO) then
  begin
    if (Key = VK_F5) then //pressionou F5.
      ChamarTelaLocalizarDescricaoProdutos('nome', grItensPedido.Columns.Grid.Fields[2].Text, False);
  end;
end;

end.

