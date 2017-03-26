unit unExemplo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  texto: String;
begin
  {$Define TESTMODE} //definiu
  texto := 'TESTMODE DEFINIDO.';

  {$IfDef TESTMODE} //se TESTEMODE esta definido
  ShowMessage(texto);
  {$EndIf}

  {$UnDef TESTMODE} //indefinindo TESTMODE

  {$IfDef TESTMODE} //se TESTEMODE esta definido
  ShowMessage('OK ' + texto);
  {$Else} //senao
  ShowMessage('NAO ' + texto);
  {$EndIf}
end;

end.
