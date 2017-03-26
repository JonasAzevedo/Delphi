(*===========================================================================*
 | unit ResourceMessages                                                     |
 |                                                                           |
 | Version  Date      By    Description                                      |
 | -------  --------  ----  -------------------------------------------------|
 | 1.0      02/12/98  CPWW  Original                                         |
 *===========================================================================*)

unit ResourceMessages;

interface

uses Windows, Classes, SysUtils, ResourceModule;

type
  TTextResource = class (TWriteableResource)
  protected
    procedure ExportToStream (stream : TStream; const ext : string); override;
  public
    class function GetFilter : string; override;
    procedure GetStrings (s : TStrings); virtual; abstract;
    procedure SetStrings (s : TStrings); virtual; abstract;
  end;

//=============================================================================
// TMessagesResource class.  Encapsulates a MESSAGETABLE resource

  TMessagesResource = class (TTextResource)
  private
    function GetBlockCount: Integer;
    property BlockCount : Integer read GetBlockCount;
    function GetLowMessageNo (blockNo : Integer) : DWORD;
    function GetUnicode (blockNo : Integer) : boolean;
    procedure GetStringsForBlock (blockNo : Integer; s : TStrings);
    function AddBlock (LowMessageNo : Integer; unicode : boolean; s : TStrings) : Integer;

  protected
    class function GetResourceTypeClass : string; override;
    function GetWriteableResourceStyles: TWriteableResourceStyles; override;

    property Unicode [index : Integer] : boolean read GetUnicode;
    property LowMessageNo [index : Integer] : DWORD read GetLowMessageNo;

  public
    class function GetResourceType : word; override;
    procedure GetStrings (s : TStrings); override;
    procedure SetStrings (s : TStrings); override;
    procedure Initialize; override;
    procedure InitializeFromFile (const fileName : string); override;
  end;

//=============================================================================
// TStringsResource class.  Encapsulates a STRINGTABLE resource

  TStringsResource = class (TTextResource)
  private
  protected
    class function GetResourceTypeClass : string; override;
    function GetWriteableResourceStyles: TWriteableResourceStyles; override;
    procedure ExportRCSnippetToStream (stream : TStream); override;
    function GetResourceName : string; override;      // 'Get' method for ResourceName property
  public
                                          // Override the constructor for new
                                          // stringtables so we can check that the
                                          // name is an integer.
    constructor Create (AParent : TResourceModule; AName : PWideChar; ACustomType : PWideChar = Nil); override;
    class function GetResourceType : word; override;

    procedure GetStrings (s : TStrings); override;
    procedure SetStrings (s : TStrings); override;
    procedure Initialize; override;
    procedure InitializeFromFile (const fileName : string); override;
    function RequireNumericID : boolean; override;
  end;

implementation

{ TMessagesResource }

type
//=============================================================================
// TMessageResourceBlock resource structure
// Header for a message table block
TMessageResourceBlock = record
  lowID : DWORD;
  highID : DWORD;
  entryOffset : DWORD   // Offset to entries from the start of the message resource
end;
PMessageResourceBlock = ^TMessageResourceBlock;

resourcestring
  rstMessageTable = 'Message Table';
  rstStrings      = 'Strings';
  rstInvalidBlockNo = 'Invalid block no in message resource';
  rstBadStringResourceID = 'String resources must have numeric IDs';

(*----------------------------------------------------------------------------*
 | TMessageResource.AddBlock                                                  |                                          |
 |                                                                            |
 | A message resource consists of a message resource header, several block    |
 | headers, followed by the messages themselves.
 *----------------------------------------------------------------------------*)
function TMessagesResource.AddBlock(LowMessageNo: Integer;
  unicode: boolean; s: TStrings): Integer;
var
  blockHeader : PMessageResourceBlock;
  bufLen : DWORD;
  len, flags, size : word;
  buffer : PChar;
  i, pos, p : Integer;
  ws : WideString;

