unit unTHread;

interface
  uses Classes;

  type
    TContador=class(TThread)
    protected
      procedure execute;override;
  end;

implementation

uses unComThread;

procedure TContador.execute;
var
  contador: Integer;
begin
  Priority := tpLower;
  Form1.ProgressBar1.Max := 1000000;
  For contador:=1 to 1000000 do
    Form1.ProgressBar1.Position := contador;
  inherited;
end;

end.
 