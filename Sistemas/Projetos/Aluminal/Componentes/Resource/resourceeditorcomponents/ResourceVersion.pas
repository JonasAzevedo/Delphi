unit ResourceVersion;

interface

uses Windows, Classes, SysUtils, ResourceModule, ConTnrs;

type
//=============================================================================
// TVersionInfoResource.  Encapsulates Version Info

  TFileFlags = (ffDebug, ffInfoInferred, ffPatched, ffPreRelease, ffPrivateBuild, ffSpecialBuild);
  TVersionFileFlags = set of TFileFlags;

  TVersionStringValue = class
  private
    fKeyName : string;
    fValue : string;

  public
    constructor Create (const AKeyName, AValue : string);
    property KeyName : string read fKeyName;
    property Value : string read fValue;
  end;

  TVersionInfoResource = class (TWriteableResource)
  private
    fChildStrings : TObjectList;
    fFixedInfo : PVSFixedFileInfo;
    fTranslations : TList;
    fLangID, fCodePage : Integer;

    function GetProductVersion : TULargeInteger;
    function GetFileVersion : TULargeInteger;
    function GetFixedFileInfo : PVSFixedFileInfo;
    function GetFileFlags : TVersionFileFlags;

    procedure SetProductVersion(const Value: TULargeInteger);
    procedure SetFileVersion(const Value: TULargeInteger);
    procedure SetFileFlags(const Value: TVersionFileFlags);
    function GetKeyCount: Integer;
    function GetKey(idx: Integer): TVersionStringValue;

    procedure UpdateData;
    procedure SetLangID(const Value: Integer);
  protected
    class function GetResourceTypeClass : string; override;
    procedure ExportToStream (strm : TStream; const ext : string); override;

  public
    constructor Create (AParent : TResourceModule; AName : PWideChar; ADataLen :  Integer; AData : pointer; ACustomType : PWideChar = Nil); override;
    constructor Create (AParent : TResourceModule; AName : PWideChar; ACustomType : PWideChar = Nil); override;
    destructor Destroy; override;
    class function GetResourceType : word; override;
    procedure NotifyChange; override;
    function SetKeyValue (const AKeyName, AValue : string) : Integer;
    procedure ChangeKey (const AOldKey, ANewKey : string);
    procedure DeleteKey (idx : Integer);
    function IndexOf (const AKeyName : string) : Integer;
    property ProductVersion : TULargeInteger read GetProductVersion write SetProductVersion;
    property FileVersion    : TULargeInteger read GetFileVersion write SetFileVersion;
    property FileFlags : TVersionFileFlags read GetFileFlags write SetFileFlags;
    property KeyCount : Integer read GetKeyCount;
    property Key [idx : Integer] : TVersionStringValue read GetKey;
    property LangID : Integer read fLangID write SetLangID;
    property CodePage : Integer read fCodePage;
  end;



implementation

resourcestring
  rstFlagsChanged = 'change flags';
  rstFileVersionChanged = 'change file version';
  rstProductVersionChanged = 'change product version';
  rstVersion      = 'Version';
  rstInvalidVersionInfoResource = 'Invalid version info resource';
  rstStringChanged = 'change string';
  rstStringAdded = 'add string';
  rstStringDeleted = 'delete string';
  rstCodePageChanged = 'change code page';
  rstKeyNameChanged = 'change string name';

{ TVersionStringValue }

(*----------------------------------------------------------------------------*
 | constructor TVersionStringValue.Create ()                                  |
 |                                                                            |
 | Create a version string value.  Version Info resources keep their strings  |
 | in a list of these classes.                                                |
 *----------------------------------------------------------------------------*)
constructor TVersionStringValue.Create(const AKeyName, AValue: string);
begin
  fKeyName := AKeyName;
  fValue := AValue;
end;

{ TVersionInfoResource }

