unit ResourceForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdActns, ActnList, Menus, ComCtrls, ExtCtrls, cmpHexEdit, ResourceModule,
  StdCtrls, cmpBitmapEditor, ToolWin, ImgList, ResourceEditorForm, contnrs, cmpMRUList;

const
  WM_FIXCLOSE = WM_USER + $300;

type
  TfmResource = class(TForm)
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    actEditCopy: TEditCopy;
    actEditCut: TEditCut;
    actEditPaste: TEditPaste;
    mnuEdit: TMenuItem;
    mnuEditCut: TMenuItem;
    mnuEditCopy: TMenuItem;
    mnuEditPaste: TMenuItem;
    resources: TResourceModule;
    tvResources: TTreeView;
    Splitter1: TSplitter;
    mnuResource: TMenuItem;
    actResourceAddResource: TAction;
    actResourceDeleteResource: TAction;
    AddResource1: TMenuItem;
    DeleteResource1: TMenuItem;
    Panel1: TPanel;
    ilResources: TImageList;
    poResourceTree: TPopupMenu;
    actResourceProperties: TAction;
    Properties1: TMenuItem;
    N1: TMenuItem;
    Properties2: TMenuItem;
    AddResource2: TMenuItem;
    DeleteResource2: TMenuItem;
    N2: TMenuItem;
    actResourceExport: TAction;
    actResourceImport: TAction;
    Import1: TMenuItem;
    Export1: TMenuItem;
    N3: TMenuItem;
    SaveDialog: TSaveDialog;
    N4: TMenuItem;
    ImportResource1: TMenuItem;
    ExportResource1: TMenuItem;
    ImportResourceDialog: TOpenDialog;
    actEditDelete: TAction;
    ilResourceForm: TImageList;
    actEditSelectAll: TAction;
    Delete1: TMenuItem;
    SelectAll1: TMenuItem;
    actResourceExportRCSnippet: TAction;
    ExportRCSnippet1: TMenuItem;
    ExportRCSnippet2: TMenuItem;
    actEditUndo: TAction;
    actEditRedo: TAction;
    N5: TMenuItem;
    mnuEditUndo: TMenuItem;
    mnuEditRedo: TMenuItem;
    actEditClearUndo: TAction;
    N6: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tvResourcesClick(Sender: TObject);
    procedure actResourceDeleteResourceExecute(Sender: TObject);
    procedure actResourceAddResourceExecute(Sender: TObject);
    procedure resourcesAddResource(sender: TObject; resource: TResource);
    procedure tvResourcesCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure tvResourcesExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure actResourcePropertiesExecute(Sender: TObject);
    procedure tvResourcesDblClick(Sender: TObject);
    procedure resourcesChangeResource(sender: TObject;
      resource: TResource);
    procedure actResourceExportExecute(Sender: TObject);
    procedure actResourceImportExecute(Sender: TObject);
    procedure actEditCopyExecute(Sender: TObject);
    procedure actEditCutExecute(Sender: TObject);
    procedure actEditPasteExecute(Sender: TObject);
    procedure actEditDeleteExecute(Sender: TObject);
    procedure actEditSelectAllExecute(Sender: TObject);
    procedure actResourceExportRCSnippetExecute(Sender: TObject);
    procedure actEditUndoExecute(Sender: TObject);
    procedure mnuEditClick(Sender: TObject);
    procedure actEditRedoExecute(Sender: TObject);
    procedure actEditClearUndoExecute(Sender: TObject);
    procedure tvResourcesChange(Sender: TObject; Node: TTreeNode);
  private
    DeleteShortcut : TShortcut;
    InsertShortcut : TShortcut;
    fMRUList : TMRUList;
    function GetFilename : string;
    procedure SetFilename(const Value: string);
    procedure SetCaption;

    function SetEditor (c : TResourceEditorClass; res : TResource) : TfmResourceEditor;
    function GetEditor : TfmResourceEditor;
    procedure FreeEditor;
    function GetSelectedResource : TResource;

    procedure WmFixClose (var message : TMessage); message WM_FIXCLOSE;
    function GetEditSupport: TEditSupport;
    procedure SelectedResourceChanged;

  protected
    procedure UpdateActions; override;
  public
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
    property FileName : string read GetFilename write SetFilename;
    procedure SaveAs (const fileName : string);
    procedure Save;
    function ImageForResource (resource : TResource) : Integer;

    property EditSupport : TEditSupport read GetEditSupport;
  end;

