(*==========================================================================*
 | unit SnapinData                                                          |
 |                                                                          |
 | 10.0.0.1  01/08/2005 Colin Wilson  DeXter version						            |
 |                                                                          |
 |           Hangs IDE on exit - fixed                                      |
 *==========================================================================*)

unit SnapinData;

interface

uses windows, classes, sysutils, controls, ComObj, menus, mmc_tlb, unitVersionInfo, actnlist, commctrl;

type
TScopeItem = class;
TScopeItems = class;
TViewType = (vtListView, vtGUID, vtHTML);
TSnapinColumns = class;
TSnapinColumn = class;
TResultItem = class;
TResultItems = class;
TSnapinToolbarButton = class;
TSnapinToolbarButtons = class;

TSnapinDataResultRename = procedure (sender : TObject; const newName : string; var allowRename : boolean) of object;
TSnapinDataResultDelete = procedure (sender : TObject; var allowDelete : boolean) of object;
TSnapinDataResultProperties = procedure (sender : TObject; var Changed : boolean) of object;
TSnapinDataScopeShow = procedure (sender : TObject; selecting : boolean) of object;
TSnapinDataScopeExpand = procedure (sender : TObject; expanding : boolean; var allow : boolean) of object;
TSnapinDataPasteQuery = procedure (sender, obj : TObject; var allow : boolean) of object;
TSnapinDataPaste = procedure (sender, obj : TObject; var PerformCut : boolean) of object;
TOnOwnerData = procedure (sender : TObject; item : TResultItem) of object;
TOnInitOCX = procedure (sender : TObject; unk : IUnknown) of object;


TSnapinData = class (TComponent)
private
  FScopeItem : TScopeItem;
  FScopeSmallImages: TImageList;
  FParent: TObject;
  FOnHelp: TNotifyEvent;
  FScopeLargeImages: TImageList;
  FResultSmallImages: TImageList;
  FResultLargeImages: TImageList;
  FVersionInfo : TVersionInfo;
  fOnScopeShow: TSnapinDataScopeShow;
  fOnScopeExpand: TSnapinDataScopeExpand;

  procedure SetScopeSmallImages(const Value: TImageList);
  procedure SetParent(const Value: TObject);
  procedure SetScopeLargeImages(const Value: TImageList);
  procedure SetResultLargeImages(const Value: TImageList);
  procedure SetResultSmallImages(const Value: TImageList);
  function GetHandle: HWND;
  function GetProvider: string;
  function GetDescription : string;
  function GetFileVersion: string;
  function GetProductName: string;
  function GetSelected: TScopeItem;
  function GetFocusedResultItem: TResultItem;
  procedure SetFocusedResultItem(const Value: TResultItem);
  procedure SetSelected(const Value: TScopeItem);

protected
  procedure Notification(AComponent: TComponent; Operation: TOperation); override;
public
  constructor Create (AOwner : TComponent); override;
  destructor Destroy; override;
  property Parent : TObject read FParent write SetParent;
  procedure HelpCommand;
  property Handle : HWND read GetHandle;

  property Provider : string read GetProvider;
  property FileDescription : string read GetDescription;
  property FileVersion : string read GetFileVersion;
  property ProductName : string read GetProductName;

  property Selected : TScopeItem read GetSelected write SetSelected;     // Selected scope item
  property FocusedResultItem : TResultItem read GetFocusedResultItem write SetFocusedResultItem;

published
  property ScopeItem : TScopeItem read FScopeItem write FScopeItem;
  property ScopeSmallImages : TImageList read FScopeSmallImages write SetScopeSmallImages;
  property ScopeLargeImages : TImageList read FScopeLargeImages write SetScopeLargeImages;
  property ResultSmallImages : TImageList read FResultSmallImages write SetResultSmallImages;
  property ResultLargeImages : TImageList read FResultLargeImages write SetResultLargeImages;
  property OnHelp : TNotifyEvent read FOnHelp write FOnHelp;
  property OnScopeShow : TSnapinDataScopeShow read fOnScopeShow write FOnScopeShow;
  property OnScopeExpand : TSnapinDataScopeExpand read fOnScopeExpand write fOnScopeExpand;
end;