constructor TVersionInfoResource.Create(AParent: TResourceModule;
  AName: PWideChar;  ACustomType : PWideChar);
begin
  inherited Create (AParent, AName, ACustomType);
  fChildStrings := TObjectList.Create;
  fTranslations := TList.Create;
  fLangID := Language;
  fCodePage := 1252;
end;

constructor TVersionInfoResource.Create(AParent: TResourceModule;
  AName: PWideChar; ADataLen: Integer; AData: pointer; ACustomType : PWideChar);
begin
  inherited Create (AParent, AName, ADataLen, AData, ACustomType);
  fChildStrings := TObjectList.Create;
  fTranslations := TList.Create;
  fLangID := Language;
  fCodePage := 1252;
end;

destructor TVersionInfoResource.Destroy;
begin
  fChildStrings.Free;
  fTranslations.Free;
  inherited
end;

function TVersionInfoResource.GetFileFlags: TVersionFileFlags;
var
  flags : Integer;
begin
  if fFixedInfo = Nil then GetFixedFileInfo;
  result := [];
  flags := fFixedInfo^.dwFileFlags and fFixedInfo^.dwFileFlagsMask;

  if (flags and VS_FF_DEBUG)        <> 0 then result := result + [ffDebug];
  if (flags and VS_FF_INFOINFERRED) <> 0 then result := result + [ffInfoInferred];
  if (flags and VS_FF_PATCHED)      <> 0 then result := result + [ffPatched];
  if (flags and VS_FF_PRERELEASE)   <> 0 then result := result + [ffPreRelease];
  if (flags and VS_FF_PRIVATEBUILD) <> 0 then result := result + [ffPrivateBuild];
  if (flags and VS_FF_SPECIALBUILD) <> 0 then result := result + [ffSpecialBuild];
end;

function TVersionInfoResource.GetFileVersion: TULargeInteger;
begin
  if fFixedInfo = Nil then GetFixedFileInfo;
  result.LowPart := fFixedInfo^.dwFileVersionLS;
  result.HighPart := fFixedInfo^.dwFileVersionMS;
end;

function TVersionInfoResource.GetFixedFileInfo: PVSFixedFileInfo;
var
  p : PChar;
  t, wLength, wValueLength, wType : word;
  key : string;

  varwLength, varwValueLength, varwType : word;
  varKey : string;

  function GetVersionHeader (var p : PChar; var wLength, wValueLength, wType : word; var key : string) : Integer;
  var
    szKey : PWideChar;
    baseP : PChar;
  begin
    baseP := p;
    wLength := PWord (p)^;
    Inc (p, sizeof (word));
    wValueLength := PWord (p)^;
    Inc (p, sizeof (word));
    wType := PWord (p)^;
    Inc (p, sizeof (word));
    szKey := PWideChar (p);
    Inc (p, (lstrlenw (szKey) + 1) * sizeof (WideChar));
    while Integer (p) mod 4 <> 0 do
      Inc (p);
    result := p - baseP;
    key := szKey;
  end;

  procedure GetStringChildren (var base : PChar; len : word);
  var
    p, strBase : PChar;
    t, wLength, wValueLength, wType, wStrLength, wStrValueLength, wStrType : word;
    key, value : string;
    langID, codePage : Integer;

  begin
    p := base;
    while (p - base) < len do
    begin
      t := GetVersionHeader (p, wLength, wValueLength, wType, key);
      Dec (wLength, t);

      langID := StrToInt ('$' + Copy (key, 1, 4));
      codePage := StrToInt ('$' + Copy (key, 5, 4));

      fLangID := langID;
      fCodePage := codePage;

      strBase := p;
      fChildStrings.Clear;
      fTranslations.Clear;

      while (p - strBase) < wLength do
      begin
        t := GetVersionHeader (p, wStrLength, wStrValueLength, wStrType, key);
        Dec (wStrLength, t);

        if wStrValueLength = 0 then
          value := ''
        else
          value := PWideChar (p);
        Inc (p, wStrLength);
        while Integer (p) mod 4 <> 0 do
          Inc (p);

        fChildStrings.Add (TVersionStringValue.Create (key, value));
      end
    end;
    base := p
  end;

  procedure GetVarChildren (var base : PChar; len : word);
  var
    p, strBase : PChar;
    t, wLength, wValueLength, wType: word;
    key : string;
    v : DWORD;
  begin
    p := base;
    while (p - base) < len do
    begin
      t := GetVersionHeader (p, wLength, wValueLength, wType, key);
      Dec (wLength, t);

      strBase := p;
      fTranslations.Clear;

      while (p - strBase) < wLength do
      begin
        v := PDWORD (p)^;
        Inc (p, sizeof (DWORD));
        fTranslations.Add (pointer (v));
      end
    end;
    base := p
  end;