var
  fmResource: TfmResource;

implementation

uses BitmapEditorForm,
     HexEditorForm,
     StringsEditorForm,
     PackageEditorForm,
     VersionEditorForm,
     ComponentEditorForm,
     AddResourceDialog,
     ResourcePropertiesDialog,
     ResourceMessages,
     ResourceGraphics,
     ResourceVersion,
     ResourceRiff,
     MenuEditorForm,
     DialogEditorForm,
     WaveEditorForm,
     MIDIEditorForm,
     AVIEditorForm,
     ResourceGroupEditorForm,
     DescriptionEditorForm,
     MainForm;

{$R *.DFM}

resourcestring
  rstUntitled = 'Untitled';
  rstNeutral = 'Language Neutral';
  rstConfirmUpdateModule = 'Are you sure you want to update the resources in a WIN32 module';
  rstColor = 'Colour';
  rstAnyFile = 'Any File (*.*)|*.*';
  rstUndo = '&Undo';
  rstUndoFmt = '&Undo %s';
  rstRedo = '&Redo';
  rstRedoFmt = '&Redo %s';

procedure TfmResource.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree
end;

procedure TfmResource.SetCaption;
begin
  if fileName = '' then
    Caption := '[' + rstUntitled + ']'
  else
    Caption := ExtractFilename (FileName)
end;

procedure TfmResource.SetFilename(const Value: string);
begin
  if Filename <> value then
  begin
    tvResources.Items.BeginUpdate;
    try
      Resources.FileName := value;
    finally
      Application.ProcessMessages;
      tvResources.Items.EndUpdate
    end;
    SetCaption
  end
end;

procedure TfmResource.FormShow(Sender: TObject);
begin
  SetCaption;
  DeleteShortcut := actResourceDeleteResource.Shortcut;
  InsertShortcut := actResourceAddResource.Shortcut;
end;

function TfmResource.GetFilename: string;
begin
  result := Resources.FileName

end;

procedure TfmResource.tvResourcesClick(Sender: TObject);
begin
//  SelectedResourceChanged;
end;

procedure TfmResource.SelectedResourceChanged;
var
  n : TTreeNode;
  res : TResource;
begin
  n := tvResources.Selected;
  if Assigned (n) then
    if n.level = 0 then
      FreeEditor
    else
    begin
      res := TResource (n.data);

      case res.RawType of
        Integer (RT_BITMAP),
        Integer (RT_ICON),
        Integer (RT_CURSOR) :
          SetEditor (TfmBitmapEditor, res);

        Integer (RT_STRING),
        Integer (RT_MESSAGETABLE) :
          SetEditor (TfmStringsEditor, res);

        Integer (RT_GROUP_CURSOR),
        Integer (RT_GROUP_ICON) :
          SetEditor (TfmResourceGroupEditor, res);

        Integer (RT_RCDATA) :
          if res is TPackageResource then
            SetEditor (TfmPackageEditor, res)
          else
            if res is TComponentResource then
              SetEditor (TfmComponentEditor, res)
            else
              if res is TDescriptionResource then
                SetEditor (TfmDescriptionEditor, res)
              else
                SetEditor (TfmHexEditor, res);

        Integer (RT_VERSION) :
          SetEditor (TfmVersionEditor, res);

        Integer (RT_MENU) :
          SetEditor (TfmMenuEditor, res);

        Integer (RT_DIALOG) :
          SetEditor (TfmDialogEditor, res);

        RT_INTERNALWAVE :
          SetEditor (TfmWaveEditor, res);

        RT_INTERNALRMID :
          SetEditor (TfmMidiEditor, res);

        RT_INTERNALAVI :
          SetEditor (TfmAVIEditor, res);

        else
          SetEditor (TfmHexEditor, res)
      end
    end
