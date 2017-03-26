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
    asg: TAdvStringGrid;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; AStringGrid: TAdvStringGrid);
    { Public declarations }
  end;

var
  PagePreview: TPagePreview;

implementation

{$R *.DFM}

constructor TPagePreview.Create(AOwner: TComponent; AStringGrid: TAdvStringGrid);
begin
  inherited Create(AOwner);
  asg := AStringGrid;
end;

procedure TPagePreview.PaintBox1Paint(Sender: TObject);
begin
  asg.PrintPreview(PaintBox1.Canvas, PaintBox1.ClientRect);
end;

end.
