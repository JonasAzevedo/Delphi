unit DescriptionEditorForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ResourceEditorForm, StdCtrls;

type
  TfmDescriptionEditor = class(TfmResourceEditor)
    Label1: TLabel;
    edEXEDescription: TEdit;
    procedure edEXEDescriptionExit(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetEditSupport: TEditSupport; override;

  public
    procedure DoResourceChanged; override;
    procedure EditUndo; override;
  end;

var
  fmDescriptionEditor: TfmDescriptionEditor;

implementation

uses ResourceModule;

{$R *.DFM}

{ TfmDescriptionEditor }

procedure TfmDescriptionEditor.DoResourceChanged;
begin
  with resource as TDescriptionResource do
    edEXEDescription.Text := Description
end;

procedure TfmDescriptionEditor.EditUndo;
begin
  if edEXEDescription.CanUndo then
    edEXEDescription.Undo
  else
    resource.Undo;
end;

function TfmDescriptionEditor.GetEditSupport: TEditSupport;
begin
  result := inherited GetEditSupport;
  if edEXEDescription.CanUndo then
    result := result + [esUndo];
end;

procedure TfmDescriptionEditor.edEXEDescriptionExit(Sender: TObject);
begin
  inherited;
  (resource as TDescriptionResource).Description := edEXEDescription.Text;
end;

end.
