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

unit Uasg5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, AdvGrid, ImgList, BaseGrid;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    ImageList1: TImageList;
    procedure AdvStringGrid1GetEditorType(Sender: TObject; aCol,
      aRow: Integer; var aEditor: TEditorType);
    procedure FormCreate(Sender: TObject);
    procedure AdvStringGrid1ComboChange(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: string);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.AdvStringGrid1GetEditorType(Sender: TObject; aCol,
  aRow: Integer; var aEditor: TEditorType);
begin
  with AdvStringGrid1 do
    case ACol of
      1: begin
          aEditor := edComboList;
          ClearComboString;
          if FileExists('cars.dat') then
            ComboBox.Items.LoadFromFile('cars.dat');
        end;
      2: begin
          aEditor := edComboList;
          ClearComboString;
          if Cells[1, ARow] <> '' then
            if FileExists(Cells[1, ARow] + '.dat') then
              ComboBox.Items.LoadFromFile(Cells[1, ARow] + '.dat');
        end;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to 2 do
    AdvStringGrid1.AddImageIdx(i, 0, i, haBeforeText, vatop);
end;

procedure TForm1.AdvStringGrid1ComboChange(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: string);
var
  sl: TStringList;
begin
  if ACol = 1 then
  begin
    sl := TStringList.Create;
    if FileExists(ASelection + '.dat') then
      sl.LoadFromFile(ASelection + '.dat');

    if sl.Count > 0 then
      AdvStringGrid1.Cells[2, ARow] := sl.Strings[0];

    sl.Free;
  end;
end;

end.
