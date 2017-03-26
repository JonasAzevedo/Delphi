unit PackageEditorForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ResourceModule, ResourceEditorForm, ComCtrls, ExtCtrls, StdCtrls;

type
  TfmPackageEditor = class(TfmResourceEditor)
    PageControl1: TPageControl;
    tsPackage: TTabSheet;
    tsRequires: TTabSheet;
    tsContains: TTabSheet;
    lvRequires: TListView;
    lvContains: TListView;
    Panel1: TPanel;
    cbNeverBuild: TCheckBox;
    cbDesignOnly: TCheckBox;
    cbRuntimeOnly: TCheckBox;
    cbNoDupCheck: TCheckBox;
    Label1: TLabel;
    cbEnvironment: TComboBox;
    Label2: TLabel;
    cbModuleType: TComboBox;
    procedure cbNeverBuildClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbEnvironmentChange(Sender: TObject);
    procedure cbModuleTypeChange(Sender: TObject);
  private
    fInitializing : boolean;
  protected
  public
    procedure DoResourceChanged; override;
  end;

var
  fmPackageEditor: TfmPackageEditor;

implementation

{$R *.DFM}

{ TfmPackageEditor }

procedure TfmPackageEditor.DoResourceChanged;
var
  i : Integer;
  st : string;
  flgs : Integer;

  procedure AddFlag (const flag : string; var st : string);
  begin
    if st <> '' then
      st := st + ', ';

    st := st + flag
  end;

begin
  fInitializing := True;
  with resource as TPackageResource do
  try
    cbNeverBuild.Checked  := (flags and 1) > 0;
    cbDesignOnly.Checked  := (flags and 2) > 0;
    cbRuntimeOnly.Checked := (flags and 4) > 0;
    cbNoDupCheck.Checked  := (flags and 8) > 0;

    cbEnvironment.ItemIndex := ((flags shr 26) and 3);
    cbModuleType.ItemIndex := ((flags shr 30) and 3);

    lvRequires.Items.BeginUpdate;
    try
      lvRequires.Items.Clear;
      for i := 0 to RequiresCount - 1 do
        with lvRequires.Items.Add do
          caption := RequiresName [i];
    finally
      lvRequires.Items.EndUpdate
    end;

    lvContains.Items.BeginUpdate;
    try
      lvContains.Items.Clear;
      for i := 0 to ContainsCount - 1 do
        with lvContains.Items.Add do
        begin
          caption := ContainsName [i];

          flgs := ContainsFlag [i];

          st := '';

          if (flgs and 1) = 1 then
            st := 'Main';

          if (flgs and 8) = 8 then
            AddFlag ('Org.', st);

          if (flgs and 6) = 6 then
            AddFlag ('Weak Package', st)
          else
            if (flgs and 2) = 2 then
              AddFlag ('Package', st)
            else
              if (flgs and 4) = 4 then
                AddFlag ('Weak', st);

          if (flgs and $10) = $10 then
            AddFlag ('Implicit', st);

          SubItems.Add (st)
        end
    finally
      lvContains.Items.EndUpdate
    end
  finally
    fInitializing := False
  end
end;

procedure TfmPackageEditor.cbNeverBuildClick(Sender: TObject);
var
  newFlags : Integer;
begin
  if fInitializing then
    Exit;

  newFlags := TPackageResource (resource).Flags and not $f;

  if cbNeverBuild.Checked then
    newFlags := newFlags or 1;

  if cbDesignOnly.Checked then
    newFlags := newFlags or 2;

  if cbRuntimeOnly.Checked then
    newFlags := newFlags or 4;

  if cbNoDupCheck.Checked then
    newFlags := newFlags or 8;

  TPackageResource (resource).Flags := newFlags;
end;

procedure TfmPackageEditor.FormShow(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePageIndex := 0
end;

procedure TfmPackageEditor.cbEnvironmentChange(Sender: TObject);
var
  newFlags : Integer;
begin
  if fInitializing then
    Exit;

  newFlags := TPackageResource (resource).Flags and not (3 shl 26);
  TPackageResource (resource).Flags := newFlags or (cbEnvironment.ItemIndex shl 26);
end;

procedure TfmPackageEditor.cbModuleTypeChange(Sender: TObject);
var
  newFlags : Integer;
begin
  if fInitializing then
    Exit;

  newFlags := TPackageResource (resource).Flags and not (3 shl 30);
  TPackageResource (resource).Flags := newFlags or (cbModuleType.ItemIndex shl 30);
end;

end.
