(*===========================================================================*
 | unit ResourceGraphics                                                     |
 |                                                                           |
 | Version  Date      By    Description                                      |
 | -------  --------  ----  -------------------------------------------------|
 | 1.0      02/12/98  CPWW  Original                                         |
 |             03/00  CPWW  Icons & Cursors consolidated with happy format   |
 *===========================================================================*)

unit ResourceGraphics;

interface
uses Windows, Classes, SysUtils, Graphics, unitExGraphics, ResourceModule;

type
  TGroupResource = class;

  TGraphicsResource = class (TWriteableResource)
  protected
  public
    constructor Create (AParent : TResourceModule; AName : PWideChar; ADataLen :  Integer; AData : pointer; ACustomType : PWideChar = Nil); override;
    procedure GetImage (image : TPicture); virtual; abstract;
    procedure SetImage (image : TPicture; const undoDescription : string = ''); virtual; abstract;
    procedure NotifyChange; override;
  end;

  TIconCursorResource = class (TGraphicsResource)
  private
    fInitPixelFormat : TPixelFormat;
    fInitWidth : Integer;
    fInitHeight : Integer;

    function GetPixelFormat: TPixelFormat;
    function GetHeight: Integer;
    function GetWidth: Integer;
    function GetBitsPerPixel: Integer;
    function GetColorCount: Integer;
    procedure SetPixelFormat(const Value: TPixelFormat);
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  protected
    fBitmapInfoOffset : DWORD;
    procedure SetResourceName(const Value: string); override;
  public
    property PixelFormat : TPixelFormat read GetPixelFormat write SetPixelFormat;
    property Width : Integer read GetWidth write SetWidth;
    property Height : Integer read GetHeight write SetHeight;
    property BitsPerPixel : Integer read GetBitsPerPixel;
    property ColorCount : Integer read GetColorCount;
    procedure Initialize; override;
    function GetResourceGroup : TGroupResource;
    function RequireNumericID : boolean; override;
  end;

//=============================================================================
// TCursorResource class.  Encapsulates a cursor resource

  TCursorResource = class (TIconCursorResource)
  private
    function GetHotspot: Integer;
  protected
    class function GetResourceTypeClass : string; override;
    procedure ExportToStream (stream : TStream; const ext : string); override;
    function GetWriteableResourceStyles: TWriteableResourceStyles; override;

  public
    constructor Create (AParent : TResourceModule; AName : PWideChar; ADataLen :  Integer; AData : pointer; ACustomType : PWideChar = Nil); override;
    class function GetResourceType : word; override;
    procedure GetImage (image : TPicture); override;
    procedure SetImage (image : TPicture; const undoDescription : string = ''); override;
    property Hotspot : Integer read GetHotspot;
  end;

  TIconDirEntry = packed record
    bWidth      : BYTE;          // Width, in pixels, of the image
    bHeight     : BYTE;         // Height, in pixels, of the image
    bColorCount : BYTE;     // Number of colors in image (0 if >=8bpp)
    bReserved   : BYTE;       // Reserved ( must be 0)
    wPlanes     : WORD;         // Color Planes
    wBitCount   : WORD;       // Bits per pixel
    dwBytesInRes : DWORD;    // How many bytes in this resource?
    dwImageOffset : DWORD;   // Where in the file is this image?
  end;
  PIconDirEntry = ^TIconDirEntry;

//=============================================================================
// TIconResource class.  Encapsulates an icon resource

  TIconResource = class (TIconCursorResource)
  private
  protected
    class function GetResourceTypeClass : string; override;
    procedure ExportToStream (stream : TStream; const ext : string); override;
    function GetWriteableResourceStyles: TWriteableResourceStyles; override;
  public
    constructor Create (AParent : TResourceModule; AName : PWideChar; ADataLen :  Integer; AData : pointer; ACustomType : PWideChar = Nil); override;
    class function GetResourceType : word; override;
    procedure GetImage (image : TPicture); override;
    procedure SetImage (image : TPicture; const undoDescription : string = ''); override;
  end;

//=============================================================================
// TBitmapResource class.  Encapsulates a bitmap resource

  TBitmapResource = class (TGraphicsResource)
  private
    FDefaultHeight: Integer;
    FDefaultWidth: Integer;
    FDefaultPixelFormat: TPixelFormat;
  protected
    class function GetResourceTypeClass : string; override;
    procedure ExportToStream (stream : TStream; const ext : string); override;
    function GetWriteableResourceStyles: TWriteableResourceStyles; override;
  public
                                          // Return the bitmap
    constructor Create (AParent : TResourceModule; AName : PWideChar; ADataLen :  Integer; AData : pointer; ACustomType : PWideChar = Nil); override;
    class function GetResourceType : word; override;
    class function GetFilter : string; override;
    procedure InitializeFromFile (const fileName : string); override;
    procedure GetImage (image : TPicture); override;
    procedure SetImage (image : TPicture; const undoDescription : string = ''); override;
    procedure Initialize; override;
    property DefaultPixelFormat : TPixelFormat read FDefaultPixelFormat write FDefaultPixelFormat;
    property DefaultWidth : Integer read FDefaultWidth write FDefaultWidth;
    property DefaultHeight : Integer read FDefaultHeight write FDefaultHeight;
  end;

  //=============================================================================