end;



procedure TfmResource.UpdateActions;
var
  resourceSelected : boolean;
  res : TResource;
  editSupport : TEditSupport;
begin
  res := GetSelectedResource;
  resourceSelected := Assigned (res);
  actResourceDeleteResource.Enabled := resourceSelected;
  actResourceProperties.Enabled := resourceSelected;
  actResourceExport.Enabled := resourceSelected and (res is TWriteableResource) and (wsExportable in TWriteableResource (res).Style);
  actResourceExportRCSnippet.Enabled := resourceSelected and (res is TWriteableResource) and (wsSnippetable in TWriteableResource (res).Style);

  editSupport := GetEditSupport;

  actEditCopy.Enabled := esCopy in editSupport;
  actEditCut.Enabled := esCut in editSupport;
  actEditPaste.Enabled := esPaste in editSupport;
  actEditDelete.Enabled := esDelete in editSupport;
  actEditSelectAll.Enabled := esSelectAll in editSupport;

  actEditUndo.Enabled := esUndo in editSupport;
  actEditRedo.Enabled := esRedo in editSupport;

  actEditClearUndo.Enabled := ((esUndo in editSupport) or (esRedo in editSupport));
end;

function TfmResource.SetEditor(c: TResourceEditorClass; res : TResource) : TfmResourceEditor;
var
  editorChanged : boolean;
begin
  result := GetEditor;

  if Assigned (result) then
    if not (result is c) then
    begin
      FreeEditor;
      result := Nil
    end;

  editorChanged := False;
  if not Assigned (result) then
  begin
    editorChanged := True;
    result := c.Create (self);
    result.Parent := Panel1;
    if Assigned (result.OnActivate) then
      result.OnActivate (self);
  end;

  result.Resource := res;
  result.Show;
  if editorChanged then
  begin
    PostMessage (handle, WM_FIXCLOSE, 0, 0);
    PostMessage (handle, WM_FIXCLOSE, 0, 0);
  end
end;

procedure TfmResource.FreeEditor;
var
  editor : TfmResourceEditor;
begin
  editor := GetEditor;
  if Assigned (editor) then
  begin
    if Assigned (@editor.OnDeactivate) then
      editor.OnDeactivate (self);
    editor.Free;
  end
end;

procedure TfmResource.actResourceDeleteResourceExecute(Sender: TObject);
var
  res : TResource;
  n : TTreeNode;
begin
  FreeEditor;

  res := GetSelectedResource;
  if Assigned (res) then
  begin
    n := tvResources.Selected;
    res.Free;
    if n.Parent.Count = 1 then
      n.Parent.Free
    else
      n.Free;

    tvResourcesClick (Nil);
  end
end;

procedure TfmResource.Save;
var
  res : TResource;
  i : Integer;
begin
  case Resources.ModuleType of
    rtResFile : Resources.WriteResFile (fileName);
    rtModule : if MessageBox (handle, PChar (rstConfirmUpdateModule), PChar (caption), MB_ICONWARNING or MB_YESNO or MB_DEFBUTTON2)= IDYES then
               begin
                 for i := 0 to resources.ResourceCount - 1 do
                 begin
                   res := resources.resource [i];
                   if res is TVersionInfoResource then
                   begin
                     with TVersionInfoResource (res) do
                       if not Dirty then
                         FileFlags := FileFlags + [ffPatched];
                     break
                   end
                 end;
                 Resources.UpdateModuleFile;
               end

  end
end;

procedure TfmResource.SaveAs(const fileName: string);
begin
  Resources.WriteResFile (fileName);
  self.fileName := fileName;
  SetCaption
end;

procedure TfmResource.actResourceAddResourceExecute(Sender: TObject);
var
  i, idx : Integer;
  cl : TWriteableResourceClass;
  res : TWriteableResource;
  pf : TPixelFormat;
