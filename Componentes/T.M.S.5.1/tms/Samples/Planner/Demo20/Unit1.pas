unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Planner;

type
  TForm1 = class(TForm)
    Planner1: TPlanner;
    Label1: TLabel;
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

procedure TForm1.FormCreate(Sender: TObject);
begin
  // programmatically create 2 items
  with planner1.CreateItem do
  begin
   ItemBegin := 8;
   ItemEnd := 12;
   ItemPos := 0;
   Text.Text := 'Item 1';
  end;
  with planner1.CreateItem do
  begin
   ItemBegin := 8;
   ItemEnd := 12;
   ItemPos := 1;
   Text.Text := 'Item 2';
  end;

  // create link from item 1 to item 2
  planner1.Items[0].LinkedItem :=  planner1.Items[1];
  planner1.Items[0].LinkType := ltLinkFull;   // begin & end time of items will simultanously change

  // create link from item 2 to item 1
  planner1.Items[1].LinkedItem :=  planner1.Items[0];
  planner1.Items[1].LinkType := ltLinkFull;
end;

end.
