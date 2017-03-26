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

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Grids, BaseGrid, AdvGrid, StdCtrls;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    ImageList1: TImageList;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure AdvStringGrid1GetDisplText(Sender: TObject; ACol,
      ARow: Integer; var Value: string);
    procedure Button2Click(Sender: TObject);
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
  advstringgrid1.AddDataImage(1, 1, 0, haLeft, vaTop);
  advstringgrid1.AddDataImage(1, 2, 0, haLeft, vaTop);
  advstringgrid1.AddDataImage(1, 3, 0, haLeft, vaTop);
  advstringgrid1.AddDataImage(1, 4, 0, haLeft, vaTop);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  advstringgrid1.Cells[1, 1] := 'Y';
  advstringgrid1.Cells[1, 2] := 'N';
  advstringgrid1.Cells[1, 3] := 'Y';
  advstringgrid1.Cells[1, 4] := 'N';
end;

procedure TForm1.AdvStringGrid1GetDisplText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
var
  oldvalue: string;
begin
  oldvalue := value;
  if (ACol = 1) and (ARow > 0) then
  begin
    if value = 'Y' then
      value := '1'
    else
      value := '0';

  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  advstringgrid1.Cells[1, 1] := 'N';
  advstringgrid1.Cells[1, 2] := 'Y';
  advstringgrid1.Cells[1, 3] := 'N';
  advstringgrid1.Cells[1, 4] := 'Y';
end;

end.
