unit ComponentEditorForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ResourceEditorForm, StdCtrls;

type
  TfmComponentEditor = class(TfmResourceEditor)
    mmoText: TMemo;
    procedure mmoTextExit(Sender: TObject);
  private
    procedure SaveResource;
  protected
    function GetEditSupport: TEditSupport; override;
  public
    procedure EditUndo; override;
    procedure DoResourceChanged; override;
  end;

var
  fmComponentEditor: TfmComponentEditor;

implementation

uses ResourceModule;

{$R *.DFM}

{ TfmComponentEditor }

procedure TfmComponentEditor.DoResourceChanged;
begin
  with resource as TComponentResource do
    mmoText.Lines.Assign (ComponentText);
end;

procedure TfmComponentEditor.SaveResource;
begin
  inherited;
  with resource as TComponentResource do
    SetComponentText (mmoText.Lines);
end;

procedure TfmComponentEditor.EditUndo;
begin
  if mmoText.CanUndo then
    mmoText.Undo
  else
    resource.Undo
end;

function TfmComponentEditor.GetEditSupport: TEditSupport;
begin
  result := inherited GetEditSupport;
  if mmoText.CanUndo then
    result := result + [esUndo];
end;

procedure TfmComponentEditor.mmoTextExit(Sender: TObject);
begin
  SaveResource
end;

end.
