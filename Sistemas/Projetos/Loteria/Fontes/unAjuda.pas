unit unAjuda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmAjuda = class(TForm)
    lblTitulo: TLabel;
    lblInfExplicacao: TLabel;
    bvlDivisao: TBevel;
    lblExplicacao: TLabel;
  private
    { Private declarations }
  public
    procedure DefinirTipoAjuda(pnTipoAjuda: Integer);
  end;

implementation

uses
  unConstantes;

{$R *.dfm}

{ TfrmAjuda }

procedure TfrmAjuda.DefinirTipoAjuda(pnTipoAjuda: Integer);
begin
  lblTitulo.Caption := '';
  lblExplicacao.Caption := '';

  if (pnTipoAjuda = nAJUDA_NUMEROS_MAIS_SORTEADOS) then
  begin
    lblTitulo.Caption := 'N�MEROS MAIS SORTEADOS';
    lblExplicacao.Caption := 'Exibe os n�meros mais sorteados na loto-f�cil';
  end;
end;

end.
