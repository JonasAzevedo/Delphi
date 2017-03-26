unit unSelecionaEmailParaSite;

interface

uses
  DBGrids, Grids,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, ComCtrls, StdCtrls, ExtCtrls;

type
  TfrmSelecionaEmailSite = class(TForm)
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    pnlSite: TPanel;
    lblSite: TLabel;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    codSite: Integer;
    nomeSite: String;
  end;

var
  frmSelecionaEmailSite: TfrmSelecionaEmailSite;

implementation

uses unDM;

{$R *.dfm}

procedure TfrmSelecionaEmailSite.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaEmailSite.FormShow(Sender: TObject);
begin
  lblSite.Caption := nomeSite;
end;

end.
