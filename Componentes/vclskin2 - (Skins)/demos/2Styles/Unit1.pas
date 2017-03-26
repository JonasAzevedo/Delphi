unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Menus, WinSkinForm, WinSkinData,
   Buttons, Grids, ToolWin, ExtCtrls, ImgList, ExtDlgs,inifiles,
   WinSkinStore;

const
  ininame= 'Config.ini';

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    DialogM: TMenuItem;
    Help1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Close1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Skin11: TMenuItem;
    Skin21: TMenuItem;
    Skin31: TMenuItem;
    Content1: TMenuItem;
    Homepage1: TMenuItem;
    About1: TMenuItem;
    sd1: TSkinData;
    ComboBox1: TComboBox;
    Label1: TLabel;
    LoadBtn: TButton;
    Button4: TButton;
    TabSheet3: TTabSheet;
    ListBox1: TListBox;
    BitBtn1: TBitBtn;
    TabSheet4: TTabSheet;
    StringGrid1: TStringGrid;
    SpeedButton1: TSpeedButton;
    Edit1: TEdit;
    ExceptionBtn: TButton;
    MessageBtn: TButton;
    Dialog1: TOpenDialog;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    Dialog2: TFontDialog;
    Dialog3: TColorDialog;
    Dialog4: TPrintDialog;
    PrintDialog2: TMenuItem;
    BuildinSkins1: TMenuItem;
    Skin12: TMenuItem;
    Skin22: TMenuItem;
    Skin32: TMenuItem;
    RichEdit1: TRichEdit;
    ImageList1: TImageList;
    Opd1: TOpenPictureDialog;
    SkinStore1: TSkinStore;
    Button1: TButton;
    Timer1: TTimer;
    Button2: TButton;
    Button3: TButton;
    Button5: TButton;
    OpenwithPreview1: TMenuItem;
    sd2: TSkinData;
    procedure Exit1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure sf1CaptionBtnClick(Sender: TObject; action: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure ExceptionBtnClick(Sender: TObject);
    procedure MessageBtnClick(Sender: TObject);
    procedure Skin21Click(Sender: TObject);
    procedure Skin31Click(Sender: TObject);
    procedure PrintDialog2Click(Sender: TObject);
    procedure Skin12Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure Button5Click(Sender: TObject);
    procedure sd1FormSkin(Sender: TObject; aName: String;
      var DoSkin: Boolean);
  private
    { Private declarations }
    procedure ReadSkinfile( apath : string );
    procedure Loadskin(aname:string);
    procedure Readini;
    procedure Writeini;
    procedure CNTabClose(var Message: TMessage); message CN_TabSheetClose;
  public
    { Public declarations }
    Ep:integer;
  end;

var
  Form1: TForm1;
  root:string;
  path:string;

implementation

uses Unit2, SkinGraphic;
{$R *.dfm}

procedure TForm1.Exit1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   sd1.active:= not sd1.active;
   if sd1.active then button4.caption:='Unskin'
   else button4.caption:='Skin';
end;

procedure TForm1.ReadSkinfile( apath : string );
var
  sts: Integer ;
  SR: TSearchRec;
  list: Tstringlist;

  procedure AddFile;
  begin
    list.add(sr.name);
  end;

begin
  list:=Tstringlist.create;
  sts := FindFirst( apath + '*.skn' , faAnyFile , SR );
  if sts = 0 then begin
      if ( SR.Name <> '.' ) and ( SR.Name <> '..' ) then begin
          if pos('.', SR.Name) <> 0 then
            Addfile;
      end;
      while FindNext( SR ) = 0 do begin
          if ( SR.Name <> '.' ) and ( SR.Name <> '..' ) then begin
              //Put User Feedback here if desired
//              Application.ProcessMessages;
              if Pos('.', SR.Name) <> 0 then  Addfile;
          end;
      end;
  end ;
  FindClose( SR ) ;
  list.sort;
  combobox1.items.assign(list);
  list.free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i,j:integer;
begin
    root:= ExtractFilePath(ParamStr(0));
    path:=root+'skins\';
    readskinfile(path);

//   load skin file from TSkinStore
   Sd1.LoadFromCollection(skinstore1,2);
   Sd2.LoadFromCollection(skinstore1,0);
   if not sd1.active then sd1.active:=true;
   if not sd2.active then sd2.active:=true;

    with stringgrid1 do begin
       rowcount:=combobox1.items.count+1;
       colcount:=7;
       for i:= 0 to colcount-1 do
         cells[i,0]:=format('column%1d',[i]);
       for i:= 1 to rowcount-1 do begin
         cells[0,i]:=format('skin file%1d',[i]);
         cells[1,i]:=combobox1.items[i-1];
       end;
       fixedcolor:=sd1.colors[csButtonFace];
    end;

//    Readini;
end;

procedure TForm1.ComboBox1Click(Sender: TObject);
begin
   sd1.skinfile:=path+combobox1.text;
   stringgrid1.fixedcolor:=sd1.colors[csButtonFace];
   if not sd1.active then sd1.active:=true;
end;

procedure TForm1.sf1CaptionBtnClick(Sender: TObject; action: Integer);
begin
     showmessage('Custom Caption Button Click No:'+inttostr(action));
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
//   sd1.skinfile:='..\skins\'+combobox1.items[1];
//   stringgrid1.fixedcolor:=sd1.colors[csButtonFace];
//    skinaddlog('****************************');
   timer1.enabled:= not timer1.enabled;
end;

procedure TForm1.LoadBtnClick(Sender: TObject);
begin
  Dialog1.filter:='Skin files (*.skn)|*.SKN';
  Dialog1.initialdir:=path;
  if Dialog1.execute then
     sd1.skinfile:=dialog1.filename;
  if not sd1.Active then
   sd1.Active:=true;

end;

procedure TForm1.ExceptionBtnClick(Sender: TObject);
var i:integer;
begin
    i:=1;
    Ep:= 100 div (i-1);
end;

procedure TForm1.MessageBtnClick(Sender: TObject);
begin
   MessageDlg('VclSkin2.0 Demo !'#13'Message Window Skin Demo.',
        mtInformation,[mbOk], 0);
end;

procedure TForm1.Skin21Click(Sender: TObject);
begin
   Dialog2.execute;
end;

procedure TForm1.Skin31Click(Sender: TObject);
begin
  Dialog3.execute;
end;

procedure TForm1.PrintDialog2Click(Sender: TObject);
begin
  Dialog4.execute;
end;

procedure TForm1.Loadskin(aname:string);
var  RS: TResourceStream;
begin
    RS := TResourceStream.Create(HInstance,aname,RT_RCDATA);
    sd1.loadfromstream(rs);
    rs.free;
end;

procedure TForm1.Skin12Click(Sender: TObject);
var i:integer;
begin
   i:=Tcomponent(sender).tag;
   Sd1.LoadFromCollection(skinstore1,i);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   if form2=nil then
     Application.CreateForm(TForm2, Form2);
   form2.show;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
   ProgressBar1.position:=ProgressBar1.position+1;
   if ProgressBar1.position>99 then
      ProgressBar1.position:=0;
end;

procedure TForm1.Readini;
var ini3:Tinifile;
begin
   ini3 := TIniFile.Create(root+ininame);
   ClientHeight:=ini3.readinteger('Path','height',400);
   ClientWidth:=ini3.readinteger('Path','width',400);
   top:=ini3.readinteger('Path','top',0);
   left:=ini3.readinteger('Path','left',0);
   ini3.free;
end;

procedure TForm1.Writeini;
var ini3:Tinifile;
begin
   ini3 := TIniFile.Create(root+ininame);
   ini3.writeinteger('Path','Width',ClientWidth);
   ini3.writeinteger('Path','Height',ClientHeight);
   ini3.writeinteger('Path','Left',left);
   ini3.writeinteger('Path','Top',top);
   ini3.free;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//    Writeini;
end;

procedure TForm1.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var r:Trect;
begin
    if panel=StatusBar.Panels[1] then begin
       r:=rect;
       InflateRect( r, -4, -2 );
       statusbar.Canvas.brush.color:=clblue;
       statusbar.Canvas.FillRect(r);
    end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
    opd1.InitialDir:=path;//ExtractFilePath(ParamStr(0));
    opd1.Filter:= 'Text files (*.skn)|*.skn';
    if opd1.Execute then begin
       sd1.SkinFile:=opd1.FileName;
    end;
end;

procedure TForm1.CNTabClose(var Message: TMessage);
var tab:TPagecontrol;
begin
   tab := Tpagecontrol(findcontrol(message.WParam));
   if tab = nil then exit;
   if MessageDlg('Do you want to close TabSheet '+tab.Pages[message.lparam].Name+' ?',
        mtInformation,[mbYes,mbNo], 0)=mrYes then
        message.Result:=0 //result=0,close
   else message.Result:=1;
end;

procedure TForm1.sd1FormSkin(Sender: TObject; aName: String;
  var DoSkin: Boolean);
begin
   if aname='Form1' then doskin:=false;
end;

end.
