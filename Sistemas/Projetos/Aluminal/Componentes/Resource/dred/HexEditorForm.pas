(*===========================================================================*
 | Delphi Resource Editor V 1.1                                              |
 |                                                                           |
 | unit HexEditorForm                                                        |
 |                                                                           |
 | Editor form used when no other editor form is available.  Contains Hex    |
 | editor                                                                    |
 *===========================================================================*)
unit HexEditorForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ResourceEditorForm, cmpHexEdit;

type
  TfmHexEditor = class(TfmResourceEditor)
    HexDump: THexDump;
    procedure HexDumpEnter(Sender: TObject);
    procedure HexDumpExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fOldData : TMemoryStream;

  protected
    function GetEditSupport: TEditSupport; override;
  public
    procedure DoResourceChanged; override;
    procedure EditMenuSelected; override;
  end;

var
  fmHexEditor: TfmHexEditor;

implementation

{$R *.DFM}

resourcestring
  rstRawResourceChanged = 'change raw resource';

{ TfmHexEditor }

(*----------------------------------------------------------------------------*
 | procedure TfmHexEditor.DoResourceChanged                                   |
 |                                                                            |
 | Called when the user selects a resource.  Initialise the hex editor.       |
 *----------------------------------------------------------------------------*)
procedure TfmHexEditor.DoResourceChanged;
begin
  HexDump.Address := Nil;
  HexDump.DataSize := resource.Data.Size;
  HexDump.Address := resource.Data.Memory;
  HexDump.CurrentLine := 1;
  HexDump.CurrentLine := 0;
  HexDump.Changes := False;
end;

(*----------------------------------------------------------------------------*
 | procedure TfmHexEditor.DoResourceChanged                                   |
 |                                                                            |
 | We don't save each change in the undo stack.  Instead the changes on the   |
 | undo stack when the user exits the form (or when they select 'Edit' from   |
 | the menu).  Save the old data on entry, so it can be added to the undo     |
 | stack on exit if the data has changed.                                     |
 *----------------------------------------------------------------------------*)
procedure TfmHexEditor.HexDumpEnter(Sender: TObject);
begin
  fOldData.Clear;
  fOldData.CopyFrom (resource.Data, 0);
end;

(*----------------------------------------------------------------------------*
 | procedure TfmHexEditor.DoResourceChanged                                   |
 |                                                                            |
 | We don't save each change in the undo stack.  Instead the changes on the   |
 | undo stack when the user exits the form (or when they select 'Edit' from   |
 | the menu).  On exit, add the old data to the undo stuck, so that it can    |
 | be undone.                                                                 |
 *----------------------------------------------------------------------------*)
procedure TfmHexEditor.HexDumpExit(Sender: TObject);
var
  fNewData : TMemoryStream;
begin
  if HexDump.Changes then
  begin
    fNewData := TMemoryStream.Create;
    try
      fNewData.CopyFrom (resource.Data, 0);
      try
        resource.Data.Clear;
        resource.Data.CopyFrom (fOldData, 0);
        resource.AddUndoEntry (rstRawResourceChanged);
        HexDump.Changes := False;
      finally
        resource.Data.Clear;
        resource.Data.CopyFrom (fNewData, 0);
        resource.NotifyChange
      end
    finally
      fNewData.Free
    end
  end
end;

(*----------------------------------------------------------------------------*
 | procedure TfmHexEditor.FormCreate                                          |
 |                                                                            |
 | Create fOldData area so that 'Undo' works                                  |
 *----------------------------------------------------------------------------*)
procedure TfmHexEditor.FormCreate(Sender: TObject);
begin
  fOldData := TMemoryStream.Create;
end;

(*----------------------------------------------------------------------------*
 | procedure TfmHexEditor.FormDestroy                                         |
 *----------------------------------------------------------------------------*)
procedure TfmHexEditor.FormDestroy(Sender: TObject);
begin
  fOldData.Free
end;

(*----------------------------------------------------------------------------*
 | procedure TfmHexEditor.EditMenuSelected                                    |
 |                                                                            |
 | Treat selecting 'Edit' from the menu as if the hex editor's lost focus, so |
 | 'Undo' works.                                                              |
 *----------------------------------------------------------------------------*)
procedure TfmHexEditor.EditMenuSelected;
begin
  HexDumpExit (Nil);
end;

(*----------------------------------------------------------------------------*
 | procedure TfmHexEditor.GetEditSupport                                      |
 |                                                                            |
 | Special case - If the hex editor has changes, undo is gonna work, because  |
 | we save changes when we lose focus, and we fake a lose focus when 'Edit'   |
 | is selected.                                                               |
 *----------------------------------------------------------------------------*)
function TfmHexEditor.GetEditSupport: TEditSupport;
begin
  result := inherited GetEditSupport;
  if HexDump.Changes then
    result := result + [esUndo];
end;

end.
