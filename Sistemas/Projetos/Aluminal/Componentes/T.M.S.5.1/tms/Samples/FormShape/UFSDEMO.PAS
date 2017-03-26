{********************************************************************}
{ TFormShape DEMO application                                        }
{ version 1.2                                                        }
{ for Delphi 4.0,5.0,6.0,7.0 & C++Builder 4.0,5.0,6.0                }
{                                                                    }
{ written by TMS Software                                            }
{            copyright © 1998-2004                                   }
{            Email : info@tmssoftware.com                            }
{            Website : http://www.tmssoftware.com                    }
{********************************************************************}

unit Ufsdemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, frmshape;

type
  TForm1 = class(TForm)
    Formshape1: TFormshape;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
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

procedure TForm1.Button1Click(Sender: TObject);
begin
self.Close;
end;

end.