TScopeItem = class (TCollectionItem)
private
  fText: string;
  FData: pointer;
  FSnapinData : TSnapinData;
  FHasChildren : boolean;
  FViewTypeHTML: string;
  FViewTypeGUID: string;
  FGUIDValid : boolean;
  FRefreshEnabled : boolean;
  FImageIndex: Integer;
  FOpenImageIndex : Integer;
  FColumns: TSnapinColumns;
  FContextMenu: TPopupMenu;
  FResultItemsContextMenu : TPopupMenu;
  FScopeItems: TScopeItems;
  FResultItems: TResultItems;
  FSubItems: TStrings;
  FToolbarButtons: TSnapinToolbarButtons;
  FParentToolbarButtons: boolean;
  FItemID: Integer;
  FParentMainMenu: boolean;
  FMainMenu: TMainMenu;
  FOldMainMenuOnChange : TMenuChangeEvent;
  FOldMultiselectMainMenuOnChange : TMenuChangeEvent;
  FMultiSelect: boolean;
  FOnOwnerData: TOnOwnerData;

  FOnResultDblClick: TNotifyEvent;
  FOnResultDelete: TSnapinDataResultDelete;
  FOnResultProperties: TSnapinDataResultProperties;
  FOnResultRefresh: TNotifyEvent;
  FOnResultRename: TSnapinDataResultRename;

  fOnScopeProperties: TSnapinDataResultProperties;
  fOnInitOCX: TOnInitOCX;
  FOnResultPrint: TNotifyEvent;

  fCanCopy: boolean;
  fCanCopyResult: boolean;
  FOnScopeRefresh: TNotifyEvent;
  FOnPasteQuery: TSnapinDataPasteQuery;
  FOnPaste: TSnapinDataPaste;
  fOnScopeDelete: TSnapinDataResultDelete;
  fOnScopeRename: TSnapinDataResultRename;
  FAllowMultiselectResultProperties: boolean;

  FResultItemsMultiselectContextMenu: TPopupMenu;
  FParentMultiselectToolbarButtons: boolean;
  FParentMultiselectMainMenu: boolean;
  FMultiselectMainMenu: TMainMenu;
  FMultiselectToolbarButtons: TSnapinToolbarButtons;

  procedure SetText(const Value: string);
  procedure SetData(const Value: pointer);
  function GetHasChildren: Boolean;
  procedure SetHasChildren(const Value: Boolean);
  procedure SetRefreshEnabled(const Value: Boolean);
  function GetViewType: TViewType;
  procedure SetViewTypeGUID(const Value: string);
  procedure SetViewTypeHTML(const Value: string);
  procedure SetImageIndex(const Value: Integer);
  procedure SetColumns(const Value: TSnapinColumns);
  procedure SetContextMenu(const Value: TPopupMenu);
  procedure SetResultItemsContextMenu(const Value: TPopupMenu);
  function GetText: string;
  procedure SetOpenImageIndex(const Value: Integer);
  function AreToolbarButtonsStored: Boolean;
  procedure SetParentToolbarButtons(const Value: boolean);
  procedure SetToolbarButtons(const Value: TSnapinToolbarButtons);
  function GetParent: TScopeItem;
  function IsMainMenuStored: Boolean;
  procedure SetMainMenu(const Value: TMainMenu);
  procedure SetParentMainMenu(const Value: boolean);
  procedure MainMenuOnChange (Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
  procedure MultiselectMainMenuOnChange (Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
  function GetSelected: boolean;
  procedure SetSelected(const Value: boolean);
  procedure SubItemsOnChange (sender : TObject);
  procedure SetResultItemsMultiselectContextMenu (const Value: TPopupMenu);
  function AreMultiselectToolbarButtonsStored: Boolean;
  function IsMultiselectMainMenuStored: Boolean;
  procedure SetMultiselectMainMenu(const Value: TMainMenu);
  procedure SetMultiselectToolbarButtons(const Value: TSnapinToolbarButtons);
  procedure SetParentMultiselectMainMenu(const Value: boolean);
  procedure SetParentMultiselectToolbarButtons(const Value: boolean);

protected
  procedure AssignTo (dest : TPersistent); override;
  function GetOwner : TPersistent; override;
public
  constructor Create (ACollection : TCollection); override;
  destructor Destroy; override;
  procedure DeleteChildren;
  procedure Expand;
  procedure Collapse;
  procedure HelpCommand;
  procedure Refresh (columnsChanged : boolean);

  property Data : pointer read FData write SetData;
  property HasChildren: Boolean read GetHasChildren write SetHasChildren;
  property SnapinData : TSnapinData read fSnapinData;
  property SubItems : TStrings read FSubItems;
  property Parent : TScopeItem read GetParent;
  property ItemID : Integer read fItemID write FItemID;
  property Selected : boolean read GetSelected write SetSelected;

published
  property Text : string read GetText write SetText;
  property ViewType : TViewType read GetViewType;
  property ViewTypeHTML : string read FViewTypeHTML write SetViewTypeHTML;
  property ViewTypeObject : string read FViewTypeGUID write SetViewTypeGUID;
  property ImageIndex : Integer read FImageIndex write SetImageIndex default -1;
  property OpenImageIndex : Integer read FOpenImageIndex write SetOpenImageIndex default -1;
  property Columns : TSnapinColumns read FColumns write SetColumns;
  property ContextMenu : TPopupMenu read FContextMenu write SetContextMenu;

  property MainMenu : TMainMenu read FMainMenu write SetMainMenu stored IsMainMenuStored;
  property ParentMainMenu : boolean read FParentMainMenu write SetParentMainMenu nodefault;

  property MultiSelectMainMenu : TMainMenu read FMultiselectMainMenu write SetMultiselectMainMenu stored IsMultiselectMainMenuStored;
  property ParentMultiselectMainMenu : boolean read FParentMultiselectMainMenu write SetParentMultiselectMainMenu nodefault;

  property ScopeItems : TScopeItems read FScopeItems write FScopeItems;
  property ResultItems : TResultItems read FResultItems write FResultItems;

  property ToolbarButtons : TSnapinToolbarButtons read FToolbarButtons write SetToolbarButtons stored AreToolbarButtonsStored;
  property ParentToolbarButtons : boolean read FParentToolbarButtons write SetParentToolbarButtons nodefault;

  property MultiselectToolbarButtons : TSnapinToolbarButtons read FMultiselectToolbarButtons write SetMultiselectToolbarButtons stored AreMultiselectToolbarButtonsStored;
  property ParentMultiselectToolbarButtons : boolean read FParentMultiselectToolbarButtons write SetParentMultiselectToolbarButtons nodefault;

  property RefreshEnabled : boolean read FRefreshEnabled write SetRefreshEnabled default True;

  property MultiSelect : boolean read FMultiSelect write FMultiSelect default True;
  property AllowMultiselectResultProperties : boolean read FAllowMultiselectResultProperties write FAllowMultiselectResultProperties default True;
  property ResultItemsContextMenu : TPopupMenu read FResultItemsContextMenu write SetResultItemsContextMenu;
  property ResultItemsMultiSelectContextMenu : TPopupMenu read FResultItemsMultiselectContextMenu write SetResultItemsMultiselectContextMenu;
  property CanCopy : boolean read fCanCopy write fCanCopy;
  property CanCopyResult : boolean read fCanCopyResult write fCanCopyResult;
  property OnOwnerData : TOnOwnerData read fOnOwnerData write fOnOwnerData;

  property OnResultDblClick : TNotifyEvent read FOnResultDblClick write FOnResultDblClick;
  property OnPasteQuery : TSnapinDataPasteQuery read FOnPasteQuery write FOnPasteQuery;
  property OnPaste : TSnapinDataPaste read FOnPaste write FOnPaste;

  // Result item Standard verbs
  property OnResultDelete : TSnapinDataResultDelete read FOnResultDelete write FOnResultDelete;
  property OnResultProperties : TSnapinDataResultProperties read FOnResultProperties write FOnResultProperties;
  property OnResultRename : TSnapinDataResultRename read FOnResultRename write FOnResultRename;
  property OnResultPrint : TNotifyEvent read FOnResultPrint write FOnResultPrint;
  property OnResultRefresh : TNotifyEvent read FOnResultRefresh write FOnResultRefresh;

  property OnScopeRefresh : TNotifyEvent read FOnScopeRefresh write FOnScopeRefresh;
  property OnScopeProperties : TSnapinDataResultProperties read fOnScopeProperties write fOnScopeProperties;
  property OnScopeDelete : TSnapinDataResultDelete read fOnScopeDelete write FOnScopeDelete;
  property OnScopeRename : TSnapinDataResultRename read fOnScopeRename write FOnScopeRename;
  property OnInitOCX : TOnInitOCX read fOnInitOCX write fOnInitOCX;
end;

TScopeItems = class (TOwnedCollection)
private
  fSnapinData : TSnapinData;
  fOwner : TScopeItem;
  function GetItem(i: Integer): TScopeItem;
protected
  procedure Update(Item: TCollectionItem); override;
public
  constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
  property Items [i : Integer] : TScopeItem read GetItem; default;
  function Add : TScopeItem;
{$if not defined (VER150) and not defined (VER140) and not defined (VER170) and not defined (VER180) and not defined (UNICODE) then}
  property Owner : TScopeItem read fOwner;
{$ifend}
  property SnapinData : TSnapinData read fSnapinData;
published
end;

TSnapinColumns = class (TOwnedCollection)
private
  fOwner : TScopeItem;
  function GetItem(i: Integer): TSnapinColumn;
protected
  procedure Update(Item: TCollectionItem); override;
public
  constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
  property Items [i : Integer] : TSnapinColumn read GetItem; default;
  function Add : TSnapinColumn;
end;

TSnapinColumn = class (TCollectionItem)
private
  FWidth: Integer;
  FCaption: string;
  FAlignment: TAlignment;
  procedure Refresh;
  procedure SetAlignment(const Value: TAlignment);
  procedure SetCaption(const Value: string);
  procedure SetWidth(const Value: Integer);
protected
  procedure AssignTo (dest : TPersistent); override;
published
  constructor Create (ACollection : TCollection); override;
  property Caption : string read FCaption write SetCaption;
  property Width : Integer read FWidth write SetWidth;
  property Alignment : TAlignment read FAlignment write SetAlignment;
end;

TResultItem = class (TCollectionItem)
private
  FText: string;
  FSubItems: TStrings;
  FImageIndex: Integer;
  fItemID: array of Integer;  // 1 per view
  fCurrentViewIdx : Integer;
  fOwnerDataScopeItem : TScopeItem;

  procedure SetText(const Value: string);
  function GetScopeItem: TScopeItem;
  procedure SetImageIndex(const Value: Integer);
  function GetSelected: boolean;
  procedure SetSelected(const Value: boolean);
  function GetItemID(viewIdx: Integer): Integer;
  procedure SetItemID(viewIdx: Integer; const Value: Integer);
  function GetFocused: boolean;
  procedure SetFocused(const Value: boolean);
  procedure SetScopeItem(const Value: TScopeItem);
  procedure SubItemsOnChange (sender : TObject);
  function GetCurrentID: Integer;

protected
  dontRefreshOnSetText : boolean;
  procedure AssignTo (dest : TPersistent); override;


public
  constructor Create (ACollection : TCollection); override;
  destructor Destroy; override;
  procedure SetCurrentViewIdx (value : Integer);
  property SubItems : TStrings read FSubItems;
  property ScopeItem : TScopeItem read GetScopeItem write SetScopeItem;
  procedure Refresh;
  property Selected : boolean read GetSelected write SetSelected;
  property Focused : boolean read GetFocused write SetFocused;
  property ItemID [viewIdx : Integer] : Integer read GetItemID write SetItemID;
  property CurrentID : Integer read GetCurrentID;

published
  property Text : string read FText write SetText;
  property ImageIndex : Integer read FImageIndex write SetImageIndex default -1;
end;

TResultItems = class (TOwnedCollection)
private
  fOwnerItemCount : Integer;
  function GetItem(i: Integer): TResultItem;
  function GetScopeItem: TScopeItem;
  function GetCount: Integer;
  procedure SetCount(const Value: Integer);
protected
  procedure Update(Item: TCollectionItem); override;
public
  property Items [i : Integer] : TResultItem read GetItem; default;
  property Count : Integer read GetCount write SetCount;
  function Add : TResultItem;
  property ScopeItem : TScopeItem read GetScopeItem;
  procedure Assign (source : TPersistent); override;
published
end;

TSnapinToolbarActionLink = class(TActionLink)
protected
  FClient: TSnapinToolbarButton;
  procedure AssignClient(AClient: TObject); override;
  function IsCaptionLinked: Boolean; override;
  function IsEnabledLinked: Boolean; override;
  function IsHintLinked: Boolean; override;
  function IsImageIndexLinked: Boolean; override;
  function IsVisibleLinked: Boolean; override;
  function IsOnExecuteLinked: Boolean; override;
  procedure SetCaption(const Value: string); override;
  procedure SetEnabled(Value: Boolean); override;
  procedure SetHint(const Value: string); override;
  procedure SetImageIndex(Value: Integer); override;
  procedure SetVisible(Value: Boolean); override;
  procedure SetOnExecute(Value: TNotifyEvent); override;
end;

TSnapinToolbarButton = class (TCollectionItem)
private
  FWrap: boolean;
  FVisible: boolean;
  FEnabled: boolean;
  FImageIndex: Integer;
  FCaption: string;
  FHint: string;
  FActionLink: TSnapinToolbarActionLink;
  FOnClick: TNotifyEvent;
  FCommand : word;
  procedure DoActionChange(Sender: TObject);

  procedure SetAction(const Value: TBasicAction);
  procedure SetCaption(const Value: string);
  procedure SetEnabled(const Value: boolean);
  procedure SetHint(const Value: string);
  procedure SetImageIndex(const Value: Integer);
  procedure SetVisible(const Value: boolean);
  procedure SetWrap(const Value: boolean);
  function GetAction: TBasicAction;
  function IsCaptionStored: Boolean;
  function IsEnabledStored: Boolean;
  function IsHintStored: Boolean;
  function IsImageIndexStored: Boolean;
  function IsVisibleStored: Boolean;
  function IsOnClickStored: Boolean;
protected
  property ActionLink: TSnapinToolbarActionLink read FActionLink write FActionLink;
  procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); dynamic;
public
  constructor Create (ACollection : TCollection); override;
  destructor Destroy; override;
  procedure Click; virtual;
  property Command : word read FCommand;
published
  property Caption : string read FCaption write SetCaption stored IsCaptionStored;
  property Enabled : boolean read FEnabled write SetEnabled stored IsEnabledStored default True;
  property Visible : boolean read FVisible write SetVisible stored IsVisibleStored default True;
  property Wrap : boolean read FWrap write SetWrap;
  property ImageIndex : Integer read FImageIndex write SetImageIndex stored IsImageIndexStored default -1;
  property Action : TBasicAction read GetAction write SetAction;
  property Hint : string read FHint write SetHint stored IsHintStored;

  property OnClick : TNotifyEvent read FOnClick write FOnClick stored IsOnClickStored;
end;

TSnapinToolbarButtons = class (TOwnedCollection)
private
  function GetItem(i: Integer): TSnapinToolbarButton;
public
  property Items [i : Integer] : TSnapinToolbarButton read GetItem; default;
  function Add : TSnapinToolbarButton;
  function DispatchCommand(ACommand: Word): Boolean;
published
end;

TSnapinMenuButton = class (TComponent)
end;

implementation

uses Snapins;

var
  ButtonCommandPool : TBits = Nil;

{ TSnapinData }

constructor TSnapinData.Create (aOwner : TComponent);
var
  inst : THandle;
begin
  inherited Create (aOwner);
  FScopeItem := TScopeItem.Create (TCollection (self));
  if csDesigning in ComponentState then
    inst := HInstance
  else
    inst := FindHInstance (aOwner.ClassType);
  try
    FVersionInfo := TVersionInfo.Create (inst);
  except
    FVersionInfo := Nil
  end
end;

procedure TSnapinData.Notification(AComponent: TComponent; Operation: TOperation);
  procedure CheckContextMenus(SItem: TScopeItem);
  var
    i: integer;
  begin
    if SItem.ContextMenu = AComponent then
      SItem.ContextMenu := nil;

    if SItem.ResultItemsContextMenu = AComponent then
      SItem.ResultItemsContextMenu := nil;

    for i := 0 to SItem.ScopeItems.Count - 1 do
      CheckContextMenus(SItem.ScopeItems[i]);
  end;

begin
  if (Operation = opRemove) and (AComponent <> nil) then
    if AComponent = ScopeLargeImages then
      ScopeLargeImages := nil
    else
      if AComponent = ScopeSmallImages then
        ScopeSmallImages := nil
      else
        if AComponent = ResultLargeImages then
          ResultLargeImages := nil
        else
          if AComponent = ResultSmallImages then
            ResultSmallImages := nil
          else
            CheckContextMenus(ScopeItem);
  inherited;
end;

destructor TSnapinData.Destroy;
begin
  FScopeItem.Free;
  FVersionInfo.Free;
  inherited Destroy
end;

procedure TSnapinData.HelpCommand;
begin
  if Assigned (FOnHelp) then
    OnHelp (self);
end;

procedure TSnapinData.SetParent(const Value: TObject);
begin
  FParent := Value as TSnapinComponentData;
end;

procedure TSnapinData.SetScopeSmallImages(const Value: TImageList);
var
  parent : TSnapinComponentData;
begin
  FScopeSmallImages := Value;
  parent := TSnapinComponentData (fParent);
  if Assigned (parent) then
    parent.SetScopeImages
end;

procedure TSnapinData.SetScopeLargeImages(const Value: TImageList);
var
  parent : TSnapinComponentData;
begin
  FScopeLargeImages := Value;
  parent := TSnapinComponentData (fParent);
  if Assigned (parent) then
    parent.SetScopeImages
end;

procedure TSnapinData.SetResultLargeImages(const Value: TImageList);
begin
  FResultLargeImages := Value;
end;

procedure TSnapinData.SetResultSmallImages(const Value: TImageList);
begin
  FResultSmallImages := Value;
end;

function TSnapinData.GetHandle: HWND;
var
  parent : TSnapinComponentData;
begin
  parent := TSnapinComponentData (fParent);
  if Assigned (parent) then
    result := parent.WindowHandle
  else
    result := 0;
end;

function TSnapinData.GetProvider: string;
begin
  if Assigned (FVersionInfo) then
    result := FVersionInfo.KeyValue ['CompanyName']
  else
    result := ''
end;

function TSnapinData.GetDescription: string;
begin
  if Assigned (FVersionInfo) then
    result := FVersionInfo.KeyValue ['FileDescription']
  else
    result := ''
end;

function TSnapinData.GetFileVersion: string;
begin
  if Assigned (FVersionInfo) then
    result := FVersionInfo.KeyValue ['FileVersion']
  else
    result := ''
end;

function TSnapinData.GetProductName: string;
begin
  result := FVersionInfo.KeyValue ['ProductName'];
end;

function TSnapinData.GetSelected: TScopeItem;
begin
  result := TSnapinComponentData (Parent).SelectedScopeItem;
end;

function TSnapinData.GetFocusedResultItem: TResultItem;
begin
  result := TSnapinComponentData (Parent).FocusedResultItem;
end;

procedure TSnapinData.SetFocusedResultItem(const Value: TResultItem);
begin
  TSnapinComponentData (Parent).FocusItem (Value, True);
end;

procedure TSnapinData.SetSelected(const Value: TScopeItem);
begin
  TSnapinComponentData (Parent).SelectItem (value, True);
end;

{ TScopeItem }
constructor TScopeItem.Create (ACollection : TCollection);
begin
  if TObject (ACollection) is TSnapinData then // It's the root scope
  begin
    FSnapinData := TSnapinData (ACollection);
    ACollection := Nil
  end;

  if Assigned (ACollection) then                // It's not the root scope
  begin
    FParentToolbarButtons := True;
    FParentMainMenu := True;
    FParentMultiselectToolbarButtons := True;
    FParentMultiselectMainMenu := True;
    FSnapinData := TScopeItems (ACollection).FSnapinData
  end
  else
  begin                                         // It's the root scope.
    FParentToolbarButtons := False;
    FParentMultiselectToolbarButtons := False;
    FParentMultiselectMainMenu := False;
    FParentMainMenu := False
  end;

  FSubItems := TStringList.Create;
  TStringList (FSubItems).OnChange := SubItemsOnChange;
  FImageIndex := -1;
  FOpenImageIndex := -1;
  FMultiSelect := True;
  fRefreshEnabled := True;
  FAllowMultiSelectResultProperties := True;
  FColumns := TSnapinColumns.Create (self, TSnapinColumn);
  FScopeItems := TScopeItems.Create (self, TScopeItem);
  FResultItems := TResultItems.Create (self, TResultItem);
  FScopeItems.fSnapinData := FSnapinData;
  FToolbarButtons := TSnapinToolbarButtons.Create (self, TSnapinToolbarButton);
  FMultiselectToolbarButtons := TSnapinToolbarButtons.Create (self, TSnapinToolbarButton);
  inherited Create (ACollection);
end;

procedure TScopeItem.DeleteChildren;
begin
  fHasChildren := False;
  FScopeItems.Clear
end;

destructor TScopeItem.Destroy;
begin
  FSubItems.Free;
  inherited Destroy
end;

function TScopeItem.GetHasChildren: Boolean;
begin
  result := FHasChildren or (FScopeItems.Count > 0)
end;

function TScopeItem.GetViewType: TViewType;
begin
  if FGUIDValid then
    result := vtGUID
  else
    if FViewTypeHTML <> '' then
      result := vtHTML
    else
      result := vtListView
end;

procedure TScopeItem.SetHasChildren(const Value: Boolean);
begin
  if value <> HasChildren then
    FHasChildren := True;
end;

procedure TScopeItem.SetColumns(const Value: TSnapinColumns);
begin
  FColumns := Value;
end;

procedure TScopeItem.SetContextMenu(const Value: TPopupMenu);
begin
  FContextMenu := Value;
end;

procedure TScopeItem.SetResultItemsContextMenu(const Value: TPopupMenu);
begin
  FResultItemsContextMenu := Value;
end;

procedure TScopeItem.SetRefreshEnabled(const Value: boolean);
begin
  FRefreshEnabled := Value;
  if FRefreshEnabled then
    Refresh (False )
end;

procedure TScopeItem.SetData(const Value: pointer);
begin
  FData := Value;
end;

procedure TScopeItem.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
  if not (csLoading in SnapinData.ComponentState) then
    Refresh (False)  
end;

procedure TScopeItem.SetText(const Value: string);
begin
  if fText <> Value then
  begin
    fText := Value;
    if not (csLoading in SnapinData.ComponentState) then
      Refresh (False)
  end
end;

procedure TScopeItem.SetViewTypeGUID(const Value: string);
begin
  FGUIDValid := True;
  FViewTypeGUID := Value;
  FViewTypeHTML := '';
end;

procedure TScopeItem.SetViewTypeHTML(const Value: string);
begin
  FViewTypeHTML := Value;
  FGUIDValid := False
end;

procedure TScopeItem.AssignTo(dest: TPersistent);
var
  dst : TScopeITem;
begin
  if dest is TScopeItem then
  begin
    dst := TScopeItem (dest);

    dst.Collection.BeginUpdate;
    try
      dst.fText := fText;
      dst.FData := fData;
      dst.FSnapinData := FSnapinData;
      dst.FHasChildren := FhasChildren;
      dst.FViewTypeHTML := FViewTypeHTML;
      dst.FViewTypeGUID := FViewTypeGUID;
      dst.FGUIDValid := FGUIDValid;
      dst.FImageIndex := FImageIndex;
      dst.FOpenImageIndex := FOpenImageIndex;
      dst.FColumns.Assign(FColumns);

      dst.FContextMenu := FContextMenu; // Don't assign
      dst.FResultItemsContextMenu := FResultItemsContextMenu;
      dst.FResultItemsMultiselectContextMenu := FResultItemsMultiselectContextMenu;

      dst.FResultItems.Assign(FResultItems);
      dst.FSubItems.Assign (FSubItems);

      dst.FToolbarButtons.Assign(FToolbarButtons);
      dst.FParentToolbarButtons := FParentToolbarButtons;
      dst.FMultiselectToolbarButtons.Assign(FMultiselectToolbarButtons);
      dst.FParentMultiselectToolbarButtons := FParentMultiselectToolbarButtons;

//      dst.FItemID := FItemID; Don't assign - dynamic.

      dst.FParentMainMenu := FParentMainMenu;
      dst.FMainMenu := FMainMenu; // Don't assign
      dst.FParentMultiSelectMainMenu := FParentMultiSelectMainMenu;
      dst.FMultiSelectMainMenu := FMultiSelectMainMenu; // Don't assign

      dst.FOldMainMenuOnChange := FOldMainMenuOnChange;
      dst.FMultiSelect := FMultiSelect;
      dst.FOnOwnerData := FOnOwnerData;
      dst.FOnResultDblClick := FOnResultDblClick;
      dst.FOnResultDelete := FOnResultDelete;
      dst.FOnResultProperties := FOnResultProperties;
      dst.FOnResultRename := FOnResultRename;
      dst.fOnScopeProperties := FOnScopeProperties;
      dst.fOnInitOCX := FOnInitOCX;
      dst.fOnScopeRename := FOnScopeRename;
      dst.fOnScopeDelete := FOnScopeDelete;
      dst.FOnResultPrint := FOnResultPrint;
      dst.FOnResultRefresh := FOnResultRefresh;
      dst.fCanCopy := fCanCopy;
      dst.fCanCopyResult := fCanCopyResult;
      dst.FOnPasteQuery := fOnPasteQuery;
      dst.FOnPaste := fOnPaste;
      dst.FOnScopeRefresh := FOnScopeRefresh;
    finally
      dst.Collection.EndUpdate
    end
  end
end;

function TScopeItem.GetOwner: TPersistent;
begin
  result := FSnapinData;
end;

procedure TScopeItem.HelpCommand;
begin
 if Assigned (fSnapinData.FOnHelp) then
   fSnapinData.OnHelp (self);
end;

procedure TScopeItem.Refresh (columnsChanged : boolean);
var
  parent : TSnapinComponentData;
begin
  if not Assigned (Collection) or (TScopeItems (Collection).UpdateCount = 0) then
  begin
    parent := TSnapinComponentData (SnapinData.Parent);

    if Assigned (parent) then
      parent.Update (Self, columnsChanged)
  end
end;

function TScopeItem.GetText: string;
begin
  result := fText;
end;

procedure TScopeItem.SetOpenImageIndex(const Value: Integer);
begin
  FOpenImageIndex := Value;
end;

function TScopeItem.AreToolbarButtonsStored: Boolean;
begin
  result := not ParentToolbarButtons;
end;

procedure TScopeItem.SetParentToolbarButtons(const Value: boolean);
begin
  if FParentToolbarButtons <> Value then
  begin
    if (not Value) or (FToolbarButtons.Count = 0) then
      FParentToolbarButtons := Value;
  end;
end;

procedure TScopeItem.SetToolbarButtons(const Value: TSnapinToolbarButtons);
begin
  FToolbarButtons := Value;
  if Value.Count > 0 then
    FParentToolbarButtons := False;
end;

function TScopeItem.GetParent: TScopeItem;
begin
  if Collection = Nil then
    result := Nil
  else
    result := TScopeItems (Collection).Owner as TScopeItem;

end;

function TScopeItem.IsMainMenuStored: Boolean;
begin
  result := not ParentMainMenu
end;

procedure TScopeItem.SetMainMenu(const Value: TMainMenu);
begin
  FMainMenu := Value;
  if value <> Nil then
  begin
    FOldMainMenuOnChange := FMainMenu.OnChange;
    FMainMenu.OnChange := MainMenuOnChange;
    FParentMainMenu := False;
  end
end;

procedure TScopeItem.SetParentMainMenu(const Value: boolean);
begin
  if Value <> FParentMainMenu then
    if (not Value) or (not Assigned (FMainMenu)) then
      FParentMainMenu := Value;
end;

procedure TScopeItem.MainMenuOnChange(Sender: TObject; Source: TMenuItem;
  Rebuild: Boolean);
var
  i : Integer;
  parent : TSnapinComponentData;
begin
  parent := TSnapinComponentData (SnapinData.Parent);
  if Assigned (parent) then
    for i := 0 to MainMenu.Items.Count - 1 do
      parent.UpdateMenuItem (MainMenu.Items [i]);

  if Assigned (FOldMainMenuOnChange) then
    FOldMainMenuOnChange (sender, source, rebuild);
end;

function TScopeItem.GetSelected: boolean;
begin
  result := SnapinData.Selected = self;
end;

procedure TScopeItem.SetSelected(const Value: boolean);
var
  parent : TSnapinComponentData;
begin
  parent := TSnapinComponentData (SnapinData.Parent);
  parent.SelectItem (self, value)
end;

procedure TScopeItem.Collapse;
var
  parent : TSnapinComponentData;
begin
  parent := TSnapinComponentData (SnapinData.Parent);
  parent.ExpandItem (self, False)
end;

procedure TScopeItem.Expand;
var
  parent : TSnapinComponentData;
begin
  parent := TSnapinComponentData (SnapinData.Parent);
  parent.ExpandItem (self, True)
end;

procedure TScopeItem.SubItemsOnChange(sender: TObject);
begin
  Refresh (False);
end;

procedure TScopeItem.SetResultItemsMultiselectContextMenu(
  const Value: TPopupMenu);
begin
  FResultItemsMultiselectContextMenu := Value;
end;

function TScopeItem.AreMultiselectToolbarButtonsStored: Boolean;
begin
  result := not ParentMultiselectToolbarButtons;
end;

function TScopeItem.IsMultiselectMainMenuStored: Boolean;
begin
  result := not ParentMultiselectMainMenu
end;

procedure TScopeItem.SetMultiselectMainMenu(const Value: TMainMenu);
begin
  FMultiselectMainMenu := Value;
  if value <> Nil then
  begin
    FOldMultiselectMainMenuOnChange := FMultiselectMainMenu.OnChange;
    FMultiselectMainMenu.OnChange := MultiSelectMainMenuOnChange;
    FParentMultiselectMainMenu := False;
  end
end;

procedure TScopeItem.SetMultiselectToolbarButtons(
  const Value: TSnapinToolbarButtons);
begin
  FMultiselectToolbarButtons := Value;
  if Value.Count > 0 then
    FParentMultiselectToolbarButtons := False;
end;

procedure TScopeItem.SetParentMultiselectMainMenu(const Value: boolean);
begin
  if Value <> FParentMultiSelectMainMenu then
    if (not Value) or (not Assigned (FMultiSelectMainMenu)) then
      FParentMultiSelectMainMenu := Value;
end;

procedure TScopeItem.SetParentMultiselectToolbarButtons(
  const Value: boolean);
begin
  if FParentMultiSelectToolbarButtons <> Value then
  begin
    if (not Value) or (FMultiSelectToolbarButtons.Count = 0) then
      FParentMultiSelectToolbarButtons := Value;
  end;
end;

procedure TScopeItem.MultiselectMainMenuOnChange(Sender: TObject;
  Source: TMenuItem; Rebuild: Boolean);
var
  i : Integer;
  parent : TSnapinComponentData;
begin
  parent := TSnapinComponentData (SnapinData.Parent);
  if Assigned (parent) then
    for i := 0 to MultiselectMainMenu.Items.Count - 1 do
      parent.UpdateMenuItem (MultiselectMainMenu.Items [i]);

  if Assigned (FOldMultiselectMainMenuOnChange) then
    FOldMultiselectMainMenuOnChange (sender, source, rebuild);
end;

{ TSnapinColumn }

procedure TSnapinColumn.AssignTo(dest: TPersistent);
var
  dst : TSnapinColumn;
begin
  if dest is TSnapinColumn then
  begin
    dst := TSnapinColumn (dest);

    dst.FWidth := FWidth;
    dst.FCaption := FCaption;
    dst.FAlignment := FAlignment
  end

end;

constructor TSnapinColumn.Create(ACollection: TCollection);
begin
  inherited Create (ACollection);
  FWidth := 100
end;

procedure TSnapinColumn.Refresh;
begin
  if TSnapinColumns (Collection).UpdateCount = 0 then
    TSnapinColumns (Collection).Update (self);
end;

procedure TSnapinColumn.SetAlignment(const Value: TAlignment);
begin
  FAlignment := Value;
  Refresh;
end;

procedure TSnapinColumn.SetCaption(const Value: string);
begin
  FCaption := Value;
  Refresh
end;

procedure TSnapinColumn.SetWidth(const Value: Integer);
begin
  FWidth := Value;
  Refresh
end;

{ TSnapinColumns }

function TSnapinColumns.Add: TSnapinColumn;
begin
  result := inherited Add as TSnapinColumn

end;

constructor TSnapinColumns.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  fOwner := TScopeItem (AOwner);
  inherited Create (AOwner, ItemClass);
end;

function TSnapinColumns.GetItem(i: Integer): TSnapinColumn;
begin
  result := inherited Items [i] as TSnapinColumn;
end;

procedure TSnapinColumns.Update(Item: TCollectionItem);
begin
  fOwner.Refresh (True)
end;

{ TScopeItems }

constructor TScopeItems.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  fOwner := TScopeItem (AOwner);
  inherited Create (AOwner, ItemClass);
end;

function TScopeItems.Add: TScopeItem;
begin
  result := inherited Add as TScopeItem;
end;

function TScopeItems.GetItem(i: Integer): TScopeItem;
begin
  result := inherited Items [i] as TScopeItem;
end;

procedure TScopeItems.Update(Item: TCollectionItem);
var
  parent : TSnapinComponentData;
begin
  if Owner = Nil then
  begin
    parent := TSnapinComponentData (SnapinData.Parent);
    if Assigned (parent) then
      parent.Update (Item, True);
  end
  else
    (Owner as TScopeItem).Refresh (True);
end;

{ TResultItem }

procedure TResultItem.AssignTo(dest: TPersistent);
var
 dst : TResultItem;
begin
  if dest is TResultItem then
  begin
    dst := TResultItem (dest);

    dst.FText := FText;
    dst.FSubItems.Assign (FSubItems);
    dst.FImageIndex := FImageIndex;
    dst.FOwnerDataScopeItem := FOwnerDataScopeItem
  end
end;

constructor TResultItem.Create(ACollection: TCollection);
begin
  inherited Create (ACollection);
  FSubItems := TStringList.Create;
  TStringList (FSubItems).OnChange := SubItemsOnChange;
  FImageIndex := -1;
  SetLength (fItemID, 0);
end;

destructor TResultItem.Destroy;
begin
  FSubItems.Free;
  inherited Destroy;
end;

function TResultItem.GetCurrentID: Integer;
begin
  result := fItemID [fCurrentViewIdx];
end;

function TResultItem.GetFocused: boolean;
begin
  result := (TSnapinComponentData (ScopeItem.SnapinData.Parent).ResultItemState (self) and LVIS_FOCUSED) <> 0
end;

function TResultItem.GetItemID(viewIdx: Integer): Integer;
begin
  if viewIdx = -1 then
    viewIdx := TSnapinComponentData (ScopeItem.SnapinData.Parent).ActiveView;

  if viewIdx < Length (fItemID) then
    result := fItemID [viewIdx]
  else
    result := 0
end;

function TResultItem.GetScopeItem: TScopeItem;
begin
  if Assigned (Collection) then
    result := (Collection as TResultItems).ScopeItem
  else
    result := fOwnerDataScopeItem
end;

function TResultItem.GetSelected: boolean;
begin
  result := (TSnapinComponentData (ScopeItem.SnapinData.Parent).ResultItemState (self) and LVIS_SELECTED) <> 0
end;

procedure TResultItem.Refresh;
var
  parent : TSnapinComponentData;
begin
  if Assigned (Collection) then
    if TResultItems (Collection).UpdateCount = 0 then
    begin
      parent := TSnapinComponentData (ScopeItem.SnapinData.fParent);
      if Assigned (parent) then
        parent.Update (Self, False)
    end
end;

procedure TResultItem.SetCurrentViewIdx(value: Integer);
begin
  fCurrentViewIdx := value
end;

procedure TResultItem.SetFocused(const Value: boolean);
begin
  TSnapinComponentData (ScopeItem.SnapinData.Parent).FocusItem (self, value)
end;

procedure TResultItem.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
  Refresh;
end;

procedure TResultItem.SetItemID(viewIdx: Integer; const Value: Integer);
begin
  if viewIdx = -1 then
    viewIdx := TSnapinComponentData (ScopeItem.SnapinData.Parent).ActiveView;

  if viewIdx >= Length (fItemID) then
    SetLength (fItemID, Length (fItemID) + 10);

  fItemID [viewIdx] := Value
end;

procedure TResultItem.SetScopeItem(const Value: TScopeItem);
begin
  if Assigned (Collection) then
    raise Exception.Create ('Not in ''Owner Data'' mode')
  else
    fOwnerDataScopeItem := Value
end;

procedure TResultItem.SetSelected(const Value: boolean);
begin
  TSnapinComponentData (ScopeItem.SnapinData.Parent).SelectItem (self, value)
end;

procedure TResultItem.SetText(const Value: string);
begin
  FText := Value;
  if not dontRefreshOnSetText then
    Refresh
end;

procedure TResultItem.SubItemsOnChange(sender: TObject);
begin
  Refresh
end;

{ TResultItems }

function TResultItems.Add: TResultItem;
begin
  result := inherited Add as TResultItem;
end;

procedure TResultItems.Assign(source: TPersistent);
begin
  inherited;

  if source is TResultItems then
    fOwnerItemCount := TResultItems (source).fOwnerItemCount
end;

function TResultItems.GetCount: Integer;
begin
  if Assigned (ScopeItem.OnOwnerData) then
    result := fOwnerItemCount
  else
    result := inherited Count;
end;

function TResultItems.GetItem(i: Integer): TResultItem;
begin
  result := inherited Items [i] as TResultItem;
end;

function TResultItems.GetScopeItem: TScopeItem;
begin
  result := GetOwner as TScopeItem
end;

procedure TResultItems.SetCount(const Value: Integer);
begin
  if Assigned (ScopeItem.fOnOwnerData) then
  begin
    if fOwnerItemCount <> value then
    begin
      fOwnerItemCount := value;
      Update (Nil)
    end
  end
  else
    raise Exception.Create ('Not in ''Owner Data'' mode');
end;

procedure TResultItems.Update(Item: TCollectionItem);
begin
  ScopeItem.Refresh (False);
end;

{ TSnapinToolbarButton }

procedure TSnapinToolbarButton.ActionChange(Sender: TObject;
  CheckDefaults: Boolean);
begin
  if Action is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Caption = '') then
        Self.Caption := Caption;
      if not CheckDefaults or (Self.Enabled = True) then
        Self.Enabled := Enabled;
      if not CheckDefaults or (Self.Hint = '') then
        Self.Hint := Hint;
      if not CheckDefaults or (Self.ImageIndex = -1) then
        Self.ImageIndex := ImageIndex;
      if not CheckDefaults or (Self.Visible = True) then
        Self.Visible := Visible;
      if not CheckDefaults or not Assigned(Self.OnClick) then
        Self.OnClick := OnExecute;
    end;
