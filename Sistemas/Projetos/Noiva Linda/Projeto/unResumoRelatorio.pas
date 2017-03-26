unit unResumoRelatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, ComCtrls, StdCtrls;

type
  TfrmResumoRelatorio = class(TForm)
    lblData: TLabel;
    lblValorTotal: TLabel;
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    Label1: TLabel;
    lblPesquisaPor: TLabel;
    Label2: TLabel;
    lblPeriodo: TLabel;
    Label4: TLabel;
    lblTotalRegistros: TLabel;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmResumoRelatorio: TfrmResumoRelatorio;

implementation

{$R *.dfm}

procedure TfrmResumoRelatorio.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmResumoRelatorio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=27) then
    Self.Close;
end;

end.
