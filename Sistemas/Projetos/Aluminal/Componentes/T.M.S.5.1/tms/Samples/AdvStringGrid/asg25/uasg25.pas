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

unit uasg25;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, AdvGrid, ExtCtrls, Printers, StdCtrls, BaseGrid;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    AdvStringGrid2: TAdvStringGrid;
    Button1: TButton;
    AdvStringGrid3: TAdvStringGrid;
    AdvStringGrid4: TAdvStringGrid;
    PrinterSetupDialog1: TPrinterSetupDialog;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  advstringgrid1.randomfill(false, 100);
  advstringgrid2.randomfill(false, 100);
  advstringgrid3.randomfill(false, 100);
  advstringgrid4.randomfill(false, 100);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  r: trect;
  quarterpage: trect;
begin
  if printersetupdialog1.Execute then
  begin
    with Printer do
    begin
      BeginDoc;
      r := Canvas.ClipRect;
      quarterpage := rect(0, 0, (r.right - r.left) shr 1, (r.bottom - r.top) shr 1);

      setmapmode(canvas.handle, mm_lometric);
      dptolp(canvas.handle, r, 2);

      advstringgrid1.PrintSettings.FitToPage := fpShrink;
      advstringgrid1.PrintDraw(canvas, quarterpage);

      advstringgrid2.PrintSettings.HeaderSize := (-r.bottom) shr 1;
      advstringgrid2.PrintSettings.FitToPage := fpShrink;
      advstringgrid2.PrintDraw(canvas, quarterpage);

      advstringgrid3.PrintSettings.LeftSize := r.right shr 1;
      advstringgrid3.PrintSettings.FitToPage := fpShrink;
      advstringgrid3.PrintDraw(canvas, quarterpage);

      advstringgrid4.PrintSettings.LeftSize := r.right shr 1;
      advstringgrid4.PrintSettings.HeaderSize := (-r.bottom) shr 1;
      advstringgrid4.PrintSettings.FitToPage := fpShrink;
      advstringgrid4.PrintDraw(canvas, quarterpage);

      EndDoc;
    end;
  end;
end;

end.
