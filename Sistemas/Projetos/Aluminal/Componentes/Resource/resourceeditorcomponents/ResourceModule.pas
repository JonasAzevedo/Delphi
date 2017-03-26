(*===========================================================================*
 | unit ResourceModule                                                       |
 |                                                                           |
 | Version  Date      By    Description                                      |
 | -------  --------  ----  -------------------------------------------------|
 | 1.0      24/11/98  CPWW  Original                                         |
 *===========================================================================*)

unit ResourceModule;

interface

{$DEFINE GRAPHICSRESOURCES}

uses
  Windows, Messages, SysUtils, Classes, mmsystem, contnrs;

const
  RT_DLGINIT = (PChar ($f0));
  RT_TOOLBAR = (PChar ($f1));

resourcestring
  rstTextFilter = 'Text files (*.txt)|*.txt';
  rstRCFilter = 'Resource files (*.rc)|*.rc';
  rstBadResourceID = 'String, Icon && Cursor resources must have numeric IDs';

type
  TResourceModule = class;

  TUndoEntry = class
  private
    fDescription : string;
    fData : TMemoryStream;
    fResName : string;
    fLangId : Integer;

  public
    constructor Create (const ADescription : string; AData : TMemoryStream; const AResName : string; ALangID : Integer);
    destructor Destroy; override;

    property Description : string read fDescription;
    property Data : TMemoryStream read fData;
  end;

//=============================================================================
// TResource class.  Encapsulates a resource

  TResource = class
  private
    fParent : TResourceModule;              // Parent resource module.
    fName : PWideChar;                      // Name or MakeIntResource name
    fData : TMemoryStream;                  // Data for the resource
    fLang : word;                           // Language ID
    fMemoryFlags : word;                    // Resource memory flags
    fDataVersion, fVersion : DWORD;         // Resource header version info
    fCharacteristics : DWORD;               // Resource header characteristics

    fCustomType : PWideChar;                // 0        = Type implicit in class (see RType)
                                            //            Used for standard resources.
                                            // <= $ffff = Cardinal resource type
                                            // > $ffff  = string resource type - eg. 'AVI'

    fUndoStack : TObjectStack;
    fRedoStack : TObjectStack;

    function GetResourceTypeName: string;   // 'Get' method for ResourceTypeName property

    procedure SetLang(const Value: word);
    function GetDirty: boolean;
    function GetCanRedo: boolean;
    procedure InternalSetResourceName (const value : string);
  protected
    constructor Create (AParent : TResourceModule; AName : PWideChar; ADataLen :  Integer; AData : pointer; ACustomType : PWideChar = Nil); overload; virtual;
    class function GetResourceTypeClass : string; virtual;
                                                      // Returns the resource type name

    function GetResourceName : string; virtual;      // 'Get' method for ResourceName property
    procedure SetResourceName(const Value: string); virtual;
    procedure ReloadResourceData; virtual;
  public
    destructor Destroy; override;

    class function GetResourceType : word; virtual;   // Return the resource type - or 0 for unsupported
    function RequireNumericID : boolean; virtual;
    property Parent : TResourceModule read fParent;
    property ResourceName : string read GetResourceName write SetResourceName;
    property ResourceTypeName : string read GetResourceTypeName;
    property Data : TMemoryStream read fData;
    property Language : word read fLang write SetLang;

    property RawName : PWideChar read fName;
    property RawType : word read GetResourceType;
    property Dirty : boolean read GetDirty;
    property CanRedo : boolean read GetCanRedo;

    procedure AddUndoEntry (const description : string);
    procedure NotifyChange; virtual;
    procedure Undo; virtual;
    procedure Redo; virtual;
    procedure ClearUndoStack;
    function GetLastUndoDescription : string;
    function GetLastRedoDescription : string;
  end;

  TResourceClass = class of TResource;

//=============================================================================
// TWriteableResource class.  Derived from TResource, but has extra support for
// creating new resources.

  TWriteableResourceStyle = (wsExportable, wsSnippetable);
  TWriteableResourceStyles = set of TWriteableResourceStyle;

  TWriteableResource = class (TResource)
  private

  protected
    procedure ExportToStream (stream : TStream; const ext : string); virtual;
    procedure ExportRCSnippetToStream (stream : TStream); virtual;
    function GetWriteableResourceStyles: TWriteableResourceStyles; virtual;
                                           // Initialize new resource - called by alternative constructor
  public
    class function GetFilter: string; virtual;
    property Style : TWriteableResourceStyles read GetWriteableResourceStyles;
                                           // Alternative constructor for creating new resources
    constructor Create (AParent : TResourceModule; AName : PWideChar;  ACustomType : PWideChar = Nil); overload; virtual;
    procedure Initialize; virtual;
    procedure InitializeFromFile (const fileName : string); virtual;
    procedure ExportResource (const FileName : string);
    procedure ExportResourceSnippet (const FileName : string);
    property Filter : string read GetFilter;
  end;

  TWriteableResourceClass = class of TWriteableResource;

  TAcceleratorResource = class (TWriteableResource)
  protected
    class function GetResourceTypeClass : string; override;
    procedure ExportToStream (stream : TStream; const ext : string); override;
  public
    class function GetResourceType : word; override;
  end;

//=============================================================================
// TRCDataResource class.  Encapsulates RC Data resources

  TRCDataResource = class (TWriteableResource)
  protected
    class function GetResourceTypeClass : string; override;
  public
    class function GetResourceType : word; override;
  end;

//=============================================================================
// TPackageResource class.  Encapsulates Delphi package RC Data resources

  TPackageResource = class (TRCDataResource)
  private
    fFlags : Integer;
    fRequiresList : TStringList;
    fContainsList : TStringList;
    constructor Create (AParent : TResourceModule; ADataLen :  Integer; AData : pointer); overload;
    function GetRequiresCount : Integer;
    function GetContainsCount : Integer;
    function GetRequiresName (index : Integer) : string;
    function GetContainsName (index : Integer) : string;
    function GetContainsFlag(index: Integer): Byte;
    procedure SetFlags(const Value: Integer);
  protected
    procedure ReloadResourceData; override;
  public
    destructor Destroy; override;
    property Flags : Integer read fFlags write SetFlags;
    property RequiresCount : Integer read GetRequiresCount;
    property ContainsCount : Integer read GetContainsCount;

    property RequiresName [index : Integer] : string read GetRequiresName;
    property ContainsName [index : Integer] : string read GetContainsName;
    property ContainsFlag [index : Integer] : Byte read GetContainsFlag;
  end;

//=============================================================================
// TComponentResource class.  Encapsulates Delphi component RC Data resources

  TComponentResource = class (TRCDataResource)
  private
    fComponentText : TStringList;
  protected
  public
    constructor Create (AParent : TResourceModule; AName : PWideChar; ADataLen :  Integer; AData : pointer; ACustomType : PWideChar = Nil); override;
    destructor Destroy; override;
    property ComponentText : TStringList read fComponentText;
    procedure SetComponentText(const Value: TStrings);
    procedure NotifyChange; override;
  end;

//=============================================================================
// TDescriptionResource.  Encapsulates description RC Data resources

  TDescriptionResource = class (TRCDataResource)
  private
    function GetDescription: string;
    procedure SetDescription(const Value: string);
  public
    constructor Create (AParent : TResourceModule; ADataLen :  Integer; AData : pointer);
    property Description : string read GetDescription write SetDescription;
  end;

//=============================================================================
// TToolbarResource.  Encapsulates RT_TOOLBAR

  TToolbarResource = class (TResource)
  protected
    class function GetResourceTypeClass : string; override;
  public
    class function GetResourceType : word; override;
  end;

