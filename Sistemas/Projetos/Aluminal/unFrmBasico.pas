unit unFrmBasico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient;

type
  TFrmBasico = class(TForm)
  private
  protected
    procedure HabilitarTela(pnStatus: Integer); dynamic; abstract;
  public
    procedure PassaParametro(const psParametro: string; const pvValor: OleVariant); dynamic; abstract;
  end;

implementation

{$R *.dfm}

end.
