unit unPesquisandoProfissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisandoRegistro, DB, DBClient, StdCtrls, plsEdit,
  ExtCtrls, Grids, DBGrids;

type
  TfrmPesquisandoProfissao = class(TfrmPesquisandoRegistro)
    cdsPesquisandoCODIGO: TStringField;
    cdsPesquisandoNOME: TStringField;
    cdsPesquisandoCC_CODIGO: TStringField;
  private
  public
  protected
    procedure popularClientDataSetPesquisa(poDados: TClientDataSet); override;
    procedure filtrarPesquisa(); override;
    procedure selecionouRegistro(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
  end;

var
  frmPesquisandoProfissao: TfrmPesquisandoProfissao;

implementation

uses unCadProfissao, unConstantes;

{$R *.dfm}

{ TfrmPesquisandoProfissao }

(* procedimentos de controle *)

procedure TfrmPesquisandoProfissao.popularClientDataSetPesquisa(poDados: TClientDataSet);
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

procedure TfrmPesquisandoProfissao.filtrarPesquisa();
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

procedure TfrmPesquisandoProfissao.selecionouRegistro();
begin
  if(cdsPesquisando.Active)then
  begin
    if(Self.FoNomeFormChamou is TfrmCadProfissao)then
      (Self.FoNomeFormChamou as TfrmCadProfissao).realizouPesquisa(cdsPesquisandoCODIGO.AsInteger);
    Self.Hide;
  end;
end;

procedure TfrmPesquisandoProfissao.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')then
    plsEdValorPesquisa.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO') then
    plsEdValorPesquisa.plsCaracteresAceitos := numeros;
end;

(* fim - procedimentos de controle *)

end.
