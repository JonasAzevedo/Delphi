unit AVIEditorForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ResourceEditorForm, MPlayer, cmpMediaPlayerMemoryFile, ExtCtrls;

type
  TfmAVIEditor = class(TfmResourceEditor)
    MediaPlayerMemoryFile1: TMediaPlayerMemoryFile;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    MediaPlayer1: TMediaPlayer;
  private
    { Private declarations }
  protected
  public
    procedure DoResourceChanged; override;
  end;

var
  fmAVIEditor: TfmAVIEditor;

implementation

uses ResourceRiff;

{$R *.DFM}

{ TfmAVIEditor }

procedure TfmAVIEditor.DoResourceChanged;
var
  res : TAVIResource;
begin
  MediaPlayer1.Close;
  Panel3.Invalidate;
  res := Resource as TAVIResource;
  MediaPlayerMemoryFile1.MemoryStream.Clear;
  MediaPlayerMemoryFile1.MemoryStream.CopyFrom (res.Data, 0);
  MediaPlayer1.Open;
end;

end.
