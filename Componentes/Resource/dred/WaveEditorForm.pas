unit WaveEditorForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ResourceEditorForm, StdCtrls, mmsystem, ActnList, ImgList, ComCtrls,
  ToolWin, ExtCtrls;

type
  TfmWaveEditor = class(TfmResourceEditor)
    Panel1: TPanel;
    ImageList1: TImageList;
    ActionList1: TActionList;
    actWaveStop: TAction;
    actWavePlay: TAction;
    actWavePause: TAction;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    ListView1: TListView;
    ToolBar1: TToolBar;
    btnStop: TToolButton;
    btnPlay: TToolButton;
    btnPause: TToolButton;
    procedure actWavePlayExecute(Sender: TObject);
    procedure actWaveStopExecute(Sender: TObject);
    procedure actWavePauseExecute(Sender: TObject);
  private
    fHeaderList : TList;
    fHW : HWaveOut;
    fPaused : boolean;

    procedure mmWomOpen (var message : TMessage); message MM_WOM_OPEN;
    procedure mmWomDone (var message : TMessage); message MM_WOM_DONE;
    procedure mmWomClose (var message : TMessage); message MM_WOM_CLOSE;

    procedure OpenWaveOut;
    procedure Stop;
    procedure Play;
  protected
    procedure UpdateActions; override;
    { Private declarations }
  public
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
    procedure DoResourceChanged; override;
    function CanClose : boolean; override;
    { Public declarations }
  end;

var
  fmWaveEditor: TfmWaveEditor;

implementation

uses ResourceRiff, syncobjs;

{$R *.DFM}

{ TfmWaveEditor }

procedure TfmWaveEditor.DoResourceChanged;
var
  res : TWaveResource;
  fmt : PWaveFormatEx;
begin
  res := Resource as TWaveResource;
  fmt := res.WaveFormat;

  if fmt^.wFormatTag = WAVE_FORMAT_PCM then
end;

constructor TfmWaveEditor.Create(AOwner: TComponent);
begin
  inherited;
  fHeaderList := TList.Create;
end;

destructor TfmWaveEditor.Destroy;
begin
  Stop;
  fHeaderList.Free;
  inherited;
end;

procedure TfmWaveEditor.mmWomClose(var message: TMessage);
begin
end;

procedure TfmWaveEditor.mmWomDone(var message: TMessage);
var
  i : Integer;
begin
  for i := 0 to fHeaderList.Count - 1 do
    if fHeaderList [i] = PWaveHdr (message.lParam) then
    begin
      waveOutUnprepareHeader (fHW, PWaveHdr (message.wParam), sizeof (TWaveHdr));
      FreeMem (fHeaderList [i]);
      fHeaderList.Delete (i);
      break
    end;

  if fHeaderList.Count = 0 then
  begin
    waveOutClose (fHW);
    fHW := 0;
    btnStop.Down := True;
    btnPause.Down := False;
    fPaused := False;
  end
end;

procedure TfmWaveEditor.mmWomOpen(var message: TMessage);
begin

end;

procedure TfmWaveEditor.OpenWaveOut;
var
  res : TWaveResource;
begin
  if fHW = 0 then
  begin
    res := Resource as TWaveResource;
    if waveOutOpen (@fHW, WAVE_MAPPER, res.WaveFormat, Handle, 0, CALLBACK_WINDOW) <> MMSYSERR_NOERROR then
      raise Exception.Create ('Unable to open wave device');
  end
end;

procedure TfmWaveEditor.Stop;
begin
  fPaused := False;
  if fHW <> 0 then
  begin
    waveOutReset (fHW);
    Application.ProcessMessages;
    if fHeaderList.Count > 0 then
      MessageBeep ($ffff);
    waveOutClose (fHW);
    fHW := 0
  end
end;

function TfmWaveEditor.CanClose: boolean;
begin
  Stop;
  result := True
end;

procedure TfmWaveEditor.actWavePlayExecute(Sender: TObject);
begin
  btnPause.Down := False;
  if fPaused then
    waveOutRestart (fHW)
  else
    Play
end;

procedure TfmWaveEditor.Play;
var
  res : TWaveResource;
  waveHeader : PWaveHdr;
begin
  res := Resource as TWaveResource;

  if fHW <> 0 then
  begin
    waveOutReset (fHW);
    application.ProcessMessages;
    btnPlay.Down := True;
  end;

  OpenWaveOut;

  GetMem (waveHeader, sizeof (TWaveHdr));
  ZeroMemory (waveHeader, SizeOf (TWaveHdr));
  waveHeader^.lpData := res.WaveData;
  waveHeader^.dwBufferLength := res.WaveDataLen;
  if waveOutPrepareHeader (fHW, waveHeader, sizeof (TWaveHdr)) <> MMSYSERR_NOERROR then
    raise Exception.Create ('Unable to prepare wave header');
  fHeaderList.Add (waveHeader);
  if waveOutSetPlaybackRate (fHW, $4000) <> MMSYSERR_NOERROR then
    MessageBeep ($ffff);
  waveOutWrite (fHW, waveHeader, sizeof (TWaveHdr));
end;

procedure TfmWaveEditor.UpdateActions;
begin
  btnPause.Enabled := fHW <> 0
end;

procedure TfmWaveEditor.actWaveStopExecute(Sender: TObject);
begin
  if fHW <> 0 then
    Stop
end;

procedure TfmWaveEditor.actWavePauseExecute(Sender: TObject);
begin
  if fHW <> 0 then
  begin
    if not fPaused then
    begin
      waveOutPause (fHW);
      fPaused := True
    end;
    btnPause.Down := True
  end
  else
    btnPause.Down := False;
end;

end.
