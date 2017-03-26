unit unCadastrarContaPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr, AppEvnts, ImgList,
  ExtCtrls, Grids, DBGrids, ComCtrls, StdCtrls, Buttons, Mask, ToolWin;

type
  TfrmCadastrarContaPagar = class(TForm)
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnCancelar: TToolButton;
    ToolButton1: TToolButton;
    tlBtnFinalizar: TToolButton;
    grpBxDadosCompra: TGroupBox;
    lblCodigo: TLabel;
    lblObservacao: TLabel;
    lblNome: TLabel;
    lblData: TLabel;
    lblInfValorTotal: TLabel;
    lblValorTotal: TLabel;
    edCodigo: TEdit;
    edFornecedor: TEdit;
    mmObservacao: TMemo;
    mEdDataCompra: TMaskEdit;
    btBtnAbreFornecedor: TBitBtn;
    StatusBar: TStatusBar;
    grpBxItensCompra: TGroupBox;
    dbGrdItensCompra: TDBGrid;
    pnlBotoesItensLocacao: TPanel;
    btBtnInserirItem: TBitBtn;
    btBtnExcluirItem: TBitBtn;
    imgLista: TImageList;
    ApplicationEvents: TApplicationEvents;
    qryItens: TSQLQuery;
    qryItensCODIGO: TIntegerField;
    qryItenscodProduto: TIntegerField;
    qryItensProduto: TStringField;
    qryItensVALOR_TOTAL: TFMTBCDField;
    dspItens: TDataSetProvider;
    cdsItens: TClientDataSet;
    cdsItensCODIGO: TIntegerField;
    cdsItenscodProduto: TIntegerField;
    cdsItensProduto: TStringField;
    cdsItensVALOR_TOTAL: TFMTBCDField;
    dsItens: TDataSource;
    qryValorTotal: TSQLQuery;
    qryValorTotalTotal: TFMTBCDField;
    dspValorTotal: TDataSetProvider;
    cdsValorTotal: TClientDataSet;
    cdsValorTotalTotal: TFMTBCDField;
    dsValorTotal: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastrarContaPagar: TfrmCadastrarContaPagar;

implementation

{$R *.dfm}

end.
