unit AddResourceDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ImgList, ExtCtrls;

type
  TdlgAddResource = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    ImageList1: TImageList;
    Panel1: TPanel;
    lvResourceTypes: TListView;
    pnlResolution: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edWidth: TEdit;
    edHeight: TEdit;
    udWidth: TUpDown;
    udHeight: TUpDown;
    cbColors: TComboBox;
    btnHelp: TButton;
    procedure FormShow(Sender: TObject);
    procedure lvResourceTypesDblClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    fResCount : Integer;
    fOrigLVHeight : Integer;
    fResolutionShowing : boolean;
  protected
    procedure UpdateActions; override;
    { Public declarations }
  public
  end;

var
  dlgAddResource: TdlgAddResource;

implementation

{$R *.DFM}

uses HelpContext;

const
  NoResolutions = 7;

  Resolutions : array [0..NoResolutions - 1] of string = (
    '2',
    '16',
    '256',
    '32768',
    '65536',
    'High Color',
    'True Color');

procedure TdlgAddResource.FormShow(Sender: TObject);
begin
  fResCount := 7;
  cbColors.ItemIndex := 1;
  fOrigLVHeight := lvResourceTypes.Height;
  fResolutionShowing := True;
end;

procedure TdlgAddResource.UpdateActions;
var
  ShowResolution : boolean;
  newResCount, i : Integer;
begin
  newResCount := 0;
  ShowResolution := Assigned (lvResourceTypes.Selected);
  if ShowResolution then
  begin
    ShowResolution := lvResourceTypes.Selected.ImageIndex in [Integer (RT_CURSOR), Integer (RT_ICON), Integer (RT_BITMAP)];
    case lvResourceTypes.Selected.ImageIndex of
      Integer (RT_CURSOR) : newResCount := 7;
      Integer (RT_ICON) : newResCount := 7;
      Integer (RT_BITMAP) : newResCount := 7
    end
  end;

  if ShowResolution <> fResolutionShowing then
  begin
    fResolutionShowing := ShowResolution;
    if ShowResolution then
    begin
      lvResourceTypes.Height := fOrigLVHeight;
      pnlResolution.Visible := True;
      if fResCount <> newResCount then
      begin
        fResCount := NewresCount;
        cbColors.Items.BeginUpdate;
        try
          cbColors.Items.Clear;
          for i := 0 to fResCount - 1 do
            cbColors.Items.Add (Resolutions [i])
        finally
          cbColors.Items.EndUpdate
        end;

       case lvResourceTypes.Selected.ImageIndex of
        Integer (RT_CURSOR) : cbColors.ItemIndex := 0;
        Integer (RT_ICON) : cbColors.ItemIndex := 1;
        Integer (RT_BITMAP) : cbColors.ItemIndex := 2;
       end
     end
    end
    else
    begin
      pnlResolution.Visible := False;
      lvResourceTypes.Height := fOrigLVHeight + pnlResolution.Height + 4;
      fResCount := 0;
    end
  end
end;

procedure TdlgAddResource.lvResourceTypesDblClick(Sender: TObject);
begin
  ModalResult := mrOK
end;

procedure TdlgAddResource.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext (hcAddResourceDialog);
end;

end.