// TGroupResource class.  Base class for CursorGroup and IconGroup resources

//
// RT_GROUP_ICON / RT_GROUP_CURSOR's resource directory structure
//
  TResourceDirectory = packed record
    details : packed record case boolean of
      False : (cursorWidth, cursorHeight : word);
      True : (iconWidth, iconHeight, iconColorCount, iconReserved : BYTE)
    end;
    wPlanes, wBitCount : word;
    lBytesInRes : DWORD;
    wNameOrdinal : word
  end;
  PResourceDirectory = ^TResourceDirectory;


  TGroupResource = class (TWriteableResource)
  private
    FDefaultWidth: Integer;
    FDefaultHeight: Integer;
    FDefaultPixelFormat: TPixelFormat;
    function GetResourceGroupCount : Integer;
    function GetResourceGroupResource (index : Integer ) : TResource;
  protected
    procedure ExportToStream (stream : TStream; const ext : string); override;
    function GetWriteableResourceStyles: TWriteableResourceStyles; override;

  public
    procedure GetGroupResourceAttributes (index : Integer; var attributes : TResourceDirectory);
    property ResourceGroupCount : Integer read GetResourceGroupCount;
    property ResourceGroupResource [index : Integer] : TResource read GetResourceGroupResource;
    procedure InitializeFromFile (const fileName : string); override;
    property DefaultPixelFormat : TPixelFormat read FDefaultPixelFormat write FDefaultPixelFormat;
    property DefaultWidth : Integer read FDefaultWidth write FDefaultWidth;
    property DefaultHeight : Integer read FDefaultHeight write FDefaultHeight;
    procedure Initialize; override;
    procedure AddResource (res : TIconCursorResource);
  end;

//=============================================================================
// TCursorGroupResource class.  Encapsulates cursor group resources

  TCursorGroupResource = class (TGroupResource)
  protected
  public
    constructor Create (AParent : TResourceModule; AName : PWideChar; ADataLen :  Integer; AData : pointer; ACustomType : PWideChar = Nil); override;
    class function GetResourceType : word; override;
    class function GetResourceTypeClass : string; override;
    class function GetFilter : string; override;
  end;

//=============================================================================
// TIconGroupResource class.  Encapsulates icon group resources

  TIconGroupResource = class (TGroupResource)
  private
  protected
  public
    constructor Create (AParent : TResourceModule; AName : PWideChar; ADataLen :  Integer; AData : pointer; ACustomType : PWideChar = Nil); override;
    class function GetResourceType : word; override;
    class function GetResourceTypeClass : string; override;
    class function GetFilter : string; override;
  end;

implementation

resourcestring
  rstCursor       = 'Cursor';
  rstBitmap       = 'Bitmap';
  rstIcon         = 'Icon';
  rstGroupCursor  = 'Cursors';
  rstGroupIcon    = 'Icons';

  rstBitmapFilter = 'Bitmap Files (*.bmp)|*.bmp';
  rstIconFilter   = 'Icon Files (*.ico)|*.ico';
  rstCursorFilter = 'Cursor Files (*.cur)|*.cur';
  rstJPEGFilter   = 'JPEG Files (*.jpg)|*.jpg';

  rstCursorChange = 'change cursor';
  rstIconChanged = 'icon changed';
  rstBitmapChanged = 'bitmap changed';

{ TGraphicsResource }

