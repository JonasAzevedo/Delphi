unit unExplicacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, plsMemo, Buttons;

type
  TfrmExplicacao = class(TForm)
    grpBxPesoCaracAgenciamento: TGroupBox;
    plsMemoPesoCaracAgenciamento: TPlsMemo;
    BitBtn1: TBitBtn;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant);
  end;

implementation

uses unConstantes;

{$R *.dfm}

{ TfrmExplicacao }

procedure TfrmExplicacao.passarParametro(pTipo: String;
  pValores: OleVariant);
begin
  if(pTipo = PRM_ABRIR_EXPLICACAO_PESO_AGENCIAMENTO_ENCONTRADO)then
  begin
    grpBxPesoCaracAgenciamento.Visible := True;
    Self.Caption := 'EXPLICAÇÃO PESO CARACTERÍSTICA AGENCIAMENTO';
  end

  else if(pTipo = PRM_ABRIR_EXPLICACAO_PESO_IMOVEL_INTERESSE_ENCONTRADO)then
  begin
    grpBxPesoCaracAgenciamento.Visible := True;
    Self.Caption := 'EXPLICAÇÃO PESO CARACTERÍSTICA IMÓVEL DE INTERESSE';
  end
end;

procedure TfrmExplicacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmExplicacao.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

end.
