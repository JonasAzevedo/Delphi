unit unPesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, Buttons, ExtCtrls, Grids, DBGrids, unFuncoes,
  DB, DBClient, Provider, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Menus;

type
  TfrmPesquisar = class(TForm)
    grpBxFiltroPesquisar: TGroupBox;
    dbGrdDadosPesquisa: TDBGrid;
    pnlBotoes: TPanel;
    btBtnLimpar: TBitBtn;
    btBtnPesquisar: TBitBtn;
    zQryDados: TZQuery;
    dspDados: TDataSetProvider;
    cdsDados: TClientDataSet;
    dsDados: TDataSource;
    ppMnPopupMenu: TPopupMenu;
    mnItSelecionarTodosRegistros: TMenuItem;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure btBtnLimparClick(Sender: TObject);
    procedure mnItSelecionarTodosRegistrosClick(Sender: TObject);
  private
  public
//    procedure iniciarTela(poForm: TForm); dynamic; //inicia a tela (constructor)
    procedure PassarParametro(pTipo:String; pValores:OleVariant); dynamic; //passando parâmetros
  protected
    FoFuncoes: TFuncoes;

    procedure LimparTela(); dynamic; //limpar componentes de apresentação da tela
    procedure SelecionarTodosDados(); dynamic; abstract; //seleciona todos os dados
    procedure Pesquisar(); dynamic; abstract; //realiza a pesquisa
    procedure FormatarValores(); dynamic; abstract; //formata os valores retornados na consulta
    procedure VerificaEncontrouRegistros();
  end;

var
  frmPesquisar: TfrmPesquisar;

implementation

uses
  plsEdit, plsMemo, plsTMaskEdit, plsComboBox;

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmPesquisar.passarParametro(pTipo:String; pValores:OleVariant);
begin

end;

procedure TfrmPesquisar.limparTela();
var
  n: Integer;
  nTotComponentes: integer;
begin
  nTotComponentes := Self.ComponentCount;
  try
    for n:=0 to nTotComponentes-1 do
    begin
      try
        if(Self.Components[n] is TPlsEdit)then
        begin
          //if((poForm.Components[n] as TPlsEdit).CanFocus)then
            (Self.Components[n] as TPlsEdit).Clear;
        end
        else if(Self.Components[n] is TPlsMemo)then
        begin
          //if((poForm.Components[n] as TPlsMemo).CanFocus)then
            (Self.Components[n] as TPlsMemo).Clear;
        end
        else if (Self.Components[n] is TPlsMaskEdit)then
        begin
          //if((poForm.Components[n] as TPlsMaskEdit).CanFocus)then
            (Self.Components[n] as TPlsMaskEdit).Clear
        end
        else if (Self.Components[n] is TPlsComboBox)then
        begin
          //if((poForm.Components[n] as TPlsComboBox).CanFocus)then
            (Self.Components[n] as TPlsComboBox).ItemIndex := -1;
        end;
      except
        Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmPesquisar.limparTela();', 'Erro');
      end;
    end;
  except
    Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmPesquisar.limparTela();', 'Erro');
  end;
end;

procedure TfrmPesquisar.VerificaEncontrouRegistros();
var
  bAchou: Boolean;
begin
  bAchou := False;
  if(cdsDados.Active)and(cdsDados.RecordCount > 0)then
    bAchou := True;

  if(not(bAchou))then
  begin
    MessageDlg('Nenhum registro foi encontrado.', mtInformation, [mbOK], 0);
    SelecionarTodosDados();
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmPesquisar.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(key=#27)then
    Self.Close;
end;

procedure TfrmPesquisar.FormCreate(Sender: TObject);
begin
  FoFuncoes := TFuncoes.Create;
  FoFuncoes.ConfigurarComponenteEscreveDireitaParaEsquerda(Self);
  LimparTela();

  cdsDados.DisableControls;
  SelecionarTodosDados();
  FormatarValores();
  cdsDados.EnableControls;
end;

procedure TfrmPesquisar.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoFuncoes);
end;

procedure TfrmPesquisar.btBtnPesquisarClick(Sender: TObject);
begin
  cdsDados.DisableControls;
  Pesquisar();
  FormatarValores();
  cdsDados.EnableControls;
end;

procedure TfrmPesquisar.btBtnLimparClick(Sender: TObject);
begin
  LimparTela();
end;

procedure TfrmPesquisar.mnItSelecionarTodosRegistrosClick(Sender: TObject);
begin
  SelecionarTodosDados();
end;

end.
