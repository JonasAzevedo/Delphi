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
  ExtCtrls, AdvGrid, Grids, AdvListv;

type
  TPagePreview = class(TForm)
    PaintBox1: TPaintBox;
    procedure PaintBox1Paint(Sender: TObject);
  private
    {
    asg:tAdvStringGrid;
    }
    prevctrl: tcomponent;
    { Private declarations }
  public
    {
    constructor Create(aOwner:tComponent; aStringGrid:tAdvStringGrid);
    }
    constructor Create(aOwner: tComponent; aComp: Tcomponent);

    { Public declarations }
  end;

var
  PagePreview: TPagePreview;

implementation

{$R *.DFM}

constructor TPagePreview.Create(aOwner: tComponent; acomp: tcomponent);
begin
  inherited Create(aOwner);
  prevctrl := acomp;
end;

procedure TPagePreview.PaintBox1Paint(Sender: TObject);
var
  t: integer;
begin
  if prevctrl is TAdvStringGrid then
    (prevctrl as TAdvStringGrid).printpreview(paintbox1.canvas, paintbox1.clientrect);

  if prevctrl is TAdvListView then
    (prevctrl as TAdvListView).preview(paintbox1.canvas, paintbox1.clientrect);
end;

end.
