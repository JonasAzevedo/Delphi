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

unit asprev;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AdvGrid, Grids;

type
  TPagePreview = class(TForm)
    PaintBox1: TPaintBox;
    procedure PaintBox1Paint(Sender: TObject);
  private
    asg: tAdvStringGrid;
    { Private declarations }
  public
    constructor Create(aOwner: tComponent; aStringGrid: tAdvStringGrid);
    { Public declarations }
  end;

var
  PagePreview: TPagePreview;

implementation

{$R *.DFM}

constructor TPagePreview.Create(aOwner: tComponent; aStringGrid: tAdvStringGrid);
begin
  inherited Create(aOwner);
  asg := aStringGrid;
end;

procedure TPagePreview.PaintBox1Paint(Sender: TObject);
var
  gr: tgridrect;
begin
  asg.printpreview(paintbox1.canvas, paintbox1.clientrect);
{
 gr.left:=0;
 gr.right:=asg.colcount-1;
 gr.top:=2;
 gr.bottom:=4;

 asg.printpreviewrect(paintbox1.canvas,paintbox1.clientrect,gr);
}
end;

end.
