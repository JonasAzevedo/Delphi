unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinSkinData;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    SkinData1: TSkinData;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CNCaptionButton(var Message: TMessage); message cn_captionBtnClick;
    procedure CNCaptionButtonVisible(var Message: TMessage); message cn_captionBtnvisible;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.CNCaptionButton(var Message: TMessage);
begin
    Showmessage('Caption Button Clicked'#13'Button ID '+inttostr(message.WParam));
end;

procedure TForm1.CNCaptionButtonVisible(var Message: TMessage);
begin
   message.result:=1;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     if form2=nil then
       Application.CreateForm(TForm2, Form2);
     form2.show;
end;

end.