//--------------------------------------------------------------------------
// Insert a block header after the other block headers, but before the
// messages.  So we need to move the messages, and adjust all the other
// block headers so that they still point to their (moved) messages
//--------------------------------------------------------------------------
  function InsertBlockHeader : PMessageResourceBlock;
  var
    headerSize : Integer;
    p : PChar;
    p1 : PChar;
    i : Integer;
  begin
    headerSize := sizeof (DWORD) + blockCount * sizeof (TMessageResourceBlock);
    data.Size := data.size + sizeof (TMessageResourceBlock);

    p := data.Memory;
    Inc (p, headerSize);                        // Old start of messages
    p1 := p;
    Inc (p1, sizeof (TMessageResourceBlock));   // New start of messages

    if blockCount > 0 then
      Move (p^, p1^, data.Size - headerSize - sizeof (TMessageResourceBlock));
                                                // Shift messages to make space for
                                                // new message block

    p := data.Memory;                           // Adjust message block headers to point
    Inc (p, sizeof (DWORD));                    // to moved messages
    for i := 0 to blockCount - 1 do
    begin
      Inc (PMessageResourceBlock (p)^.entryOffset, sizeof (TMessageResourceBlock));
      Inc (p, sizeof (TMessageResourceBlock))
    end;

    Inc (PDWORD (data.Memory)^);               // Increment block count

    p := Data.Memory;                          // Return new message resource block
    Inc (p, headerSize);
    result := PMessageResourceBlock (p)
  end;

begin { TMessageResource.AddBlock}
  if s.Count > 0 then
  begin
    bufLen := 0;
    for i := 0 to s.Count - 1 do
    begin
      if unicode then
        size := (Length (s [i]) + 1) * sizeof (WideChar)
      else
        size := Length (s [i]) + 1;

      size := size + 2 * sizeof (word);      // Leave space for 'size & flags'
      while (size mod 4) <> 0 do             // DWORD align.
        Inc (size);

      Inc (bufLen, size);
    end;

    GetMem (buffer, bufLen);                 // Create a temporary buffer for the
                                             // messages.
    try
                                             // Create a new block header for the
                                             // messages
      blockHeader := InsertBlockHeader;
      blockHeader^.lowID := LowMessageNo;
      blockHeader^.highID := LowMessageNo + s.Count - 1;
      data.Seek (0, soFromEnd);
                                            // Messages will be added to the end of
                                            // the data.  Make the new block header
                                            // point to them
      blockHeader^.entryOffset := data.Position;

      pos := 0;
      if unicode then flags := 1 else flags := 0;

                                            // Add each message to the temporary
                                            // buffer.
      for i := 0 to s.Count - 1 do
      begin
        if unicode then
        begin
          ws := s [i];
          len := Length (ws);
          size := (len + 1) * sizeof (WideChar);
        end
        else
        begin
          len := Length (s [i]);
          size := len + 1;
        end;

        len := size + 2 * sizeof (word);
        while (len mod 4 ) <> 0 do
          Inc (len);


        p := pos;                           // Save the 'len' word first
        move (len, buffer [pos], sizeof (len));
        Inc (pos, sizeof (len));

                                            // Then the flags word
        move (flags, buffer [pos], sizeof (flags));
        Inc (pos, sizeof (flags));

                                            // Then the string itself
        if unicode then
          Move (PWideChar (ws)^, buffer [pos], size)
        else
          Move (PChar (s [i])^, buffer [pos], size);

        pos := p + len;
      end;

                                            // Copy from the temporary buffer to
                                            // the resource's stream.
      data.WriteBuffer (buffer^, pos);
    finally
      FreeMem (buffer)
    end;
  end;
  result := 0;
end;

(*----------------------------------------------------------------------------*
 | TMessageResource.GetBlockCount                                             |
 |                                                                            |
 | Return the count of message blocks held in this resource.  It's easy -     |
 | it's the first four bytes of the resource.                                 |
 *----------------------------------------------------------------------------*)
function TMessagesResource.GetBlockCount: Integer;
begin
  result := PInteger (data.memory)^
end;

