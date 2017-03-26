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
  Dialogs, StdCtrls, tmsAdvGridExcel, Grids, BaseGrid, AdvGrid, Buttons,
  ExtCtrls;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    AdvGridExcelIO1: TAdvGridExcelIO;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SaveDialog1: TSaveDialog;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if opendialog1.Execute then
  begin
    advgridexcelio1.XLSImport(opendialog1.filename);
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if savedialog1.execute then
  begin
    if fileexists(savedialog1.filename) then
      deletefile(savedialog1.filename);
    advgridexcelio1.XLSExport(savedialog1.filename);
  end;
end;

end.
