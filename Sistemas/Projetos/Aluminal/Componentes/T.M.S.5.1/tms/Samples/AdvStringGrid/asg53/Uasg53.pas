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

unit Uasg53;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AdvGrid, AsgMemo, Grids, BaseGrid
{$IFDEF VER140}
  , Variants
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    MemoEditLink1: TMemoEditLink;
    MemoEditLink2: TMemoEditLink;
    procedure AdvStringGrid1GetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AdvStringGrid1GetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  AEditor := edCustom;
  if ARow <> 2 then
    AdvStringGrid1.Editlink := MemoEditLink1
  else
    AdvStringGrid1.Editlink := MemoEditLink2;

end;

end.