(*----------------------------------------------------------------------------*
 | TMessageResource.GetLowMessageNo                                           |
 |                                                                            |
 | Get the low message number for the first message in a block.               |
 *----------------------------------------------------------------------------*)
function TMessagesResource.GetLowMessageNo(blockNo: Integer): DWORD;
var
  p : PChar;
begin
  if blockNo >= BlockCount then
    raise Exception.Create (rstInvalidBlockNo);
  p := data.memory;
  Inc (p, sizeof (DWORD));                         // Skip block count -
                                                   // p now points to the block
                                                   // headers.
  while blockNo > 0 do
  begin
    Inc (p, sizeof (TMessageResourceBlock));
    Dec (blockNo)
  end;

  result := PMessageResourceBlock (p)^.lowID;
end;

(*----------------------------------------------------------------------------*
 | TMessageResource.GetStrings                                                |
 |                                                                            |
 | Get the resource messages.  The string list objects are the message IDs.   |
 *----------------------------------------------------------------------------*)
procedure TMessagesResource.GetStrings(s: TStrings);
var
  i : Integer;
begin
  s.BeginUpdate;
  try
    s.Clear;
    for i := 0 to BlockCount - 1 do
      GetStringsForBlock (i, s);
  finally
    s.EndUpdate
  end
end;

(*----------------------------------------------------------------------------*
 | TMessageResource.GetStringsForBlock                                        |
 |                                                                            |
 | Get the messages for a particular message block.  The string list objects  |
 | are the message IDs.                                                       |
 *----------------------------------------------------------------------------*)
procedure TMessagesResource.GetStringsForBlock(blockNo: Integer;
  s: TStrings);
var
  lowMessageNo, highMessageNo, entryOffset : DWORD;
  p : PChar;
  i : DWORD;
  len, flags : word;
  msg : PChar;
begin
  if blockNo >= BlockCount then
    raise Exception.Create ('Invalid block no');
  p := data.memory;
  Inc (p, sizeof (DWORD));
  while blockNo > 0 do               // Find the block header for the required
  begin                              // block.

    Inc (p, sizeof (TMessageResourceBlock));
    Dec (blockNo)
  end;

  lowMessageNo := PMessageResourceBlock (p)^.lowID;
  highMessageNo := PMessageResourceBlock (p)^.highID;
  entryOffset := PMessageResourceBlock (p)^.entryOffset;

  p := data.memory;
  Inc (p, entryOffset);              // 'p' points to the block's messages

  i := lowMessageNo;
  while i <= highMessageNo do
  begin
    len := PWORD (p)^ - 2 * sizeof (WORD);
    Inc (p, sizeof (len));
    flags := PWORD (p)^;
    Inc (p, sizeof (flags));
    if (flags and 1) = 1 then         // Unicode ?
      GetMem (msg, (len + 1) * sizeof (WideChar))
    else
      GetMem (msg, len + 1);

    try
      Move (p^, msg^, len);
      msg [len] := #0;
      if (flags and 1) = 1 then
        s.AddObject (PWideChar (msg), TObject (i))
      else
        s.AddObject (msg, TObject (i));

    finally
      FreeMem (msg)
    end;

    Inc (p, len);
    Inc (i)
  end
end;

(*----------------------------------------------------------------------------*
 | TMessageResource.GetUnicode                                                |
 |                                                                            |
 | Return True if the first message in a resource block is unicode            |
 *----------------------------------------------------------------------------*)
function TMessagesResource.GetUnicode(blockNo: Integer): boolean;
var
  p : PChar;
  entryOffset : DWORD;
begin
  if blockNo >= BlockCount then
    raise Exception.Create ('Invalid block no');

  p := data.memory;
  Inc (p, sizeof (DWORD));
  while blockNo > 0 do
  begin
    Inc (p, sizeof (TMessageResourceBlock));
    Dec (blockNo)
  end;

  entryOffset := PMessageResourceBlock (p)^.entryOffset;

  p := data.memory;
  Inc (p, entryOffset + sizeof (word));
  result := PWORD (p)^ <> 0
end;