begin
  p := data.memory;
  GetVersionHeader (p, wLength, wValueLength, wType, key);

  if wValueLength <> 0 then
  begin
    fFixedInfo := PVSFixedFileInfo (p);
    if fFixedInfo^.dwSignature <> $feef04bd then
      raise Exception.Create (rstInvalidVersionInfoResource);

    Inc (p, wValueLength);
    while Integer (p) mod 4 <> 0 do
      Inc (p);
  end
  else
    fFixedInfo := Nil;

  while wLength > (p - data.memory) do
  begin
    t := GetVersionHeader (p, varwLength, varwValueLength, varwType, varKey);
    Dec (varwLength, t);

    if varKey = 'StringFileInfo' then
      GetStringChildren (p, varwLength)
    else
      if varKey = 'VarFileInfo' then
        GetVarChildren (p, varwLength)
      else
        break;
  end;
  result := fFixedInfo;
end;

function TVersionInfoResource.GetProductVersion: TULargeInteger;
begin
  if fFixedInfo = Nil then GetFixedFileInfo;
  result.LowPart := fFixedInfo^.dwProductVersionLS;
  result.HighPart := fFixedInfo^.dwProductVersionMS
end;

class function TVersionInfoResource.GetResourceType: word;
begin
  result := word (RT_VERSION);
end;

class function TVersionInfoResource.GetResourceTypeClass: string;
begin
  result := rstVersion
end;

procedure TVersionInfoResource.ExportToStream(strm: TStream; const ext : string);
var
  zeros, v : DWORD;
  wSize : WORD;
  stringInfoStream : TMemoryStream;
  strg : TVersionStringValue;
  i, p, p1 : Integer;
  wValue : WideString;

  procedure PadStream (strm : TStream);
  begin
    if strm.Position mod 4 <> 0 then
      strm.Write (zeros, 4 - (strm.Position mod 4))
  end;

  procedure SaveVersionHeader (strm : TStream; wLength, wValueLength, wType : word; const key : string; const value);
  var
    wKey : WideString;
    valueLen : word;
    keyLen : word;
  begin
    wKey := key;
    strm.Write (wLength, sizeof (wLength));

    strm.Write (wValueLength, sizeof (wValueLength));
    strm.Write (wType, sizeof (wType));
    keyLen := (Length (wKey) + 1) * sizeof (WideChar);
    strm.Write (wKey [1], keyLen);

    PadStream (strm);

    if wValueLength > 0 then
    begin
      valueLen := wValueLength;
      if wType = 1 then
        valueLen := valueLen * sizeof (WideChar);
      strm.Write (value, valueLen)
    end;
  end;

