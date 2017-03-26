{***************************************************************************}
{ TAdvStringGrid demo application                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2009                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{***************************************************************************}

unit Ucollist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, BtnListB;

type
  TFieldChooser = class(TForm)
    ButtonListbox1: TButtonListbox;
    procedure FormCreate(Sender: TObject);
    procedure ButtonListbox1OleDragStart(Sender: TObject;
      DropIndex: Integer);
    procedure ButtonListbox1OleDragStop(Sender: TObject;
      OLEEffect: Integer);
    procedure ButtonListbox1OleDragOver(Sender: TObject;
      var Allow: Boolean);
  private
    { Private declarations }
    colsource: TObject;
  public
    { Public declarations }
  end;

var
  FieldChooser: TFieldChooser;

implementation

{$R *.DFM}

procedure TFieldChooser.FormCreate(Sender: TObject);
begin
  SetWindowPos(self.handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
end;

procedure TFieldChooser.ButtonListbox1OleDragStart(Sender: TObject;
  DropIndex: Integer);
begin
  colsource := Sender;
end;

procedure TFieldChooser.ButtonListbox1OleDragStop(Sender: TObject;
  OLEEffect: Integer);
begin
  colsource := nil;
end;

procedure TFieldChooser.ButtonListbox1OleDragOver(Sender: TObject;
  var Allow: Boolean);
begin
  Allow := Sender <> ColSource;
end;

end.
