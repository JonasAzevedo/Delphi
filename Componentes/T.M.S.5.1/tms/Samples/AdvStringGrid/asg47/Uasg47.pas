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

unit Uasg47;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls
{$IFDEF VER140}
  , Variants
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    Label1: TLabel;
    Button1: TButton;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  AdvStringGrid1.Clear;
  AdvStringGrid1.RowCount := 2;
  AdvStringGrid1.LoadFromMDBSQL('CARS.MDB', ComboBox1.Items[ComboBox1.ItemIndex]);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ComboBox1.ItemIndex := 0;
end;

end.
