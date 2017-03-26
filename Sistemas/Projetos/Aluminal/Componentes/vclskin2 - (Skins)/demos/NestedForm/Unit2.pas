unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinSkinForm, ExtCtrls, Buttons;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    SpeedButton1: TSpeedButton;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses unit1;
{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
//        showmessage('form2.button1 click');
//   form1.skindata1.skinfile:='skin0063.skn';
   close;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  showmessage('form2 closing');
  Action := caFree;
end;

end.
