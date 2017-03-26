{***************************************************************************}
{ TAdvStringGrid demo application                                           }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2009                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{***************************************************************************}

unit uasg23;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, jpeg,
  Grids, AdvGrid, StdCtrls, FileCtrl, FlCtrlEx, ComCtrls, ExtCtrls, asgprev,
  BaseGrid;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    ProgressBar1: TProgressBar;
    AdvPreviewDialog1: TAdvPreviewDialog;
    Panel1: TPanel;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Button1: TButton;
    filenames: TCheckBox;
    UpDown1: TUpDown;
    Label1: TLabel;
    procedure DirectoryListBoxEx1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure AdvStringGrid1GetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
  private
    { Private declarations }
  public
    { Public declarations }
    dirpath: string;
    imagecount: integer;
    procedure LoadImages;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.LoadImages;
var
  i: integer;
  r, c: integer;

begin
  dirpath := directorylistbox1.directory;
  if dirpath[length(dirpath)] <> '\' then dirpath := dirpath + '\';
  if filelistbox1.items.Count <= 0 then exit;
  advstringgrid1.Clear;
  r := 1;
  c := 1;

  progressbar1.min := 1;
  progressbar1.max := filelistbox1.items.Count;
  progressbar1.position := 1;
  advstringgrid1.beginupdate;

  with filelistbox1, advstringgrid1 do
    for i := 1 to items.Count do
    begin
//   advstringgrid1.CreatePicture(c,r,true,StretchWithAspectRatio,20,haCenter,vaCenter).LoadFromFile(dirpath+items[i-1]);
//   advstringgrid1.CreatePicture(c,r,true,ShrinkWithAspectRatio,20,haCenter,vaCenter).LoadFromFile(dirpath+items[i-1]);
      if filenames.Checked then
      begin
        advstringgrid1.cells[c, r] := items[i - 1];
        advstringgrid1.CreateFilePicture(c, r, true, ShrinkWithAspectRatio, 20, haCenter, vaAboveText).FileName := (dirpath + items[i - 1]);
      end
      else
      begin
        advstringgrid1.CreateFilePicture(c, r, true, ShrinkWithAspectRatio, 20, haCenter, vaCenter).FileName := (dirpath + items[i - 1]);
      end;

      inc(c);
      if c = colcount then
      begin
        c := 1;
        inc(r);
      end;
      if r = rowcount then
      begin
        rowcount := rowcount + 1;
        rowheights[rowcount - 1] := rowheights[rowcount - 2];
      end;
      progressbar1.position := i;
    end;
  advstringgrid1.endupdate;
end;



procedure TForm1.DirectoryListBoxEx1Change(Sender: TObject);
begin
  LoadImages;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  advpreviewdialog1.execute;
end;

procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  with advstringgrid1 do
  begin
    if Button = btNext then colcount := colcount + 1
    else if Colcount > 2 then colcount := colcount - 1;

    defaultcolwidth := colwidths[1];
    colwidths[0] := 16;
    Label1.Caption := 'Nr. of columns : ' + inttostr(colcount);
  end;

  LoadImages;
end;

procedure TForm1.AdvStringGrid1GetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  Halign := taCenter;
end;

end.
