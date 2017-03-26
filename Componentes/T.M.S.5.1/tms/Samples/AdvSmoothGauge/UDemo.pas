unit UDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvSmoothGauge, ComCtrls, StdCtrls, AdvStyleIF, ExtCtrls;

type
  TForm185 = class(TForm)
    AdvSmoothGauge1: TAdvSmoothGauge;
    AdvSmoothGauge2: TAdvSmoothGauge;
    AdvSmoothGauge3: TAdvSmoothGauge;
    TrackBar1: TTrackBar;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ComboBox1: TComboBox;
    Timer1: TTimer;
    CheckBox1: TCheckBox;
    procedure TrackBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form185: TForm185;
  g: TAdvSmoothGauge;

implementation

{$R *.dfm}

procedure TForm185.CheckBox1Click(Sender: TObject);
begin
  AdvSmoothGauge1.Animation := CheckBox1.Checked;
end;

procedure TForm185.ComboBox1Change(Sender: TObject);
var
  s: TTMSStyle;
begin
  s := tsOffice2003Blue;
  case ComboBox1.ItemIndex of
  0: s := TTMSStyle(0);
  1: s := TTMSStyle(1);
  2: s := TTMSStyle(2);
  3: s := TTMSStyle(3);
  4: s := TTMSStyle(4);
  5: s := TTMSStyle(5);
  6: s := tsOffice2007Silver;
  7: s := tsWindowsXP;
  8: s := tsWhidbey;
  end;
  AdvSmoothGauge1.SetComponentStyle(s);
end;

procedure TForm185.FormCreate(Sender: TObject);
begin
  ComboBox1.ItemIndex := 4;
  g := TAdvSmoothGauge.Create(Self);
  g.Width := 150;
  g.Height := 150;
  g.Top := TrackBar1.Top + TrackBar1.Height;
  g.Left := TrackBar1.Left;
  g.Parent := Self;
end;

procedure TForm185.FormDestroy(Sender: TObject);
begin
  g.free;
end;

procedure TForm185.RadioButton1Click(Sender: TObject);
begin
  AdvSmoothGauge2.Value := -30;
end;

procedure TForm185.RadioButton2Click(Sender: TObject);
begin
  AdvSmoothGauge2.Value := 30;
end;

procedure TForm185.Timer1Timer(Sender: TObject);
begin
  g.Value := Random(100);
end;

procedure TForm185.TrackBar1Change(Sender: TObject);
begin
  AdvSmoothGauge3.Value := TrackBar1.Position;
  AdvSmoothGauge1.Value := TrackBar1.Position;
end;

end.
