program Dred;

{%ToDo 'Dred.todo'}

uses
  Forms,
  MainForm in 'MainForm.pas' {fmMain},
  ResourceForm in 'ResourceForm.pas' {fmResource},
  ResourceEditorForm in 'ResourceEditorForm.pas' {fmResourceEditor},
  BitmapEditorForm in 'BitmapEditorForm.pas' {fmBitmapEditor},
  HexEditorForm in 'HexEditorForm.pas' {fmHexEditor},
  StringsEditorForm in 'StringsEditorForm.pas' {fmStringsEditor},
  PackageEditorForm in 'PackageEditorForm.pas' {fmPackageEditor},
  AddResourceDialog in 'AddResourceDialog.pas' {dlgAddResource},
  ResourcePropertiesDialog in 'ResourcePropertiesDialog.pas' {dlgResourceProperties},
  VersionEditorForm in 'VersionEditorForm.pas' {fmVersionEditor},
  ComponentEditorForm in 'ComponentEditorForm.pas' {fmComponentEditor},
  AboutBoxForm in 'AboutBoxForm.pas' {fmNTAboutBox},
  MenuEditorForm in 'MenuEditorForm.pas' {fmMenuEditor},
  DialogEditorForm in 'DialogEditorForm.pas' {fmDialogEditor},
  WaveEditorForm in 'WaveEditorForm.pas' {fmWaveEditor},
  MIDIEditorForm in 'MIDIEditorForm.pas' {fmMIDIEditor},
  ResourceGroupEditorForm in 'ResourceGroupEditorForm.pas' {fmResourceGroupEditor},
  AVIEditorForm in 'AVIEditorForm.pas' {fmAVIEditor},
  NewImageForm in 'NewImageForm.pas' {fmNewImage},
  DescriptionEditorForm in 'DescriptionEditorForm.pas' {fmDescriptionEditor},
  HelpContext in 'HelpContext.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Delphi Resource Editor';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