//=============================================================================
// TResourceModule.  Encapsulates a resource module.

  TResourceEvent = procedure (sender : TObject; resource : TResource) of object;
  TResourceModuleType = (rtResFile, rtModule);

  TResourceModule = class(TComponent)
  private
    fFileName : string;
    fModuleType : TResourceModuleType;     // .RES file or module (.DLL, .EXE, etc.)
    fResourceList : TList;                 // The module's resources

    fOnAddResource : TResourceEvent;       // Called when a resource is added to
                                           // the module

    fResourceType : PChar;                 // Contains the type of resource to enumerate.
                                           // Set this *before* setting the file name property.

    f16bit : boolean;
    fOnDeleteResource: TResourceEvent;
    fOnChangeResource: TResourceEvent;
    fResourceListChanged : boolean;

    procedure Open;                        // Open the module and load the resources.
    procedure Close;                       // Close the module and free the resources.


    procedure LoadResourceFile;            // Load the resource from a resource file
                                           // Load the resource from a module (eg. .EXE, .DLL, .OCX, .DCU)
    function LoadResourceFromModule (hModule : Integer; const resType, resName : PChar; language : word) : boolean;

                                           // Add a resource from a .res file to the list
    procedure ParseResource (header, data : PChar; dataSize : Integer);

                                           // Add a resource to the list of resources
    procedure AddToList (resource : TResource);
    procedure DoResourceChanged (resource : TResource);

                                           // Create a resource from resource data and add it to the list.
    function AddResourceToList (AType, AName : PWideChar; ADataLen :  Integer; AData : pointer; ALang : word) : TResource;

                                           // 'Set' method for the filename property
    procedure SetFileName (const value : string);

                                           // Get methods.
    function GetResourceCount : Integer;
    function GetResource (index : Integer) : TResource;

    function GetWriteableResourceName(index: Integer): string;
    function GetWriteableResourceClass(index: Integer): TWriteableResourceClass;
    function GetWriteableResourceCount: Integer;
    function GetChanged: boolean;
    function GetCanUpdateModule: boolean;

  protected
    { Protected declarations }
  public
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;

    property ModuleType : TResourceModuleType read fModuleType;
    property ResourceType : PChar read fResourceType write fResourceType;
    property ResourceCount : Integer read GetResourceCount;
    property Resource [index : Integer] : TResource read GetResource; default;

    procedure WriteResFile (const fileName : string);
    procedure UpdateModuleFile;

    property WriteableResourceCount : Integer read GetWriteableResourceCount;
    property WriteableResourceName [index : Integer] : string read GetWriteableResourceName;
    property WriteableResourceClass [index : Integer] : TWriteableResourceClass read GetWriteableResourceClass;

    property Changed : boolean read GetChanged write fResourceListChanged;
    property CanUpdateModule : boolean read GetCanUpdateModule;

    function GetUniqueResourceName (resClass : TResourceClass) : Integer;
    function IsUniqueResourceName (resClass : TResourceClass; nm : PWideChar) : boolean;
    function FindResource (resClass : TResourceClass; nm : PWideChar) : TResource;

  published
    property FileName : string read fFileName write SetFileName;
    property OnAddResource : TResourceEvent read fOnAddResource write fOnAddResource;
    property OnChangeResource : TResourceEvent read fOnChangeResource write fOnChangeResource;
    property OnDeleteResource : TResourceEvent read fOnDeleteResource write fOnDeleteResource;
  end;

procedure Register;
procedure RegisterWriteableResources (resources : array of TWriteableResourceClass);
function ResourceWideCharToStr(var wstr : PWideChar) : string;
procedure ResourceStrToWideChar (const s : string; var p : PWideChar);
function WStrNew (s : PWideChar) : PWideChar;
procedure WStrFree (s : PWideChar);

implementation

{$IFDEF GRAPHICSRESOURCES}
uses ResourceMessages, ResourceVersion, cmpRiffStream, ResourceRIFF, ResourceDialogs, ResourceGraphics, ResourceMenus;
{$ELSE}
uses ResourceMessages, ResourceVersion;
{$ENDIF}

//=============================================================================
// Resource strings
resourcestring
  rstUnknownResourceType = 'Unknown resource type - %8.8x';
  rstCantUpdateResource = 'The operating system does not support updating resources in modules';
  rstNoExportSnippet = 'The resource cannot be exported to a resource snippet';
  rstNoExport = 'The resource cannot be exported';

  rstAccelerator  = 'Accelerator';
  rstRCData       = 'RC Data';

  rstToolbar      = 'Toolbar';
  rstResourceNameChanged = 'change resource name';
  rstLanguageChanged = 'change resource language';
  rstDescriptionChanged = 'change description';
  rstComponentChanged = 'change component';
  rstFlagsChanged = 'change flags';

const
  FilerSignature : array[1..4] of Char = 'TPF0';

type
//=============================================================================
// TPackageInfoHeader resource structure
// From Delphi source...
PPackageInfoHeader = ^TPackageInfoHeader;
TPackageInfoHeader = packed record
  Flags: Integer;
  RequiresCount: Integer;
  {Requires: array[0..9999] of TPkgName;
  ContainsCount: Integer;
  Contains: array[0..9999] of TUnitName;}
end;

//=============================================================================
// TPkgName resource structure
// From Delphi source...
PPkgName = ^TPkgName;
TPkgName = packed record
  HashCode: Byte;
  Name: array[0..255] of Char;
end;

//=============================================================================
// TUnitName resource structure
// From Delphi source...
PUnitName = ^TUnitName;
TUnitName = packed record
  Flags : Byte;
  HashCode: Byte;
  Name: array[0..255] of Char;
end;

TfnBeginUpdateResource = function (pFileName: PChar; bDeleteExistingResources: BOOL): THandle; stdcall;
TfnEndUpdateResource = function (hUpdate : THandle; bDiscard : BOOL) : BOOL; stdcall;
TfnUpdateResourceW = function (hUpdate: THandle; lpType, lpName: PWideChar; wLanguage: Word; lpData: Pointer; cbData: DWORD): BOOL; stdcall;

//=============================================================================
// List of resource classes registered as being writable.  See the 'initialization'
// section.
var
  WriteableResourceList : TList;

  fnBeginUpdateResource : TfnBeginUpdateResource;
  fnEndUpdateResource : TfnEndUpdateResource;
  fnUpdateResourceW : TfnUpdateResourceW;

  g_bCanUpdateResource : boolean;

procedure Register;
begin
  RegisterComponents('Samples', [TResourceModule]);
end;

//=============================================================================
// Helper functions:

(*----------------------------------------------------------------------------*
 | function WStrNew ()                                                        |
 |                                                                            |
 | Copy a resource name or type string or MakeResourceInt pseudo string       |
 |                                                                            |
 | Parameters:                                                                |
 |   s : PWideString           The resource string to copy                    |
 |                                                                            |
 | The function returns the copy of the string.                               |
 *----------------------------------------------------------------------------*)
function WStrNew (s : PWideChar) : PWideChar;
begin
  if (Integer (s) and $ffff0000) <> 0 then
  begin                          // It's a genuine string - Duplicate it.
    GetMem (result, (lstrlenw (s) + 1) * sizeof (WideChar));
    lstrcpyw (result, s)
  end
  else                           // It's a pseudo string (or null).  Copy it.
    result := s
end;

(*----------------------------------------------------------------------------*
 | procedure WStrFree ()                                                      |
 |                                                                            |
 | Free a resource name or type string                                        |
 |                                                                            |
 | Parameters:                                                                |
 |   s : PWideString           The resource string to free                    |
 |                                                                            |
 | The function frees the string.                                             |
 *----------------------------------------------------------------------------*)
procedure WStrFree (s : PWideChar);
begin
  if (Integer (s) and $ffff0000) <> 0 then
    FreeMem (s)                  // Don't touch pseudo strings
end;

(*----------------------------------------------------------------------------*
 | procedure ResourceWideCharToStr ()                                                 |
 |                                                                            |
 | Copy an array of wide chartacers (not necessarily NULL terminated)         |
 |                                                                            |
 | Parameters:                                                                |
 |   WStr : PWChar             The characters                                 |
 |   Len : Integer             The number of characters.                      |
 *----------------------------------------------------------------------------*)
function ResourceWideCharToStr(var wstr : PWideChar) : string;
var
  len : word;
begin
  len := word (wstr^);
  SetLength (result, len);
  Inc (wstr);
  WideCharToMultiByte(CP_ACP, 0, WStr, Len, PChar (Result), Len + 1, nil, nil);
  Inc (wstr, len);
  result := PChar (result);
end;

(*----------------------------------------------------------------------------*
 | procedure ResourceStrToWideChar ()                                         |
 |                                                                            |
 | Copy a string to a (non-NULL terminated) array of Wide Chars               |
 |                                                                            |
 | Parameters:                                                                |
 |   s : string                The string                                     |
 |   var p : PWideChar         [in]  Points to the start of the receiving buf |
 |                             [out] Points after the characters.             |
 *----------------------------------------------------------------------------*)
procedure ResourceStrToWideChar (const s : string; var p : PWideChar);
var
  buffer : PWideChar;
  len, size : word;
