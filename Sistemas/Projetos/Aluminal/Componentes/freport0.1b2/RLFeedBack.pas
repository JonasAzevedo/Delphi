unit RLFeedBack;

interface

uses
  SysUtils, Classes,
{$ifdef Win32}
  Graphics, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, Controls, ComCtrls;
{$endif}
{$ifdef CF}
  Graphics, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, Controls, ComCtrls;
{$endif}
{$ifdef CLX}
  QTypes, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls, QButtons, QControls, QComCtrls;
{$endif}

type
  TRLFeedBackCancelEvent=procedure(Sender:TObject; var CancelIt:boolean) of object;

  TfrmRLFeedBack = class(TForm)
    BitBtnCancel: TBitBtn;
    ProgressBar: TProgressBar;
    TimerBlink: TTimer;
    LabelStepName: TLabel;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerBlinkTimer(Sender: TObject);
  private
    { Private declarations }
    BarIndex:integer;
    Bars    :TList;
    //
    procedure   Init;
  public
    { Public declarations }
    Canceled:boolean;
    Finished:boolean;
    OnCancel:TRLFeedBackCancelEvent;
    //
    constructor Create(const aTitle:string; aCount:integer=1); reintroduce;
    //
    procedure   Max(n:integer);
    procedure   NextBar;
    procedure   Tick;
    procedure   Finish;
    procedure   StepCaption(const aCaption:string);
  end;

var
  frmRLFeedBack: TfrmRLFeedBack;

implementation

uses
  RLReport, RLConsts;

procedure TfrmRLFeedBack.Init;
begin
  Left := 289;
  Top := 252;
  Width := 393;
  Height := 129;
  HorzScrollBar.Range := 61;
  VertScrollBar.Range := 45;
  ActiveControl := BitBtnCancel;
  AutoScroll := False;
  Caption := 'Progresso';
  Color := clBtnFace;
  Font.Color := clWindowText;
  Font.Height := 11;
  Font.Name := 'MS Sans Serif';
  Font.Pitch := fpVariable;
  Font.Style := [];
  FormStyle := fsStayOnTop;
  Position := poMainFormCenter;
{$ifdef Win32}
  BorderStyle := bsDialog
{$endif};
{$ifdef CF}
  BorderStyle := bsDialog
{$endif}
{$ifdef CLX}
  BorderStyle := fbsDialog;
{$endif};
  OnDestroy := FormDestroy;
  PixelsPerInch := 96;
  LabelStepName:=TLabel.Create(Self);
  with LabelStepName do
  begin
    Name := 'LabelStepName';
    Parent := Self;
    Left := 14;
    Top := 12;
    Width := 39;
    Height := 13;
    Caption := 'LabelStepName';
    Font.Color := clWindowText;
    Font.Height := 12;
    Font.Name := 'MS Sans Serif';
    Font.Pitch := fpVariable;
    Font.Style := [];
    ParentFont := False;
  end;
  ProgressBar:=TProgressBar.Create(Self);
  with ProgressBar do
  begin
    Name := 'ProgressBar';
    Parent := Self;
    Left := 14;
    Top := 28;
    Width := 355;
    Height := 17;
    Min := 0;
    Max := 100;
    Step := 1;
  end;
  BitBtnCancel:=TBitBtn.Create(Self);
  with BitBtnCancel do
  begin
    Name := 'BitBtnCancel';
    Parent := Self;
    Left := 151;
    Top := 65;
    Width := 85;
    Height := 25;
    Caption := '&Cancelar';
    TabOrder := 0;
    OnClick := BitBtnCancelClick;
    Kind := bkCancel;
  end;
  TimerBlink:=TTimer.Create(Self);
  with TimerBlink do
  begin
    Name := 'TimerBlink';
    Enabled := False;
    Interval := 300;
    OnTimer := TimerBlinkTimer;
    Left := 4;
    Top := 64;
  end;
  //
  BitBtnCancel.Caption :=LS_CancelStr;
  LabelStepName.Caption:=LS_WaitStr;
end;

constructor TfrmRLFeedBack.Create(const aTitle:string; aCount:integer=1);
var
  i,h,d:integer;
  b,n:TProgressBar;
begin
  inherited CreateNew(nil);
  Init;
  //
  d:=Height-BitBtnCancel.Top;
  Caption:=aTitle;
  Bars:=TList.create;
  h:=0;
  b:=ProgressBar;
  Bars.Add(b);
  for i:=2 to aCount do
  begin
    n:=TProgressBar.Create(self);
    n.Name      :='ProgressBar'+IntToStr(i);
    n.Parent    :=b.Parent;
    n.Boundsrect:=b.BoundsRect;
    n.Step      :=b.Step;
    n.Top       :=b.Top+b.Height+2;
    inc(h,b.Height+2);
    b:=n;
    Bars.Add(b);
  end;
  Height  :=Height+h;
  BitBtnCancel.Top:=Height-d;
  BarIndex:=0;
  OnCancel:=nil;
  Canceled:=false;
  Finished:=false;
end;

procedure TfrmRLFeedBack.BitBtnCancelClick(Sender: TObject);
begin
  if BitBtnCancel.Kind=bkOk then
    Finished:=true
  else begin
    Canceled:=true;
    if assigned(OnCancel) then
      OnCancel(self,Canceled);
  end;    
end;

procedure TfrmRLFeedBack.Max(n:integer);
begin
  TProgressBar(Bars[BarIndex]).Max     :=n;
  TProgressBar(Bars[BarIndex]).Position:=0;
end;

procedure TfrmRLFeedBack.StepCaption(const aCaption:string);
begin
  LabelStepName.Caption:=aCaption;
  LabelStepName.Update;
end;

procedure TfrmRLFeedBack.Tick;
begin
  TProgressBar(Bars[BarIndex]).StepIt;
  Application.ProcessMessages;
  if Application.Terminated then
    Abort;
end;

procedure TfrmRLFeedBack.NextBar;
begin
  inc(BarIndex);
end;

procedure TfrmRLFeedBack.Finish;
begin
  LabelStepName.Caption:=LS_FinishedStr;
  BitBtnCancel.Kind    :=bkOk;
  BitBtnCancel.Caption :=LS_CloseStr;
  BitBtnCancel.Default :=true;
  TimerBlink.Enabled   :=true;
  while not Finished do 
    Application.ProcessMessages;
end;

procedure TfrmRLFeedBack.FormDestroy(Sender: TObject);
begin
  Bars.free;
end;

procedure TfrmRLFeedBack.TimerBlinkTimer(Sender: TObject);
begin
  LabelStepName.Visible:=not LabelStepName.Visible;
end;

end.

