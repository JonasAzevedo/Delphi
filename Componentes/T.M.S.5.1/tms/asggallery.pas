{***************************************************************************}
{ TAdvStringGrid gallery component                                          }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 1996-2005                                          }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit AsgGallery;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls;

{$R GALLERY.RES}

{$I TMSDEFS.INC}

type
  TGridGallery = class(TForm)
    GroupBox1: TGroupBox;
    AdvStringGrid1: TAdvStringGrid;
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { Private declarations }
    FGalleryFile: string;
  public
    { Public declarations }
    oldidx: integer;
    property GalleryFile: string read FGalleryFile;
    procedure InitGrid;
    procedure LoadList;
    procedure ResToFile(ResName,FileName:string);
  end;

var
  GridGallery: TGridGallery;

implementation

uses
  ShlObj, ActiveX, ShellAPI;

{$R *.dfm}

{ get My Documents folder }

{$IFDEF DELPHI6_LVL}
{$IFNDEF TMSDOTNET}
procedure FreePidl( pidl: PItemIDList );
var
  allocator: IMalloc;
begin
  if Succeeded(SHGetMalloc(allocator)) then
    allocator.Free(pidl);
end;

function GetMyDocuments: string;
var
  pidl: PItemIDList;
  Path: array [0..MAX_PATH-1] of char;
begin
  Result := '';

  if Succeeded(
       SHGetSpecialFolderLocation(0, CSIDL_PERSONAL, pidl)
     ) then
  begin
    if SHGetPathFromIDList(pidl, Path) then
      Result := StrPas(Path);
    FreePidl(pidl);
  end;
end;
{$ENDIF}
{$ENDIF}

procedure TGridGallery.InitGrid;
var
  i: Integer;
begin
  AdvStringGrid1.RowCount := 7;
  AdvStringGrid1.ColCount := 7;
  AdvStringGrid1.LinearFill(false);
  AdvStringGrid1.Row := 4;
  AdvStringGrid1.ColWidths[0] := 40;

  for i := 1 to 3 do
    AdvStringGrid1.Cells[1,i] := 'Group 1';

  for i := 1 to 3 do
    AdvStringGrid1.Cells[1,3+i] := 'Group 2';

  AdvStringGrid1.Grouping.Summary := true;
  AdvStringGrid1.Grouping.MergeHeader := true;
  AdvStringGrid1.Grouping.MergeSummary := true;
  AdvStringGrid1.Grouping.MergeSummary := true;

  AdvStringGrid1.Group(1);

  AdvStringGrid1.AddComment(1,2,'A comment');
  AdvStringGrid1.ShowHint := true;

  AdvStringGrid1.SortSettings.Column := 1;
  AdvStringGrid1.SortSettings.Show := true;
  AdvStringGrid1.SortSettings.IndexShow := true;
  AdvStringGrid1.SortIndexes.Add(1);
  AdvStringGrid1.QSortGroupIndexed;

  AdvStringGrid1.SearchFooter.ShowMatchCase := false;
  AdvStringGrid1.SearchFooter.ShowHighLight := false;
  AdvStringGrid1.SearchFooter.Visible := true;

  AdvStringGrid1.Cells[1,0] := 'A';
  AdvStringGrid1.Cells[2,0] := 'B';
  AdvStringGrid1.Cells[3,0] := 'C';
  AdvStringGrid1.Cells[4,0] := 'D';
  AdvStringGrid1.Cells[5,0] := 'E';

  AdvStringGrid1.Row := 4;
  AdvStringGrid1.Options := AdvStringGrid1.Options + [goRowSelect];
  AdvStringGrid1.Repaint;
  AdvStringGrid1.SearchPanel.Repaint;
  AdvStringGrid1.SearchPanel.EditControl.Width :=   AdvStringGrid1.SearchPanel.EditControl.Width  + 1;
  AdvStringGrid1.SearchPanel.EditControl.Width :=   AdvStringGrid1.SearchPanel.EditControl.Width  - 1;  
end;

procedure TGridGallery.ResToFile(ResName,FileName: string);
{$IFNDEF TMSDOTNET}
var
  reshandle: THandle;
  hglobal: THandle;
  ressize: dword;
  ptr: pointer;
  rtext: string;
  tf: TextFile;
  i: Integer;
{$ENDIF}
begin
  {$IFNDEF TMSDOTNET}
  reshandle := FindResource(hinstance, PChar(ResName), PChar(RT_RCDATA));
  hglobal := LoadResource(hinstance, reshandle);
  Ressize := SizeOfResource(hinstance, reshandle);
  ptr := LockResource(hglobal);

  rtext := '';
  for i := 1 to ressize do
  begin
    rtext := rtext + char(ptr^);
    ptr := pointer(integer(ptr) + 1);
  end;

  {$IFDEF DELPHI6_LVL}
  AssignFile(tf, GetMyDocuments+'\'+FileName+'.GP');
  {$ELSE}
  AssignFile(tf,'.\'+FileName+'.GP');  
  {$ENDIF}
  {$i-}
  rewrite(tf);
  {$i+}
  if ioresult = 0 then
  begin
    write(tf,rtext);
    CloseFile(tf);
  end;
{$ENDIF}  
end;

{$WARNINGS OFF}
procedure TGridGallery.LoadList;
var
  SR: TSearchRec;
  FileAttrs: Integer;
  len: integer;
begin
  // get gallery files
  FileAttrs := faArchive;
  {$IFDEF DELPHI6_LVL}
  if FindFirst(GetMyDocuments+'\*.GP',FileAttrs,SR) = 0 then
  {$ELSE}
  if FindFirst('.\*.GP',FileAttrs,SR) = 0 then
  {$ENDIF}
  begin
    repeat
      if (sr.Attr and FileAttrs) = sr.Attr then
      begin
        len := Length(ExtractFileExt(sr.Name));
        listbox1.Items.Add(copy(sr.Name,1,length(sr.Name)-len));
      end;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
end;
{$WARNINGS ON}

procedure TGridGallery.FormCreate(Sender: TObject);
begin
  InitGrid;
  LoadList;

  if ListBox1.Items.Count = 0 then //
  begin
    // extract resources
    ResToFile('G1','Office 2003 Blue');
    ResToFile('G2','Office 2003 Olive');
    ResToFile('G3','Office 2003 Silver');
    ResToFile('G4','Whidbey');
    ResToFile('G5','Windows XP');
    ResToFile('G6','Arctic');
    ResToFile('G7','Aqua');
    ResToFile('G8','SilverFox');
    ResToFile('G9','MacOS');
    ResToFile('G10','BabyBlue');
    ResToFile('G11','SummerSand');
    ResToFile('G12','Classic');
    LoadList;
  end;
  oldidx := -1;
end;

procedure TGridGallery.ListBox1Click(Sender: TObject);
var
  fName: string;
begin
  if (oldidx <> ListBox1.ItemIndex) and (Listbox1.ItemIndex <> -1) then
  begin
    {$IFDEF DELPHI6_LVL}
    fname := GetMyDocuments + '\' + ListBox1.Items[ListBox1.ItemIndex] + '.GP';
    {$ELSE}
    fname := '.\' + ListBox1.Items[ListBox1.ItemIndex] + '.GP';
    {$ENDIF}
    FGalleryFile := fname;

    AdvStringgrid1.UnGroup;
    AdvStringGrid1.LoadVisualProps(fname);
    InitGrid;
    oldidx := ListBox1.ItemIndex;
  end;
end;

end.
