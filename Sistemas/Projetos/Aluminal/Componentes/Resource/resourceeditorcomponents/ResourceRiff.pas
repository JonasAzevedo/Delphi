unit ResourceRiff;

interface
uses Windows, Classes, SysUtils, MMSystem, ResourceModule, cmpMidiData;

resourcestring
  rstWaveRiff     = 'Audio';
  rstRMidRiff     = 'MIDI';
  rstAVIRiff      = 'Video';


const
  RT_INTERNALRIFF = 1012;
  RT_INTERNALWAVE = 1013;
  RT_INTERNALRMID = 1014;
  RT_INTERNALAVI  = 1015;

type
//=============================================================================
// TRiffResource.  Encapsulates RIFF resources

  TRiffResource = class (TWriteableResource)
  protected
    class function GetResourceTypeClass : string; override;
    procedure ExportToStream (stream : TStream; const ext : string); override;
  public
    class function GetResourceType : word; override;
  end;

  TRMIDResource = class (TRiffResource)
  private
    function GetMIDIData: TMidiData;
  protected
    fMidiData : TMidiData;
    class function GetResourceTypeClass : string; override;
  public
    destructor Destroy; override;
    class function GetResourceType : word; override;
    class function GetFilter : string; override;
    procedure InitializeFromFile (const fileName : string); override;
    property MidiData : TMidiData read GetMIDIData;
  end;

  TWAVEResource = class (TRiffResource)
  private
    fFormat : PWaveFormatEx;
    fWaveData : pchar;
    fWaveDataLen : Integer;
    procedure ExtractWaveData;
    function GetData: PChar;
    function GetFormat: PWaveFormatEx;
    function GetDataLen: Integer;
  protected
    class function GetResourceTypeClass : string; override;
  public
    procedure InitializeFromFile (const fileName : string); override;
    class function GetResourceType : word; override;
    class function GetFilter : string; override;
    destructor Destroy; override;

    property WaveFormat : PWaveFormatEx read GetFormat;
    property WaveData : PChar read GetData;
    property WaveDataLen : Integer read GetDataLen;
  end;

  TAVIResource = class (TRiffResource)
  private
    fAVIData : pchar;
    fAVIDataLen : Integer;

    procedure ExtractAVIData;
    function GetData: PChar;
    function GetDataLen: Integer;
  protected
    class function GetResourceTypeClass : string; override;
  public
    procedure InitializeFromFile (const fileName : string); override;
    class function GetResourceType : word; override;
    class function GetFilter : string; override;
    destructor Destroy; override;
    property AVIData : PChar read GetData;
    property DataLen : Integer read GetDataLen;
  end;

implementation

uses cmpRiffStream;

resourcestring
  rstWaveFilter = 'Wave Files (*.wav)|*.wav';
  rstRMIDFilter = 'MIDI Files (*.mid)|*.mid|RMID Files (*.rmi)|*.rmi';
  rstAVIFilter  = 'Video Files (*.avi)|*.avi';
  rstRiff         = 'Multimedia';

{ TRiffResource }

procedure TRiffResource.ExportToStream(stream: TStream; const ext : string);
begin
  Data.Seek (0, soFromBeginning);
  stream.CopyFrom (Data, Data.Size);
end;

class function TRiffResource.GetResourceType: word;
begin
  result := RT_INTERNALRIFF;
end;

class function TRiffResource.GetResourceTypeClass: string;
begin
  result := rstRiff;
end;

{ TWAVEResource }

destructor TWAVEResource.Destroy;
begin
  if Assigned (fFormat) then
    FreeMem (fFormat);

  if Assigned (fWaveData) then
    FreeMem (fWaveData);

  inherited;
end;

procedure TWAVEResource.ExtractWaveData;
var
  riffStream : TRiffMemoryStream;

begin
  if not Assigned (fFormat) or not Assigned (fWaveData) then
  begin
    ReallocMem (fWaveData, 0);
    ReallocMem (fFormat, 0);
    fWaveDataLen := 0;

    riffStream := TRiffMemoryStream.Create (Data.Memory, Data.Size);
    try
      riffStream.Descend ('WAVE', MMIO_FINDRIFF);
      riffStream.Descend ('fmt ', MMIO_FINDCHUNK);

      GetMem (fFormat, riffStream.ChunkSize);
      riffStream.Read (fFormat^, riffStream.ChunkSize);

      riffStream.Ascend;
      riffStream.Descend ('data', MMIO_FINDCHUNK);

      GetMem (fWaveData, riffStream.ChunkSize);
      fWaveDataLen := riffStream.ChunkSize;
      riffStream.Read (fWaveData^, riffStream.ChunkSize)
    finally
      riffStream.Free
    end
  end
end;

function TWAVEResource.GetData: PChar;
begin
  ExtractWaveData;
  result := fWaveData;
end;

function TWAVEResource.GetDataLen: Integer;
begin
  ExtractWaveData;
  result := fWaveDataLen;
