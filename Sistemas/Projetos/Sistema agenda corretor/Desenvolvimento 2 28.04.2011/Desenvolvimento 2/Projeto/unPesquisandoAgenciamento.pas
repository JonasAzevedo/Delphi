unit unPesquisandoAgenciamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisandoRegistro, DB, DBClient, StdCtrls, plsEdit,
  ExtCtrls, Grids, DBGrids;

type
  TfrmPesquisandoAgenciamento = class(TfrmPesquisandoRegistro)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisandoAgenciamento: TfrmPesquisandoAgenciamento;

implementation

{$R *.dfm}

end.