(*----------------------------------------------------------------------------*
 | TMessageResource.Initialize                                                |
 |                                                                            |
 | Initialize a new message resource                                          |
 *----------------------------------------------------------------------------*)
procedure TMessagesResource.Initialize;
begin
  Data.SetSize (sizeof (Integer));
  ZeroMemory (data.Memory, data.Size);
  inherited
end;

(*----------------------------------------------------------------------------*
 | TMessageResource.GetResourceType                                           |
 *----------------------------------------------------------------------------*)
class function TMessagesResource.GetResourceType: word;
begin
  result := word (RT_MESSAGETABLE);
end;

(*----------------------------------------------------------------------------*
 | TMessageResource.SetStrings                                                |
 |                                                                            |
 | Set messages from a string list with the objects containing the message IDs|
 |                                                                            |
 | Put each set of contiguous strings in it's own message block.              |
 *----------------------------------------------------------------------------*)
procedure TMessagesResource.SetStrings(s: TStrings);
var
  sBuffer : TStringList;
  i : Integer;
  messageNo, lowMessageNo, lastMessageNo : Integer;
  startBlock : boolean;
begin
  lowMessageNo := 0;
  lastMessageNo := 0;
  Data.SetSize (sizeof (Integer));
  ZeroMemory (data.Memory, data.Size);

  sBuffer := TStringList.Create;
  try
    startBlock := True;
    i := 0;
    while i < s.Count do
    begin
      messageNo := Integer (s.Objects [i]);

      if (not startBlock) and (messageNo <> lastMessageNo + 1) then
      begin    // Break in contigousness - save the block
        if sBuffer.Count > 0 then
        begin
          AddBlock (lowMessageNo, False, sBuffer);
          sBuffer.Clear
        end;

        startBlock := True
      end;

      if startBlock then
      begin
        lowMessageNo := messageNo;
        startBlock := False
      end;

      sBuffer.AddObject (s [i], TObject (messageNo));
      Inc (i)
    end;

    if sBuffer.Count > 0 then
      AddBlock (lowMessageNo, False, sBuffer);
  finally
    sBuffer.Free
  end;
  NotifyChange
end;

{ TStringsResource }

(*----------------------------------------------------------------------------*
 | constructor TStringsResource.Create                                        |
 |                                                                            |
 | Override the constructor for Strings resources to ensure that the name is  |
 | an 'Integer' name.                                                         |
 *----------------------------------------------------------------------------*)

constructor TStringsResource.Create(AParent: TResourceModule;
  AName: PWideChar;  ACustomType : PWideChar);
begin
  if (Integer (AName) and $ffff0000) = 0 then
    inherited Create (AParent, PWideChar ((Integer (AName) shr 4)  + 1), ACustomType)
  else
    raise Exception.Create (rstBadStringresourceID);
end;

(*----------------------------------------------------------------------------*
 | TStringsResource.GetResourceName                                           |
 |                                                                            |
 | String resource names are the ID of the first resource in the block of 16  |
 | strings.  Each string resource name therefore must be exactly divisible by |
 | 16.                                                                        |
 *----------------------------------------------------------------------------*)
function TStringsResource.GetResourceName: string;
begin
  result := Format ('%d', [(Integer (RawName)  - 1) shl 4])
end;

(*----------------------------------------------------------------------------*
 | TStringsResource.GetStrings                                                |
 |                                                                            |
 | Get the strings from the strings resource into a 'TStrings' construct.     |
 *----------------------------------------------------------------------------*)
procedure TStringsResource.GetStrings(s: TStrings);
var
  p : PWideChar;
  Cnt, ID : Integer;
  st : string;
begin
  s.BeginUpdate;
  with s do
  try
    Clear;
    P := Data.Memory;
    Cnt := 0;
    while Cnt < 16 do
    begin
      ID := StrToInt (ResourceName) + Cnt;
      st := ResourceWideCharToStr(P);
      if st <> '' then
        AddObject (st, TObject (ID));
      Inc (cnt);
    end
  finally
    EndUpdate;
  end;
end;