end;

class function TWAVEResource.GetFilter: string;
begin
  result := rstWaveFilter
end;

function TWAVEResource.GetFormat: PWaveFormatEx;
begin
  ExtractWaveData;
  result := fFormat
end;

class function TWAVEResource.GetResourceType: word;
begin
  result := RT_INTERNALWAVE;
end;

class function TWAVEResource.GetResourceTypeClass: string;
begin
  result := rstWaveRiff;
end;

procedure TWAVEResource.InitializeFromFile(const fileName: string);
begin
  Data.LoadFromFile (fileName);
  inherited;
end;

{ TRMIDResource }

destructor TRMIDResource.Destroy;
begin
  fMidiData.Free;
  inherited;
end;

class function TRMIDResource.GetFilter: string;
begin
  result := rstRMIDFilter
end;

function TRMIDResource.GetMIDIData: TMidiData;
begin
  if not Assigned (fMidiData) then
  begin
    fMidiData := TMidiData.Create (Nil);
    data.Seek (0, soFromBeginning);
    fMidiData.LoadFromStream (data)
  end;
  result := fMidiData
end;

class function TRMIDResource.GetResourceType: word;
begin
  result := RT_INTERNALRMID;
end;

class function TRMIDResource.GetResourceTypeClass: string;
begin
  result := rstRMidRiff;
end;

procedure TRMIDResource.InitializeFromFile(const fileName: string);
var
  s : TMemoryStream;
  buffer : PChar;
  info : TMMIOInfo;
  mmioh : HMMIO;
  ckInfo, ckInfo1 : TMMCKInfo;
  size : Integer;
begin
  if CompareText (ExtractFileExt (fileName), '.mid') = 0 then
  begin
    buffer := Nil;
    s := TMemoryStream.Create;
    try
      s.LoadFromFile (fileName);
      GetMem (buffer, s.Size + 1024);
      FillChar (info, SizeOf (info), 0);
      info.fccIOProc := FOURCC_MEM;
      info.pchBuffer := buffer;
      info.cchBuffer := s.Size + 1024;
      mmioh := mmioOpen (Nil, @info, MMIO_WRITE);
      if mmioh <> 0 then
      try
        FillChar (ckInfo, Sizeof (ckInfo), 0);
        ckInfo.fccType := mmioStringToFourCC ('RMID', 0);
        mmioCreateChunk (mmioh, @ckInfo, MMIO_CREATERIFF);

        FillChar (ckInfo1, SizeOf (ckInfo1), 0);
        ckInfo1.ckid := mmioStringToFourCC ('data', 0);
        ckInfo1.fccType := mmioStringToFourCC ('data', 0);
        mmioCreateChunk (mmioh, @ckInfo1, 0);

        mmioWrite (mmioh, s.Memory, s.Size);
        mmioAscend (mmioh, @ckInfo1, 0);
        mmioAscend (mmioh, @ckInfo, 0);
      finally
        mmioClose (mmioh, 0);
      end;


      size := ckInfo.ckSize + 8;
      Data.Seek (0, soFromBeginning);
      Data.Write (buffer [0], size);

    finally
      s.Free;
      FreeMem (buffer);
    end
  end
  else
  begin
    Data.LoadFromFile (fileName);
  end;

  inherited;

end;

{ TAVIResource }

destructor TAVIResource.Destroy;
begin
  if Assigned (fAVIData) then
    FreeMem (fAVIData);

  inherited;
end;

procedure TAVIResource.ExtractAVIData;
var
  riffStream : TRiffMemoryStream;

begin
  if not Assigned (fAVIData) then
  begin
    ReallocMem (fAVIData, 0);
    fAVIDataLen := 0;

    riffStream := TRiffMemoryStream.Create (Data.Memory, Data.Size);
    try
      riffStream.Descend ('AVI', MMIO_FINDRIFF);
      riffStream.Descend ('data', MMIO_FINDCHUNK);

      GetMem (fAVIData, riffStream.ChunkSize);
      fAVIDataLen := riffStream.ChunkSize;
      riffStream.Read (fAVIData^, riffStream.ChunkSize)
    finally
      riffStream.Free
    end
  end
end;

function TAVIResource.GetData: PChar;
begin
  ExtractAVIData;
  result := fAVIData;
end;

function TAVIResource.GetDataLen: Integer;
begin
  ExtractAVIData;
  result := fAVIDataLen;
end;

class function TAVIResource.GetFilter: string;
begin
  result := rstAVIFilter
end;

class function TAVIResource.GetResourceType: word;
begin
  result := RT_INTERNALAVI;
end;

class function TAVIResource.GetResourceTypeClass: string;
begin
  result := rstAVIRiff;
end;

procedure TAVIResource.InitializeFromFile(const fileName: string);
begin
  Data.LoadFromFile (fileName);
  inherited;
end;

initialization
  RegisterWriteableResources ([TWaveResource, TRMIDResource]);
end.
