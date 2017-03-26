{***************************************************************************}
{ TAdvStringGrid demo application                                           }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2009                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{***************************************************************************}

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, BaseGrid, AdvGrid, XPMan;

type
  TForm5 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    XPManifest1: TXPManifest;
    Button2: TButton;
    Button3: TButton;
    procedure AdvStringGrid1GetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure AdvStringGrid1CanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure AdvStringGrid1GetFormat(Sender: TObject; ACol: Integer;
      var AStyle: TSortStyle; var aPrefix, aSuffix: string);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitGrid;
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.AdvStringGrid1CanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := ARow > 2;
end;

procedure TForm5.AdvStringGrid1GetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
{$IFDEF VER200}
  case ACol of
    1: AEditor := edNormal;
    2: AEditor := edComboList;
    3: AEditor := edComboEdit;
    4: AEditor := edEditBtn;
  end;
  if ACol = 2 then
  begin
    AdvStringGrid1.ComboBox.Items.Clear;
    AdvStringGrid1.ComboBox.Items.Add(AdvStringGrid1.WideCells[1, 1]);
    AdvStringGrid1.ComboBox.Items.Add(AdvStringGrid1.WideCells[1, 2]);
    AdvStringGrid1.ComboBox.Items.Add(AdvStringGrid1.WideCells[2, 1]);
    AdvStringGrid1.ComboBox.DropWidth := 120;
  end;

  if ACol = 3 then
  begin
    AdvStringGrid1.ComboBox.Items.Clear;
    AdvStringGrid1.ComboBox.Items.Add('Edit 1');
    AdvStringGrid1.ComboBox.Items.Add('Edit 2');
    AdvStringGrid1.ComboBox.Items.Add('Edit 3');
  end;
{$ELSE}
  case ACol of
    1: AEditor := edUniEdit;
    2: AEditor := edUniComboList;
    3: AEditor := edUniComboEdit;
    4: AEditor := edUniEditBtn;
  end;

  if ACol = 2 then
  begin
    AdvStringGrid1.UniCombo.Items.Clear;
    AdvStringGrid1.UniCombo.Items.Add(AdvStringGrid1.WideCells[1, 1]);
    AdvStringGrid1.UniCombo.Items.Add(AdvStringGrid1.WideCells[1, 2]);
    AdvStringGrid1.UniCombo.Items.Add(AdvStringGrid1.WideCells[2, 1]);
    AdvStringGrid1.UniCombo.DropWidth := 120;
  end;

  if ACol = 3 then
  begin
    AdvStringGrid1.UniCombo.Items.Clear;
    AdvStringGrid1.UniCombo.Items.Add('Edit 1');
    AdvStringGrid1.UniCombo.Items.Add('Edit 2');
    AdvStringGrid1.UniCombo.Items.Add('Edit 3');
  end;
{$ENDIF}

end;

procedure TForm5.AdvStringGrid1GetFormat(Sender: TObject; ACol: Integer;
  var AStyle: TSortStyle; var aPrefix, aSuffix: string);
begin
{$IFDEF VER200}
  AStyle := ssAlphabetic;
{$ELSE}
  AStyle := ssUnicode;
{$ENDIF}
end;

procedure TForm5.InitGrid;
begin
  advstringgrid1.Cells[1, 0] := 'Edit';
  advstringgrid1.Cells[2, 0] := 'ComboList';
  advstringgrid1.Cells[3, 0] := 'ComboEdit';
  advstringgrid1.Cells[4, 0] := 'Edit Btn';

  advstringgrid1.WideCells[1, 3] := 'Cell 1,1';
  advstringgrid1.WideCells[1, 4] := 'Cell 1,2';
  advstringgrid1.WideCells[2, 3] := 'Cell 2,2';
  advstringgrid1.WideCells[2, 4] := 'Cell 2,1';

  advstringgrid1.RowColor[1] := clInfoBk;
  advstringgrid1.RowColor[2] := clInfoBk;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  advstringgrid1.SortSettings.Column := 1;
  advstringgrid1.SortSettings.Direction := sdAscending;
  advstringgrid1.QSort;
end;

procedure TForm5.Button3Click(Sender: TObject);
begin
  advstringgrid1.AutoSizeColumns(false, 4);
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
{$IFNDEF VER200}
  advstringgrid1.LoadFromCSV('.\unicode.csv');
{$ENDIF}
  InitGrid;
end;

end.