end;

procedure TSnapinToolbarButton.Click;
begin
  if Enabled then
  begin
    if Assigned(FOnClick) and (Action <> nil) and (@FOnClick <> @Action.OnExecute) then
      FOnClick(Self)
    else if (ActionLink <> nil) then
      FActionLink.Execute
    else if Assigned(FOnClick) then
      FOnClick(Self);
  end;
end;

constructor TSnapinToolbarButton.Create(ACollection: TCollection);
begin
  inherited Create (ACollection);
  FCommand := ButtonCommandPool.OpenBit;
  ButtonCommandPool [FCommand] := True;

  FEnabled := True;
  FVisible := True;
  FImageIndex := -1;
end;

destructor TSnapinToolbarButton.Destroy;
begin
  ButtonCommandPool [FCommand] := False;
  inherited;
end;

procedure TSnapinToolbarButton.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

function TSnapinToolbarButton.GetAction: TBasicAction;
begin
  if FActionLink <> nil then
    Result := FActionLink.Action else
    Result := nil;
end;

function TSnapinToolbarButton.IsCaptionStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsCaptionLinked;
end;

function TSnapinToolbarButton.IsEnabledStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsEnabledLinked;
end;

function TSnapinToolbarButton.IsHintStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHintLinked;
end;