begin
  with TdlgAddResource.Create (self) do
  try
    lvResourceTypes.Items.BeginUpdate;
    with lvResourceTypes.Items do
    try
      for i := 0 to Resources.WriteableResourceCount - 1 do
        with Add do
        begin
          Caption := Resources.WriteableResourceName [i];
          idx := Resources.WriteableResourceClass [i].GetResourceType;
          case idx of
            Integer (RT_GROUP_CURSOR),
            Integer (RT_GROUP_ICON) : idx := idx - DIFFERENCE;
            Integer (RT_MESSAGETABLE) : idx := Integer (RT_STRING);
            Integer (RT_INTERNALRIFF),
            Integer (RT_INTERNALWAVE),
            Integer (RT_INTERNALRMID) : idx := idx - 1000;
          end;
          ImageIndex := idx;
          Data := pointer (idx);
        end
    finally
     EndUpdate
    end;

    if ShowModal = mrOK then
    begin
      if Assigned (lvResourceTypes) then
      begin
        i := lvResourceTypes.Selected.Index;
        cl := Resources.WriteableResourceClass [i];
        res := cl.Create (Resources, PWideChar (resources.GetUniqueResourceName (cl)));

        case cbColors.ItemIndex of
          0 : pf := pf1Bit;
          1 : pf := pf4Bit;
          2 : pf := pf8Bit;
          3 : pf := pf15Bit;
          4 : pf := pf16Bit;
          5 : pf := pf24Bit;
          6 : pf := pf32Bit;
          else
            pf := pf4Bit
        end;

        if res is TGroupResource then
        begin
          TGroupResource (res).DefaultPixelFormat := pf;
          TGroupResource (res).DefaultWidth := udWidth.Position;
          TGroupResource (res).DefaultHeight := udHeight.Position;
        end
        else
          if res is TBitmapResource then
          begin
            TBitmapResource (res).DefaultPixelFormat := pf;
            TBitmapResource (res).DefaultWidth := udWidth.Position;
            TBitmapResource (res).DefaultHeight := udHeight.Position;
          end;
        res.Initialize
      end
    end
  finally
    Free
  end
end;

procedure TfmResource.resourcesAddResource(sender: TObject;
  resource: TResource);
var
  r, n : TTreeNode;
  i,c : Integer;
  gres : TResource;
  attributes : TResourceDirectory;
  st : string;

begin
  if (resource is TIconResource) or (resource is TCursorResource) then Exit;

  with tvResources.Items do
  try
    r := tvResources.Items.GetFirstNode;
    while (Assigned (r)) and (r.Text <> resource.ResourceTypeName) do
      r := r.GetNextSibling;

    if not Assigned (r) then
    begin
      r := Add (Nil, resource.ResourceTypeName);
      r.ImageIndex := 10;
      r.SelectedIndex := 10
    end;

    if Resource.Language = 0 then
      n := AddChildObject (r, Resource.ResourceName, resource)
    else
      n := AddChildObject (r, Format ('%s - %s', [Resource.ResourceName, Languages.NameFromLocaleID [Resource.Language]]), resource);
      
    n.ImageIndex := ImageForResource (resource);
    if n.ImageIndex = 10 then
      n.SelectedIndex := 10
    else
      n.SelectedIndex := n.ImageIndex;

    if resource is TGroupResource then
      with TGroupResource (resource) do
        for i := 0 to ResourceGroupCount - 1 do
        begin
          gres := ResourceGroupResource [i];
          GetGroupResourceAttributes (i, attributes);
          if Assigned (gres) then
          begin
            if resource is TCursorGroupResource then
              st := Format ('%s - %dx%d', [gres.ResourceName, attributes.details.cursorWidth, attributes.details.cursorHeight div 2])
            else
              if resource is TIconGroupResource then
              begin
                c := 1 shl attributes.wBitCount;
                st := Format ('%s - %dx%d %d %s', [gres.ResourceName, attributes.details.iconWidth, attributes.details.iconHeight, c, rstColor]);
              end
              else
                st := '';
            with AddChildObject (n, st, gres) do
            begin
              ImageIndex := ImageForResource (gres);
              if ImageIndex = 10 then
                SelectedIndex := 10
              else
                SelectedIndex := ImageIndex
            end
          end
        end

  finally
  end
