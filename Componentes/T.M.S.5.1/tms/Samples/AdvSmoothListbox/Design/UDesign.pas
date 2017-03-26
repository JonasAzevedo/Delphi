unit UDesign;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvSmoothListBox, StdCtrls, AdvSmoothGDIP, jpeg, ExtCtrls, GDIPPictureContainer, ComObj, Math;

type
  TForm67 = class(TForm)
    AdvSmoothListBox1: TAdvSmoothListBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure GetOutlookContacts;
    { Public declarations }
  end;

var
  Form67: TForm67;

implementation

{$R *.dfm}


procedure TForm67.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := true;
  DoubleBuffered := true;
  GetOutlookContacts;
end;

procedure TForm67.GetOutlookContacts;
const
  olFolderContacts = $0000000A;
var
  outlook, NameSpace, Contacts, Contact: OleVariant;
  i: Integer;
begin
  AdvSmoothListBox1.Items.Clear;
  outlook := CreateOleObject('Outlook.Application');
  NameSpace := outlook.GetNameSpace('MAPI');

  Contacts := NameSpace.GetDefaultFolder(olFolderContacts);
  for i := 1 to Contacts.Items.Count do
  begin
    Contact := Contacts.Items.Item(i);
    with AdvSmoothListBox1.Items.Add do
    begin
      Caption := Contact.FullName;
      CaptionFont.Size := 11;
      CaptionFont.Color := clWhite;
//      Notes := 'dit is een url : <a href="http://www.tmssoftware.com">tmssoftware</a><br/>Het Werkt!!';
      Info := Contact.Email1Address;
      InfoFont.Size := 8;
      InfoFont.Color := clWhite;
//      GraphicLeftType := gtCheckBox;
//      Randomize;
//      GraphicRight.LoadFromFile('Z:\Graphics\Apple\PNG\a ('+inttostr(RandomRange(1, 12)) + ').png');
//      GraphicRightType := gtDetailImage;
//      GraphicLeftType := gtCheckBox;

    end;
  end;

  AdvSmoothListBox1.Footer.Caption := inttostr(AdvSmoothListBox1.Items.Count - 1) + ' contacts';

  Outlook := UnAssigned;

  AdvSmoothListBox1.Items.Sort;
end;

end.
