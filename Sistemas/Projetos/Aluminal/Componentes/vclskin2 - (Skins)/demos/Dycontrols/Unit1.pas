unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinSkinData, ComCtrls, Menus;

type
  TForm1 = class(TForm)
    Button3: TButton;
    SkinData1: TSkinData;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    Button1: TButton;
    N11111111111: TMenuItem;
    N22222222222221: TMenuItem;
    N33333333331: TMenuItem;
    N4444444441: TMenuItem;
    N555555555551: TMenuItem;
    Button2: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button3Click(Sender: TObject);
var tabsheet:TTabsheet;
    memo1:Tmemo;
    button:TButton;
    i:integer;
begin
  // Create a new tabsheet
  with PageControl1 do begin
    TabSheet := TTabSheet.Create(PageControl1);
    tabsheet.Caption:='List';
    TabSheet.PageControl := PageControl1;
    PageControl1.ActivePage := TabSheet;
    with Tabsheet do begin
      memo1:=Tmemo.create(self); //should be self
      memo1.ScrollBars:=ssboth;
      memo1.parent := tabsheet;
//      memo1.align := alclient;
      for i:= 0 to 100 do memo1.Lines.add('Line'+inttostr(i));
      button:=Tbutton.Create(self);
      button.Left := memo1.Left+memo1.Width+20;
      button.Top :=15;
      button.Caption := 'test';
      button.Parent := tabsheet;
    end;
  end;
  SkinData1.UpdateSkinControl(self,tabsheet);
  memo1.Invalidate;
end;

procedure TForm1.Button1Click(Sender: TObject);
var i:integer;
    item:Tmenuitem;
begin
    for i:= 1 to 3 do begin
       item:=  TMenuItem.Create(Self);
       item.Caption := 'newitem'+inttostr(i);
       PopupMenu1.items.add(item);
    end;
    skindata1.UpdateMenu(self);
end;

procedure TForm1.Button2Click(Sender: TObject);
var btn:Tbutton;
begin
    btn:=TButton.create(tabsheet1);
    btn.Width:= 75;
    btn.Height := 25;
    btn.Top := 5;
    btn.Left :=5;
    btn.Caption := 'DyBtn';
    btn.Parent := tabsheet1;
    SkinData1.UpdateSkinControl(self,tabsheet1);
    btn.Visible :=true;
end;

end.