begin { ExportToStream }
  if fFixedInfo = Nil then GetFixedFileInfo;
  if fFixedInfo <> Nil then
  begin
    zeros := 0;

    SaveVersionHeader (strm, 0, sizeof (fFixedInfo^), 0, 'VS_VERSION_INFO', fFixedInfo^);

    if fChildStrings.Count > 0 then
    begin
      stringInfoStream := TMemoryStream.Create;
      try
        SaveVersionHeader (stringInfoStream, 0, 0, 0, IntToHex (fLangID, 4) + IntToHex (fCodePage, 4), zeros);

        for i := 0 to fChildStrings.Count - 1 do
        begin
          PadStream (stringInfoStream);

          p := stringInfoStream.Position;
          strg := TVersionStringValue (fChildStrings [i]);
          wValue := strg.fValue;
          SaveVersionHeader (stringInfoStream, 0, Length (strg.fValue) + 1, 1, strg.KeyName, wValue [1]);
          wSize := stringInfoStream.Size - p;
          stringInfoStream.Seek (p, soFromBeginning);
          stringInfoStream.Write (wSize, sizeof (wSize));
          stringInfoStream.Seek (0, soFromEnd);

        end;

        stringInfoStream.Seek (0, soFromBeginning);
        wSize := stringInfoStream.Size;
        stringInfoStream.Write (wSize, sizeof (wSize));

        PadStream (strm);
        p := strm.Position;
        SaveVersionHeader (strm, 0, 0, 0, 'StringFileInfo', zeros);
        strm.Write (stringInfoStream.Memory^, stringInfoStream.size);
        wSize := strm.Size - p;
      finally
        stringInfoStream.Free
      end;
      strm.Seek (p, soFromBeginning);
      strm.Write (wSize, sizeof (wSize));
      strm.Seek (0, soFromEnd)
    end;

    if fTranslations.Count > 0 then
    begin
      PadStream (strm);
      p := strm.Position;
      SaveVersionHeader (strm, 0, 0, 0, 'VarFileInfo', zeros);
      PadStream (strm);

      p1 := strm.Position;
      SaveVersionHeader (strm, 0, 0, 0, 'Translations', zeros);

      for i := 0 to fTranslations.Count - 1 do
      begin
        v := Integer (fTranslations [i]);
        strm.Write (v, sizeof (v))
      end;

      wSize := strm.Size - p1;
      strm.Seek (p1, soFromBeginning);
      strm.Write (wSize, sizeof (wSize));
      wSize := sizeof (Integer) * fTranslations.Count;
      strm.Write (wSize, sizeof (wSize));

      wSize := strm.Size - p;
      strm.Seek (p, soFromBeginning);
      strm.Write (wSize, sizeof (wSize));
    end;

    strm.Seek (0, soFromBeginning);
    wSize := strm.Size;
    strm.Write (wSize, sizeof (wSize));
    strm.Seek (0, soFromEnd);
  end
  else
    raise Exception.Create ('Invalid version resource');
end;

procedure TVersionInfoResource.SetFileFlags(
  const Value: TVersionFileFlags);
var
  flags : DWORD;
begin
  if fFixedInfo = Nil then GetFixedFileInfo;

  flags := 0;
  if ffDebug in value then flags := flags or VS_FF_DEBUG;
  if ffInfoInferred in value then flags := flags or VS_FF_INFOINFERRED;
  if ffPatched in value then flags := flags or VS_FF_PATCHED;
  if ffPreRelease in value then flags := flags or VS_FF_PRERELEASE;
  if ffPrivateBuild in value then flags := flags or VS_FF_PRIVATEBUILD;
  if ffSpecialBuild in value then flags := flags or VS_FF_SPECIALBUILD;

  if (fFixedInfo^.dwFileFlags and fFixedInfo^.dwFileFlagsMask) <> flags then
  begin
    AddUndoEntry (rstFlagsChanged);
    fFixedInfo^.dwFileFlags := (fFixedInfo^.dwFileFlags and not fFixedInfo^.dwFileFlagsMask) or flags;
    NotifyChange
  end
end;

