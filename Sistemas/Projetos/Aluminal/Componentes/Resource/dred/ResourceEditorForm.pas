unit ResourceEditorForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ResourceModule, Menus, contnrs;

type
  TEditSupportItems = (esUndo, esRedo, esCopy, esCut, esPaste, esDelete, esSelectAll);
  TEditSupport = set of TEditSupportItems;

  TfmResourceEditor = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    fResource: TResource;
    FMergeWithMainMenu: boolean;
    procedure SetResource(const Value: TResource);
    procedure MergeWithMainMenu;
    procedure UnMergeWithMainMenu;
  protected
    fMerged : boolean;
    function GetEditSupport: TEditSupport; virtual;

    { Private declarations }
  public
    procedure DoResourceChanged; virtual;
    constructor Create (AOwner : TComponent); override;

    destructor Destroy; override;
    function CanClose : boolean; virtual;
    procedure EditMenuSelected; virtual;
    property Resource : TResource read fResource write SetResource;
    property AutoMergeWithMainMenu : boolean read FMergeWithMainMenu write FMergeWithMainMenu default True;

    property EditSupport : TEditSupport read GetEditSupport;

    procedure EditCopyToClipboard; virtual;
    procedure EditCutToClipboard; virtual;
    procedure EditPaste; virtual;
    procedure EditDelete; virtual;
    procedure EditSelectAll; virtual;
    procedure EditUndo; virtual;
    procedure EditRedo; virtual;
  end;

  TResourceEditorClass = class of TfmResourceEditor;

var
  fmResourceEditor: TfmResourceEditor;

implementation

uses MainForm, ResourceForm;

{$R *.DFM}

resourceString
  rstChanges = 'changes';

procedure TfmResourceEditor.DoResourceChanged;
begin
end;

procedure TfmResourceEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmResourceEditor.MergeWithMainMenu;
var
  itm, newItem, parentMenu, mnu : TMenuItem;
  f : TForm;
  i, insertPos : Integer;

  procedure AddSubItems (dst, src : TMenuItem); forward;

  procedure CopyItem (dst, src : TMenuItem);
  begin
    if Assigned (src.Action) then
      dst.Action := src.Action
    else
    begin
      dst.Caption := src.Caption;
      dst.OnClick := src.OnClick
    end;
    dst.GroupIndex := src.GroupIndex;
    AddSubItems (dst, src);
  end;

  procedure AddSubItems (dst, src : TMenuItem);
  var
    i : Integer;
    newItem : TMenuItem;
  begin
    for i := 0 to src.Count - 1 do
    begin
      newItem := TMenuItem.Create (dst.Owner);
      CopyItem (newItem, src.Items [i]);
      dst.Add (newItem);
    end
  end;

begin
  if (not fMerged) and Assigned (Menu) and (Owner is TForm) then
  begin
    fMerged := True;
    mnu := menu.Items;
    if owner is TForm then
    begin
      f := TForm (owner);             // Find main form
      while Assigned (f.owner) and (f.owner is TForm) do
        f := f.Owner as TForm;

      parentMenu := f.menu.Items;

      for i := 0 to mnu.Count - 1 do
      begin
        itm := mnu.Items [i];
        insertPos := 0;
        while (insertPos < parentMenu.Count) and (itm.GroupIndex > parentMenu.Items [insertPos].GroupIndex) do
          Inc (insertPos);

        newItem := TMenuItem.Create (f);
        CopyItem (newItem, itm);
        parentMenu.Insert (insertPos, newItem)
      end
    end
  end
end;

procedure TfmResourceEditor.SetResource(const Value: TResource);
begin
  if value <> fResource then
  begin
    fResource := Value;
    DoResourceChanged
  end
end;

procedure TfmResourceEditor.UnMergeWithMainMenu;
var
  f : TForm;
  parentMenu : TMenuItem;
  i, j : Integer;
  itm : TMenuItem;
  mnu : TMenuItem;

begin
  if not fMerged or not Assigned (Menu) then Exit;
  mnu := menu.items;
  fMerged := False;
 if owner is TForm then
  begin
    f := TForm (owner);
    while Assigned (f.owner) and (f.owner is TForm) do
      f := f.Owner as TForm;

    if not Assigned (f.Menu) then
      Exit;

    parentMenu := f.menu.Items;

    for i := 0 to mnu.Count - 1 do
    begin
      itm := mnu.Items [i];

      for j := 0 to parentMenu.Count - 1 do
        if parentMenu.Items [j].Caption = itm.Caption then
        begin
          parentMenu.Items [j].Free;
          break
        end
    end
  end
end;

procedure TfmResourceEditor.FormActivate(Sender: TObject);
begin
  if AutoMergeWithMainMenu and Assigned (Menu) then
    MergeWithMainMenu
end;

procedure TfmResourceEditor.FormDeactivate(Sender: TObject);
begin
  if AutoMergeWithMainMenu and Assigned (Menu) then
    UnMergeWithMainMenu
end;

constructor TfmResourceEditor.Create(AOwner: TComponent);
begin
  FMergeWithMainMenu := True;
  inherited Create (AOwner);
end;

function TfmResourceEditor.CanClose: boolean;
begin
  result := True;
end;

procedure TfmResourceEditor.EditCopyToClipboard;
begin

end;

procedure TfmResourceEditor.EditCutToClipboard;
begin

end;

procedure TfmResourceEditor.EditDelete;
begin

end;

procedure TfmResourceEditor.EditPaste;
begin

end;

function TfmResourceEditor.GetEditSupport: TEditSupport;
begin
  if Assigned (resource) then
  begin
    if resource.Dirty then
      result := [esUndo]
    else
      result := [];

    if resource.CanRedo then
      result := result + [esRedo]
  end
  else
    result := [];
end;

procedure TfmResourceEditor.EditSelectAll;
begin

end;

destructor TfmResourceEditor.Destroy;
begin
  inherited;
end;

procedure TfmResourceEditor.EditUndo;
begin
  if Assigned (resource) then
    resource.Undo;
end;

procedure TfmResourceEditor.EditRedo;
begin
  if Assigned (resource) then
    resource.Redo;
end;

procedure TfmResourceEditor.EditMenuSelected;
begin

end;

end.