end;

function TfmResource.ImageForResource(resource: TResource): Integer;
begin
  case resource.RawType of
    Integer (RT_CURSOR),
    Integer (RT_BITMAP),
    Integer (RT_ICON),
    Integer (RT_MENU),
    Integer (RT_DIALOG),
    Integer (RT_STRING)       : result := Integer (resource.RawType);

    Integer (RT_INTERNALRIFF),
    Integer (RT_INTERNALWAVE),
    Integer (RT_INTERNALRMID) : result := Integer (resource.RawType) - 1000;

    Integer (RT_ACCELERATOR)  : result := 7;
    Integer (RT_VERSION)      : result := 8;
    Integer (RT_TOOLBAR)      : result := 9;
    Integer (RT_MESSAGETABLE) : result := Integer (RT_STRING);

    else
            result := 10
  end
end;

procedure TfmResource.tvResourcesCollapsing(Sender: TObject;
  Node: TTreeNode; var AllowCollapse: Boolean);
begin
  Node.ImageIndex := 10;
  Node.SelectedIndex := 10;
end;

procedure TfmResource.tvResourcesExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
begin
  Node.ImageIndex := 11;
  Node.SelectedIndex := 11;
end;

procedure TfmResource.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  editor : TfmResourceEditor;
begin
  editor := GetEditor;
  if Assigned (editor) then
    if not Editor.CanClose then
      CanClose := False;

  if CanClose then
  begin
    if resources.Changed then
      case MessageBox (handle, 'Changes have been made.  Do you want to save them', PChar (caption), MB_YESNOCANCEL or MB_DEFBUTTON2 or MB_ICONQUESTION) of
        IDYES :
          if not fmMain.SaveCurrentForm then
            begin
              CanClose := False;
              tvResourcesClick (Nil)
            end;

        IDCANCEL :
          begin
            CanClose := False;
            tvResourcesClick (Nil)
          end
      end;

    if CanClose then
      fmMain.mnuMain.Unmerge (MainMenu1);
  end
end;

procedure TfmResource.FormActivate(Sender: TObject);
var
  frm : TfmResourceEditor;
begin
  PostMessage (Handle, WM_FIXCLOSE, 0, 0);
  frm := GetEditor;
  if Assigned (frm) and Assigned (frm.OnActivate) then
    frm.OnActivate (self)
end;

procedure TfmResource.FormDeactivate(Sender: TObject);
var
  frm : TfmResourceEditor;
begin
  frm := GetEditor;
  if Assigned (frm) and Assigned (frm.OnDeactivate) then
    frm.OnDeactivate (self)
end;

procedure TfmResource.actResourcePropertiesExecute(Sender: TObject);
var
  res : TResource;
  i : Integer;
  idx : Integer;
  nm : PWideChar;
  nms : string;
  nmsw : WideString;
  isInteger : boolean;
  sLang : string;

