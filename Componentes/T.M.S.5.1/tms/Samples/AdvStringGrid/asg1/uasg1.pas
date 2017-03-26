{***************************************************************************}
{ TAdvStringGrid demo application                                           }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2009                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{***************************************************************************}

unit uasg1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, AdvGrid, StdCtrls, AsPrev, BaseGrid;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    save: TButton;
    load: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit3: TEdit;
    Label8: TLabel;
    Edit4: TEdit;
    Label9: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    FontDialog1: TFontDialog;
    CheckBox1: TCheckBox;
    labelspage: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    procedure saveClick(Sender: TObject);
    procedure loadClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure AdvStringGrid1PrintSetColumnWidth(Sender: TObject;
      aCol: Integer; var width: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure AdvStringGrid1PrintNewPage(Sender: TObject; aRow: Integer;
      var newpage: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.saveClick(Sender: TObject);
begin
  AdvStringGrid1.SaveToFile('adres.tbl');
end;

procedure TForm1.loadClick(Sender: TObject);
begin
  AdvStringGrid1.LoadFromFile('adres.tbl');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  PagePreview: TPagePreview;
begin
  with AdvStringGrid1.printsettings do
  begin
    Fixedheight := Strtoint(edit2.text) * 10;
    Leftsize := Strtoint(edit3.text) * 10;
    Headersize := Strtoint(edit4.text) * 10;
    if Checkbox1.Checked then
      Borders := pbSingle
    else
      Borders := pbNoborder;
  end;

  PagePreview := TPagePreview.Create(self, AdvStringGrid1);
  try
    PagePreview.ShowModal;
  finally
    PagePreview.Free;
  end;
end;

procedure TForm1.AdvStringGrid1PrintSetColumnWidth(Sender: TObject;
  aCol: Integer; var width: Integer);
begin
  Width := StrToInt(edit1.text) * 10;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  with AdvStringGrid1.PrintSettings do
  begin
    Fixedheight := StrToInt(edit2.text) * 10;
    LeftSize := StrToInt(edit3.text) * 10;
    HeaderSize := StrToInt(edit4.text) * 10;
    if Checkbox1.Checked then
      Borders := pbSingle
    else Borders := pbNoBorder;
  end;

  AdvStringGrid1.print;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    AdvStringGrid1.Font := Fontdialog1.Font;
    AdvStringGrid1.PrintSettings.Font := FontDialog1.Font;
  end;
end;

procedure TForm1.AdvStringGrid1PrintNewPage(Sender: TObject; aRow: Integer;
  var newpage: Boolean);
var
  i: integer;
begin
  i := StrToInt(LabelsPage.Text);
  if (arow > 0) and (arow mod i = 0) then
    NewPage := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  AdvStringGrid1.LoadFromFile('adres.tbl');
end;

end.
