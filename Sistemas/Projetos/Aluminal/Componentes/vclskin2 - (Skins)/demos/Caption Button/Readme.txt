Custom Caption Button

Vclskin support custom caption button.

1 open skin file in skin builder, click "Add caption button" button in toolbar.
2 import button bitmap .
3 set "Button Action Code" to (200~2000).
4 capture "cn_captionBtnClick" in your application.

example code:

  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    SkinData1: TSkinData;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CNCaptionButton(var Message: TMessage); message cn_captionBtnClick;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.CNCaptionButton(var Message: TMessage);
begin
    Showmessage('Caption Button Clicked'#13'Button ID '+inttostr(message.WParam));
end;
 