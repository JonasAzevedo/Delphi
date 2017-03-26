unit UDemo;

interface

uses
  ComObj, Classes, Controls, StdCtrls,
  Windows, Messages, SysUtils, Variants,
  Graphics, Forms, Dialogs, OleServer,
  AdvSmoothListBox, ExtCtrls;

type
  TForm66 = class(TForm)
    AdvSmoothListBox1: TAdvSmoothListBox;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OutlookContacts;
  end;

var
  Form66: TForm66;

implementation

{$R *.dfm}

procedure TForm66.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := true;
  OutlookContacts;
end;

procedure TForm66.OutlookContacts;


end;

end.