(*----------------------------------------------------------------------------*
 | TStringsResource.Initialize                                                |
 |                                                                            |
 | Initialize a new string resource                                           |
 *----------------------------------------------------------------------------*)
procedure TStringsResource.Initialize;
begin
  Data.SetSize (16 * sizeof (word));
  ZeroMemory (data.Memory, data.Size);
  inherited
end;

(*----------------------------------------------------------------------------*
 | TStringResource.GetResourceType                                            |
 *----------------------------------------------------------------------------*)
class function TStringsResource.GetResourceType: word;
begin
  result := word (RT_STRING)
end;

procedure TStringsResource.SetStrings(s: TStrings);
var
  len, i : Integer;
  p : PWideChar;
begin
  len := 16 * sizeof (word);
  for i := 0 to s.Count - 1 do
    len := len + sizeof (WideChar) * Length (s [i]);

  Data.Size := len;

  p := Data.Memory;
  ZeroMemory (Data.Memory, len);
  for i := 0 to s.Count - 1 do
    ResourceStrToWideChar (s [i], p);
  NotifyChange
end;

class function TMessagesResource.GetResourceTypeClass: string;
begin
  result := rstMessageTable;

end;

class function TStringsResource.GetResourceTypeClass: string;
begin
  result := rstStrings;
end;

procedure TTextResource.ExportToStream(stream: TStream; const ext: string);
var
  s : TStringList;
begin
  s := TStringList.Create;
  try
    GetStrings (s);
    s.SaveToStream (stream)
  finally
    s.Free
  end
end;

class function TTextResource.GetFilter: string;
begin
  result := rstTextFilter
end;

procedure TStringsResource.InitializeFromFile(const fileName: string);
var
  s, s1 : TStringList;
  i : Integer;
  res : TStringsResource;
begin
  Initialize;
  s1 := Nil;
  s := TStringList.Create;
  try
    s1 := TStringList.Create;
    s.LoadFromFile (fileName);
    i := 0;
    res := self;
    repeat
      s1.Clear;
      while (i < s.Count) and (s1.Count < 16) do
      begin
        s1.Add (s [i]);
        Inc (i)
      end;

      if res = Nil then
      begin
        res := TStringsResource.Create (Parent, PWideChar (Parent.GetUniqueResourceName (TStringsResource) * 16));
        res.Initialize
      end;

      if s1.Count > 0 then
        res.SetStrings (s1);
      res := Nil;
    until i >= s.Count
  finally
    s.Free;
    s1.Free
  end
end;

procedure TStringsResource.ExportRCSnippetToStream(stream: TStream);
var
  i : Integer;
  s : TStringList;
  st : string;
begin
  s := TStringList.Create;
  try
    GetStrings (s);
    st := 'STRINGTABLE';

    if language <> 0 then
      st := st + Format (' LANGUAGE %x,%x', [language and $3ff, language shr 10]);

    st := st + #13#10'{'#13#10;
    stream.Write (PChar (st)^, Length (st));

    for i := 0 to  s.Count - 1 do
    begin
      st := Format ('    %d'#9'"%s"'#13#10, [Integer (s.Objects [i]), s [i]]);
      stream.Write (PChar (st)^, Length (st));
    end;
    st := '}'#13#10;
    stream.Write (PChar (st)^, Length (st));
  finally
    s.Free
  end
end;


procedure TMessagesResource.InitializeFromFile(const fileName: string);
var
  s : TStringList;
begin
  Initialize;
  s := TStringList.Create;
  try
    s.LoadFromFile (fileName);
    SetStrings (s)
  finally
    s.Free
  end
end;

function TMessagesResource.GetWriteableResourceStyles: TWriteableResourceStyles;
begin
  result := inherited GetWriteableResourceStyles + [wsExportable]
end;

function TStringsResource.GetWriteableResourceStyles: TWriteableResourceStyles;
begin
  result := inherited GetWriteableResourceStyles + [wsExportable, wsSnippetable];
end;

function TStringsResource.RequireNumericID: boolean;
begin
  result := True
end;

initialization
  RegisterWriteableResources ([TStringsResource, TMessagesResource]);
end.