begin
  res := GetSelectedResource;
  if Assigned (res) then
    with TdlgResourceProperties.Create (self) do
    try
      edIdentifier.Text := res.ResourceName;

      idx := 0;
      cbLanguage.Items.Add (rstNeutral);
      for i := 0 to Languages.Count - 1 do
      begin
        sLang := Languages.Name [i];
        cbLanguage.Items.Add (sLang);
        if res.Language = Languages.LocaleID [i] then
          idx := i + 1;
      end;
      
      if idx > 0 then
        cbLanguage.Text := Languages.NameFromLocaleID [res.Language]
      else
        cbLanguage.Text := rstNeutral;

      cbLanguage.ItemIndex := idx;

      if ShowModal = mrOK then
      begin
        nms := edIdentifier.Text;
        if nms <> res.ResourceName then
        begin
          isInteger := True;
          for i := 1 to Length (nms) do
            if not (nms [i] in ['0'..'9']) then
            begin
              isInteger := False;
              break
            end;

          if isInteger then
            if StrToInt (nms) >= 65536 then
              isInteger := False;

          if isInteger then
            nm := PWideChar (StrToInt (nms))
          else
          begin
            nmsw := nms;
            nm := PWideChar (nmsw)
          end;

          if not res.parent.IsUniqueResourceName (TResourceClass (res.ClassType), nm) then
            Raise Exception.Create ('Duplicate resource name');

          res.ResourceName := edIdentifier.Text
        end;
        if cbLanguage.Text = rstNeutral then
          res.Language := 0
        else
          for i := 0 to Languages.Count -1 do
            if Languages.Name [i] = cbLanguage.Text then
            begin
              res.Language := Languages.LocaleID [i];
              break
            end;

        if res is TIconCursorResource then
          resourcesChangeResource (self, TIconCursorResource (res).GetResourceGroup)
        else
          resourcesChangeResource (self, res);
      end
    finally
      Free
    end
end;

function TfmResource.GetSelectedResource: TResource;
var
  Node : TTreeNode;
begin
  result := Nil;
  node := tvResources.Selected;
  if Assigned (node) and (node.Level > 0) then
    result := TResource (node.data);
end;

procedure TfmResource.tvResourcesDblClick(Sender: TObject);
begin
  actResourceProperties.Execute
end;

procedure TfmResource.resourcesChangeResource(sender: TObject;
  resource: TResource);
var
  n, r, g : TTreeNode;
  i : Integer;
  gres : TResource;
  attributes : TResourceDirectory;
  st : string;
  orphan : boolean;
  editor : TfmResourceEditor;
begin
  r := tvResources.Items.GetFirstNode;
  n := Nil;
  while Assigned (r) do
  begin
    n := r.getFirstChild;
    while Assigned (n) and (n.Data <> Resource) do
      n := n.getNextSibling;

    if not Assigned (n) then
      r := r.getNextSibling
    else
      break
  end;

  if Assigned (n) then
  begin
    if Resource.Language = 0 then
      n.Text := Resource.ResourceName
    else
      n.Text := Format ('%s - %s', [Resource.ResourceName, Languages.NameFromLocaleID [Resource.Language]]);

    if Resource.Dirty then n.Text := '*' + n.Text;

    if resource is TGroupResource then
    begin
      r := n.GetFirstChild;

      for i := 0 to TGroupResource (resource).ResourceGroupCount - 1 do
      begin
        g := r;
        gres := TGroupResource (resource).ResourceGroupResource [i];
        TGroupResource (resource).GetGroupResourceAttributes (i, attributes);
        if resource is TCursorGroupResource then
          st := Format ('%s - %dx%d', [gres.ResourceName, attributes.details.cursorWidth, attributes.details.cursorHeight div 2])
        else
          if resource is TIconGroupResource then
            st := Format ('%s - %dx%d %d %s', [gres.ResourceName, attributes.details.iconWidth, attributes.details.iconHeight, 1 shl attributes.wBitCount, rstColor])
          else
            st := '';

        while Assigned (g) and (g.Data <> gres) do
          g := g.GetNextSibling;

        if Assigned (g) then
          g.text := st
        else
          with tvResources.Items.AddChildObject (n, st, gres) do
          begin
            ImageIndex := ImageForResource (gres);
            if ImageIndex = 10 then
              SelectedIndex := 10
            else
              SelectedIndex := ImageIndex
          end
      end;

      g := r;
      while Assigned (g) do
      begin
        orphan := True;
        for i := 0 to TGroupResource (resource).ResourceGroupCount - 1 do
        begin
          gres := TGroupResource (resource).ResourceGroupResource [i];
          if gres = g.Data then
          begin
            orphan := False;
            break
          end
        end;

        r := g;
        g := g.getNextSibling;
        if orphan then
          r.Delete
      end
    end
  end;

  editor := GetEditor;
  if Assigned (editor) and (editor.Resource = resource) then
    editor.DoResourceChanged;
end;