begin
  len := Length (s);
  size := (Length (s) + 1) * sizeof (WideChar);
  GetMem (buffer, size);
  try
    MultiByteToWideChar (CP_ACP, 0, PChar (s), -1, buffer, size);
    p^ := WideChar (len);
    Inc (p);
    Move (buffer^, p^, len * sizeof (WideChar));
    Inc (p, len)
  finally
    FreeMem (buffer)
  end
end;

(*----------------------------------------------------------------------------*
 | function EnumResLangProc ()                                                |
 |                                                                            |
 | Callback for EnumResourceLanguages                                         |
 |                                                                            |
 | lParam contains the resource module instance.                              |
 *----------------------------------------------------------------------------*)
function EnumResLangProc (hModule : Integer; resType, resName : PChar; wIDLanguage : word; lParam : Integer) : BOOL; stdcall;
begin
  TResourceModule (lParam).LoadResourceFromModule (hModule, resType, resName, wIDLanguage);
  result := True
end;

(*----------------------------------------------------------------------------*
 | function EnumResNamesProc ()                                               |
 |                                                                            |
 | Callback for EnumResourceNames                                             |
 |                                                                            |
 | lParam contains the resource module instance.                              |
 *----------------------------------------------------------------------------*)
function EnumResNamesProc (hModule : Integer; resType, resName : PChar; lParam : Integer) : BOOL; stdcall;
begin
  if not EnumResourceLanguages (hModule, resType, resName, @EnumResLangProc, lParam) then
    RaiseLastWin32Error;
  result := True;
end;

(*----------------------------------------------------------------------------*
 | function EnumResTypesProc ()                                               |
 |                                                                            |
 | Callback for EnumResourceTypes                                             |
 |                                                                            |
 | Enumerates resource names for the specified resource type.                 |
 |                                                                            |
 | lParam contains the resource module instance.                              |
 *----------------------------------------------------------------------------*)
function EnumResTypesProc (hModule : Integer; resType : PChar; lParam : Integer) : BOOL; stdcall;
begin
  EnumResourceNames (hModule, resType, @EnumResNamesProc, lParam);
  result := True;
end;

(*----------------------------------------------------------------------------*
 | function RegisterWriteableResources ()                                     |
 |                                                                            |
 | Register a bunch of writeable resource classes                             |
 *----------------------------------------------------------------------------*)
procedure RegisterWriteableResources (resources : array of TWriteableResourceClass);
var
  i : Integer;
begin
  if not Assigned (WriteableResourceList) then
    WriteableResourceList := TList.Create;

  for i := Low (resources) to High (resources) do
    WriteableResourceList.Add (resources [i])
end;

{ TResource }

//----------------------------------------------------------------------------
// TResource is the base class for all resources

