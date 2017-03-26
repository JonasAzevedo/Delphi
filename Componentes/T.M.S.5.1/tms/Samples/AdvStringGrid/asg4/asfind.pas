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

unit asfind;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ashlp, ExtCtrls;

type
  Tfinddlg = class(TForm)
    Label1: TLabel;
    findtext: TEdit;
    chkcase: TCheckBox;
    chkfull: TCheckBox;
    chkregular: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    dir: TRadioGroup;
    where: TRadioGroup;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  finddlg: Tfinddlg;

implementation

{$R *.DFM}

procedure Tfinddlg.Button3Click(Sender: TObject);
var
  findhlp: tfindhlp;
begin
  findhlp := tfindhlp.create(self);
  try
    findhlp.showmodal;
  finally
    findhlp.free;
  end;
end;

end.
