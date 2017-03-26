{********************************************************************}
{ TAdvComboBox DEMO application                                      }
{ version 1.1                                                        }
{ for Delphi 4.0,5.0,6.0,7.0 & C++Builder 4.0,5.0,6.0                }
{                                                                    }
{ written by TMS Software                                            }
{            copyright © 1998-2004                                   }
{            Email : info@tmssoftware.com                            }
{            Website : http://www.tmssoftware.com                    }
{********************************************************************}

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvCombo;

type
  TForm1 = class(TForm)
    AdvComboBox1: TAdvComboBox;
    AdvComboBox2: TAdvComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
