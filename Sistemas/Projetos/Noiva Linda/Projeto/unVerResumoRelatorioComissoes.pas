unit unVerResumoRelatorioComissoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, AppEvnts, Grids;

type
  TfrmVerResumoRelatorioComissoes = class(TForm)
    strGrdComissoes: TStringGrid;
    ApplicationEvents: TApplicationEvents;
    StatusBar: TStatusBar;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVerResumoRelatorioComissoes: TfrmVerResumoRelatorioComissoes;

implementation

{$R *.dfm}

procedure TfrmVerResumoRelatorioComissoes.ApplicationEventsHint(
  Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmVerResumoRelatorioComissoes.FormShow(Sender: TObject);
var
  i:Integer;
  total: Real;
begin
  strGrdComissoes.Cells[3,0] := 'TOTAL';
  strGrdComissoes.FixedRows := 1;
  for i:=1 to strGrdComissoes.RowCount do
    begin
    if(strGrdComissoes.Cells[1,i] = '')then
      strGrdComissoes.Cells[1,i] := '0,00';
    if(strGrdComissoes.Cells[2,i] = '')then
      strGrdComissoes.Cells[2,i] := '0,00';
    total := StrToFloat(strGrdComissoes.Cells[1,i])+StrToFloat(strGrdComissoes.Cells[2,i]);
    strGrdComissoes.Cells[3,i] := FormatFloat('#0.00',total);
    end;

end;

end.
