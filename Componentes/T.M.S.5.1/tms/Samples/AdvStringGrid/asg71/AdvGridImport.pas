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

unit AdvGridImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AsgImport, StdCtrls, Grids, BaseGrid, AdvGrid, ExtCtrls, jpeg;

type
  TForm2 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    btnImport: TButton;
    Label1: TLabel;
    AdvGridImportDialog1: TAdvGridImportDialog;
    CheckBox1: TCheckBox;
    procedure btnImportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}


procedure TForm2.btnImportClick(Sender: TObject);
begin
  AdvGridImportDialog1.OpenAndExecute;
end;

end.
