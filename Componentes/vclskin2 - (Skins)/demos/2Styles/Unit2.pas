unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, WinSkinData, StdCtrls;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
//   Sd3.LoadFromCollection(form1.skinstore1,1);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
