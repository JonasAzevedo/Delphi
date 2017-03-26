{**************************************************************************}
{ TADVSTRINGGRID DESIGN TIME EDITOR                                        }
{ for Delphi & C++Builder                                                  }
{                                                                          }
{ written by TMS Software                                                  }
{            copyright � 1996-2009                                         }
{            Email : info@tmssoftware.com                                  }
{            Web : http://www.tmssoftware.com                              }
{                                                                          }
{ The source code is given as is. The author is not responsible            }
{ for any possible damage done due to the use of this code.                }
{ The component can be freely used in any application. The complete        }
{ source code remains property of the author and may not be distributed,   }
{ published, given or sold in any form as such. No parts of the source     }
{ code can be included in any other component or application without       }
{ written authorization of the author.                                     }
{**************************************************************************}

unit asgde;

interface
{$I TMSDEFS.INC}
uses
  Classes, AdvGrid, Windows, Forms, TypInfo, Controls
{$IFDEF DELPHI6_LVL}
  {$IFDEF TMSDOTNET}
  , Borland.Vcl.Design.DesignIntf, Borland.Vcl.Design.DesignEditors
  {$ENDIF}
  {$IFNDEF TMSDOTNET}
  , DesignIntf, DesignEditors, ContNrs, AsgPropPref, AsgGallery
  {$ENDIF}
{$ELSE}
  , DsgnIntf
{$ENDIF}
  ;

type
  TAdvStringGridEditor = class(TDefaultEditor)
  protected
    {$IFDEF DELPHI6_LVL}
    procedure PrintSetProc(const Prop: IProperty);
    {$ELSE}
    procedure PrintSetProc(PropEd: TPropertyEditor);
    {$ENDIF}
  public
    function GetVerb(index:integer):string; override;
    function GetVerbCount:integer; override;
    procedure ExecuteVerb(Index:integer); override;
  end;

implementation

uses
  Dialogs, SysUtils, ShlObj, ActiveX, ShellAPI;

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

{$IFNDEF DELPHI6_LVL}
procedure TAdvStringGridEditor.PrintSetProc(PropEd: TPropertyEditor);
begin
  try
    if PropEd.GetName = 'PrintSettings' then
      PropEd.Edit
  finally
    PropEd.Free;
  end;
end;

{$ELSE}
procedure TAdvStringGridEditor.PrintSetProc(const Prop: IProperty);
begin
  if Prop.GetName = 'PrintSettings' then
    Prop.Edit
end;
{$ENDIF}


procedure TAdvStringGridEditor.ExecuteVerb(Index: integer);
var
  compiler: string;
  od: TOpendialog;
  {$IFDEF DELPHI6_LVL}
  sd: TSaveDialog;
  CList: IDesignerSelections;
  {$IFNDEF TMSDOTNET}
  gg: TGridGallery;
  {$ENDIF}
  {$ENDIF}

begin
  case index of
  0:begin
    {$IFDEF VER100}
    compiler := 'Delphi 3';
    {$ENDIF}
    {$IFDEF VER110}
    compiler := 'C++Builder 3';
    {$ENDIF}
    {$IFDEF VER120}
    compiler := 'Delphi 4';
    {$ENDIF}
    {$IFDEF VER125}
    compiler := 'C++Builder 4';
    {$ENDIF}
    {$IFDEF VER130}
    {$IFDEF BCB}
    compiler := 'C++Builder 5';
    {$ELSE}
    compiler := 'Delphi 5';
    {$ENDIF}
    {$ENDIF}
    {$IFDEF VER140}
      {$IFDEF BCB}
      compiler := 'C++Builder 6';
      {$ELSE}
      compiler := 'Delphi 6';
      {$ENDIF}
    {$ENDIF}
    {$IFDEF VER150}
      {$IFDEF BCB}
      compiler := '';
      {$ELSE}
      compiler := 'Delphi 7';
      {$ENDIF}
    {$ENDIF}
    {$IFDEF VER160}
      compiler := 'Delphi 8';
    {$ENDIF}
    {$IFDEF VER170}
      compiler := 'Delphi 2005';
    {$ENDIF}
    {$IFDEF VER180}
      {$IFDEF BCB}
      compiler := 'C++Builder 2006';
      {$ELSE}
      compiler := 'Delphi 2006';
      {$ENDIF}
    {$ENDIF}
    {$IFDEF VER185}
      {$IFDEF BCB}
      compiler := 'C++Builder 2007';
      {$ELSE}
      compiler := 'Delphi 2007';
      {$ENDIF}
    {$ENDIF}
    {$IFDEF VER200}
      {$IFDEF BCB}
      compiler := 'C++Builder 2009';
      {$ELSE}
      compiler := 'Delphi 2009';
      {$ENDIF}
    {$ENDIF}


    MessageDlg(Component.ClassName+' version '+(Component as TAdvStringGrid).VersionString+' for '+compiler+#13#10'� 1997-2009 by TMS software',
               mtinformation,[mbok],0);
    end;
  1:begin
  {$IFNDEF TMSDOTNET}
     ShellExecute(0,'open','http://www.tmssoftware.com',nil,nil,SW_NORMAL);
  {$ENDIF}
  {$IFDEF TMSDOTNET}
     ShellExecute(0,'open','http://www.tmssoftware.com','','',SW_NORMAL);
  {$ENDIF}
    end;
  2:begin
    od := TOpenDialog.Create(nil);
    od.DefaultExt := '*.CSV';
    od.Filter := 'CSV files (*.csv)|*.csv|All files (*.*)|*.*';
    if od.Execute then
    begin
      (Component as TAdvStringGrid).SaveFixedCells := False;
      (Component as TAdvStringGrid).LoadFromCSV(od.FileName);
    end;
    od.Free;
   end;
  3:begin
     (Component as TAdvStringGrid).Clear;
    end;
  {$IFDEF DELPHI6_LVL}
  {$IFNDEF TMSDOTNET}
  4:begin
      CList := TDesignerSelections.Create;
      CList.Add(Component);
      GetComponentProperties(CList, tkProperties, Designer, PrintSetProc,nil);
    end;
  5:begin
      if FileExists(GetMyDocuments + '\ASGPREF.CFG') then
        RestorePropertiesToFile(Component,GetMyDocuments + '\ASGPREF.CFG');
    end;
  6:begin
      StorePropertiesToFile(Component,GetMyDocuments + '\ASGPREF.CFG');
    end;
  7:begin
      od := TOpenDialog.Create(Application);
      if od.Execute then
        RestorePropertiesToFile(Component,od.FileName);
      od.Free;
    end;
  8:begin
      sd := TSaveDialog.Create(Application);
      if sd.Execute then
        StorePropertiesToFile(Component,sd.FileName);
      sd.Free;
    end;
  9:begin
      gg := TGridGallery.Create(Application);
      if gg.ShowModal = mrOK then
        (Component as TAdvStringGrid).LoadVisualProps(gg.GalleryFile);

      gg.Free;
    end;
  {$ENDIF}
  {$ENDIF}
  end;
end;

function TAdvStringGridEditor.GetVerb(index: integer): string;
begin
  case index of
  0:result := '&Version';
  1:result := 'www.tmssoftware.com';
  2:result := '&Load CSV file';
  3:result := '&Clear';
  {$IFDEF DELPHI6_LVL}
  {$IFNDEF TMSDOTNET}
  4:result := '&Print settings';
  5:Result := 'Get preference';
  6:Result := 'Set preference';
  7:Result := 'Load Config';
  8:Result := 'Save Config';
  9:Result := 'Gallery';
  {$ENDIF}
  {$ENDIF}
  end;
end;

function TAdvStringGridEditor.GetVerbCount: integer;
begin
  {$IFNDEF TMSDOTNET}
  {$IFDEF DELPHI6_LVL}
  Result := 10;
  {$ELSE}
  Result := 4;
  {$ENDIF}
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  Result := 4;
  {$ENDIF}
end;


end.

