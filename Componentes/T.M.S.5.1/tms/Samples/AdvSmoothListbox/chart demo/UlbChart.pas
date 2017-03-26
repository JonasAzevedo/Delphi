unit UlbChart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvSmoothListBox, AdvChart, AdvChartView, AdvChartViewGDIP, StdCtrls, Math,
  AdvChartPaneEditorGDIP, AdvChartUtil, AdvChartGDIP, ExtCtrls;

type
  TForm65 = class(TForm)
    AdvSmoothListBox1: TAdvSmoothListBox;
    Button1: TButton;
    AdvChartPanesEditorDialogGDIP1: TAdvChartPanesEditorDialogGDIP;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure AdvSmoothListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  protected
    procedure MouseUpChart(Sender: Tobject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  public
    { Public declarations }
  end;

var
  Form65: TForm65;

implementation

{$R *.dfm}


procedure TForm65.AdvSmoothListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  bmp: TBitmap;
  ms: TMemoryStream;
begin
  case Key of
    VK_SPACE :
    begin
      if AdvSmoothListBox1.Items.SelectedItem <> nil then
      begin
        AdvSmoothListBox1.DetailControl := AdvSmoothListBox1.Items.SelectedItem.Control;
        case AdvSmoothListBox1.DetailStatus of
          dsDetailsVisible:
          begin
            bmp := TBitmap.Create;
            bmp.Width := 100;
            bmp.Height := 100;
            TAdvGDIPChartView(AdvSmoothListBox1.Items.SelectedItem.Control).PrintAllPanes(bmp.Canvas,rect(0, 0, 100, 100));
            ms := TMemoryStream.Create;
            bmp.SaveToStream(ms);
            AdvSmoothListBox1.Items.SelectedItem.GraphicRight.LoadFromStream(ms);
            ms.Free;
            bmp.Free;
          end;
        end;
      end;
    end;  
  end;
end;

procedure TForm65.FormCreate(Sender: TObject);
var
  c: TAdvGDIPChartView;
  bmp: TBitmap;
  ms: TMemoryStream;
  I: integer;
  K: integer;
begin
  ReportMemoryLeaksOnShutdown := true;
  for I := 0 to 20 do
  begin
    with AdvSmoothListBox1.Items.Add do
    begin
      c := TAdvGDIPChartView.Create(AdvSmoothListBox1);
      c.Panes.Add;
      c.Panes[0].Range.RangeTo := 20;
      c.Panes[0].YAxis.Position := yNone;
      c.Panes[0].XAxis.Position := xNone;            
      with c.Panes[0].Series.add do
      begin
        for K := 0 to 20 do
        begin
          AddSinglePoint(RandomRange(10, 100));
        end;
      end;


      c.Parent := AdvSmoothListBox1;
      c.OnMouseUp := Self.MouseUpChart;
      c.Visible := false;

      Control := c;
      Caption := 'chart ' + inttostr(i);
      CaptionFont.Size := 16;

      GraphicRightType := gtImage;
      GraphicRightShow := gsAlways;
      bmp := TBitmap.Create;
      bmp.Width := 100;
      bmp.Height := 100;
      c.PrintAllPanes(bmp.Canvas,Rect(0, 0, 100, 100));
      ms := TMemoryStream.Create;

      bmp.SaveToStream(ms);
      GraphicRight.LoadFromStream(ms);
      ms.Free;
      bmp.Free;
    end;
  end;
end;

procedure TForm65.MouseUpChart(Sender: Tobject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  AdvChartPanesEditorDialogGDIP1.ChartView := TAdvGDIPChartView(AdvSmoothListBox1.Items.SelectedItem.Control);
  AdvSmoothListBox1.DetailControl := AdvSmoothListBox1.Items.SelectedItem.Control;
  AdvChartPanesEditorDialogGDIP1.Execute;
end;

end.
