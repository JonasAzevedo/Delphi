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

unit uasg8;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Grids, AdvGrid, Buttons, Menus, BaseGrid;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    RichEdit1: TRichEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    FontName: TComboBox;
    SpeedButton8: TSpeedButton;
    ColorDialog1: TColorDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    SavetoCSV1: TMenuItem;
    LoadfromCSV1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    FontSize: TComboBox;
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure SavetoCSV1Click(Sender: TObject);
    procedure LoadfromCSV1Click(Sender: TObject);
    procedure AdvStringGrid1SelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure FontSizeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
  with advstringgrid1 do
  begin
    RichToCell(col, row, richedit1);
   //HideSelection;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if fsBold in richedit1.SelAttributes.Style then
    richedit1.SelAttributes.Style :=
      richedit1.SelAttributes.Style - [fsBold]
  else
    richedit1.SelAttributes.Style :=
      richedit1.SelAttributes.Style + [fsBold];
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if fsItalic in richedit1.SelAttributes.Style then
    richedit1.SelAttributes.Style :=
      richedit1.SelAttributes.Style - [fsItalic]
  else
    richedit1.SelAttributes.Style :=
      richedit1.SelAttributes.Style + [fsItalic];
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  if fsUnderline in richedit1.SelAttributes.Style then
    richedit1.SelAttributes.Style :=
      richedit1.SelAttributes.Style - [fsUnderline]
  else
    richedit1.SelAttributes.Style :=
      richedit1.SelAttributes.Style + [fsUnderline];

end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  colordialog1.color := richedit1.SelAttributes.Color;
  if colordialog1.execute then
    richedit1.SelAttributes.color := colordialog1.color;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  richedit1.Paragraph.Alignment := taLeftJustify;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
  richedit1.Paragraph.Alignment := taCenter;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  richedit1.Paragraph.Alignment := taRightJustify;
end;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  DC: HDC;
begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontName.Items));
  ReleaseDC(0, DC);
  FontName.Sorted := True;

  FontName.ItemIndex := FontName.Items.IndexOf('Arial');
  FontSize.ItemIndex := 1;


end;



procedure TForm1.FontNameChange(Sender: TObject);
begin
  RichEdit1.SelAttributes.Name := fontname.items[fontname.itemindex];
end;

procedure TForm1.SavetoCSV1Click(Sender: TObject);
begin
  AdvStringGrid1.SaveFixedCells := False;
  if opendialog1.Execute then
    AdvStringGrid1.LoadFromFile(opendialog1.Filename);
end;

procedure TForm1.LoadfromCSV1Click(Sender: TObject);
begin
  if Savedialog1.Execute then
  begin
    AdvStringGrid1.SaveToFile(SaveDialog1.Filename);
  end;
end;

procedure TForm1.AdvStringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  AdvStringgrid1.celltorich(acol, arow, richedit1);
end;

procedure TForm1.FontSizeChange(Sender: TObject);
begin
  Richedit1.selattributes.Size := strtoint(fontsize.items[fontsize.itemindex]);
end;

end.
