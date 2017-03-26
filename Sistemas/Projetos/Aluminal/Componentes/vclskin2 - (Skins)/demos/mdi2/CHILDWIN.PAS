unit CHILDWIN;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls, ExtCtrls, Menus,
  ComCtrls;

type
  TMDIChild = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    MainMenu1: TMainMenu;
    Child11: TMenuItem;
    N11111: TMenuItem;
    N22221: TMenuItem;
    N33331: TMenuItem;
    Memo1: TMemo;
    Button2: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMDIChild.Button2Click(Sender: TObject);
begin
    panel1.repaint;
end;

end.