procedure TVersionInfoResource.SetFileVersion(const Value: TULargeInteger);
begin
  if fFixedInfo = Nil then GetFixedFileInfo;
  if (value.LowPart <> fFixedInfo^.dwFileVersionLS) or (value.HighPart <> fFixedInfo^.dwFileVersionMS) then
  begin
    AddUndoEntry (rstFileVersionChanged);
    fFixedInfo^.dwFileVersionLS := value.LowPart;
    fFixedInfo^.dwFileVersionMS := value.HighPart;
    NotifyChange;
  end
end;

procedure TVersionInfoResource.SetProductVersion(
  const Value: TULargeInteger);
begin
  if fFixedInfo = Nil then GetFixedFileInfo;
  if (value.LowPart <> fFixedInfo^.dwProductVersionLS) or (value.HighPart <> fFixedInfo^.dwProductVersionMS) then
  begin
    AddUndoEntry (rstProductVersionChanged);
    fFixedInfo^.dwProductVersionLS := value.LowPart;
    ffixedInfo^.dwProductVersionMS := value.HighPart;
    NotifyChange;
  end
end;

procedure TVersionInfoResource.NotifyChange;
begin
  fFixedInfo := Nil;
  inherited;
end;

function TVersionInfoResource.GetKeyCount: Integer;
begin
  if fFixedInfo = Nil then GetFixedFileInfo;
  result := fChildStrings.Count
end;

function TVersionInfoResource.GetKey(idx: Integer): TVersionStringValue;
begin
  if fFixedInfo = Nil then GetFixedFileInfo;
  result := TVersionStringValue (fChildStrings [idx])
end;

procedure TVersionInfoResource.DeleteKey(idx: Integer);
begin
  AddUndoEntry (rstStringDeleted);
  fChildStrings.Delete (idx);
  UpdateData
end;

procedure TVersionInfoResource.UpdateData;
var
  st : TMemoryStream;
begin
  st := TMemoryStream.Create;
  try
    ExportToStream (st, '');
    st.Seek (0, soFromBeginning);
    data.Seek (0, soFromBeginning);
    data.size := 0;
    data.CopyFrom (st, st.Size);
    NotifyChange;
  finally
    st.Free
  end
end;

procedure TVersionInfoResource.SetLangID(const Value: Integer);
begin
  if fLangID <> Value then
  begin
    fLangID := Value;
    AddUndoEntry (rstCodePageChanged);
    UpdateData
  end
end;

function TVersionInfoResource.IndexOf(const AKeyName: string): Integer;
var
  i : Integer;
  k : TVersionStringValue;
begin
  result := -1;
  for i := 0 to KeyCount - 1 do
  begin
    k := Key [i];
    if CompareText (k.KeyName, AKeyName) = 0 then
    begin
      result := i;
      break
    end
  end;
end;

procedure TVersionInfoResource.ChangeKey(const AOldKey, ANewKey: string);
var
  idx : Integer;
begin
  if AOldKey <> ANewKey then
  begin
    idx := IndexOf (AOldKey);
    if idx > -1 then
    begin
      AddUndoEntry (rstKeyNameChanged);
      Key [idx].fKeyName := ANewKey;
      UpdateData
    end
    else
      SetKeyValue (ANewKey, '')
  end
end;

function TVersionInfoResource.SetKeyValue(const AKeyName, AValue: string): Integer;
var
  idx : Integer;
  k : TVersionStringValue;
begin
  idx := IndexOf (AKeyName);

  if idx = -1 then
  begin
    if AKeyName <> '' then
    begin
      AddUndoEntry (rstStringAdded);
      idx := fChildStrings.Add (TVersionStringValue.Create (AKeyNAme, AValue))
    end
  end
  else
  begin
    k := Key [idx];
    if (AValue <> k.fValue) or (AKeyName <> k.fKeyName) then
    begin
      k.fKeyName := AKeyName;
      k.fValue := AValue;
      AddUndoEntry (rstStringChanged)
    end
  end;

  result := idx;
  UpdateData
end;

end.
