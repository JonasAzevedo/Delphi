unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrid, ExtCtrls, DBCtrls, DB,
  ADODB, StdCtrls, DBTables, DBGrids, Mask, AsgLinks, asgprev,
  AsgFindDialog;

type
  TForm1 = class(TForm)
    DBAdvGrid1: TDBAdvGrid;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Table1: TTable;
    Button3: TButton;
    AdvPreviewDialog1: TAdvPreviewDialog;
    Button4: TButton;
    AdvGridFindDialog1: TAdvGridFindDialog;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBAdvGrid1GetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure Button3Click(Sender: TObject);
    procedure DBAdvGrid1CanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure Button4Click(Sender: TObject);
    procedure DBAdvGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBAdvGrid1.FloatingFooter.Visible := true;
  Table1.Active := true;
  DBAdvGrid1.FloatingFooter.ColumnCalc[4] := acSum;

  with dbadvgrid1 do
  begin
    fixedcolor := clwhite;
    columns[0].Color := clWhite;
    columns[1].Color := clWhite;
    look := glXP;
  end;

end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then
    DBAdvGrid1.Options:= DBAdvGrid1.Options + [goEditing]
  else
    DBAdvGrid1.Options:= DBAdvGrid1.Options - [goEditing];
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  DBAdvGrid1.Navigation.AdvanceOnEnter:= CheckBox1.Checked;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  DBAdvGrid1.Navigation.AdvanceInsert:= CheckBox2.Checked;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  DBAdvGrid1.Navigation.AllowInsertRow:= CheckBox4.Checked;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  DBAdvGrid1.Navigation.AllowDeleteRow:= CheckBox5.Checked;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  DBAdvGrid1.CopySelectionToClipboard;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  DBAdvGrid1.PasteSelectionFromClipboard;
end;

procedure TForm1.DBAdvGrid1GetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    3:
    begin
      AEditor:= edComboEdit;
      DBAdvGrid1.Combobox.Items.Add('South America');
      DBAdvGrid1.Combobox.Items.Add('North America');
    end;
    4, 5: AEditor:= edPositiveNumeric;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  advgridfinddialog1.Execute;
end;

procedure TForm1.DBAdvGrid1CanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  canedit := (acol > 2);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  advpreviewdialog1.Execute ;
end;

procedure TForm1.DBAdvGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_left then key := vk_up;
  if Key = vk_right then key := vk_down;
end;

end.
