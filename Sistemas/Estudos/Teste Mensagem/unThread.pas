unit unThread;

interface

uses
  Classes;

type
  ThreadMoveUltLista = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation


uses unPrincipal;

procedure ThreadMoveUltLista.execute;
var
  contador: Integer;
begin
  Priority := tpLower;
  frmPrincipal.lstBxMsgTodas.ItemIndex := frmPrincipal.lstBxMsgTodas.Count-1;

  inherited;
end;

end.