(*----------------------------------------------------------------------------*
 | constructor TGraphicsResource.Create ()                                    |
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
constructor TGraphicsResource.Create(AParent: TResourceModule;
  AName: PWideChar; ADataLen: Integer; AData: pointer;
  ACustomType: PWideChar);
begin
  inherited Create (AParent, AName, ADataLen, AData, ACustomType);
end;


function TIconCursorResource.GetResourceGroup: TGroupResource;
var
  i, j : Integer;
  res, mres : TResource;
  gres : TGroupResource;
begin
  result := Nil;
  for i := 0 to Parent.ResourceCount - 1 do
  begin
    res := Parent.Resource [i];
    if res is TGroupResource then
    begin
      gres := TGroupResource (res);
      for j := 0 to gres.ResourceGroupCount - 1 do
      begin
        mres := gres.ResourceGroupResource [j];
        if mres = self  then
        begin
          result := gres;
          break
        end
      end;

      if result <> Nil then
        break
    end
  end
end;


{ TIconCursorResource }

function TIconCursorResource.GetBitsPerPixel: Integer;
begin
  case PixelFormat of
    pf1Bit : result := 1;
    pf4Bit : result := 4;
    pf8Bit : result := 8;
    pf15Bit : result := 15;
    pf16Bit : result := 16;
    pf24Bit : result := 24;
    pf32Bit : result := 32;
    else
      raise Exception.Create ('Invalid pixel format in TIconResource');
  end
end;

function TIconCursorResource.GetColorCount: Integer;
begin
  result := 1 shl BitsPerPixel
end;

function TIconCursorResource.GetHeight: Integer;
var
  infoHeader : PBitmapInfoHeader;
begin
  if Data.Size = 0 then
    result := fInitHeight
  else
  begin
    infoHeader := PBitmapInfoHeader (PChar (Data.Memory) + fBitmapInfoOffset);
    result := infoHeader^.biHeight div 2
  end
end;

function TIconCursorResource.GetPixelFormat: TPixelFormat;
var
  infoHeader : PBitmapInfoHeader;
  pixelFormat : TPixelFormat;
begin
  if Data.Size = 0 then
    result := fInitPixelFormat
  else
  begin
    infoHeader := PBitmapInfoHeader (PChar (Data.Memory) + fBitmapInfoOffset);
    pixelFormat := pfCustom;
    with infoHeader^ do
      case biBitCount of
        1: pixelFormat := pf1Bit;
        4: pixelFormat := pf4Bit;
        8: pixelFormat := pf8Bit;
       16: case biCompression of
             BI_RGB : pixelFormat := pf15Bit;
             BI_BITFIELDS: pixelFormat := pf16Bit;
           end;
       24: pixelFormat := pf24Bit;
       32: if biCompression = BI_RGB then pixelFormat := pf32Bit
      end;

    result := pixelFormat
  end
end;

function TIconCursorResource.GetWidth: Integer;
var
  infoHeader : PBitmapInfoHeader;
begin
  if Data.Size = 0 then
    result := fInitWidth
  else
  begin
    infoHeader := PBitmapInfoHeader (PChar (Data.Memory) + fBitmapInfoOffset);
    result := infoHeader^.biWidth
  end
end;

procedure TIconCursorResource.Initialize;
var
  pal : array [0..255] of TPaletteEntry;
  p, pColorTable : PRGBQuad;
  pInfoHeader : PBitmapInfoHeader;
  pXORBitmap : PChar;
  pANDBitmap : PChar;
  i : Integer;
  cc, w, h, XORSize, ANDSIze, ccSize, bpp : Integer;
begin
  cc := ColorCount;
  w := Width;
  h := Height;
  bpp := BitsPerPixel;

  ANDSize := BytesPerScanline(w, 1, 32) * h;
  XORSize := BytesPerScanline(w, bpp, 32) * h;
  if cc <= 256 then
    ccSize := cc * sizeof (RGBQUAD)
  else
    ccSize := 0;

  data.Size := Integer (fBitmapInfoOffset) + sizeof (TBitmapInfoHeader) + ccSize + XORSize + ANDSize;
  ZeroMemory (data.Memory, data.Size);

  pInfoHeader := PBitmapInfoHeader (PChar (data.Memory) + fBitmapInfoOffset);
  pColorTable := PRGBQuad (PChar (data.Memory) + sizeof (TBitmapInfoHeader) + fBitmapInfoOffset);
  pXORBitmap  := PChar (pColorTable) + ccSize;
  PANDBitmap := PChar (pXORBitmap) + XORSize;

  with pInfoHeader^ do
  begin   
    biSize := sizeof (TBitmapInfoHeader);
    biWidth := w;
    biHeight := h * 2;
    biPlanes := 1;
    biCompression := BI_RGB;
    biSizeImage := XORSize;

    if bpp = 16 then
      biCompression := BI_BITFIELDS
    else
      if bpp = 15 then
        bpp := 16;

    biBitCount := bpp;
  end;

  p := pColorTable;
  case cc of
    2   : GetPaletteEntries (SystemPalette2, 0, cc, pal);
    16  : GetPaletteEntries (SystemPalette16, 0, cc, pal);
    256 : GetPaletteEntries (SystemPalette256, 0, cc, pal)
  end;

  if cc <= 256 then
    for i := 0 to cc - 1 do
    begin
      p^.rgbBlue := pal [i].peBlue;
      p^.rgbGreen := pal [i].peGreen;
      p^.rgbRed := pal [i].peRed;
      p^.rgbReserved := pal [i].peFlags;
      Inc (p)
    end;

  FillMemory (pANDBitmap, ANDSize, $ff);

  if fBitmapInfoOffset = sizeof (DWORD) then
    PDWORD (data.Memory)^ := TCursorResource (self).Hotspot;

  inherited;
end;

procedure TIconCursorResource.SetHeight(const Value: Integer);
begin
  if Data.Size <> 0 then
    raise Exception.Create ('Can''t change icon/cursor height');

  fInitHeight := value
end;

procedure TIconCursorResource.SetPixelFormat(const Value: TPixelFormat);
begin
  if Data.Size <> 0 then
    raise Exception.Create ('Can''t change icon/cursor pixel format');

  fInitPixelFormat := Value
end;

procedure TIconCursorResource.SetWidth(const Value: Integer);
begin
  if Data.Size <> 0 then
    raise Exception.Create ('Can''t change icon/cursor width');

  fInitWidth := value
end;

{ TCursorResource }

(*----------------------------------------------------------------------------*
 | class function TCursorResource.GetResourceType                             |
 |                                                                            |
 | Class function returns RT_CURSOR class                                     |
 *----------------------------------------------------------------------------*)
constructor TCursorResource.Create(AParent: TResourceModule;
  AName: PWideChar; ADataLen: Integer; AData: pointer;
  ACustomType: PWideChar);
begin
  inherited Create (AParent, AName, ADataLen, AData, ACustomType);
  fBitmapInfoOffset := sizeof (DWORD);
  fInitPixelFormat := pf1Bit;
  fInitWidth := GetSystemMetrics (SM_CXCURSOR);
  fInitHeight := GetSystemMetrics (SM_CYCURSOR);
end;

procedure TCursorResource.ExportToStream(stream: TStream; const ext : string);
var
  hdr : TIconHeader;
  dirEntry : TIconDirEntry;
begin
  hdr.wReserved := 0;
  hdr.wCount := 1;
  hdr.wType := 2; // 1 for icons
  stream.WriteBuffer (hdr, sizeof (hdr));

  dirEntry.bWidth := Width;
  dirEntry.bHeight := Height;
  dirEntry.bColorCount := 0;
  dirEntry.bReserved := 0;
  dirEntry.wPlanes := LOWORD (Hotspot);
  dirEntry.wBitCount := HIWORD (Hotspot);
  dirEntry.dwBytesInRes := Data.Size - sizeof (DWORD);
  dirEntry.dwImageOffset := sizeof (hdr) + sizeof (dirEntry);
  stream.WriteBuffer (dirEntry, sizeof (dirEntry));

  data.seek (sizeof (DWORD), soFromBeginning);  // step over hotspot
  stream.CopyFrom (data, data.size - data.position);
end;

function TCursorResource.GetHotspot: Integer;
begin
  if Data.Size = 0 then
    result := 0
  else
    result := PInteger (data.memory)^
end;

procedure TCursorResource.GetImage(image: TPicture);
var
  cursor : TExCursor;
begin
  cursor := TExCursor.Create;
  data.Seek (0, soFromBeginning);
  cursor.LoadFromStream (data);
  try
    image.Graphic := cursor
  finally
    cursor.Free
  end
end;

class function TCursorResource.GetResourceType: word;
begin
  result := word (RT_CURSOR);
end;

class function TCursorResource.GetResourceTypeClass: string;
begin
  result := rstCursor;
end;

function TCursorResource.GetWriteableResourceStyles: TWriteableResourceStyles;
begin
  result := [wsExportable]
end;

procedure TCursorResource.SetImage(image: TPicture; const undoDescription : string = '');
var
  st : TMemoryStream;
  offset : Integer;
begin
  if undoDescription = '' then
    AddUndoEntry (rstCursorChange)
  else
    AddUndoEntry (undoDescription);

  try
    offset := 0;
    st := TMemoryStream.Create;
    try
      TExCursor (image.graphic).SaveToStream (st);
      st.Seek (offset, soFromBeginning);
      data.Seek (0, soFromBeginning);
      data.size := 0;
      data.CopyFrom (st, st.Size - offset);
    finally
      st.Free
    end
  finally
    NotifyChange
  end
end;

function TIconCursorResource.RequireNumericID: boolean;
begin
  result := True
end;

procedure TIconCursorResource.SetResourceName(const Value: string);
var
  rGroup : TGroupResource;
  intResource : boolean;
  i, iValue, iOldName : Integer;
  p : PResourceDirectory;
begin
  rGroup := GetResourceGroup;

  intResource := True;
  iOldName := word (RawName);

  iValue := 0;

  for i := 1 to Length (value) do
    if not (value [i] in ['0'..'9']) then
    begin
      intResource := False;
      break
    end;

  if intResource then
  try
    iValue := StrToInt (value);
    intResource := (iValue < 65536) // and (Format ('%03.3d', [i]) = value);
  except
    intResource := False
  end;

  if not intResource then
    raise Exception.Create (rstBadResourceID);

  if Assigned (rGroup) then
  begin
    p := PResourceDirectory (PChar (rGroup.Data.Memory) + SizeOf (TIconHeader));
    for i := 0 to rGroup.ResourceGroupCount - 1 do
    begin
      if p^.wNameOrdinal = iOldName then
        p^.wNameOrdinal := iValue;
      Inc (p);
    end
  end;

  inherited
end;

{ TIconResource }

constructor TIconResource.Create(AParent: TResourceModule;
  AName: PWideChar; ADataLen: Integer; AData: pointer;
  ACustomType: PWideChar);
begin
  inherited Create (AParent, AName, ADataLen, AData, ACustomType);
  fInitPixelFormat := pf4Bit;
  fInitWidth := 32;
  fInitHeight := 32
end;


procedure TIconResource.ExportToStream(stream: TStream; const ext : string);
var
  hdr : TIconHeader;
  dirEntry : TIconDirEntry;
begin
  hdr.wReserved := 0;
  hdr.wCount := 1;
  hdr.wType := 1; // 1 for icons
  stream.WriteBuffer (hdr, sizeof (hdr));

  dirEntry.bWidth := Width;
  dirEntry.bHeight := Height;
  dirEntry.bColorCount := ColorCount;
  dirEntry.bReserved := 0;
  dirEntry.wPlanes := 1;
  dirEntry.wBitCount := BitsPerPixel;
  dirEntry.dwBytesInRes := Data.Size;
  dirEntry.dwImageOffset := sizeof (hdr) + sizeof (dirEntry);
  stream.WriteBuffer (dirEntry, sizeof (dirEntry));

  stream.CopyFrom (Data, 0);
end;

class function TIconResource.GetResourceType: word;
begin
  result := word (RT_ICON)
end;

class function TIconResource.GetResourceTypeClass: string;
begin
  result := rstIcon
end;

procedure TIconResource.GetImage(image: TPicture);
var
  icon : TExIcon;
begin
  icon := TExIcon.Create;
  if data.Size > 0 then
  begin
    data.Seek (0, soFromBeginning);
    icon.LoadFromStream (data)
  end;
  try
    image.Graphic := icon
  finally
    icon.Free
  end
end;

procedure TIconResource.SetImage(image: TPicture; const undoDescription : string);
var
  st : TMemoryStream;
  offset : Integer;
begin
  if undoDescription = '' then
    AddUndoEntry (rstIconChanged)
  else
    AddUndoEntry (undoDescription);

  try
    offset := 0;
    st := TMemoryStream.Create;
    try
      TExIcon (image.graphic).SaveToStream (st);
      st.Seek (offset, soFromBeginning);
      data.Seek (0, soFromBeginning);
      data.size := 0;
      data.CopyFrom (st, st.Size - offset);
    finally
      st.Free
    end
  finally
    NotifyChange
  end
end;

{ TBitmapResource }

(*----------------------------------------------------------------------------*
 | procedure TBitmapResource.GetResourceType                                  |
 |                                                                            |
 | Class function returns RT_BITMAP class                                     |
 *----------------------------------------------------------------------------*)
constructor TBitmapResource.Create(AParent: TResourceModule;
  AName: PWideChar; ADataLen: Integer; AData: pointer;
  ACustomType: PWideChar);
begin
  inherited;

  DefaultWidth := 16;
  DefaultHeight := 16;
  DefaultPixelFormat := pf8Bit;
end;

procedure TBitmapResource.ExportToStream(stream: TStream; const ext : string);
var
  hdr : TBitmapFileHeader;
  clrSize : DWORD;
begin
  FillChar (hdr, SizeOf (hdr), 0);
  hdr.bfType := $4D42;
  hdr.bfSize := sizeof (hdr) + data.Size;

  if PBitmapInfo (data.MEmory)^.bmiHeader.biClrUsed = 0 then
    clrSize := SizeOf (RGBQUAD) * (1 shl PBitmapInfo (data.Memory)^.bmiHeader.biBitCount)
  else
    clrSize := SizeOf (RGBQUAD) * PBitmapInfo (data.Memory)^.bmiHeader.biClrUsed;

  hdr.bfOffBits := sizeof (hdr) +
                   PBitmapInfo (data.Memory)^.bmiHeader.biSize +
                   clrSize;

  stream.Write (hdr, sizeof (hdr));
  stream.CopyFrom (data, 0);
end;

class function TBitmapResource.GetFilter: string;
begin
  result := rstBitmapFilter + '|' + rstJPEGFilter
end;

procedure TBitmapResource.GetImage(image: TPicture);
var
  s : TMemoryStream;
  hdr : TBitmapFileHeader;
begin
  s := TMemoryStream.Create;
  try
    hdr.bfType :=$4D42;         // TBitmap.LoadFromStream requires a bitmapfileheader
    hdr.bfSize := data.size;    // before the data...
    hdr.bfReserved1 := 0;
    hdr.bfReserved2 := 0;
    hdr.bfOffBits := sizeof (hdr);

    s.Write (hdr, sizeof (hdr));
    data.Seek (0, soFromBeginning);
    s.CopyFrom (data, data.size);

    s.Seek (0, soFromBeginning);
    image.Bitmap.IgnorePalette := False;
    image.Bitmap.LoadFromStream (s);
  finally
    s.Free
  end
end;

class function TBitmapResource.GetResourceType: word;
begin
  result := word (RT_BITMAP)
end;

class function TBitmapResource.GetResourceTypeClass: string;
begin
  result := rstBitmap
end;

function TBitmapResource.GetWriteableResourceStyles: TWriteableResourceStyles;
begin
  result := inherited GetWriteableResourceStyles + [wsExportable];
end;

procedure TBitmapResource.Initialize;
var
  bmp : TBitmap;
  s : TMemoryStream;
begin
  s := Nil;
  bmp := TBitmap.Create;
  try
    s := TMemoryStream.Create;
    
    bmp.Width := DefaultWidth;
    bmp.Height := DefaultHeight;
    bmp.PixelFormat := DefaultPixelFormat;

    case DefaultPixelFormat of
      pf1Bit : bmp.Palette := CopyPalette (SystemPalette2);
      pf8Bit : bmp.Palette := CopyPalette (SystemPalette256)
    end;

    bmp.Canvas.Brush.Color := clWhite;
    bmp.Canvas.FillRect (Rect (0, 0, bmp.Width, bmp.Height));

    bmp.SaveToStream (s);
    s.Seek (sizeof (TBitmapFileHeader), soFromBeginning);
    Data.CopyFrom (s, s.Size - s.Position);
  finally
    bmp.Free;
    s.Free
  end;
  inherited
end;

procedure TBitmapResource.InitializeFromFile(const fileName: string);
var
  s : TMemoryStream;
begin
  s := TMemoryStream.Create;
  try
    s.LoadFromFile (fileName);
    data.Write ((PChar (s.Memory) + sizeof (TBitmapFileHeader))^, s.Size - sizeof (TBitmapFileHEader));
  finally
    s.Free
  end;
  inherited;
end;

procedure TBitmapResource.SetImage(image: TPicture; const undoDescription : string);
var
  bmp : TBitmap;
  s : TMemoryStream;
begin
  if undoDescription = '' then
    AddUndoEntry (rstBitmapChanged)
  else
    AddUndoEntry (undoDescription);

  try
    bmp := image.Bitmap;
    s := TMemoryStream.Create;
    try
      bmp.SaveToStream (s);
      data.Clear;
      data.Write ((PChar (s.Memory) + sizeof (TBitmapFileHeader))^, s.Size - sizeof (TBitmapFileHEader));
    finally
      s.Free
    end
  finally
    NotifyChange
  end
end;

function TIconResource.GetWriteableResourceStyles: TWriteableResourceStyles;
begin
  result := inherited GetWriteableResourceStyles + [wsExportable]
end;

{ TGroupResource }

procedure TGroupResource.GetGroupResourceAttributes(index: Integer;
  var attributes: TResourceDirectory);
var
  p : PResourceDirectory;
begin
  p := PResourceDirectory (PChar (Data.Memory) + SizeOf (TIconHeader));
  Inc (p, index);
  attributes := p^;
end;

function TGroupResource.GetResourceGroupCount: Integer;
begin
  result := PIconHeader (Data.Memory).wCount
end;

function TGroupResource.GetResourceGroupResource(
  index: Integer): TResource;
var
  i : Integer;
  res : TResource;
  attributes : TResourceDirectory;
begin
  result := Nil;
  GetGroupResourceAttributes (index, attributes);
  for i := 0 to Parent.ResourceCount - 1 do
  begin
    res := Parent.Resource [i];
    if (GetResourceType - 11 = res.RawType) and (attributes.wNameOrdinal = Integer (res.RawName)) then
    begin
      result := res;
      break
    end
  end
end;

procedure TGroupResource.ExportToStream(stream: TStream; const ext : string);
var
  hdr : PIconHeader;
  i, offset : Integer;
  dir : TIconDirEntry;
  resDir : PResourceDirectory;
  res : TResource;
begin
  Data.Seek (0, soFromBeginning);
  stream.CopyFrom (Data, sizeof (TIconHeader));
  hdr := PIconHeader (data.Memory);

  offset := sizeof (TIconHeader) + sizeof (TIconDirEntry) * hdr^.wCount;
  resDir := PResourceDirectory (PChar (data.Memory) + sizeof (TIconHeader));
  for i := 0 to hdr^.wCount - 1 do
  begin
    res := GetResourceGroupResource (i);

    if hdr^.wType = 1 then
    begin
      dir.bWidth := resDir^.details.iconWidth;
      dir.bHeight := resDir^.details.iconHeight;
      dir.bColorCount := resDir^.details.iconColorCount;
      dir.bReserved := resDir^.details.iconReserved;
      dir.wPlanes := resDir^.wPlanes;
      dir.wBitCount := resDir^.wBitCount;
      dir.dwBytesInRes := res.Data.Size;
    end
    else
    begin
      dir.bWidth := resDir^.details.cursorWidth;
      dir.bHeight := resDir^.details.cursorHeight div 2;
      dir.bColorCount := 0;
      dir.bReserved := 0;
      dir.wPlanes := LOWORD (TCursorResource (res).HotSpot);
      dir.wBitCount := HIWORD (TCursorResource (res).HotSpot);
      dir.dwBytesInRes := res.Data.Size - sizeof (DWORD);
    end;

    dir.dwBytesInRes := resDir^.lBytesInRes;
    dir.dwImageOffset := offset;

    if (dir.bColorCount = 0) and (dir.wBitCount <= 8) then
      dir.bColorCount := 1 shl dir.wBitCount;

    stream.Write (dir, sizeof (dir));
    Inc (offset, dir.dwBytesInRes);
    Inc (resDir);
  end;

  for i := 0 to hdr^.wCount - 1 do
  begin
    res := GetResourceGroupResource (i);
    if hdr.wType = 1 then
      stream.CopyFrom (res.Data, 0)
    else
    begin
      res.Data.Seek (4, soFromBeginning);
      stream.CopyFrom (res.Data, res.Data.Size - sizeof (DWORD))
    end
  end
end;

procedure TGroupResource.InitializeFromFile(const fileName: string);
var
  s : TMemoryStream;
  i : Integer;
  res : TGraphicsResource;
  hdr : PIconHeader;
  dir : PIconDirEntry;
  resDir : TResourceDirectory;
  wNameOrdinal : word;
  hotspot : Integer;
begin
  s := TMemoryStream.Create;
  try
    s.LoadFromFile (fileName);
    s.Seek (0, soFromBeginning);
    Data.CopyFrom (s, sizeof (TIconHeader));
    hdr := PIconHeader (data.Memory);
    s.Position := s.Position + hdr^.wCount * sizeof (TIconDirEntry);

    dir := PIconDirEntry (PChar (s.Memory) + sizeof (TIconHeader));

    for i := 0 to hdr^.wCount - 1 do
    begin

      if hdr^.wType = 1 then
      begin
        wNameOrdinal := parent.GetUniqueResourceName (TIcoNResource);
        res := TIconResource.Create (parent, PWideChar (wNameOrdinal));
        resDir.details.iconWidth := dir^.bWidth;
        resDir.details.iconHeight := dir^.bHeight;
        resDir.details.iconColorCount := dir^.bColorCount;
        resDir.details.iconReserved := dir^.bReserved;
        resDir.wPlanes := dir^.wPlanes;
        resDir.wBitCount := dir^.wBitCount;

        if dir^.wBitCount = 0 then
          case dir^.bColorCount of
              2 : dir^.wBitCount := 1;
             16 : dir^.wBitCount := 4;
//            256 : dir^.wBitCount := 8
          end;

      end
      else
      begin
        wNameOrdinal := parent.GetUniqueResourceName (TCursorResource);
        res := TCursorResource.Create (parent, PWideChar (wNameOrdinal));
        resDir.details.cursorWidth := dir^.bWidth;
        resDir.details.cursorHeight := dir^.bHeight * 2;
        hotspot := MAKELONG (dir^.wBitCount, dir^.wPlanes);
      end;

      resDir.lBytesInRes := dir^.dwBytesInRes;
      resDir.wNameOrdinal := wNameOrdinal;

      Data.Write (resDir, sizeof (resDir));

      if hdr^.wType = 2 then
        res.Data.Write (hotspot, sizeof (hotspot));

      res.Data.CopyFrom (s, dir.dwBytesInRes);
      res.InitializeFromFile ('');
      Inc (dir)
    end;

    inherited;
  finally
    s.Free
  end;

end;

procedure TGroupResource.Initialize;
var
  hdr : PIconHeader;
  resource : TIconCursorResource;
  dir : PResourceDirectory;
  nm : PWideChar;
  isIcon : boolean;
begin
  isIcon := not (self is TCursorGroupResource);
  data.Size := SizeOf (TIconHeader);
  hdr := PIconHeader (data.Memory);
  hdr^.wReserved := 0;
  hdr^.wCount := 0;
  if isIcon then
    hdr^.wType := 1
  else
    hdr^.wType := 2;
  inherited;

  if isIcon then
  begin
    nm := PWideChar (parent.GetUniqueResourceName (TIconResource));
    resource := TIconResource.Create (parent, nm)
  end
  else
  begin
    nm := PWideChar (parent.GetUniqueResourceName (TCursorResource));
    resource := TCursorResource.Create (parent, nm);
  end;

  resource.PixelFormat := DefaultPixelFormat;
  resource.Width := DefaultWidth;
  resource.Height := DefaultHeight;

  resource.Initialize;

  hdr := PIconHeader (data.Memory);
  hdr^.wCount := hdr^.wCount + 1;
  data.Size := data.Size + sizeof (TResourceDirectory);
  dir := PResourceDirectory (PChar (Data.Memory) + SizeOf (TIconHeader));
  Inc (dir, hdr^.wCount - 1);

  if isICon then
  begin
    dir^.details.iconHeight := resource.Height;
    dir^.details.iconWidth := resource.Width;
    if resource.ColorCount <= 256 then
      dir^.details.iconColorCount := resource.ColorCount
    else
      dir^.details.iconColorCount := 0;
    dir^.details.iconReserved := 0;
  end
  else
  begin
    dir^.details.cursorHeight := Resource.Height * 2;
    dir^.details.cursorWidth := Resource.Width;
  end;

  dir^.wPlanes := 1;
  dir^.wBitCount := TIconResource (resource).BitsPerPixel;
  dir^.lBytesInRes := resource.Data.Size;
  dir^.wNameOrdinal := Word (nm);
  NotifyChange
end;

function TGroupResource.GetWriteableResourceStyles: TWriteableResourceStyles;
begin
  result := inherited GetWriteableResourceStyles + [wsExportable];
end;

procedure TGroupResource.AddResource(res: TIconCursorResource);
var
  hdr : PIconHeader;
  resDir : PResourceDirectory;
  IsIcon : boolean;
begin
  IsIcon := res is TIconResource;

  if IsIcon and not (self is TIconGroupResource) then
    raise Exception.Create ('Can''t add cursors to icon groups or icons to cursor groups');

  hdr := PIconHeader (data.Memory);

  if Data.Size < Sizeof (TIconHeader) + (hdr.wCount + 1) * sizeof (TResourceDirectory) then
    Data.Size := Sizeof (TIconHeader) + (hdr.wCount + 1) * sizeof (TResourceDirectory);

  resDir := PResourceDirectory (PChar (Data.Memory) + SizeOf (TIconHeader));
  Inc (resDir, hdr^.wCount);

  if IsIcon then
  begin
    resDir^.details.iconWidth := res.Width;
    resDir^.details.iconHeight := res.Height;
    resDir^.details.iconColorCount := res.ColorCount;
    resDir^.details.iconReserved := 0
  end
  else
  begin
    resDir^.details.cursorWidth := res.Width;
    resDir^.details.cursorHeight := res.Height * 2  // Irritating funky height thing...
  end;

  resDir^.wPlanes := 1;
  resDir^.wBitCount := res.BitsPerPixel;
  resDir^.lBytesInRes := res.Data.Size;
  resDir^.wNameOrdinal := Word (res.RawName);

  Inc (hdr^.wCount);
  NotifyChange
end;

{ TCursorGroupResource }

constructor TCursorGroupResource.Create(AParent: TResourceModule;
  AName: PWideChar; ADataLen: Integer; AData: pointer;
  ACustomType: PWideChar);
begin
  inherited Create (AParent, AName, ADataLen, AData, ACustomType);
  FDefaultWidth := GetSystemMetrics (SM_CXCURSOR);
  FDefaultHeight := GetSystemMetrics (SM_CYCURSOR);
  FDefaultPixelFormat := pf1Bit;
end;

class function TCursorGroupResource.GetFilter: string;
begin
  result := rstCursorFilter
end;

class function TCursorGroupResource.GetResourceType: word;
begin
  result := word (RT_GROUP_CURSOR)
end;

class function TCursorGroupResource.GetResourceTypeClass: string;
begin
  result := rstGroupCursor
end;

{ TIconGroupResource }

constructor TIconGroupResource.Create(AParent: TResourceModule;
  AName: PWideChar; ADataLen: Integer; AData: pointer;
  ACustomType: PWideChar);
begin
  inherited Create (AParent, AName, ADataLen, AData, ACustomType);
  FDefaultWidth := GetSystemMetrics (SM_CXICON);
  FDefaultHeight := GetSystemMetrics (SM_CYICON);
  FDefaultPixelFormat := pf4Bit;
end;

class function TIconGroupResource.GetFilter: string;
begin
  result := rstIconFilter
end;

class function TIconGroupResource.GetResourceType: word;
begin
  result := word (RT_GROUP_ICON)
end;

class function TIconGroupResource.GetResourceTypeClass: string;
begin
  result := rstGroupIcon
end;


procedure TGraphicsResource.NotifyChange;
begin
  inherited;

end;

initialization
  RegisterWriteableResources ([TCursorGroupResource, TIconGroupResource, TBitmapResource]);
end.