function TSnapinToolbarButton.IsImageIndexStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsImageIndexLinked;
end;

function TSnapinToolbarButton.IsOnClickStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsOnExecuteLinked;
end;

function TSnapinToolbarButton.IsVisibleStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsVisibleLinked;
end;

procedure TSnapinToolbarButton.SetAction(const Value: TBasicAction);
begin
  if Value = nil then
  begin
    FActionLink.Free;
    FActionLink := nil;
  end
  else
  begin
    if FActionLink = nil then
      FActionLink := TSnapinToolbarActionLink.Create(Self);
    FActionLink.Action := Value;
    FActionLink.OnChange := DoActionChange;
    ActionChange(Value, csLoading in Value.ComponentState);
  end;
end;

procedure TSnapinToolbarButton.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure TSnapinToolbarButton.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
end;

procedure TSnapinToolbarButton.SetHint(const Value: string);
begin
  FHint := Value;
end;

procedure TSnapinToolbarButton.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
end;

procedure TSnapinToolbarButton.SetVisible(const Value: boolean);
begin
  FVisible := Value;
end;

procedure TSnapinToolbarButton.SetWrap(const Value: boolean);
begin
  FWrap := Value;
end;

{ TSnapinToolbarActionLink }

procedure TSnapinToolbarActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TSnapinToolbarButton
end;

