unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Planner, StdCtrls;

type
  TForm1 = class(TForm)
    Planner1: TPlanner;
    Label1: TLabel;
    procedure Planner1ItemMoving(Sender: TObject; Item: TPlannerItem;
      DeltaBegin, DeltaPos: Integer; var Allow: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Planner1ItemMoving(Sender: TObject; Item: TPlannerItem;
  DeltaBegin, DeltaPos: Integer; var Allow: Boolean);
begin
  if item.ItemEnd + DeltaBegin > planner1.PositionProps[item.ItemPos + DeltaPos].MaxSelection then
    Allow := false;
end;

end.
