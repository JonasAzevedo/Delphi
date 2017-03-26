unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, WinSkinData, WinSkinForm, ComCtrls, StdCtrls,
  Buttons;

type
  TForm1 = class(TForm)
    SkinData1: TSkinData;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3;

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
begin
   skinaddlog('Form.OnActive');
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   skinaddlog('Form.OnShow');
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  frm: TForm2;
begin
  PageControl1.activepage:=tabsheet1;
  if Panel1.ControlCount = 0 then begin
    frm := Tform2.Create(self);
    frm.Parent := Panel1;
    frm.BorderStyle := bsnone;
    frm.WindowState := wsmaximized;
    if skindata1.active then
      skindata1.AddNestForm(self,frm);
    frm.Visible := True;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if Panel1.ControlCount > 0 then
    TForm(Panel1.Controls[0]).free;
end;

procedure TForm1.Button3Click(Sender: TObject);
var frm:Tframe3;
begin
  PageControl1.activepage:=tabsheet2;
  if Panel2.ControlCount = 0 then begin
    frm := Tframe3.Create(self);
    frm.Parent := Panel2;
    skindata1.AddNestForm(self,frm);
    frm.Visible := True;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if Panel2.ControlCount > 0 then
    TFrame(Panel2.Controls[0]).free;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
     skindata1.Active:=not skindata1.Active;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    Button1Click(nil);
end;

end.
