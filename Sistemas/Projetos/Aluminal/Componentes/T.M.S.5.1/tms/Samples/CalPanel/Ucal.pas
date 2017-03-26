{********************************************************************}
{ TCALENDARPANEL DEMO                                                }
{ version 1.3                                                        }
{ TCALCOMP DEMO                                                      }
{ version 2.1                                                        }
{ for Delphi 3.0,4.0,5.0,6.0,7.0 & C++Builder 3.0,4.0,5.0,6.0        }
{                                                                    }
{ written by TMS Software                                            }
{            copyright © 1998-2004                                   }
{            Email : info@tmssoftware.com                            }
{            Website : http://www.tmssoftware.com                    }
{********************************************************************}

unit Ucal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, CalPanel, CalComp;

type
  TForm1 = class(TForm)

    CalPanel1: TCalPanel;
    Button1: TButton;
    CalComp1: TCalComp;
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
 calcomp1.execute;
end;

end.
