unit UDemo;

interface

uses
  Windows, SysUtils, Graphics, Forms, Controls, StdCtrls, Classes, AdvSmoothListBox,
  ExtCtrls, Math, ImgList, GDIPPictureContainer, jpeg, Dialogs, AdvStyleIF, ShellAPI,
  ComCtrls;

type
  TForm67 = class(TForm)
    AdvSmoothListBox1: TAdvSmoothListBox;
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GDIPPictureContainer1: TGDIPPictureContainer;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    Edit2: TEdit;
    Edit1: TEdit;
    AdvSmoothListBox3: TAdvSmoothListBox;
    AdvSmoothListBox2: TAdvSmoothListBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    ComboBox1: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    AdvSmoothListBox4: TAdvSmoothListBox;
    ComboBox2: TComboBox;
    Label3: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    TabSheet5: TTabSheet;
    AdvSmoothListBox5: TAdvSmoothListBox;
    procedure FormCreate(Sender: TObject);
    procedure AdvSmoothListBox1ShowDetail(Sender: TObject; itemindex: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure AdvSmoothListBox2ItemClick(Sender: TObject; itemindex: Integer);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure AdvSmoothListBox1AnchorClick(Sender: TObject; Anchor: string);
    procedure AdvSmoothListBox3ItemCheckClick(Sender: TObject;
      itemindex: Integer; checked: Boolean);
    procedure ComboBox2Change(Sender: TObject);
    procedure AdvSmoothListBox4ItemDragDrop(Sender: TObject; DragItemIndex,
      DropItemIndex: Integer; var allowdrop: Boolean);
    procedure AdvSmoothListBox5ItemButtonClick(Sender: TObject;
      itemindex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form67: TForm67;

implementation

{$R *.dfm}


procedure TForm67.AdvSmoothListBox1AnchorClick(Sender: TObject; Anchor: string);
begin
  ShellExecute(WindowHandle, 'Open', Pchar(Anchor), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm67.AdvSmoothListBox1ShowDetail(Sender: TObject;
  itemindex: Integer);
begin
  with AdvSmoothListBox1.Items[itemindex] do
  begin
    Edit1.Text := Caption;
    Edit2.Text := Info;
    Memo1.Text := Notes;
  end;
end;

procedure TForm67.AdvSmoothListBox2ItemClick(Sender: TObject;
  itemindex: Integer);
begin
  AdvSmoothListBox1.Invalidate;
end;

procedure TForm67.AdvSmoothListBox3ItemCheckClick(Sender: TObject;
  itemindex: Integer; checked: Boolean);
var
  I: Integer;
  count: integer;
begin
  if checked then
  begin
    AdvSmoothListBox3.Items[itemindex].GraphicLeftType := gtCommonImage;
    AdvSmoothListBox3.Items[itemindex].Notes := '<font color="clGreen">Task finished</font>';
    AdvSmoothListBox3.Items[itemindex].ProgressValue := 100;
  end
  else
  begin
    AdvSmoothListBox3.Items[itemindex].Notes := '<font color="clRed">Task unfinished</font>';
    AdvSmoothListBox3.Items[itemindex].GraphicLeftType := gtImage;
    AdvSmoothListBox3.Items[itemindex].ProgressValue := 0;    
  end;

  Count := 0;
  for I := 0 to AdvSmoothListBox3.Items.Count - 1 do
  begin
    if AdvSmoothListBox3.Items[I].Checked then
      Inc(Count);    
  end;
  AdvSmoothListBox3.Footer.Caption := 'Finished tasks : ' + '<font size="10" color="clBlack">'+inttostr(count)+'</font>';
end;

procedure TForm67.AdvSmoothListBox4ItemDragDrop(Sender: TObject; DragItemIndex,
  DropItemIndex: Integer; var allowdrop: Boolean);
var
  drag, drop: TAdvSmoothListBoxItem;
  dragdate: TDate;
  d, m, y: Word;
begin
  drag := AdvSmoothListBox4.Items[DragItemIndex];
  drop := AdvSmoothListBox4.Items[DropItemIndex];
  //change category
  drag.CategoryID := drop.categoryID;
  //change date
  dragdate := StrToDate(drag.info);
  DecodeDate(dragdate, y, m, d);
  drag.Info := FormatDateTime('dd/mm/yyyy', EncodeDate(y, drag.categoryID + 1, d));
//  AdvSmoothListBox4.Items.Sort;
end;

procedure TForm67.AdvSmoothListBox5ItemButtonClick(Sender: TObject;
  itemindex: Integer);
begin
  if AdvSmoothListBox5.Items[itemindex].Expanded then
    AdvSmoothListBox5.Items[itemindex].ButtonCaption := '-'
  else
    AdvSmoothListBox5.Items[itemindex].ButtonCaption := '+'
end;

procedure TForm67.Button1Click(Sender: TObject);
begin
  if AdvSmoothListBox1.DetailStatus = dsDetailsVisible then
  begin
    with AdvSmoothListBox1.Items.SelectedItem do
    begin
      Caption := Edit1.Text;
      Info := Edit2.Text;
      Notes := Memo1.Text;
    end;
    AdvSmoothListBox1.HideDetails;
  end;
end;

procedure TForm67.Button2Click(Sender: TObject);
begin
  AdvSmoothListBox2.Items[4].Caption := '';
end;

procedure TForm67.CheckBox1Click(Sender: TObject);
begin
  AdvSmoothListBox1.LookupBar.Visible := CheckBox1.Checked;
end;

procedure TForm67.ComboBox1Change(Sender: TObject);
begin
  //Save progress fill settings to clipboard
  AdvSmoothListBox3.ItemAppearance.ProgressAppearance.ProgressFill.SaveToClipBoard;
  case ComboBox1.ItemIndex of
    0:AdvSmoothListBox3.SetComponentStyle(tsOffice2003Blue);
    1:AdvSmoothListBox3.SetComponentStyle(tsOffice2003Silver);
    2:AdvSmoothListBox3.SetComponentStyle(tsOffice2003Olive);
    3:AdvSmoothListBox3.SetComponentStyle(tsOffice2003Classic);
    4:AdvSmoothListBox3.SetComponentStyle(tsOffice2007Luna);
    5:AdvSmoothListBox3.SetComponentStyle(tsOffice2007Obsidian);
    6:AdvSmoothListBox3.SetComponentStyle(tsOffice2007Silver);
  end;
  //load progress fill settings to clipboard  
  AdvSmoothListBox3.ItemAppearance.ProgressAppearance.ProgressFill.LoadFromClipBoard;
end;

procedure TForm67.ComboBox2Change(Sender: TObject);
begin
  AdvSmoothListBox4.LookupBar.Position := TAdvSmoothListBoxLookupBarPosition(ComboBox2.ItemIndex);
end;

procedure TForm67.FormCreate(Sender: TObject);
var
  I: Integer;
  name, surname: String;
const
  contactlist: array[0..19] of string = ('John', 'Mike', 'Laura', 'Steven', 'Jenna', 'Peter',
    'Abby', 'Roger', 'Alton', 'Byron', 'Curtis', 'Brad', 'Audrey', 'April',
    'Ariana', 'Alice', 'Mandy', 'Mary', 'Melanie', 'Megan');
  contactlist2: array[0..19] of string = ('Lazares', 'Mccain', 'Cortez', 'Owen', 'Campfield', 'Hays',
    'Grooms', 'Caldwell', 'Newell', 'Meyers', 'Nixon', 'Young', 'Etcher', 'Walker',
    'Robinson', 'Powell', 'Norris', 'Cook', 'Bush', 'Chipman');
begin
  DoubleBuffered := true;
  //Contact list
  AdvSmoothListBox1.Items.Clear;
  for I := 0 to 20 do
  begin
    with AdvSmoothListBox1.Items.Add do
    begin
      Randomize;
      CaptionFont.Color := clWhite;
      CaptionFont.Size := 8;
      name := contactlist[RandomRange(0, 20)];
      surname := contactlist2[RandomRange(0, 20)];
      Caption :=  name + ' ' + surname;

      InfoFont.Size := 7;
      InfoFont.Color := clWhite;
      Info := '0462/'+ inttostr(Random(99)) + '/' + inttostr(Random(99)) + '/' + inttostr(Random(99));

      Notes := '<font size="8"><b>hi!, i am ' + name + '</b></font><br/><font size="8">my </font>' +
      '<font size="8" color="clYellow">email address </font><font size="8">is </font><font size="8">' +
      '<a href="mailto:'+name+'@email.com">'+ name+'@email.com<a/></font>';
      NotesLocation := plCenterLeft;
    end;
  end;

  AdvSmoothListBox1.Items.Sort;
  AdvSmoothListBox1.Footer.Caption := inttostr(AdvSmoothListBox1.Items.Count) + ' Contacts';
  ComboBox1.ItemIndex := 4;

  //TODOList
  for I := 0 to 20 do
  begin
    with AdvSmoothListBox3.Items.Add do
    begin
      Caption := 'Task ' + inttostr(I + 1);
      GraphicRightType := gtCheckBox;
      Info := 'Task description';
      Notes := '<font color="clred">Task unfinished</font>';
      NotesLocation := plCenterCenter;
      GraphicLeftMargin := 15;
      ProgressVisible := true;
    end;
  end;
  AdvSmoothListBox3.Footer.Caption := 'Finished tasks : ' + '<font size="10" color="clBlack">0</font>';


  //Custom Categories
  for I := 0 to 11 do
  begin
    with AdvSmoothListBox4.Categories.Add do
    begin
      Text :=  LongMonthNames[I + 1];
      LookupText := UpperCase(ShortMonthNames[I + 1]);
    end;
  end;
  //Item category
  for I := 0 to AdvSmoothListBox4.Items.Count - 1 do
  begin
    with AdvSmoothListBox4.Items[I] do
    begin
      CategoryID := random(11);
      Info := FormatDateTime('dd/mm/yyyy', EncodeDate(2008, CategoryID + 1, RandomRange(4, 25)));
    end;
  end;
  AdvSmoothListBox4.Items.Sort;


  with AdvSmoothListBox5.Items.Add do
  begin
    Caption := 'Mercedes';
    GraphicLeftType := gtSmoothButton;
    ButtonCaption := '-';
    ButtonBevelColor := clBlack;
    ButtonColor := clGreen;
    GraphicLeftWidth := 25;    
  end;
  with AdvSmoothListBox5.Items.Add do
  begin
    Level := 1;
    Caption := 'Mercedes SLK Roadster';
    Indent := 30;
  end;
  with AdvSmoothListBox5.Items.Add do
  begin
    Level := 1;
    Caption := 'Mercedes SLR Coupé';
    Indent := 30;
  end;
  with AdvSmoothListBox5.Items.Add do
  begin
    Level := 1;
    Caption := 'Mercedes GLK 4x4';
    Indent := 30;
  end;

  with AdvSmoothListBox5.Items.Add do
  begin
    Caption := 'BMW';
    GraphicLeftType := gtSmoothButton;
    ButtonCaption := '-';
    ButtonBevelColor := clBlack;
    ButtonColor := clGreen;
    GraphicLeftWidth := 25;
  end;
  with AdvSmoothListBox5.Items.Add do
  begin
    Level := 1;
    Caption := 'BMW M3';
    Indent := 30;
  end;
  with AdvSmoothListBox5.Items.Add do
  begin
    Level := 1;
    Caption := 'BMW Z4';
    Indent := 30;
  end;
  with AdvSmoothListBox5.Items.Add do
  begin
    Level := 1;
    Caption := 'BMW X5';
    Indent := 30;
  end;

  with AdvSmoothListBox5.Items.Add do
  begin
    Caption := 'Land Rover';
    GraphicLeftType := gtSmoothButton;
    ButtonCaption := '-';
    ButtonBevelColor := clBlack;
    ButtonColor := clGreen;
    GraphicLeftWidth := 25;
  end;
  with AdvSmoothListBox5.Items.Add do
  begin
    Level := 1;
    Caption := 'Land Rover Defender 90';
    Indent := 30;
  end;
  with AdvSmoothListBox5.Items.Add do
  begin
    Level := 1;
    Caption := 'Land Rover Series III';
    Indent := 30;
  end;
  with AdvSmoothListBox5.Items.Add do
  begin
    Level := 1;
    Caption := 'Range Rover Sport V8';
    Indent := 30;
  end;
end;

end.
