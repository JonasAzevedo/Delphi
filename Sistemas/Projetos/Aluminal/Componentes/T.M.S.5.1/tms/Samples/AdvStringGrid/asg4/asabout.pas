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

unit asabout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, shellapi, ComCtrls, pngimage;

type
  TAbout = class(TForm)
    Label3: TLabel;
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    Button1: TButton;
    Image2: TImage;
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  About: TAbout;

implementation

{$R *.DFM}

procedure TAbout.Label3Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'http://www.tmssoftware.com', nil, nil, SW_NORMAL);
end;

end.