(*----------------------------------------------------------------------------*
 | constructor TResource.Create ()                                            |
 |                                                                            |
 | Create a resource object from data supplied.                               |
 |                                                                            |
 | Parameters:                                                                |
 |   AParent : TResourceModule         The parent resource module             |
 |   AName : PWideChar                 Name of resource (or integer resource  |
 |                                     name                                   |
 |   ADataLen : Integer                Size of resource data                  |
 |   AData : pointer                   The resource data.                     |
 |   ACustomType : PWideChar           Name of resource type (or integer      |
 |                                     resource type name).                   |
 *----------------------------------------------------------------------------*)
constructor TResource.Create (AParent : TResourceModule; AName : PWideChar; ADataLen :  Integer; AData : pointer; ACustomType : PWideChar);
begin
  fParent := AParent;
  fData := TMemoryStream.Create;
  fUndoStack := TObjectStack.Create;
  fRedoStack := TObjectStack.Create;
  if Assigned (AData) then
    fData.WriteBuffer (AData^, ADataLen);

  fCustomType := WStrNew (ACustomType);
  fName := WStrNew (AName);
end;

(*----------------------------------------------------------------------------*
 | destructor TResource.Destroy ()                                            |
 |                                                                            |
 | Tidy up, and remove resource from parent's resource list.                  |
 *----------------------------------------------------------------------------*)
destructor TResource.Destroy;
var
  i : Integer;
begin
  fData.Free;
  ClearUndoStack;
  fUndoStack.Free;
  fRedoStack.Free;
  WStrFree (fName);
  WStrFree (fCustomType);

  if Assigned (fParent) then           // Remove resource from the
                                       // parent's resource list
    with fParent do
      for i := 0 to fResourceList.Count - 1 do
        if fResourceList [i] = self then
        begin
          fResourceList.Delete (i);
          fParent.fResourceListChanged := True;
          if Assigned (fParent.fOnDeleteResource) and not (csDestroying in ComponentState) then
            fParent.fOnDeleteResource (fParent, self);
          break
        end;

  inherited
end;

(*----------------------------------------------------------------------------*
 | function TResource.GetResourceName ()                                      |
 |                                                                            |
 | The function returns the resources name in a displayable string            |
 *----------------------------------------------------------------------------*)
function TResource.GetResourceName : string;
begin
  if (Integer (fName) and $ffff0000) <> 0 then
    result := fName
  else
    result := Format ('%03.3d', [Integer (fName)])
end;

(*----------------------------------------------------------------------------*
 | function TResource.GetResourceTypeClass ()                                 |
 |                                                                            |
 | The function returns the resource class in a displayable string            |
 *----------------------------------------------------------------------------*)
class function TResource.GetResourceTypeClass : string;
begin
  result := Format (rstUnknownResourceType, [Integer (GetResourceType)]);
end;

(*----------------------------------------------------------------------------*
 | function TResource.GetResourceTypeName ()                                  |
 |                                                                            |
 | The function returns the resource type in a displayable string             |
 *----------------------------------------------------------------------------*)
function TResource.GetResourceTypeName : string;
begin
  if Assigned (fCustomType) then
    if (Integer (fCustomType) and $ffff0000) <> 0 then  // Custom resource type
      result := fCustomType
    else
      result := Format ('%08.8x', [Integer (fCustomType)])
  else
    result := GetResourceTypeClass
end;

(*----------------------------------------------------------------------------*
 | class function TResource.GetResourceType                                   |
 |                                                                            |
 | Get integer resource type.  0 = unknown.                                   |
 *----------------------------------------------------------------------------*)
class function TResource.GetResourceType: word;
begin
  result := 0;
end;

procedure TResource.InternalSetResourceName (const Value: string);
var
  i : DWORD;
  intResource : boolean;
begin
  intResource := True;
  // If the name is an integer, < 65536, then save the name as a Pseudo string

  for i := 1 to Length (value) do
    if not (value [i] in ['0'..'9']) then
    begin
      intResource := False;
      break
    end;

  if intResource then
  try
    i := StrToInt (value);
    intResource := (i < 65536) // and (Format ('%03.3d', [i]) = value);
  except
    intResource := False
  end;

  WStrFree (fName);
  if intResource then
    if self is TStringsResource then
                               // Adjust for funky string name thing.

      fName := WStrNew (PWideChar (i shr 4 + 1))
    else
      fName := WStrNew (PWideChar (i))

  else                         // Strings and individual Icons & Cursors names
                               // must be numeric
    if RequireNumericID then
      raise Exception.Create (rstBadResourceID)
    else
      fName := WStrNew (PWideChar (WideString (value)));
end;


(*----------------------------------------------------------------------------*
 | procedure TResource.SetResourceName ()                                     |
 |                                                                            |
 | Sets the resource name.                                                    |
 *----------------------------------------------------------------------------*)
procedure TResource.SetResourceName(const Value: string);
begin
  if value <> ResourceName then
  begin
    AddUndoEntry (rstResourceNameChanged);
    try
      InternalSetResourceName (value);
    finally
      NotifyChange
    end
  end
end;

(*----------------------------------------------------------------------------*
 | procedure TResource.SetLang ()                                             |
 |                                                                            |
 | Set method for 'Language' property.                                        |
 *----------------------------------------------------------------------------*)
procedure TResource.SetLang(const Value: word);
begin
  if value <> fLang then
  begin
    AddUndoEntry (rstLanguageChanged);
    try
      fLang := Value;
    finally
      NotifyChange
    end
  end
end;

(*----------------------------------------------------------------------------*
 | function TResource.RequireNumericID                                        |
 |                                                                            |
 | Override this to return true for resources that require a numeric name.    |
 | eg. string, icon, cursor                                                   |
 *----------------------------------------------------------------------------*)
function TResource.RequireNumericID: boolean;
begin
  result := False
end;

//----------------------------------------------------------------------------
// TWriteableResource is the base class for all writeable resources

{ TWriteableResource }

(*----------------------------------------------------------------------------*
 | constructor TWriteableResource.Create                                      |
 |                                                                            |
 | Create a writeable resource.  Writeable resources must know how to         |
 | initialize themselves.                                                     |
 *----------------------------------------------------------------------------*)
constructor TWriteableResource.Create(AParent : TResourceModule; AName : PWideChar; ACustomType : PWideChar);
begin
  Create (AParent, AName, 0, Nil, ACustomType);
end;

(*----------------------------------------------------------------------------*
 | procedure TWriteableResource.ExportRCSnippetToStream                       |
 |                                                                            |
 | Export a writeable resource to a stream in it's RC Snippet format.         |
 | Override this - the base class does nothing.                               |
 *----------------------------------------------------------------------------*)
procedure TWriteableResource.ExportRCSnippetToStream(stream: TStream);
begin
  if not (wsSnippetable in style) then
    raise Exception.Create (rstNoExportSnippet);
end;

(*----------------------------------------------------------------------------*
 | procedure TWriteableResource.ExportResource                                |
 |                                                                            |
 | Export a writeable resource to a file by calling the resource's            |
 | exportToStream method.                                                     |
 *----------------------------------------------------------------------------*)
procedure TWriteableResource.ExportResource(const FileName: string);
var
  strm : TFileStream;
begin
  strm := TFileStream.Create (FileName, fmCreate);
  try
    ExportToStream (strm, ExtractFileExt (FileName))
  finally
    strm.Free
  end
end;

(*----------------------------------------------------------------------------*
 | function TWriteableResource.ExportResourceSnippet                          |
 |                                                                            |
 | Export a writeable resource snippet to a file                              |
 *----------------------------------------------------------------------------*)
procedure TWriteableResource.ExportResourceSnippet(const FileName: string);
var
  strm : TFileStream;
begin
  strm := TFileStream.Create (FileName, fmCreate);
  try
    ExportRCSnippetToStream (strm)
  finally
    strm.Free
  end
end;

(*----------------------------------------------------------------------------*
 | function TWriteableResource.ExportToStream                                 |
 |                                                                            |
 | Export a writeable resource to a stream.  Should be overriden.             |
 *----------------------------------------------------------------------------*)
procedure TWriteableResource.ExportToStream(stream: TStream;
  const ext: string);
begin
  if not (wsExportable in style) then
    raise Exception.Create (rstNoExport);
end;

(*----------------------------------------------------------------------------*
 | function TWriteableResource.GetFilter                                      |
 |                                                                            |
 | Get the filter applicable to the resource type for use in Save dialog      |
 | boxes.  This stub function will usually be overwritten.                    |
 *----------------------------------------------------------------------------*)
class function TWriteableResource.GetFilter: string;
begin
  result := '';
end;

(*----------------------------------------------------------------------------*
 | function TWriteableResource.GetWriteableResourceStyles                     |
 |                                                                            |
 | Get the wsExportable and wsSnippetable styles for the writeable resource   |
 |                                                                            |
 | Override this...                                                           |
 *----------------------------------------------------------------------------*)
function TWriteableResource.GetWriteableResourceStyles: TWriteableResourceStyles;
begin
  result := [];
end;

(*----------------------------------------------------------------------------*
 | function TWriteableResource.Iniitialize                                    |
 |                                                                            |
 | Initialize a new instance of the resource.  Writeable resources can        |
 | override this to perform additional initialization of the new resource,    |
 | but must call 'inherited'                                                  |
 *----------------------------------------------------------------------------*)
procedure TWriteableResource.Initialize;
begin
  fParent.AddToList (self);
end;

(*----------------------------------------------------------------------------*
 | function TWriteableResource.IniitializeFromFile                            |
 |                                                                            |
 | Initialize a new instance of the resource from a file.  Writeable          |
 | resources should override this to perform additional initialization of the |
 | new resource, but must call 'inherited'                                    |
 *----------------------------------------------------------------------------*)
procedure TWriteableResource.InitializeFromFile(const fileName: string);
begin
  fParent.AddToList (self);
end;

(*----------------------------------------------------------------------------*
 | function TWriteableResource.NotifyChange                                   |
 |                                                                            |
 | Tell the parent module that the resource has changed.  Causes the module's |
 | OnChangeResource to be called                                              |
 *----------------------------------------------------------------------------*)
procedure TResource.NotifyChange;
begin
  fParent.DoResourceChanged (self)
end;

{ TRCDataResource }

(*----------------------------------------------------------------------------*
 | class function TResource.GetResourceType                                   |
 |                                                                            |
 | Get integer resource type.  RT_RCDATA                                      |
 *----------------------------------------------------------------------------*)
class function TRCDataResource.GetResourceType: word;
begin
  result := word (RT_RCDATA)
end;

(*----------------------------------------------------------------------------*
 | function TResource.GetResourceTypeClass ()                                 |
 |                                                                            |
 | The function returns the resource class in a displayable string - 'RC Data'|
 *----------------------------------------------------------------------------*)
class function TRCDataResource.GetResourceTypeClass: string;
begin
  result := rstRCData
end;

{ TPackageResource }

(*----------------------------------------------------------------------------*
 | constructor TPackageResource.Create ()                                     |
 |                                                                            |
 | Constructor for TPackageResource - decodes Delphi & BCB PACKAGEINFO        |
 | RC Data blocks.                                                            |
 *----------------------------------------------------------------------------*)
constructor TPackageResource.Create (AParent : TResourceModule; ADataLen :  Integer; AData : pointer);
begin
  inherited Create (AParent, PWideChar (WideString ('PACKAGEINFO')), ADataLen, AData);

  fRequiresList := TStringList.Create;
  fContainsList := TStringList.Create;

  ReloadResourceData
end;

procedure TPackageResource.ReloadResourceData;
var
  infoHeader : PPackageInfoHeader;
  pName : PPkgName;
  i, count : Integer;
  uName : PUnitName;
begin
  inherited;
  infoHeader := PPackageInfoHeader (Data.Memory);

                               // First you get the header 'flags' and 'requirescount' fields

  pName := PPkgName (Integer (infoHeader) + sizeof (TPackageInfoHeader));
  fFlags := infoHeader^.Flags;
  count := infoHeader^.RequiresCount;

  fRequiresList.Clear;
  for i := 0 to count - 1 do   // ... Next comes the 'Requires' name list
  begin
    fRequiresList.Add (pName^.Name);
    Inc (Integer (pName), StrLen (pName.Name) + 2);
  end;

                               // ... Next comes the 'Contains' count and unit records
  Count := PInteger (pName)^;
  UName := PUnitName(Integer(pName) + sizeof (count));

  fContainsList.Clear;
  for i := 0 to count - 1 do
  begin
    fContainsList.AddObject (UName.Name, TObject (UName.Flags));
    Inc(Integer(UName), StrLen(UName.Name) + 3);
  end
end;

(*----------------------------------------------------------------------------*
 | destructor TPackageResource.Destroy ()                                     |
 |                                                                            |
 | Destructor for TPackageResource
 *----------------------------------------------------------------------------*)
destructor TPackageResource.Destroy;
begin
  fRequiresList.Free;
  fContainsList.Free;
  inherited
end;

(*----------------------------------------------------------------------------*
 | function TPackageResource.GetContainsCount()                               |
 |                                                                            |
 | 'ContainsCount' property get method.  Gets the number of entries in the    |
 | 'Contains' list.                                                           |
 *----------------------------------------------------------------------------*)
function TPackageResource.GetContainsCount : Integer;
begin
  result := fContainsList.Count
end;

(*----------------------------------------------------------------------------*
 | function TPackageResource.GetContainsFlag()                                |
 |                                                                            |
 | 'ContainsFlag []' property Get method.  Returns the 'ContainsFlag' for the |
 | specified 'contains list' entry                                            |
 *----------------------------------------------------------------------------*)
function TPackageResource.GetContainsFlag(index: Integer): Byte;
begin
  result := Byte (fContainsList.Objects [index]);
end;

(*----------------------------------------------------------------------------*
 | function TPackageResource.GetContainsName()                                |
 |                                                                            |
 | 'ContainsName []' property Get method.  Returns the name of the  specified |
 | 'contains list' entry                                                      |
 *----------------------------------------------------------------------------*)
function TPackageResource.GetContainsName (index : Integer) : string;
begin
  result := fContainsList [index];
end;

(*----------------------------------------------------------------------------*
 | function TPackageResource.GetRequiresCount()                               |
 |                                                                            |
 | 'RequiresCount' property get method.  Gets the number of entries in the    |
 | 'Requires' list.                                                           |
 *----------------------------------------------------------------------------*)
function TPackageResource.GetRequiresCount : Integer;
begin
  result := fRequiresList.Count
end;

(*----------------------------------------------------------------------------*
 | function TPackageResource.GetRequiresName()                                |
 |                                                                            |
 | 'RequiresName []' property Get method.  Returns the name of the  specified |
 | 'requires list' entry                                                      |
 *----------------------------------------------------------------------------*)
function TPackageResource.GetRequiresName (index : Integer) : string;
begin
  result := fRequiresList [index];
end;

{ TResourceModule }

(*----------------------------------------------------------------------------*
 | constructor TResourceModule.Create ()                                      |
 |                                                                            |
 | Constructor for TResourceModule                                            |
 *----------------------------------------------------------------------------*)
constructor TResourceModule.Create (AOwner : TComponent);
begin
  inherited Create (AOwner);
  fResourceList := TList.Create;
end;

(*----------------------------------------------------------------------------*
 | destructor TResourceModule.Destroy ()                                      |
 |                                                                            |
 | Destructor for TResourceModule                                             |
 *----------------------------------------------------------------------------*)
destructor TResourceModule.Destroy;
begin
  Close;
  fResourceList.Free;
  inherited
end;

(*----------------------------------------------------------------------------*
 | function TResourceModule.AddResourcetoList ()                              |
 |                                                                            |
 | Creates a TResource derived class from the data given, and adds it to the  |
 | resource list.
 *----------------------------------------------------------------------------*)
function TResourceModule.AddResourceToList (AType, AName : PWideChar; ADataLen :  Integer; AData : pointer; ALang : word) : TResource;
var
  resource : TResource;
  gres : TResource;

{$IFDEF GRAPHICSRESOURCES}
  function CreateRIFFResource(AName: PWideChar;
    ADataLen: Integer; AData: PChar): TRIFFResource;
  var
    riffStream : TRiffMemoryStream;

  begin
    riffStream := TRiffMemoryStream.Create (AData, ADataLen);
    try
      riffStream.Descend ('', 0);
      if riffStream.ChunkType = 'WAVE' then
        result := TWAVEResource.Create (self, AName, ADataLen, AData, PWideChar (WideString ('WAVE')))
      else
        if riffStream.ChunkType = 'RMID' then
          result := TRMIDResource.Create (self, AName, ADataLen, AData, PWideChar (WideString ('MIDI')))
        else
          if riffStream.ChunkType = 'AVI ' then
            result := TAVIResource.Create (self, AName, ADataLen, AData, PWideChar (WideString ('Video')))
          else
            result := TRiffResource.Create (self, AName, ADataLen, AData, PWideChar (WideString ('RIFF')))
    finally
      riffStream.Free
    end
  end;
{$ENDIF}


begin
  case Integer (AType) of                  // Create the resource object

{$IFDEF GRAPHICSRESOURCES}
    Integer (RT_CURSOR)      : resource := TCursorResource.Create (self, AName, ADataLen, AData);
    Integer (RT_BITMAP)      : resource := TBitmapResource.Create (self, AName, ADataLen, AData);
    Integer (RT_ICON)        : resource := TIconResource.Create (self, AName, ADataLen, AData);
    Integer (RT_MENU)        : resource := TMenuResource.Create (self, AName, ADataLen, AData);
    Integer (RT_DIALOG)      : resource := TDialogResource.Create (self, AName, ADataLen, AData);
{$ENDIF}
    Integer (RT_STRING)      : resource := TStringsResource.Create (self, AName, ADataLen, AData);
    Integer (RT_ACCELERATOR) : resource := TAcceleratorResource.Create (self, AName, ADataLen, AData);
    Integer (RT_RCDATA)      :
        if (Integer (AName) and $ffff0000) = 0 then
           resource := TRCDataResource.Create (self, AName, ADataLen, AData)
         else
           if AName = 'PACKAGEINFO' then
             resource := TPackageResource.Create (self, ADataLen, AData)
           else
             if AName = 'DESCRIPTION' then
               resource := TDescriptionResource.Create (self, ADataLen, AData)
             else
               if (ADataLen > sizeof (FilerSignature)) and CompareMem (AData, @FilerSignature, sizeof (FilerSignature)) then
                 resource := TComponentResource.Create (self, AName, ADataLen, AData)
               else
                 resource := TRCDataResource.Create (self, AName, ADataLen, AData);

    Integer (RT_MESSAGETABLE) : resource := TMessagesResource.Create (self, AName, ADataLen, AData);
{$IFDEF GRAPHICSRESOURCES}
    Integer (RT_GROUP_CURSOR) : resource := TCursorGroupResource.Create (self, AName, ADataLen, AData);
    Integer (RT_GROUP_ICON)   : resource := TIconGroupResource.Create (self, AName, ADataLen, AData);
{$ENDIF}
    Integer (RT_VERSION)      : resource := TVersionInfoResource.Create (self, AName, ADataLen, AData);
    Integer (RT_TOOLBAR)      : resource := TToolbarResource.Create (self, AName, ADataLen, AData);

    else                                    // Unknown resource type - but could be a RIFF

{$IFDEF GRAPHICSRESOURCES}
      if (ADataLen > sizeof (FOURCC_RIFF)) and (PDWORD (AData)^ = FOURCC_RIFF) then
        resource := CreateRIFFResource (AName, ADataLen, AData)
      else
{$ENDIF}
        resource := TResource.Create (self, AName, ADataLen, AData, AType)
  end;

  resource.fLang := ALang;
  AddToList (resource);                     // Add the resource to the list.

{$IFDEF GRAPHICSRESOURCES}
  if resource is TIconCursorResource then   // Tell the UI to update the group resource too, for icons and cursor
  begin
    gres := TIconCursorResource (resource).GetResourceGroup;
    DoResourceChanged (gres);
  end;
{$ENDIF}

  result := resource
end;

(*----------------------------------------------------------------------------*
 | procedure TResourceModule.Close                                            |
 |                                                                            |
 | Close a resource module.  Delete it's individual resource objects.         |
 *----------------------------------------------------------------------------*)
procedure TResourceModule.Close;
begin
  while fResourceList.Count > 0 do
    TResource (fResourceList [0]).Free;
end;

(*----------------------------------------------------------------------------*
 | function TResourceModule.                                                  |
 |                                                                            |
 | 'ResourceCount' property Get method                                        |
 *----------------------------------------------------------------------------*)
function TResourceModule.GetResourceCount : Integer;
begin
  result := fResourceList.Count;
end;

(*----------------------------------------------------------------------------*
 | function TResourceModule.GetResource                                       |
 |                                                                            |
 | Resource [] property Get method                                            |
 *----------------------------------------------------------------------------*)
function TResourceModule.GetResource (index : Integer) : TResource;
begin
  result := TResource (fResourceList [index]);
end;

(*----------------------------------------------------------------------------*
 | function TResourceModule.GetWriteableResourceCount                         |
 |                                                                            |
 | 'WriteableResourceCount' property Get method                               |
 *----------------------------------------------------------------------------*)
function TResourceModule.GetWriteableResourceCount: Integer;
begin
  result := WriteableResourceList.Count
end;

function TResourceModule.FindResource(resClass: TResourceClass;
  nm: PWideChar): TResource;
var
  i, n : Integer;
  res : TResource;
begin
  result := Nil;
  for i := 0 to ResourceCount - 1 do
  begin
    res := Resource [i];
    if (Integer (res.fName) and $ffff0000) = 0 then
    begin                          // It's a pseudo string = compare integer values
      n := Integer (res.fName);
      if res is TStringsResource then
        Dec (n);
      if (n = Integer (nm)) and (res is resClass) then
      begin
        result := res;
        break
      end
    end
    else                          // It's a real string.  Compare strings
      if ((Integer (nm) and $ffff0000) <> 0) and (lstrcmpiW (nm, res.fName) = 0) then
      begin
        result := res;
        break
      end
  end;
end;

(*----------------------------------------------------------------------------*
 | procedure TResourceModule.LoadResourceFile                                 |
 |                                                                            |
 | Load the file, in '.RES' format.                                           |
 *----------------------------------------------------------------------------*)
procedure TResourceModule.LoadResourceFile;
var
  p, q, buffer : PChar;
  n, bufLen, DataSize, HeaderSize, ChunkSize : Integer;
begin
  with TFileStream.Create (FileName, fmOpenRead or fmShareDenyWrite) do
  try
    bufLen := Size;
    GetMem (buffer, bufLen);
    try
      ReadBuffer (buffer^, bufLen);             // Read the entite file

      p := buffer;
      n := 0;
      f16Bit := True;
                                                // Parse each resource
      while n + 2 * sizeof (Integer) < bufLen do
      begin
        DataSize := PInteger (p)^;
        q := p;
        Inc (q, SizeOf  (Integer));
        HeaderSize := PInteger (q)^;
        q := p;
        Inc (q, HeaderSize);

        ParseResource (p, q, DataSize);
        ChunkSize := DataSize + HeaderSize;
        ChunkSize := ((ChunkSize + 3) div 4) * 4;
        Inc (p, ChunkSize);
        Inc (n, ChunkSize);
      end;

    finally
      FreeMem (buffer)
    end
  finally
    Free                                       // Free the file stream
  end;
  fResourceListChanged := False;
 end;

(*----------------------------------------------------------------------------*
 | function TResourceModule.LoadResourceFromModule                            |
 |                                                                            |
 | Load a particular resource from a .EXE, .DLL, etc.  Called by the          |
 | EnumResLangProc callback.                                                  |
 *----------------------------------------------------------------------------*)
function TResourceModule.LoadResourceFromModule (hModule : Integer; const resType, resName : PChar; language : word) : boolean;
var
  resourceHandle : Integer;
  infoHandle, size : Integer;
  p : PChar;
  pt, pn : PWideChar;
  wType, wName : WideString;
begin
  result := True;
  resourceHandle := Windows.FindResource (hModule, resName, resType);
  if resourceHandle <> 0 then
  begin
    size := SizeOfResource (hModule, resourceHandle);
    infoHandle := LoadResource (hModule, resourceHandle);
    if infoHandle <> 0 then
    try
      p := LockResource (infoHandle);

      if (Integer (resType) and $ffff0000) = 0 then
        pt := PWideChar (resType)
      else
      begin
        wType := resType;
        pt := PWideChar (wType)
      end;

      if (Integer (resName) and $ffff0000) = 0 then
        pn := PWideChar (resName)
      else
      begin
        wName := resName;
        pn := PWideChar (wName)
      end;

      AddResourceToList (pt, pn, size, p, language);
      fResourceListChanged := False;
    finally
      FreeResource (infoHandle)
    end
    else
      RaiseLastWin32Error;
  end
  else
    RaiseLastWin32Error;
end;

(*----------------------------------------------------------------------------*
 | procedure TResourceModule.Open                                             |
 |                                                                            |
 | Open the file (.RES, or a module) and load it's resources                  |
 *----------------------------------------------------------------------------*)
procedure TResourceModule.Open;
var
  fInstance : Integer;
  ext : string;
begin
  Close;
  ext := UpperCase (ExtractFileExt (FileName));
  if (ext = '.RES') or (ext = '.DCR') then
  begin
    fModuleType := rtResFile;         // Load from .RES file
    LoadResourceFile
  end
  else
  begin
                                      // Load from module file

    fInstance := LoadLibraryEx (PChar (fFileName), 0, LOAD_LIBRARY_AS_DATAFILE);
    if fInstance <> 0 then
    try
      fModuleType := rtModule;
      if fResourceType = Nil then     // Load *all* types ?
        EnumResourceTypes (fInstance, @EnumResTypesProc, Integer (self))
      else
      begin                           // ... no.  Load specified type...
                                      // ... but if that's an Icon or Cursor group, load
                                      // the icons & cursors, too!

        if fResourceType = RT_GROUP_ICON then
          EnumResourceNames (fInstance, RT_ICON, @EnumResNamesProc, Integer (self))
        else
          if fResourceType = RT_GROUP_CURSOR then
            EnumResourceNames (fInstance, RT_CURSOR, @EnumResNamesProc, Integer (self));

        EnumResourceNames (fInstance, fResourceType, @EnumResNamesProc, Integer (self))
      end
    finally
      FreeLibrary (fInstance)
    end
    else
      RaiseLastWin32Error;
  end
end;

(*----------------------------------------------------------------------------*
 | procedure TResourceModule.ParseResource                                    |
 |                                                                            |
 | Create and add to the resource list a resource from a .RES chunk.          |
 *----------------------------------------------------------------------------*)
procedure TResourceModule.ParseResource (header, data : PChar; dataSize : Integer);
var
  p : PChar;
  sName, sType : PWideChar;
  res : TResource;
  language, memoryFlags : word;
  version, dataVersion, characteristics : DWORD;

  procedure GetName (var name : PWideChar);
  begin
    if PWord (p)^ = $ffff then
    begin
      Inc (p, sizeof (word));
      name := PWideChar (PWord (p)^);
      Inc (p, sizeof (word))
    end
    else
    begin
      name := PWideChar (p);
      Inc (p, (lstrlenw (name) + 1) * sizeof (WideChar))
    end
  end;

begin
  p := header;
  Inc (p, 2 * sizeof (Integer));
  GetName (sType);
  GetName (sName);

  if (Integer (p) mod 4) <> 0 then
    Inc (p, 4 - Integer (p) mod 4);

  dataVersion := PDWORD (p)^;
  Inc (p, sizeof (DWORD));
  memoryFlags := PWORD (p)^;
  Inc (p, sizeof (word));
  language := PWORD (p)^;
  Inc (p, sizeof (word));
  version := PDWORD (p)^;
  Inc (p, sizeof (DWORD));
  characteristics := PDWORD (p)^;
  Inc (p, sizeof (DWORD));

  if (dataSize <> 0) or (sName <> Nil) then
  begin
    res := AddResourceToList (sType, sName, dataSize, data, language);
    res.fCharacteristics := characteristics;
    res.fVersion := version;
    res.fLang := language;
    res.fMemoryFlags := memoryFlags;
    res.fDataVersion := dataVersion
  end
  else       // NB!!!  32 bit .RES files start with a dummy '32-bit indicator'
             // resource !!!  Is this documented?  I don't think so!

    f16Bit := False;
end;

(*----------------------------------------------------------------------------*
 | procedure TResourceModule.SetFileName                                      |
 |                                                                            |
 | 'FileName' property Set method.                                            |
 *----------------------------------------------------------------------------*)
procedure TResourceModule.SetFileName (const value : string);
begin
  if fFileName <> value then
  begin
    fFileName := value;
    if not (csDesigning in ComponentState) then
      Open
  end
end;


(*----------------------------------------------------------------------------*
 | procedure TResourceModule.WriteResFile                                     |
 |                                                                            |
 | Write the resources to a .RES file (he says it so casually!)               |
 *----------------------------------------------------------------------------*)
procedure TResourceModule.WriteResFile(const fileName: string);
var
  res : TResource;
  i, dataSize, headerSize, totalSize : DWORD;
  header : array [0..1023] of char;

  function GetResHeader (header : PChar) : DWORD;
  var
    pos : DWORD;
    len : DWORD;
    w : word;
    ws : WideString;
  begin
    pos := 0;
    ZeroMemory (header, 1024);

    if Assigned (res.fCustomType) then
    begin                           // resource type not implicit in the class
      if (Integer (res.fCustomType) and $ffff0000) <> 0 then
      begin                         // String resource type
        ws := res.fCustomType;
        len := (Length (ws) + 1) * sizeof (WideChar);
        Move (PWideChar (ws)^, header [pos], len);
        Inc (pos, len)
      end
      else
      begin                         // Integer resource type.
        w := $ffff;
        Move (w, header [pos], sizeof (w));
        Inc (pos, sizeof (w));

        w := Word (DWORD (res.fCustomType) and $0000ffff);
        Move (w, header [pos], sizeof (w));
        Inc (pos, sizeof (w))
      end
    end
    else
    begin                           // Implicit resource types are always
      w := $ffff;                   // Integer.
      Move (w, header [pos], sizeof (w));
      Inc (pos, sizeof (w));

      w := res.GetResourceType;
      Move (w, header [pos], sizeof (w));
      Inc (pos, sizeof (w))
    end;

    if (Integer (res.fName) and $ffff0000) <> 0 then
    begin
      ws := res.fName;
      len := (Length (ws) + 1) * sizeof (WideChar);
      Move (PWideChar (ws)^, header [pos], len);
      Inc (pos, len)
    end
    else
    begin
      w := $ffff;
      Move (w, header [pos], sizeof (w));
      Inc (pos, sizeof (w));

      w := Word (DWORD (res.fName) and $0000ffff);
      Move (w, header [pos], sizeof (w));
      Inc (pos, sizeof (w))
    end;

    if (pos mod 4) <> 0 then
      Inc (pos, 4 - (pos mod 4));

    Move (res.fDataVersion, header [pos], sizeof (DWORD));
    Inc (pos, sizeof (DWORD));

    Move (res.fMemoryFlags, header [pos], sizeof (WORD));
    Inc (pos, sizeof (WORD));

    Move (res.fLang, header [pos], sizeof (WORD));
    Inc (pos, sizeof (WORD));

    Move (res.fVersion, header [pos], sizeof (DWORD));
    Inc (pos, sizeof (DWORD));

    Move (res.fCharacteristics, header [pos], sizeof (DWORD));
    Inc (pos, sizeof (DWORD));
    result := pos;
  end;

begin // TResourceModule.WriteResFile
  with TFileStream.Create (fileName, fmCreate or fmShareExclusive) do
  try
    if not f16Bit then               // Write 32-bit resource indicator (An empty type 0 resource)
    begin
      res := TResource.Create (Nil, Nil, 0, Nil);
      try
        dataSize := res.Data.Size;

        WriteBuffer (dataSize, sizeof (dataSize));
        headerSize := GetResHeader (header);

        totalSize := headerSize + 2 * sizeof (DWORD);

        WriteBuffer (totalSize, sizeof (headerSize));
        WriteBuffer (header, headerSize);
      finally
        res.Free
      end
    end;

    dataSize := 0;
    if ResourceCount > 0 then
      for i := 0 to ResourceCount - 1 do
      begin
        res := Resource [i];
        dataSize := res.Data.Size;

        WriteBuffer (dataSize, sizeof (dataSize));
        headerSize := GetResHeader (header);

        totalSize := headerSize + 2 * sizeof (DWORD);

        WriteBuffer (totalSize, sizeof (headerSize));
        WriteBuffer (header, headerSize);
        WriteBuffer (res.Data.Memory^, dataSize);

        totalSize := dataSize + totalSize;
        ZeroMemory (@header, sizeof (header));

        if (totalSize mod 4) <> 0 then
          WriteBuffer (header, 4 - (totalSize mod 4));


        res.ClearUndoStack;
      end
  finally
    Free
  end;
  fFileName := fileName
end;

(*----------------------------------------------------------------------------*
 | function TResourceModule.GetWriteableResourceName                          |
 |                                                                            |
 | 'WriteableResourceName[]' property Get method                                |
 *----------------------------------------------------------------------------*)
function TResourceModule.GetWriteableResourceName(index: Integer): string;
begin
  result := TWriteableResourceClass (WriteableResourceList [index]).GetResourceTypeClass;
end;

(*----------------------------------------------------------------------------*
 | function TResourceModule.                                                  |
 |                                                                            |
 | 'WriteableResourceClass[]' property Get method                             |
 *----------------------------------------------------------------------------*)
function TResourceModule.GetWriteableResourceClass(
  index: Integer): TWriteableResourceClass;
begin
  result := TWriteableResourceClass (WriteableResourceList [index]);
end;

(*----------------------------------------------------------------------------*
 | procedure TResourceModule.AddToList                                        |
 |                                                                            |
 | Add a resource to the resource list, and notify the UI                     |
 *----------------------------------------------------------------------------*)
procedure TResourceModule.AddToList (Resource : TResource);
begin
  fResourceListChanged := True;
  fResourceList.Add (resource);
  if Assigned (fOnAddResource) and not (csDestroying in ComponentState) then
    OnAddResource (self, Resource);
end;

(*----------------------------------------------------------------------------*
 | function TResourceModule.GetChanged                                        |
 |                                                                            |
 | 'Changed' property Get method.  True if any of the resources in the module |
 | have been modified.                                                        |
 *----------------------------------------------------------------------------*)
function TResourceModule.GetChanged: boolean;
var
  i : Integer;
  res : TResource;
begin
  result := fResourceListChanged;
  for i := 0 to ResourceCount - 1 do
  begin
    res := Resource [i];
    result := result or res.Dirty
  end
end;

(*----------------------------------------------------------------------------*
 | procedure TResourceModule.UpdateModuleFile                                 |
 |                                                                            |
 | Update thre resources in a .EXE, /DLL, etc.  NT only!                      |
 *----------------------------------------------------------------------------*)
procedure TResourceModule.UpdateModuleFile;
var
  updateHandle : THandle;
  ok : boolean;
  i : Integer;
  res : TResource;
  resType : PWideChar;
  resName : PWideChar;
begin
  if not g_bCanUpdateResource then
    raise Exception.Create (rstCantUpdateResource);

  updateHandle := fnBeginUpdateResource (PChar (fileName), True);

  ok := UpdateHandle <> 0;
  if ok then
  try
    for i := 0 to ResourceCount - 1 do
    begin
      res := Resource [i];
      if Assigned (res.fCustomType) then
        resType := res.fCustomType
      else
        resType := PWideChar (res.GetResourceType);

      resName := res.RawName;

                             // Update each resource

      ok := fnUpdateResourceW (updateHandle, resType, resName, res.Language, res.Data.Memory, res.Data.Size);

      if not ok then
        RaiseLastWin32Error
    end

  finally
    if not fnEndUpdateResource (updateHandle, not ok) then
      RaiseLastWin32Error
  end
  else
    RaiseLastWin32Error;

  if ok then                 // Set each resource to 'unchanged'
    for i := 0 to ResourceCount - 1 do
    begin
      res := Resource [i];
      res.ClearUndoStack;
    end
end;

(*----------------------------------------------------------------------------*
 | function TResourceModule.GetCanUpdateModule                                |
 |                                                                            |
 | 'CanUpdateModule' property Get method.  Returns true if we're on NT        |
 *----------------------------------------------------------------------------*)
function TResourceModule.GetCanUpdateModule: boolean;
begin
  result := g_bCanUpdateResource
end;

(*----------------------------------------------------------------------------*
 | function TResourceModule.GetUniqueResourceName                             |
 |                                                                            |
 | Get a unique integer resource name for the specified resource class        |
 *----------------------------------------------------------------------------*)
function TResourceModule.GetUniqueResourceName (resClass : TResourceClass): Integer;
var
  duplicate : boolean;
begin
  result := 0;
  repeat
    duplicate := not IsUniqueResourceName (resClass, PWideChar (result));
    if duplicate then
      Inc (result)
  until not duplicate or (result >= 65536);
end;

(*----------------------------------------------------------------------------*
 | procedure TResourceModule.DoResourceChanged                                |
 |                                                                            |
 | Notify the UI that the specified resource has changed.                     |
 *----------------------------------------------------------------------------*)
procedure TResourceModule.DoResourceChanged(resource: TResource);
begin
  if Assigned (fOnChangeResource) and not (csDestroying in ComponentState) then
    OnChangeResource (self, Resource);
end;

(*----------------------------------------------------------------------------*
 | function TResourceModule.ISUniqueResourceName                              |
 |                                                                            |
 | Confirm whether a resource name already exists for the specified resource  |
 | type.                                                                      |
 *----------------------------------------------------------------------------*)
function TResourceModule.IsUniqueResourceName(resClass: TResourceClass;
  nm: PWideChar): boolean;
begin
  result := not Assigned (FindResource (resClass, nm));
end;

{ TDescriptionResource }

(*----------------------------------------------------------------------------*
 | constructor TDescriptionResource.Create ()                                 |
 |                                                                            |
 | Constructor for TDescriptionResource - decodes Delphi & BCB PACKAGEINFO    |
 | EXE Description RC Data blocks.                                            |
 *----------------------------------------------------------------------------*)
constructor TDescriptionResource.Create(AParent: TResourceModule;
  ADataLen: Integer; AData: pointer);
begin
  inherited Create (AParent, PWideChar (WideString ('DESCRIPTION')), ADataLen, AData);
end;

(*----------------------------------------------------------------------------*
 | function TDescriptionResource.GetDescription                               |
 |                                                                            |
 | Description property Get method                                            |
 *----------------------------------------------------------------------------*)
function TDescriptionResource.GetDescription: string;
begin
  result := PWideChar (data.Memory);
end;

(*----------------------------------------------------------------------------*
 | procedure TDescriptionResource.SetDescription                              |
 |                                                                            |
 | Description property Set method                                            |
 *----------------------------------------------------------------------------*)
procedure TDescriptionResource.SetDescription(const Value: string);
begin
  AddUndoEntry (rstDescriptionChanged);
  try
    data.Size := (Length (value) + 1) * sizeof (WideChar);
    lstrcpyW (PWideChar (data.Memory), PWideChar (WideString (value)));
  finally
    NotifyChange
  end
end;

{ TAcceleratorResource }

(*----------------------------------------------------------------------------*
 | function  TAcceleratorResource.GetResourceType                             |
 |                                                                            |
 | Get integer resource type.  RT_ALLELERATOR                                 |
 *----------------------------------------------------------------------------*)
class function TAcceleratorResource.GetResourceType: word;
begin
  result := word (RT_ACCELERATOR)
end;

(*----------------------------------------------------------------------------*
 | function  TAcceleratorResource.GetResourceTypeClass                        |
 |                                                                            |
 | Return 'Accelerator'                                                       |
 *----------------------------------------------------------------------------*)
class function TAcceleratorResource.GetResourceTypeClass: string;
begin
  result := rstAccelerator
end;

(*----------------------------------------------------------------------------*
 | procedure TAcceleratorResource.ExportToStream                              |
 |                                                                            |
 | Not yet implemented                                                        |
 *----------------------------------------------------------------------------*)
procedure TAcceleratorResource.ExportToStream(stream: TStream; const ext : string);
begin
  raise Exception.Create ('Not yet implemented')
end;

{ TToolbarResource }

(*----------------------------------------------------------------------------*
 | function  TToolbarResource.GetResourceType                                 |
 |                                                                            |
 | Get integer resource type.  RT_TOOLBAR                                     |
 *----------------------------------------------------------------------------*)
class function TToolbarResource.GetResourceType: word;
begin
  result := word (RT_TOOLBAR)
end;

(*----------------------------------------------------------------------------*
 | function  TToolbarResource.GetResourceTypeClass                            |
 |                                                                            |
 | Return 'Toolbar'                                                           |
 *----------------------------------------------------------------------------*)
class function TToolbarResource.GetResourceTypeClass: string;
begin
  result := rstToolbar
end;

{ TComponentResource }

(*----------------------------------------------------------------------------*
 | constructor TComponentResource.Create ()                                   |
 |                                                                            |
 | Constructor for TComponentResource - decodes Delphi & BCB Component        |
 | RC Data blocks.  (Starting with 'TPF0')                                    |
 *----------------------------------------------------------------------------*)
constructor TComponentResource.Create(AParent: TResourceModule;
  AName: PWideChar; ADataLen: Integer; AData: pointer;
  ACustomType: PWideChar);
var
  textStream : TMemoryStream;

begin
  inherited Create (AParent, AName, ADataLen, AData, ACustomType);
  fData.Seek (0, soFromBeginning);
  fComponentText := TStringList.Create;
  textStream := TMemoryStream.Create;
  try
                                       // Decode data to text representation
    ObjectBinaryToText (fData, textStream);
    textStream.Seek (0, soFromBeginning);
    fComponentText.LoadFromStream (textStream)
  finally
    textStream.Free
  end
end;

(*----------------------------------------------------------------------------*
 | destructor TComponentResource.Destroy                                      |
 |                                                                            |
 | Free the text representation                                               |
 *----------------------------------------------------------------------------*)
destructor TComponentResource.Destroy;
begin
  fComponentText.Free;
  inherited
end;

procedure TComponentResource.SetComponentText(const Value: TStrings);
var
  textStream : TMemoryStream;
begin
  AddUndoEntry (rstComponentChanged);
  fComponentText.Assign (value);

  textStream := TMemoryStream.Create;
  try
    Value.SaveToStream (textStream);
    textStream.Seek (0, soFromBeginning);
    fData.Clear;
    ObjectTextToBinary (textStream, fData);
  finally
    textStream.Free
  end
end;

var
  HKernel : THandle;

procedure TResource.ClearUndoStack;
begin
  while fUndoStack.Count > 0 do
    fUndoStack.pop.Free;

  while fRedoStack.Count > 0 do
    fRedoStack.pop.Free;
end;

function TResource.GetDirty: boolean;
begin
  result := fUndoStack.Count <> 0;
end;

{ TUndoEntry }

constructor TUndoEntry.Create(const ADescription: string;
  AData: TMemoryStream; const AResName : string; ALangID : Integer);
begin
  fDescription := ADescription;
  fData := TMemoryStream.Create;
  fLangID := ALangID;
  fResname := AResName;
  fData.CopyFrom (AData, 0);
end;

destructor TUndoEntry.Destroy;
begin
  fData.Free;
  inherited
end;

procedure TResource.AddUndoEntry(const description: string);
begin
  while fRedoStack.Count > 0 do
    fRedoStack.pop.Free;

  fUndoStack.Push (TUndoEntry.Create (description, Data, ResourceName, Language));
end;

function TResource.GetCanRedo: boolean;
begin
  result := fRedoStack.Count > 0;
end;

procedure TResource.Undo;
var
  undoEntry : TUndoEntry;
begin
  if Dirty then
  begin
    undoEntry := TUndoEntry (fUndoStack.Pop);

    if Assigned (undoEntry) then
    begin
      fRedoStack.Push (TUndoEntry.Create (undoEntry.Description, Data, ResourceName, Language));
      Data.Clear;
      Data.CopyFrom (undoEntry.Data, 0);
      ReloadResourceData;
      fLang := undoEntry.fLangID;

      if ResourceName <> undoEntry.fResName then
        InternalSetResourceName (undoEntry.fResName);

      NotifyChange;
      undoEntry.Free;
    end
  end

end;

function TResource.GetLastUndoDescription: string;
begin
  if Dirty then
    result := TUndoEntry (fUndoStack.Peek).Description
  else
    result := ''
end;

procedure TComponentResource.NotifyChange;
var
  textStream : TMemoryStream;
begin
  textStream := TMemoryStream.Create;
  try
                                       // Decode data to text representation
    fData.Seek (0, soFromBeginning);
    ObjectBinaryToText (fData, textStream);
    textStream.Seek (0, soFromBeginning);
    fComponentText.LoadFromStream (textStream);
  finally
    textStream.Free
  end;
  inherited
end;

procedure TResource.Redo;
var
  redoEntry : TUndoEntry;
begin
  if CanRedo then
  begin
    redoEntry := TUndoEntry (fRedoStack.Pop);

    if Assigned (redoEntry) then
    begin
      fUndoStack.Push (TUndoEntry.Create (redoEntry.Description, Data, ResourceName, Language));
      Data.Clear;
      Data.CopyFrom (redoEntry.Data, 0);
      ReloadResourceData;
      fLang := redoEntry.fLangId;
      if ResourceName <> redoEntry.fResName then
        InternalSetResourceName (redoEntry.fResName);
      NotifyChange;
      redoEntry.Free;
    end
  end
end;

function TResource.GetLastRedoDescription: string;
begin
  if CanRedo then
    result := TUndoEntry (fRedoStack.Peek).Description
  else
    result := ''
end;

procedure TPackageResource.SetFlags(const Value: Integer);
var
  infoHeader : PPackageInfoHeader;
begin
  if fFlags <> Value then
  begin
    AddUndoEntry (rstFlagsChanged);
    try
      fFlags := value;
      infoHeader := PPackageInfoHeader (Data.Memory);
      infoHeader^.Flags := fFlags
    finally
      NotifyChange
    end
  end
end;

procedure TResource.ReloadResourceData;
begin
end;

initialization
  hKernel := LoadLibrary ('kernel32.dll');
  if hKernel <> 0 then
  begin
    fnBeginUpdateResource := GetProcAddress (hKernel, 'BeginUpdateResourceA');
    fnEndUpdateResource := GetProcAddress (hKernel, 'EndUpdateResourceA');
    fnUpdateResourceW := GetProcAddress (hKernel, 'UpdateResourceW');

    g_bCanUpdateResource := Assigned (fnBeginUpdateResource) and Assigned (fnEndUpdateResource) and Assigned (fnUpdateResourceW)
  end
  else
    g_bCanUpdateResource := False
finalization
  WriteableResourceList.Free
end.
