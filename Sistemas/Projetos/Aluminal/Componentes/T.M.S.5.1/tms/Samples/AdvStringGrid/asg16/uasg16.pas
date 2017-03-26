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

unit uasg16;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, AdvGrid, asgprint, asgprev, BaseGrid;

type
  TForm1 = class(TForm)
    Button1: TButton;
    AdvPreviewDialog1: TAdvPreviewDialog;
    AdvStringGrid1: TAdvStringGrid;
    AdvGridPrintSettingsDialog1: TAdvGridPrintSettingsDialog;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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

procedure TForm1.Button1Click(Sender: TObject);
begin
  advpreviewdialog1.execute;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  advgridprintsettingsdialog1.execute;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  advstringgrid1.savefixedcells := false;
  advstringgrid1.loadfromcsv('cars.csv');
end;

end.
