unit unVerLocacoesPendentesVencendo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, AppEvnts, ComCtrls;

type
  TfrmLocacoesPendentesVencendo = class(TForm)
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    dbGrdLocacoesPendentesVencendo: TDBGrid;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLocacoesPendentesVencendo: TfrmLocacoesPendentesVencendo;

implementation

uses unPrincipal;

{$R *.dfm}

procedure TfrmLocacoesPendentesVencendo.ApplicationEventsHint(
  Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmLocacoesPendentesVencendo.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key=#27) then
    Self.Close;
end;

end.
