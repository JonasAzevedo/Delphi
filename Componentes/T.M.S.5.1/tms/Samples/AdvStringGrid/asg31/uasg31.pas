{***************************************************************************}
{ TAdvStringGrid demo application                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2009                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{***************************************************************************}

unit uasg31;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Series, TeEngine, ExtCtrls, TeeProcs, Chart, Grids, AdvGrid,
  ChartLink, ComCtrls, BaseGrid;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    ChartLink1: TChartLink;
    ChartLink2: TChartLink;
    SaveBtn: TButton;
    LoadBtn: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Chart1: TChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
    Chart2: TChart;
    ChartLink3: TChartLink;
    ChartLink4: TChartLink;
    Chart3: TChart;
    Series3: TPieSeries;
    Series4: TPieSeries;
    Label1: TLabel;
    procedure SaveBtnClick(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadChart;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.SaveBtnClick(Sender: TObject);
begin
  AdvStringGrid1.SaveFixedCells := False;
  AdvStringGrid1.SaveToCSV('carsales.csv');
end;

procedure TForm1.LoadChart;
begin
  AdvStringGrid1.SaveFixedCells := False;
  AdvStringGrid1.LoadFromCSV('carsales.csv');
  AdvStringGrid1.AutoSizeColumns(true, 10);
end;

procedure TForm1.LoadBtnClick(Sender: TObject);
begin
  LoadChart;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  LoadChart;
end;

end.
