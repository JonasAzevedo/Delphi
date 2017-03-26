{********************************************************************}
{ TAdvListView demo                                                  }
{ for Delphi 5,6,7 & C++Builder 5,6                                  }
{ version 1.6                                                        }
{                                                                    }
{ written by TMS Software                                            }
{            copyright � 1998-2006                                   }
{            Email : info@tmssoftware.com                            }
{            Website : http://www.tmssoftware.com                    }
{********************************************************************}

unit ualvdemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, AdvListV, StdCtrls, Spin, CommCtrl, ExtCtrls, Menus,
  ualvprev, ShellAPI, ImgList
{$IFDEF VER120}
  , ImgList
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    AdvListView2: TAdvListView;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Button8: TButton;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button4: TButton;
    SpinEdit1: TSpinEdit;
    CheckBox7: TCheckBox;
    subedit: TCheckBox;
    subsel: TCheckBox;
    multisel: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    RadioGroup1: TRadioGroup;
    ImageList1: TImageList;
    HeaderImages: TImageList;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Savetofile1: TMenuItem;
    Loadfromfile1: TMenuItem;
    LoadfromCSV1: TMenuItem;
    SavetoCSV1: TMenuItem;
    SavetoHTML1: TMenuItem;
    SavetoXLS1: TMenuItem;
    SavetoDOC1: TMenuItem;
    SavetoXML1: TMenuItem;
    Preview1: TMenuItem;
    Print1: TMenuItem;
    Clear1: TMenuItem;
    Edit1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Copyselected1: TMenuItem;
    Paste1: TMenuItem;
    Sort1: TMenuItem;
    Column01: TMenuItem;
    Column11: TMenuItem;
    Column21: TMenuItem;
    Column1: TMenuItem;
    Column51: TMenuItem;
    Column52: TMenuItem;
    Draw1: TMenuItem;
    Aligntop1: TMenuItem;
    Aligncenter1: TMenuItem;
    Alignbottom1: TMenuItem;
    N1: TMenuItem;
    Imageson1: TMenuItem;
    Font1: TMenuItem;
    RichText1: TMenuItem;
    HTMLText1: TMenuItem;
    N2: TMenuItem;
    Flatheader1: TMenuItem;
    Move1: TMenuItem;
    Swaprows121: TMenuItem;
    Swapcolumns121: TMenuItem;
    Moverow1to51: TMenuItem;
    Movecolumn1to51: TMenuItem;
    About1: TMenuItem;
    FontDialog1: TFontDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    TabSheet2: TTabSheet;
    AdvListView1: TAdvListView;
    Label4: TLabel;
    ImageList2: TImageList;
    detail: TCheckBox;
    Indents1: TMenuItem;
    Timer1: TTimer;
    TabSheet3: TTabSheet;
    AdvListView3: TAdvListView;
    CheckBox10: TCheckBox;
    TabSheet4: TTabSheet;
    AdvListView4: TAdvListView;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button5: TButton;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure AdvListView1GetFormat(Sender: TObject; ACol: Integer;
      var AStyle: TSortStyle; var aPrefix, aSuffix: string);
    procedure Button4Click(Sender: TObject);
    procedure AdvListView1DrawItemProp(Sender: TObject; itemindex,
      subitemindex: Integer; AState: TOwnerDrawState; ABrush: TBrush;
      AFont: TFont; ItemText: string);
    procedure LoadfromCSV1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure SavetoCSV1Click(Sender: TObject);
    procedure SavetoHTML1Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure Column01Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Preview1Click(Sender: TObject);
    procedure Imageson1Click(Sender: TObject);
    procedure Aligntop1Click(Sender: TObject);
    procedure Aligncenter1Click(Sender: TObject);
    procedure Alignbottom1Click(Sender: TObject);
    procedure Flatheader1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure AdvListView2StartColumnTrack(Sender: TObject;
      column: Integer; var Allow: Boolean);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure SavetoXLS1Click(Sender: TObject);
    procedure SavetoDOC1Click(Sender: TObject);
    procedure subeditClick(Sender: TObject);
    procedure AdvListView2ColumnRClick(Sender: TObject; column: Integer);
    procedure Swaprows121Click(Sender: TObject);
    procedure Swapcolumns121Click(Sender: TObject);
    procedure Moverow1to51Click(Sender: TObject);
    procedure Movecolumn1to51Click(Sender: TObject);
    procedure RichText1Click(Sender: TObject);
    procedure Font1Click(Sender: TObject);
    procedure SavetoXML1Click(Sender: TObject);
    procedure subselClick(Sender: TObject);
    procedure multiselClick(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Copyselected1Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure AdvListView2FilterBtnClick(Sender: TObject; iItem: Integer);
    procedure AdvListView2FilterChange(Sender: TObject; iItem: Integer);
    procedure CheckBox9Click(Sender: TObject);
    procedure HTMLText1Click(Sender: TObject);
    procedure AdvListView2AnchorEnter(Sender: TObject; Anchor: string);
    procedure AdvListView2AnchorExit(Sender: TObject; Anchor: string);
    procedure AdvListView2AnchorClick(Sender: TObject; Anchor: string);
    procedure Savetofile1Click(Sender: TObject);
    procedure Loadfromfile1Click(Sender: TObject);
    procedure AdvListView2RawCompare(Sender: TObject; col, row1,
      row2: Integer; var res: Integer);
    procedure detailClick(Sender: TObject);
    procedure Indents1Click(Sender: TObject);
    procedure AdvListView2RightClickCell(Sender: TObject; iItem,
      iSubItem: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure AdvListView2Edited(Sender: TObject; Item: TListItem;
      var S: String);
  private
    procedure InitPrintSettings;
    procedure InitListView;
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button3Click(Sender: TObject);
begin
  advlistview4.UnHilightInList;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  with advlistview2 do
  begin
    loadheader := true;
    loadfromcsv('test.csv');
    columns[2].alignment := taRightJustify;
    columns[3].alignment := taRightJustify;
    sortcolumn := 1;
    AutoSizeColumns;
    autohint := true;
  end;

  with advlistview4 do
  begin
    loadheader := true;
    loadfromcsv('test.csv');
    AutoSizeColumns;
  end;

  InitListView;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  if (spinedit1.text <> '') then
    advlistview2.itemheight := spinedit1.value;
end;

procedure TForm1.AdvListView1GetFormat(Sender: TObject; ACol: Integer;
  var AStyle: TSortStyle; var aPrefix, aSuffix: string);
begin
  case acol of
    1: aStyle := ssNumeric;
    2: aStyle := ssDate;
    3: begin
        aStyle := ssNumeric;
        asuffix := 'pk';
      end;
    4: begin
        aStyle := ssFinancial;
        aprefix := '$ ';
      end;
  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  advlistview2.autosizecolumns;
end;

procedure TForm1.AdvListView1DrawItemProp(Sender: TObject; itemindex,
  subitemindex: Integer; AState: TOwnerDrawState; ABrush: TBrush;
  AFont: TFont; ItemText: string);
begin
  if (itemindex < 0) then Exit;

  if (subitemindex = -1) then
  begin
    afont.style := [fsBold];
    afont.name := 'Tahoma';
    afont.color := clTeal;
  end;
  if (subitemindex = 2) then
  begin
    afont.color := clNavy;
    abrush.color := clYellow;
  end;
  if (subitemindex = 1) then
  begin
    if length(Itemtext) = 2 then
    begin
      afont.color := clRed;
      afont.style := [fsBold];
    end;
  end;
end;

procedure TForm1.LoadfromCSV1Click(Sender: TObject);
begin
  AdvListView2.LoadHeader := False;
  Advlistview2.LoadFromCSV('cars.csv');
end;

procedure TForm1.Clear1Click(Sender: TObject);
begin
  Advlistview2.Items.Clear;
end;

procedure TForm1.SavetoCSV1Click(Sender: TObject);
begin
  Advlistview2.SaveHeader := False;
  Advlistview2.SaveToCSV('sample.csv');
end;

procedure TForm1.SavetoHTML1Click(Sender: TObject);
begin
  Advlistview2.savetohtml('sample.htm');
  Shellexecute(self.handle, 'open', 'sample.htm', nil, nil, SW_NORMAL);
end;

procedure TForm1.Print1Click(Sender: TObject);
begin
  InitPrintSettings;
  if printersetupdialog1.Execute then
    advlistview2.print;
end;

procedure TForm1.Column01Click(Sender: TObject);
begin
  if advlistview2.sortdirection = sdAscending then
    advlistview2.sortdirection := sdDescending
  else
    advlistview2.sortdirection := sdAscending;

  advlistview2.sortcolumn := (sender as TMenuItem).Tag;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  MessageDlg('TAdvListView version ' + AdvListView1.GetVersionString + #13 + #10 + '� 1998-2007 by TMS software', mtInformation, [mbok], 0);
end;

procedure TForm1.InitPrintSettings;
begin
  with advlistview2 do
  begin
    printsettings.titletext := edit2.text;
    if checkbox2.checked then
      printsettings.time := ppTopLeft
    else
      printsettings.time := ppNone;
    if checkbox2.checked then
      printsettings.date := ppTopRight
    else
      printsettings.date := ppNone;
    if checkbox3.checked then
      printsettings.pagenr := ppBottomCenter
    else
      printsettings.pagenr := ppNone;
    if checkbox4.checked then
      printsettings.borders := pbSingle
    else
      printsettings.borders := pbNoborder;

    if checkbox5.checked then
      printsettings.fittopage := fpAlways
    else
      printsettings.fittopage := fpNever;

    printsettings.centered := checkbox6.checked;
  end;
end;

procedure TForm1.Preview1Click(Sender: TObject);
var
  preview: tpreview;
begin
  InitPrintSettings;

  advlistview2.printsettings.Font.Color := clblack;

  preview := TPreview.create(self, advlistview2);
  try
    preview.showmodal;
  finally
    preview.free;
  end;
end;

procedure TForm1.Imageson1Click(Sender: TObject);
var
  i: integer;
begin
  if advlistview2.items.count <= 0 then exit;

  (sender as TMenuItem).Checked := not (sender as TMenuItem).Checked;

  advlistview2.subimages := (sender as TMenuItem).Checked;

  for i := 0 to advlistview2.items.count - 1 do
  begin
    if (sender as TMenuItem).Checked then
      advlistview2.subitemimages[i, 4] := random(4) - 1
    else
      advlistview2.subitemimages[i, 4] := -1;
  end;

end;

procedure TForm1.Aligntop1Click(Sender: TObject);
begin
  advlistview2.VAlignment := vtaTop;
  (sender as TMenuItem).Checked := true;
end;

procedure TForm1.Aligncenter1Click(Sender: TObject);
begin
  advlistview2.VAlignment := vtaCenter;
  (sender as TMenuItem).Checked := true;
end;

procedure TForm1.Alignbottom1Click(Sender: TObject);
begin
  advlistview2.VAlignment := vtaBottom;
  (sender as TMenuItem).Checked := true;
end;

procedure TForm1.Flatheader1Click(Sender: TObject);
begin
  (sender as TMenuItem).Checked := not (sender as TMenuItem).Checked;
  advlistview2.headerflatstyle := (sender as TMenuItem).Checked;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  fontdialog1.font := advlistview2.printsettings.font;
  if fontdialog1.execute then
    advlistview2.printsettings.font := fontdialog1.font;

end;

procedure TForm1.AdvListView2StartColumnTrack(Sender: TObject;
  column: Integer; var Allow: Boolean);
begin
  allow := checkbox7.checked;
end;



procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  advlistview2.rearrangeitems := radiogroup1.itemindex = 0;
  advlistview2.hottrack := radiogroup1.itemindex = 1;
end;

procedure TForm1.Label3Click(Sender: TObject);
begin
  shellexecute(self.handle, 'open', 'http://www.tmssoftware.com', nil, nil, sw_normal);
end;

procedure TForm1.SavetoXLS1Click(Sender: TObject);
begin
  advlistview2.SavetoXLS('sample.xls');
end;

procedure TForm1.SavetoDOC1Click(Sender: TObject);
begin
  advlistview2.SavetoDOC('sample.doc');
end;

procedure TForm1.subeditClick(Sender: TObject);
begin
  advlistview2.rowselect := not subedit.checked;
  advlistview2.subitemedit := subedit.checked;
  advlistview2.readonly := not subedit.checked;
  if subedit.checked then
  begin
    radiogroup1.itemindex := 2;
    advlistview2.rearrangeitems := false;
    advlistview2.hottrack := false;
  end;

end;

procedure TForm1.AdvListView2ColumnRClick(Sender: TObject;
  column: Integer);
begin
  messagedlg('Right click on column header ' + inttostr(column), mtinformation, [mbok], 0);
end;

procedure TForm1.Swaprows121Click(Sender: TObject);
begin
  advlistview2.swapitems(1, 5);
end;

procedure TForm1.Swapcolumns121Click(Sender: TObject);
begin
  advlistview2.swapcolumns(1, 5);
end;

procedure TForm1.Moverow1to51Click(Sender: TObject);
begin
  advlistview2.moveitem(1, 5);
end;

procedure TForm1.Movecolumn1to51Click(Sender: TObject);
begin
  advlistview2.movecolumn(1, 5);
end;

procedure TForm1.RichText1Click(Sender: TObject);
begin
  with advlistview2.richedit do
  begin
    text := 'This is rich text';
    selstart := 0;
    sellength := 4;
    selattributes.color := clBlue;
    selstart := 8;
    sellength := 4;
    selattributes.Style := [fsBold];
    selattributes.color := clRed;
    selstart := 13;
    sellength := 4;
    selsuperscript;
  end;
  advlistview2.richtoitem(1, 1, advlistview2.richedit);
end;

procedure TForm1.Font1Click(Sender: TObject);
begin
  fontdialog1.font := advlistview2.font;
  if fontdialog1.execute then advlistview2.font := fontdialog1.font;
end;

procedure TForm1.SavetoXML1Click(Sender: TObject);
var
  sl: tstringlist;
begin
  sl := tstringlist.Create;
  sl.add('Car');
  sl.add('Type');
  sl.add('Cylinders');
  sl.add('Intro');
  sl.add('Power');
  sl.add('Price');
  sl.add('Web');

  advListview2.Savetoxml('test.xml', 'CARLIST', 'CAR', sl);
  sl.free;

end;

procedure TForm1.subselClick(Sender: TObject);
begin
  advlistview2.rowselect := not subsel.checked;
  advlistview2.subitemselect := subsel.checked;
  if subsel.checked then
  begin
    radiogroup1.itemindex := 2;
    advlistview2.rearrangeitems := false;
    advlistview2.hottrack := false;
  end;

end;

procedure TForm1.multiselClick(Sender: TObject);
begin
  advlistview2.multiselect := multisel.checked;
end;

procedure TForm1.Cut1Click(Sender: TObject);
begin
  advlistview2.cuttoclipboard;
end;

procedure TForm1.Copy1Click(Sender: TObject);
begin
  advlistview2.copytoclipboard;
end;

procedure TForm1.Paste1Click(Sender: TObject);
begin
  advlistview2.pastefromclipboard;
end;

procedure TForm1.Copyselected1Click(Sender: TObject);
begin
  advlistview2.copyselectiontoclipboard;
end;

procedure TForm1.CheckBox8Click(Sender: TObject);
begin
  advlistview2.filterbar := checkbox8.checked;
  advlistview2.filtertimeout := 2000;
end;

procedure TForm1.AdvListView2FilterBtnClick(Sender: TObject;
  iItem: Integer);
begin
  showmessage('Filter button for item ' + inttostr(iItem) + ' clicked');
end;

procedure TForm1.AdvListView2FilterChange(Sender: TObject; iItem: Integer);
begin
  showmessage('Filter item ' + inttostr(iItem) + ' changed.'#13'New value is ' + advlistview2.GetFilter(iItem, 0));
end;

procedure TForm1.CheckBox9Click(Sender: TObject);
begin
  advlistview2.checkboxes := checkbox9.checked;
end;

procedure TForm1.HTMLText1Click(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to advlistview2.items.Count do
  begin
    advlistview2.items[i - 1].subitems[5] := '<FONT color="clblue">This</FONT> is item <B>(' + inttostr(i) + ')</B>';
  end;

  advlistview2.items[0].subitems[5] := '<IMG src="idx:0"> is an image<B></B>';
  advlistview2.items[1].subitems[5] := 'This is an <A HREF="action">anchor</A>';
  advlistview2.items[2].subitems[5] := 'This is the URL <A HREF="http://www.tmssoftware.com">www.tmssoftware.com</A>';
  exit;
  advlistview2.autosizecolumns;
  advlistview2.itemheight := 16;
  spinedit1.value := 16;
  advlistview2.Columns[6].Caption := 'HTML';
end;

procedure TForm1.AdvListView2AnchorEnter(Sender: TObject; Anchor: string);
begin
  statusbar1.simpletext := anchor;
end;

procedure TForm1.AdvListView2AnchorExit(Sender: TObject; Anchor: string);
begin
  statusbar1.simpletext := '';
end;

procedure TForm1.AdvListView2AnchorClick(Sender: TObject; Anchor: string);
begin
  messagedlg(anchor, mtinformation, [mbok], 0);
end;

procedure TForm1.Savetofile1Click(Sender: TObject);
begin
  advlistview2.saveheader := true;
  advlistview2.savetofile('test.dat');
end;

procedure TForm1.Loadfromfile1Click(Sender: TObject);
begin
  advlistview2.loadheader := true;
  advlistview2.loadfromfile('test.dat');
end;

procedure TForm1.AdvListView2RawCompare(Sender: TObject; col, row1,
  row2: Integer; var res: Integer);
var
  img1, img2: integer;
begin
  img1 := advlistview2.subitemimages[row1, 4];
  img2 := advlistview2.subitemimages[row2, 4];
  if img1 > img2 then res := 1
  else if img1 < img2 then res := -1 else res := 0;
end;

procedure TForm1.detailClick(Sender: TObject);
begin
  if detail.checked then
  begin
    advlistview1.detailview.visible := true;
    advlistview1.itemheight := 60;
  end
  else
  begin
    advlistview1.detailview.visible := false;
    advlistview1.itemheight := 16;
  end;
end;

procedure TForm1.InitListView;
begin
  with AdvListView1 do
  begin
    with Items.Add do
    begin
      Caption := '<b>TAdvEdit</b>';
      SubItems.Add('D2 D3 D4 D5');
      SubItems.Add('Feb 15, 2001');
      SubItems.Add('<a href="http://www.tmssoftware.com/advedit.htm">View</a>');
      SubItems.Add('Data aware and non data aware edit control with lots of features including focus color, error color, attached label, validated input ... ');
    end;

    with Items.Add do
    begin
      Caption := '<b>TAdvSpinEdit</b>';
      SubItems.Add('D3 D4 D5');
      SubItems.Add('Feb 15, 2001');
      SubItems.Add('<a href="http://www.tmssoftware.com/advspin.htm">View</a>');
      SubItems.Add('Data aware and non data aware spin edit control with lots of features including float increments, smart increments, flat style ... ');
    end;

    with Items.Add do
    begin
      Caption := '<b>TWebPost</b>';
      SubItems.Add('D3 D4 D5');
      SubItems.Add('Feb 7, 2001');
      SubItems.Add('<a href="http://www.tmssoftware.com/webpost.htm">View</a>');
      SubItems.Add('Can post form data or automatic collected data on a client machine to a webserver CGI, ISAPI or ASP application for easy remote collection of data, support or statistics.');
    end;

    with Items.Add do
    begin
      Caption := '<b>TAdvStringGrid</b>';
      SubItems.Add('D2 D3 D4 D5');
      SubItems.Add('Jan 31, 2001');
      SubItems.Add('<a href="http://www.tmssoftware.com/advgrid.htm">View</a>');
      SubItems.Add('StringGrid packed with productivity tools. From loading and saving in various formats, from using different inplace editors, graphics to printing and so much more ...');
    end;

    with Items.Add do
    begin
      Caption := '<b>TPlanner</b>';
      SubItems.Add('D3 D4 D5');
      SubItems.Add('Dec 18, 2000');
      SubItems.Add('<a href="http://www.tmssoftware.com/planner.htm">View</a>');
      SubItems.Add('The most configurable planning component. Features various modes, item editing, lots of control over planned items appearance, moving, sizing ...');
    end;

    with Items.Add do
    begin
      Caption := '<b>TWebUpdate</b>';
      SubItems.Add('D3 D4 D5');
      SubItems.Add('Jan 6, 2001');
      SubItems.Add('<a href="http://www.tmssoftware.com/wupdate.htm">View</a>');
      SubItems.Add('Makes version checking, updating and replacing your application from a web, ftp or network based distribution easy.');
    end;

  end;
end;

procedure TForm1.Indents1Click(Sender: TObject);
begin
  AdvListView2.Columns[0].Width := 120;
  Advlistview2.itemindents[2, 0] := 1;
  Advlistview2.itemindents[3, 0] := 1;
  Advlistview2.itemindents[4, 0] := 2;
  Advlistview2.itemindents[5, 0] := 2;
end;

procedure TForm1.AdvListView2RightClickCell(Sender: TObject; iItem,
  iSubItem: Integer);
begin
  Advlistview2.StartEdit(iItem, iSubItem);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

  if advlistview3.Progress[0, 2] < 100 then
    advlistview3.Progress[0, 2] := advlistview3.Progress[0, 2] + 5
  else
    advlistview3.Progress[0, 2] := 0;

  if advlistview3.Progress[1, 2] < 100 then
    advlistview3.Progress[1, 2] := advlistview3.Progress[1, 2] + 4
  else
    advlistview3.Progress[1, 2] := 0;

  if advlistview3.Progress[2, 2] < 100 then
    advlistview3.Progress[2, 2] := advlistview3.Progress[2, 2] + 3
  else
    advlistview3.Progress[2, 2] := 0;

  if advlistview3.Progress[3, 2] < 100 then
    advlistview3.Progress[3, 2] := advlistview3.Progress[3, 2] + 6
  else
    advlistview3.Progress[3, 2] := 0;

end;

procedure TForm1.CheckBox10Click(Sender: TObject);
begin
  timer1.enabled := CheckBox10.checked;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  advlistview4.HilightInList('BMW',false);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  advlistview4.MarkInList('Mercedes',false);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Advlistview4.UnMarkInList;
end;

procedure TForm1.AdvListView2Edited(Sender: TObject; Item: TListItem;
  var S: String);
begin
  showmessage(s);
end;

end.