function TSnapinToolbarActionLink.IsCaptionLinked: Boolean;
begin
  Result := inherited IsCaptionLinked and
            AnsiSameCaption(FClient.Caption, (Action as TCustomAction).Caption);
end;

function TSnapinToolbarActionLink.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
    (FClient.Enabled = (Action as TCustomAction).Enabled);
end;

function TSnapinToolbarActionLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and
    (FClient.Hint = (Action as TCustomAction).Hint);
end;

function TSnapinToolbarActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FClient.ImageIndex = (Action as TCustomAction).ImageIndex);
end;

function TSnapinToolbarActionLink.IsOnExecuteLinked: Boolean;
begin
  Result := inherited IsOnExecuteLinked and
    (@FClient.OnClick = @Action.OnExecute);
end;

function TSnapinToolbarActionLink.IsVisibleLinked: Boolean;
begin
  Result := inherited IsVisibleLinked and
    (FClient.Visible = (Action as TCustomAction).Visible);
end;

procedure TSnapinToolbarActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FClient.Caption := Value;
end;

procedure TSnapinToolbarActionLink.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

procedure TSnapinToolbarActionLink.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

procedure TSnapinToolbarActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then FClient.ImageIndex := Value;
end;

procedure TSnapinToolbarActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then FClient.OnClick := Value;
end;

procedure TSnapinToolbarActionLink.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := Value;
end;

{ TSnapinToolbarButtons }

function TSnapinToolbarButtons.Add: TSnapinToolbarButton;
begin
  result := inherited Add as TSnapinToolbarButton
end;

function TSnapinToolbarButtons.DispatchCommand(ACommand: Word): Boolean;
var
  Item: TSnapinToolbarButton;
  i : Integer;
begin
  Result := False;
  for i := 0 to Count - 1 do
  begin
    Item := TSnapinToolbarButton (Items [i]);
    if Item.Command = ACommand then
    begin
      item.Click;
      result := True;
      break
    end
  end
end;

function TSnapinToolbarButtons.GetItem(i: Integer): TSnapinToolbarButton;
begin
  result := inherited Items [i] as TSnapinToolbarButton;
end;

initialization
  ButtonCommandPool := TBits.Create;
finalization
  ButtonCommandPool.Free;
end.