procedure TfmResource.actResourceExportExecute(Sender: TObject);
var
  res : TWriteableResource;
  st : string;
  p : Integer;
begin
  res := GetSelectedResource as TWriteableResource;
  st := res.Filter;
  SaveDialog.Filter := st;
  p := pos ('|', st);
  if p > 0 then
  begin
    st := Copy (st, p + 1, MaxInt);
    p := Pos ('.', st);
    if p > 0 then
    begin
      st := Copy (st, p + 1, MaxInt);
      p := pos ('|', st);
      if p > 0 then
        st := Copy (st, 1, p - 1);
      SaveDialog.DefaultExt := trim (st);
    end
  end;

  if SaveDialog.Execute then
  begin
    res.ExportResource (SaveDialog.FileName);
  end
end;

procedure TfmResource.WmFixClose(var message: TMessage);
var
  Size : DWORD;
begin
  if WindowState = wsMaximized then
  begin
    Size := ClientWidth + (Longint(ClientHeight) shl 16);
    SendMessage(Handle, WM_SIZE, SIZE_RESTORED, Size);
    SendMessage(Handle, WM_SIZE, SIZE_MAXIMIZED, Size)
  end
end;

procedure TfmResource.actResourceImportExecute(Sender: TObject);
var
  i, n : Integer;
  rc : TWriteableResourceClass;
  s1, st : string;
  gotClass : boolean;
  res : TWriteableResource;
  lastExt : string;

  function MatchesFilter (const ext, filter : string) : Integer;
  var
    f, s, s1 : string;
    p : Integer;
    n : Integer;
  begin
    result := -1;
    n := -1;
    f := filter;
    repeat
      Inc (n);
      p := Pos ('|', f);
      if p > 0 then
      begin
        s := Copy (f, 1, p - 1);
        f := Copy (f, p + 1, MaxInt)
      end;

      p := Pos ('|', f);
      if p > 0 then
      begin
        s1 := Copy (f, 1, p - 1);
        f := Copy (f, p + 1, MaxInt)
      end
      else
        s1 := f;

      if CompareText (s1, '*' + ext) = 0 then
        result := n
    until (p = 0) or (result >= 0)
  end;

begin
  ImportResourceDialog.FileName := '';
  if fMRUList.Strings.Count > 0 then
  begin
    ImportResourceDialog.InitialDir := ExtractFilePath (fMRUList.Strings [0]);
    lastExt := ExtractFileExt (fMRUList.Strings [0]);
  end;

  for i := 0 to Resources.WriteableResourceCount - 1 do
  begin
    rc := Resources.WriteableResourceClass [i];
    s1 := rc.GetFilter;
    if s1 <> '' then
      if st = '' then
        st := s1
      else
        st := st + '|' + s1
  end;

  if st <> '' then
    st := st + '|';

  ImportResourceDialog.FilterIndex := MatchesFilter (lastExt, st) + 1;
  st := st + rstAnyFile;
  ImportResourceDialog.Filter := st;

  if ImportResourceDialog.Execute then
  begin
    gotClass := False;
    rc := Nil;
    for i := 0 to Resources.WriteableResourceCount - 1 do
    begin
      rc := Resources.WriteableResourceClass [i];
      s1 := rc.GetFilter;
      if (s1 <> '') and (MatchesFilter (ExtractFileExt (ImportResourceDialog.FileName), s1) >= 0) then
      begin
        gotClass := True;
        break
      end
    end;

    if gotClass then
    begin
      n := resources.GetUniqueResourceName (rc);
      if rc = TStringsResource then
        n := n * 16;

      case rc.GetResourceType of
        RT_INTERNALRMID :
          res := rc.Create (Resources, PWideChar (n), PWideChar (WideString ('MIDI')));
        else
          res := rc.Create (Resources, PWideChar (n));
      end;
      res.InitializeFromFile (ImportResourceDialog.FileName);
    end;

    fMRUList.AddFile (ImportResourceDialog.FileName);
  end

end;

