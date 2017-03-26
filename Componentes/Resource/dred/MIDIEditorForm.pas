unit MIDIEditorForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ResourceEditorForm, cmpBarControl, cmpPianoRoll, ExtCtrls, cmpKeyboard,
  cmpMidiPlayer, cmpTrackOutputs, StdCtrls, ActnList, ComCtrls, ToolWin,
  ImgList, Grids, cmpMidiGrid, cmpMidiData, unitMidiTrackStream;

type
  TfmMIDIEditor = class(TfmResourceEditor)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    cbTrack: TComboBox;
    TrackOutputs1: TTrackOutputs;
    MidiPlayer1: TMidiPlayer;
    ImageList1: TImageList;
    tbMIDITransport: TToolBar;
    ToolButton2: TToolButton;
    btnMIDIStop: TToolButton;
    ToolButton4: TToolButton;
    ToolButton1: TToolButton;
    ActionList1: TActionList;
    actMIDIRewind: TAction;
    actMIDIStop: TAction;
    actMIDIPlay: TAction;
    actMIDIFastForward: TAction;
    Timer1: TTimer;
    Label2: TLabel;
    stNoTracks: TLabel;
    Label3: TLabel;
    stResolution: TLabel;
    Label4: TLabel;
    stMidiDataFormat: TLabel;
    Panel4: TPanel;
    HeaderControl1: THeaderControl;
    MidiGrid1: TMidiGrid;
    procedure cbTrackChange(Sender: TObject);
    procedure actMIDIPlayExecute(Sender: TObject);
    procedure actMIDIStopExecute(Sender: TObject);
    procedure actMIDIRewindExecute(Sender: TObject);
    procedure actMIDIFastForwardExecute(Sender: TObject);
    procedure MidiPlayer1Stop(Sender: TObject);
    procedure MidiPlayer1FastForward(Sender: TObject);
    procedure MidiPlayer1Play(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Keys1NoteOn(Sender: TObject; note, velocity: Integer);
    procedure Keys1NoteOff(Sender: TObject; note, velocity: Integer);
    procedure HeaderControl1SectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    fCurrentTrack : TMidiTrackStream;
    procedure SetRowForPosition;
    procedure AdjustGrid;
    procedure AdjustHeader;
    { Private declarations }
  protected

  public
    procedure DoResourceChanged; override;
  end;

var
  fmMIDIEditor: TfmMIDIEditor;

implementation

uses ResourceRiff;

{$R *.DFM}

{ TfmMIDIEditor }

const
  Sections = 6;
  SectionLoadings : array [0..Sections - 1] of Integer = (12, 13, 10, 30, 20, 10);
  MaxLoadings = 95;

procedure TfmMIDIEditor.DoResourceChanged;
var
  res : TRMIDResource;
  data : TMidiData;
  i : Integer;
begin
  TrackOutputs1.Active := False;
  actMIDIRewind.Execute;

  res := Resource as TRMIDResource;
  data := res.MidiData;
  MidiGrid1.MidiData := data;
  TrackOutputs1.MidiData := data;
  fCurrentTrack := data.Tracks [0];

  cbTrack.Items.Clear;
  for i := 0 to data.NoTracks - 1 do
  begin
    cbTrack.Items.Add (Format ('%d - %s', [i, data.Tracks [i].TrackName]))
  end;

  if data.NoTracks > 0 then
  begin
    cbTrack.ItemIndex := 0
  end;

  stNoTracks.Caption := IntToStr (data.NoTracks);
  stResolution.Caption := IntToStr (data.PPQN);
  stMIDIDataFormat.Caption := IntToStr (data.FileType);
end;

procedure TfmMIDIEditor.cbTrackChange(Sender: TObject);
begin
  MidiGrid1.Track := cbTrack.ItemIndex;
  fCurrentTrack := MidiGrid1.MidiData.Tracks [cbTrack.ItemIndex];
end;

procedure TfmMIDIEditor.actMIDIPlayExecute(Sender: TObject);
begin
  TrackOutputs1.Active := True;
  MidiPlayer1.Play := True
end;

procedure TfmMIDIEditor.actMIDIStopExecute(Sender: TObject);
begin
  MidiPlayer1.Stop;
  TrackOutputs1.Active := False;
end;

procedure TfmMIDIEditor.actMIDIRewindExecute(Sender: TObject);
begin
  MidiPlayer1.Rewind;
  TrackOutputs1.Active := False;
  SetRowForPosition;
  btnMIDIStop.Down := True
end;

procedure TfmMIDIEditor.actMIDIFastForwardExecute(Sender: TObject);
begin
  TrackOutputs1.Active := True;
  MidiPlayer1.FastForward := True;
end;

procedure TfmMIDIEditor.MidiPlayer1Stop(Sender: TObject);
begin
  inherited;
  btnMIDIStop.Down := True;
  Timer1.Enabled := False;
end;

procedure TfmMIDIEditor.MidiPlayer1FastForward(Sender: TObject);
begin
  Timer1.Enabled := True
end;

procedure TfmMIDIEditor.MidiPlayer1Play(Sender: TObject);
begin
  Timer1.Enabled := True
end;

procedure TfmMIDIEditor.Timer1Timer(Sender: TObject);
begin
  SetRowForPosition;
end;

procedure TfmMIDIEditor.Keys1NoteOn(Sender: TObject; note,
  velocity: Integer);
var
  trk : Integer;
  output : TTrackOutput;
  channel : TMidiChannel;
begin
  trk := cbTrack.ItemIndex;
  if trk >= 0 then
  begin
    TrackOutputs1.Active := True;
    output := TrackOutputs1.TrackOutput [trk];
    channel := output.TrackData.Channel;
    output.Port.PatchChange (output.TrackData.Bank, output.TrackData.Patch, channel);
    output.Port.NoteOn (channel, note, velocity)
  end
end;

procedure TfmMIDIEditor.Keys1NoteOff(Sender: TObject; note,
  velocity: Integer);
var
  trk : Integer;
  output : TTrackOutput;
  channel : TMidiChannel;
begin
  trk := cbTrack.ItemIndex;
  if trk >= 0 then
  begin
    TrackOutputs1.Active := True;
    output := TrackOutputs1.TrackOutput [trk];
    channel := output.TrackData.Channel;
    output.Port.NoteOff (channel, note, velocity)
  end
end;

procedure TfmMIDIEditor.SetRowForPosition;
var
  idx : Integer;
begin
  if Assigned (fCurrentTrack) then
  begin
    idx := fCurrentTrack.FindEventNo (MidiPlayer1.position , feFirst);
    if (idx = -1) or (idx >= fCurrentTrack.EventCount) then
      idx := fCurrentTrack.EventCount - 1
    else
      if fCurrentTrack.Event [idx]^.pos <> MidiPlayer1.position then
        Dec (idx);
                               
    MidiGrid1.row := idx;
  end
end;

procedure TfmMIDIEditor.HeaderControl1SectionResize(
  HeaderControl: THeaderControl; Section: THeaderSection);
var
  i, idx, widthLeft, sectionsLeft : Integer;
begin
  for idx := 0 to Sections - 1 do
    if Section = HeaderControl.Sections [idx] then
      break;

  widthLeft := MidiGrid1.ClientWidth;
  for i := 0 to idx do
    Dec (widthLeft, HeaderControl1.Sections [i].Width);

  sectionsLeft := 0;
  for i := idx + 1 to Sections - 1 do
    Inc (sectionsLeft, sectionLoadings [i]);

  for i := idx + 1 to Sections - 2 do
    HeaderControl1.Sections [i].Width := widthLeft * SectionLoadings [i] div sectionsLeft;

  AdjustGrid;
end;

procedure TfmMIDIEditor.AdjustGrid;
var i, totWidth : Integer;
begin
  totWidth := 0;
  for i := 0 to Sections - 2 do
    Inc (totWidth, HeaderControl1.Sections [i].width);

  HeaderControl1.Sections [Sections - 1].width := MidiGrid1.ClientWidth - totWidth;
  MidiGrid1.ColWidths [0] := HeaderControl1.Sections [0].Width - 1;
  for i := 1 to Sections - 1 do
    MidiGrid1.ColWidths [i] := HeaderControl1.Sections [i].Width - 1
end;

procedure TfmMIDIEditor.AdjustHeader;
var i, width : Integer;
begin
  width := MidiGrid1.ClientWidth;
  for i := 0 to Sections - 2 do
    HeaderControl1.Sections [i].Width := width * SectionLoadings [i] div MaxLoadings;

  AdjustGrid;
end;

procedure TfmMIDIEditor.FormShow(Sender: TObject);
begin
  inherited;
  AdjustHeader;
end;

procedure TfmMIDIEditor.FormResize(Sender: TObject);
begin
  inherited;
  AdjustHeader;
end;

end.
