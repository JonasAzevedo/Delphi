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

unit uasg33;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atScript, gridscript, Grids, AdvGrid, StdCtrls, asgprev, ImgList,
  BaseGrid
{$IFDEF VER140}
  , Variants
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Grid1: TAdvStringGrid;
    GridScript1: TGridScript;
    Button1: TButton;
    Grid2: TAdvStringGrid;
    Grid3: TAdvStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  GridScript1.clear;
  GridScript1.SourceCode.Assign(Memo1.Lines);
  GridScript1.Execute(unassigned);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  GridScript1.AddGrid('Grid1', Grid1);
  GridScript1.AddGrid('Grid2', Grid2);
end;

end.
