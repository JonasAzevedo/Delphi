unit unPesquisandoBairro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisandoRegistro, DB, DBClient, StdCtrls, plsEdit,
  ExtCtrls, Grids, DBGrids;

type
  TfrmPesquisandoBairro = class(TfrmPesquisandoRegistro)
    cdsPesquisandoCODIGO: TStringField;
    cdsPesquisandoNOME: TStringField;
    cdsPesquisandoCC_CODIGO: TStringField;
  private
  public
  protected
    procedure selecionarTodosRegistros();
    procedure popularClientDataSetPesquisa(poDados: TClientDataSet); override;
    procedure filtrarPesquisa(); override;
    procedure selecionouRegistro(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
  end;

var
  frmPesquisandoBairro: TfrmPesquisandoBairro;

implementation

uses unCadBairro, unConstantes;

{$R *.dfm}

{ TfrmPesquisandoBairro }

(* procedimentos de controle *)

procedure TfrmPesquisandoBairro.passarParametro(pTipo:String; pValores:OleVariant);
begin
  if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS)then
    Self.selecionarTodosRegistros();
end;

procedure TfrmPesquisandoBairro.selecionarTodosRegistros();
begin
end;

procedure TfrmPesquisandoBairro.popularClientDataSetPesquisa(poDados: TClientDataSet);
begin
  cdsPesquisando.EmptyDataSet;
  poDados.First;
  while(not(poDados.Eof))do
  begin
    cdsPesquisando.Insert;
    cdsPesquisando.FieldByName('CODIGO').AsString := poDados.FieldByName('CODIGO').AsString;
    cdsPesquisando.FieldByName('NOME').AsString := poDados.FieldByName('NOME').AsString;
    cdsPesquisando.FieldByName('CC_CODIGO').AsString := poDados.FieldByName('CODIGO').AsString;
    cdsPesquisando.Post;
    poDados.Next;
  end;
  cdsPesquisando.Active := True;
end;

procedure TfrmPesquisandoBairro.filtrarPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'CC_CODIGO') then
  begin
    cdsPesquisando.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisa.Text + '%');
    cdsPesquisando.Filtered := true;
  end;

  if(cdsPesquisando.RecordCount=0)then
  begin
    MessageDlg('Nenhum registro encontrado.',mtInformation,[mbOK],0);
    cdsPesquisando.Filter := STRING_INDEFINIDO;
    cdsPesquisando.Filtered := true;
    plsEdValorPesquisa.Clear;
  end;
end;

procedure TfrmPesquisandoBairro.selecionouRegistro();
begin
  if(cdsPesquisando.Active)then
  begin
    if(Self.FoNomeFormChamou is TfrmCadBairro)then
    begin
      (Self.FoNomeFormChamou as TfrmCadBairro).passarParametro(PRM_PESQUISOU,null);
      (Self.FoNomeFormChamou as TfrmCadBairro).realizouPesquisa(cdsPesquisandoCODIGO.AsInteger);
    end;
    Self.Hide;
  end;
end;

procedure TfrmPesquisandoBairro.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')then
    plsEdValorPesquisa.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO') then
    plsEdValorPesquisa.plsCaracteresAceitos := numeros;
end;

(* fim - procedimentos de controle *)

end.