constructor TfmResource.Create(AOwner: TComponent);
begin
  inherited;
  fMRUList := TMRUList.Create (nil);
  fMRUList.Manufacturer := 'Woozle';
  fMRUList.AppName := Application.Title;
  fMRUList.AppSection := 'Import';

end;

destructor TfmResource.Destroy;
begin
  fMRUList.Free;
  inherited;
end;

function TfmResource.GetEditSupport: TEditSupport;
var
  editor : TfmResourceEditor;
begin
  editor := GetEditor;
  if Assigned (editor) then
    result := editor.EditSupport
  else
    result := []
end;

procedure TfmResource.actEditCopyExecute(Sender: TObject);
var
  editor : TfmResourceEditor;
begin
  editor := GetEditor;
  if Assigned (editor) then
    editor.EditCopyToClipboard
end;

procedure TfmResource.actEditCutExecute(Sender: TObject);
var
  editor : TfmResourceEditor;
begin
  editor := GetEditor;
  if Assigned (editor) then
    editor.EditCutToClipboard
end;

procedure TfmResource.actEditPasteExecute(Sender: TObject);
var
  editor : TfmResourceEditor;
begin
  editor := GetEditor;
  if Assigned (editor) then
    editor.EditPaste
end;

procedure TfmResource.actEditDeleteExecute(Sender: TObject);
var
  editor : TfmResourceEditor;
begin
  editor := GetEditor;
  if Assigned (editor) then
    editor.EditDelete
end;

procedure TfmResource.actEditSelectAllExecute(Sender: TObject);
var
  editor : TfmResourceEditor;
begin
  editor := GetEditor;
  if Assigned (editor) then
    editor.EditSelectAll
end;

function TfmResource.GetEditor: TfmResourceEditor;
begin
  if (Panel1.ControlCount > 0) and (Panel1.Controls [0] is TfmResourceEditor) then
    result := TfmResourceEditor (Panel1.Controls [0])
  else
    result := Nil
end;

{ localInfo }

procedure TfmResource.actResourceExportRCSnippetExecute(Sender: TObject);
var
  res : TWriteableResource;
begin
  res := GetSelectedResource as TWriteableResource;
  SaveDialog.Filter := rstRCFilter;

  if SaveDialog.Execute then
  begin
    res.ExportResourceSnippet (SaveDialog.FileName);
  end

end;

procedure TfmResource.actEditUndoExecute(Sender: TObject);
var
  editor : TfmResourceEditor;
begin
  editor := GetEditor;
  if Assigned (editor) then
    editor.EditUndo;
end;

procedure TfmResource.mnuEditClick(Sender: TObject);
var
  editor : TfmResourceEditor;
  st : string;
begin
  editor := GetEditor;
  if Assigned (editor) then
    editor.EditMenuSelected;
    
  if Assigned (editor) and Assigned (editor.resource) then
    st := editor.resource.GetLastUndoDescription
  else
    st := '';
  if st <> '' then
    mnuEditUndo.Caption := Format (rstUndoFmt, [st])
  else
    mnuEditUndo.Caption := rstUndo;

  if Assigned (editor) and Assigned (editor.resource) then
    st := editor.resource.GetLastRedoDescription
  else
    st := '';
  if st <> '' then
    mnuEditRedo.Caption := Format (rstRedoFmt, [st])
  else
    mnuEditRedo.Caption := rstRedo;
end;

procedure TfmResource.actEditRedoExecute(Sender: TObject);
var
  editor : TfmResourceEditor;
begin
  editor := GetEditor;
  if Assigned (editor) then
    editor.EditRedo;
end;

procedure TfmResource.actEditClearUndoExecute(Sender: TObject);
var
  editor : TfmResourceEditor;
begin
  editor := GetEditor;
  if Assigned (editor) and Assigned (editor.Resource) then
  begin
    if editor.Resource.Dirty then
      editor.Resource.Parent.Changed := True;
    editor.Resource.ClearUndoStack
  end
end;

procedure TfmResource.tvResourcesChange(Sender: TObject; Node: TTreeNode);
begin
  SelectedResourceChanged
end;

end.
