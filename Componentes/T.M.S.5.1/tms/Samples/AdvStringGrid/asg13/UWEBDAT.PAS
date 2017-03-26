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

unit Uwebdat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  webdata, StdCtrls, Grids, AdvGrid, ComCtrls, shellapi, BaseGrid
{$IFDEF VER150}
  , XPMan
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    WebData1: TWebData;
    Button1: TButton;
    qgrid: TAdvStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    ProgressBar1: TProgressBar;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    proxyuser: TEdit;
    proxypwd: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    proxyserver: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure WebData1Data(sender: TObject; iItem: Integer; data: string);
    procedure qgridAutoInsertRow(Sender: TObject; ARow: Integer);
    procedure qgridAutoDeleteRow(Sender: TObject; aRow: Integer);
    procedure qgridCanEditCell(Sender: TObject; Arow, Acol: Integer;
      var canedit: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure WebData1Progress(sender: TObject; iItem: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label3Click(Sender: TObject);
    procedure WebData1CollectDone(sender: TObject);
    procedure WebData1CollectError(sender: TObject; iItem,
      errcode: Integer);
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
var
  i: integer;

begin
  webdata1.Data.Clear;

  webdata1.Proxy := proxyserver.text;
  webdata1.ProxyUserID := proxyuser.text;
  webdata1.ProxyPassword := proxypwd.text;

  i := 1;
  while (i < qgrid.rowcount) do
  begin
    if qgrid.cells[1, i] = '' then qgrid.removerows(i, 1)
    else inc(i);
  end;
  qgrid.autonumbercol(0);

  for i := 1 to qgrid.Rowcount - 1 do
  begin

    with webdata1.Data.Add do
    begin
      ScanFirst := '<TD><SPAN class="smallprompt">Last</SPAN>';
      ScanFrom := '<SPAN class="smallprompt"><B>';
      ScanTo := '</B>';
      URL := 'http://moneycentral.msn.com/scripts/webquote.dll?iPage=lqd&Symbol=' + qgrid.cells[1, i];
    end;
  end;
  progressbar1.Max := webdata1.data.count - 1;
  progressbar1.Min := 0;

  if checkbox1.checked then
    webdata1.ThreadCollectData
  else
    webdata1.CollectData;

end;

procedure TForm1.WebData1Data(sender: TObject; iItem: Integer;
  data: string);
begin
  qgrid.cells[2, iItem + 1] := data;
end;

procedure TForm1.qgridAutoInsertRow(Sender: TObject; ARow: Integer);
begin
  qgrid.autonumbercol(0);
end;

procedure TForm1.qgridAutoDeleteRow(Sender: TObject; aRow: Integer);
begin
  qgrid.autonumbercol(0);
end;

procedure TForm1.qgridCanEditCell(Sender: TObject; Arow, Acol: Integer;
  var canedit: Boolean);
begin
  canedit := acol <> 2;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  qgrid.delimiter := ',';
  qgrid.loadfromcsv('quotes.csv');
  qgrid.autonumbercol(0);
end;

procedure TForm1.WebData1Progress(sender: TObject; iItem: Integer);
begin
  progressbar1.Position := iItem;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qgrid.delimiter := ',';
  qgrid.savetocsv('quotes.csv');
end;

procedure TForm1.Label3Click(Sender: TObject);
begin
  shellexecute(self.handle, 'open', 'http://www.tmssoftware.com', nil, nil, sw_normal);
end;

procedure TForm1.WebData1CollectDone(sender: TObject);
begin
  messagedlg('All quotes downloaded', mtinformation, [mbok], 0);
end;

procedure TForm1.WebData1CollectError(sender: TObject; iItem,
  errcode: Integer);
begin
  qgrid.cells[2, iItem + 1] := 'Error';
end;

end.
