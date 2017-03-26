{***********************************************************************}
{ TAdvSmoothDatePicker component                                        }
{ for Delphi & C++ Builder                                              }
{                                                                       }
{ written by :                                                          }
{            TMS Software                                               }
{            copyright © 2009                                           }
{            Email : info@tmssoftware.com                               }
{            Website : http://www.tmssoftware.com                       }
{                                                                       }
{ The source code is given as is. The author is not responsible         }
{ for any possible damage done due to the use of this code.             }
{ The component can be freely used in any application. The source       }
{ code remains property of the writer and may not be distributed        }
{ freely as such.                                                       }
{***********************************************************************}

{$I TMSDEFS.INC}

unit AdvSmoothDatePicker;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, AdvSmoothEditButton, AdvSmoothCalendar, AdvStyleIF, GDIPFill;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 5; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 4; // Build nr.

  // Version history
  // v1.0.0.0 : first release
  // v1.0.0.1 : Fixed : issue with dropdown button click & dateselect
  // v1.0.0.2 : Improved : behaviour with click outside calendar to hide calendar
  //          : Improved : default control width
  // v1.0.0.3 : Fix with default weekend fill
  // v1.0.1.0 : New Exposed Width and Height of Calendar
  //          : Fix with hiding dropdown calendar when in Month or Year mode
  // v1.5.0.0 : New Properties MaxDate, MinDate, Animation, ShowCurrentDate, ShowHint, StatusAppearance
  //          : New : Calendar Day Status Indicator
  //          : New : Exposed events OnDateFill, OnDateStatus, OnDateHint
  //          : Fixed : Issue with Resizing Calendar and first dropdown.
  // v1.5.0.1 : Fixed : Memory leak
  // v1.5.0.2 : Fixed : Issue with initialization of the Text property
  // v1.5.0.3 : Fixed : Access violation when initializing events
  // v1.5.0.4 : Fixed : issue with editing date
  //          : Fixed : issue with ReadOnly property

type
  TAdvSmoothDatePicker = class;

  TAdvSmoothDatePickerCalendar = class(TPersistent)
  private
    FOwner: TAdvsmoothDatePicker;
    FHeader: TAdvSmoothCalendarHeader;
    FDateAppearance: TAdvSmoothCalendarDateAppearance;
    FFooter: TAdvSmoothCalendarFooter;
    FFill: TGDIPFill;
    FWidth: integer;
    FHeight: integer;
    FMaxDate: TDate;
    FAnimation: Boolean;
    FMinDate: TDate;
    FShowCurrentDate: Boolean;
    FStatusAppearance: TGDIPStatus;
    FShowHint: Boolean;
  protected
    procedure DateAppearanceChanged(Sender: TObject);
    procedure FillChanged(Sender: TObject);
    procedure FooterChanged(Sender: TObject);
    procedure HeaderChanged(Sender: TObject);
    procedure WidthChanged(Sender: TObject);
    procedure HeightChanged(Sender: TObject);
    procedure ShowCurrentDateChanged(Sender: TObject);
    procedure StatusAppearanceChanged(Sender: TObject);
    procedure AnimationChanged(Sender: TObject);
    procedure MaxDateChanged(Sender: TObject);
    procedure MinDateChanged(Sender: TObject);
    procedure ShowHintChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvSmoothDatePicker);
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
  published
    property Fill: TGDIPFill read FFill write FFill;
    property MinDate: TDate read FMinDate write FMinDate;
    property MaxDate: TDate read FMaxDate write FMaxDate;
    property Animation: Boolean read FAnimation write FAnimation;
    property ShowCurrentDate: Boolean read FShowCurrentDate write FShowCurrentDate;
    property DateAppearance: TAdvSmoothCalendarDateAppearance read FDateAppearance write FDateAppearance;
    property StatusAppearance: TGDIPStatus read FStatusAppearance write FStatusAppearance;
    property Footer: TAdvSmoothCalendarFooter read FFooter write FFooter;
    property Header: TAdvSmoothCalendarHeader read FHeader write FHeader;
    property Width: integer read FWidth write FWidth;
    property Height: integer read FHeight write FHeight;
    property ShowHint: Boolean read FShowHint write FShowHint;
  end;

  TAdvSmoothDatePicker = class(TAdvSmoothEditBtn, ITMSStyle)
  private
    FTimer: TTimer;
    FDesignTime: Boolean;
    FCal: TAdvSmoothCalendar;
    FDeactivating: boolean;
    FIgnoreSelect: boolean;
    CalParent : TForm;
    CancelThisBtnClick : Boolean;
    FHideCalendarAfterSelection: boolean;
    FOnDaySelect: TAdvSmoothCalendarDateSelectedEvent;
    FCalendar: TAdvSmoothDatePickerCalendar;
    FOnDateFill: TAdvSmoothCalendarDateFillEvent;
    FOnDateStatus: TAdvSmoothCalendarGetDateStatusEvent;
    FOnDateHint: TAdvSmoothCalendarDateHintEvent;
    procedure HideParent;
    procedure InitEvents;
    function GetParentEx: TWinControl;
    procedure SetParentEx(const Value: TWinControl);
    function GetDate: TDateTime;
    procedure SetDate(const Value: TDateTime);
    procedure SetCalendar(const Value: TAdvSmoothDatePickerCalendar);
    { Private declarations }
  protected
    function GetVersionNr: Integer; override;
    { Protected declarations }
    procedure BtnClick(Sender: TObject); override;
    procedure CalParentDeactivate(Sender: TObject);
    procedure CalendarDateFill(Sender: TObject; AFill: TGDIPFill; AFont: TFont; Date: TDateTime; DateKind: TAdvSmoothCalendarDateKind);
    procedure CalendarDateHint(Sender: TObject; Date: TDateTime; var hint: String);
    procedure CalendarDateStatus(Sender: TObject; Date: TDateTime; var StatusMessage: String;
      Fill: TGDIPStatus; var OffsetX: integer; var OffsetY: integer);
    procedure CalendarDaySelect(Sender: TObject; Mode: TAdvSmoothCalendarDateMode; Date: TDateTime);
    procedure CalendarKeyPress(Sender: TObject; var Key: Char);
    procedure CalendarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CalendarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure Loaded; override;
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CreateWnd; override;
    procedure TimerEvent(Sender: TObject); 
    property Cal: TAdvSmoothCalendar read FCal write FCal;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure CancelBtnClick;
    destructor Destroy; override;
    procedure DropDown; virtual;
    property Parent: TWinControl read GetParentEx write SetParentEx;
    procedure SetComponentStyle(AStyle: TTMSStyle);
  published
    { Published declarations }
    property TabOrder;
    property TabStop;
    property HideCalendarAfterSelection : boolean read FHideCalendarAfterSelection
      write FHideCalendarAfterSelection;
    property OnSelectDate: TAdvSmoothCalendarDateSelectedEvent read FOnDaySelect write FOnDaySelect;
    property OnDateFill: TAdvSmoothCalendarDateFillEvent read FOnDateFill write FOnDateFill;
    property OnDateStatus: TAdvSmoothCalendarGetDateStatusEvent read FOnDateStatus write FOnDateStatus;
    property OnDateHint: TAdvSmoothCalendarDateHintEvent read FOnDateHint write FOnDateHint;
    property Calendar: TAdvSmoothDatePickerCalendar read FCalendar write SetCalendar;
    property Date: TDateTime read GetDate write SetDate;
  end;

implementation


{ TAdvSmoothDatePicker }

procedure TAdvSmoothDatePicker.DropDown;
var
  CalPos: TPoint;
  r: TRect;
  d,m,y: Word;

  function Min(a,b: Integer): Integer;
  begin
    if (a > b) then
      Result := b
    else
      Result := a;
  end;

  function CheckDate(dt: TDateTime): TDateTime;
  begin
    Result := dt;
  end;

  function GetParentWnd: HWnd;
  var
    Last, P: HWnd;
  begin
    P := GetParent((Owner as TWinControl).Handle);
    Last := P;
    while P <> 0 do
    begin
      Last := P;
      P := GetParent(P);
    end;
    Result := Last;
  end;

begin
  if (Parent is TForm) then
  begin
    if (Parent as TForm).FormStyle = fsStayOnTop then
      CalParent.FormStyle := fsStayOnTop;
  end
  else
    CalParent.FormStyle := fsStayOnTop;

  CalPos.x := -2;
  CalPos.y := Height - 3;
  CalPos := ClientToScreen(CalPos);

  {$IFNDEF TMSDOTNET}
  SystemParametersInfo(SPI_GETWORKAREA, 0,@r,0); //account for taskbar...
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  SystemParametersInfo(SPI_GETWORKAREA, 0,r,0); //account for taskbar...
  {$ENDIF}

  Cal.Footer.Assign(Calendar.Footer);
  Cal.DateAppearance.Assign(Calendar.DateAppearance);
  Cal.StatusAppearance.Assign(Calendar.StatusAppearance);
  Cal.Header.Assign(Calendar.Header);
  Cal.Fill.Assign(Calendar.Fill);
  Cal.Width := Calendar.Width;
  Cal.Height := Calendar.Height;
  Cal.MaxDate := Calendar.MaxDate;
  Cal.MinDate := Calendar.MinDate;
  Cal.ShowCurrentDate := Calendar.ShowCurrentDate;
  Cal.Animation := Calendar.Animation;
  Cal.ShowHint := Calendar.ShowHint;

  if (CalPos.y + FCal.Height > r.Bottom) then
    CalPos.Y := CalPos.Y - FCal.Height - Height + 3;

  if (CalPos.x + FCal.Width > r.right) then
    CalPos.x := CalPos.x - (FCal.Width - Width);

  // Set planner date
  try
    if (Text = '') then
      FCal.SelectedDate := Round(CheckDate(Now))
    else
      FCal.SelectedDate := Round(StrToDate(Text));
  except
    on Exception do
       Text := 'exception';
  end;

  CalParent.Width := 0;
  CalParent.Height := 0;

  DecodeDate(FCal.SelectedDate, y, m, d);

  FCal.Year := y;
  FCal.Month := m;

  CalParent.Show;

  CalParent.Left := CalPos.x;
  CalParent.Top := CalPos.y;
  CalParent.Width := FCal.Width;
  CalParent.Height := FCal.Height;

  FCal.SetFocus;
  SendMessage(GetParentWnd, WM_NCACTIVATE, 1, 0);
end;

procedure TAdvSmoothDatePicker.SetCalendar(
  const Value: TAdvSmoothDatePickerCalendar);
begin
  if FCalendar <> value then
  begin
    FCalendar := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDatePicker.SetComponentStyle(AStyle: TTMSStyle);
begin
  case AStyle of
    tsOffice2003Blue: Cal.SetComponentStyle(tsOffice2003Blue);
    tsOffice2003Olive: Cal.SetComponentStyle(tsOffice2003Olive);
    tsOffice2003Silver: Cal.SetComponentStyle(tsOffice2003Silver);
    tsOffice2003Classic: Cal.SetComponentStyle(tsOffice2003Classic);
    tsOffice2007Luna: Cal.SetComponentStyle(tsOffice2007Luna);
    tsOffice2007Obsidian: Cal.SetComponentStyle(tsOffice2007Obsidian);
    tsOffice2007Silver: Cal.SetComponentStyle(tsOffice2007Silver);
    tsWindowsXP: Cal.SetComponentStyle(tsWindowsXP);
    tsWhidbey: Cal.SetComponentStyle(tsWhidbey);
  end;

  Calendar.Footer.Assign(Cal.Footer);
  Calendar.DateAppearance.Assign(Cal.DateAppearance);
  Calendar.StatusAppearance.Assign(Cal.StatusAppearance);
  Calendar.Header.Assign(Cal.Header);
  Calendar.Fill.Assign(Cal.Fill);
  Calendar.Width := Cal.Width;
  Calendar.Height := Cal.Height;
  Calendar.Animation := Cal.Animation;
  Calendar.MaxDate := Cal.MaxDate;
  Calendar.MinDate := Cal.MinDate;
  Calendar.ShowCurrentDate := Cal.ShowCurrentDate;
  Calendar.ShowHint := Cal.ShowHint;
end;

procedure TAdvSmoothDatePicker.BtnClick(Sender: TObject);
begin
  CancelThisBtnClick := False;
  
  inherited;

  if CancelThisBtnClick then
    Exit;

  if FDeactivating then
  begin
    FDeactivating := false;
    Exit;
  end;

  if Assigned(CalParent) then
  begin
    if CalParent.Visible then
    begin
      FDeactivating := true;
      CalParent.Hide;
      Exit;
    end
    else
      DropDown;
  end
  else
    DropDown;
end;

procedure TAdvSmoothDatePicker.CancelBtnClick;
begin
  CancelThisBtnClick := True;
end;

constructor TAdvSmoothDatePicker.Create(AOwner: TComponent);
begin
  inherited;
  Text := '';
  CalParent := TForm.Create(Self);
  CalParent.BorderStyle := bsNone;

  CalParent.Width := 0;
  CalParent.Height := 0;

  FCal := TAdvSmoothCalendar.Create(Self);
  FCal.Parent := CalParent;
  FCal.KeyBoardDateModeToggle := false;
  FCal.MultiSelect := false;
  FCal.Name := self.Name +'cal_';
  FCal.TabStop := true;
  FCal.ShowFocus := true;
  FIgnoreSelect := false;

  FCalendar := TAdvSmoothDatePickerCalendar.Create(Self);
  CalParent.OnDeactivate := CalParentDeactivate;
  Width := 108;
  FHideCalendarAfterSelection := True;
  Button.Glyph.Handle := LoadBitmap(0, MakeIntResource(OBM_COMBO));
  Button.FocusControl := nil;
  ButtonStyle := bsDropDown;
  Date := Round(Now);

  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));

  if FDesignTime then
    SetComponentStyle(tsOffice2007Luna);

  FTimer := TTimer.Create(self);
  FTimer.Enabled := false;
  FTimer.OnTimer := TimerEvent;
  FTimer.Interval := 100;
end;

destructor TAdvSmoothDatePicker.Destroy;
begin
  FTimer.Free;
  FCalendar.Free;
  FCal.Free;
  CalParent.Free;
  inherited;
end;

procedure TAdvSmoothDatePicker.TimerEvent(Sender: TObject);
begin
  FDeactivating := false;
  FTimer.Enabled :=false;
end;

procedure TAdvSmoothDatePicker.HideParent;
begin
  if (csDesigning in ComponentState) then
    Exit;

  FDeactivating := false;
  if CalParent.HandleAllocated then
  begin
    CalParent.Hide;
    try
      SetFocus;
    except
    end;
  end;
end;

procedure TAdvSmoothDatePicker.KeyDown(var Key: Word; Shift: TShiftState);
var
  s:string;
  ss: integer;
  ssl: integer;
  dfus: boolean;
begin
  inherited;
  if (key = VK_F4) and not (ssAlt in Shift) and not (ssCtrl in Shift) then
  begin
    if CalParent.Visible then
      HideParent
    else
      BtnClick(Self);
  end;

  dfus := pos('M',Uppercase(ShortDateFormat)) < pos('D',Uppercase(ShortDateFormat));

  case key of
  VK_DOWN:
    begin
      s := Text;
      ss := SelStart;
      ssl := SelStart;
      if (ss > pos(DateSeparator,s)) then
      begin
        ss := ss - pos(DateSeparator,s);
        Delete(s,1,pos(DateSeparator,s));
        if (ss > pos(DateSeparator,s)) then
        begin
          FCal.SelectedDate := Date;
          Date := FCal.SelectedDate;
        end
        else
        begin
          FCal.SelectedDate := Date;

          if dfus then
            Date := Date -1
          else
          begin
            Date := FCal.SelectedDate;
          end;
        end;
      end
      else
      begin
        if dfus then
        begin
          Date := FCal.SelectedDate;
        end
        else
          Date := Date - 1;
      end;

      SelStart := ssl;

    end;
  VK_UP:
    begin
      s := Text;
      ss := SelStart;
      ssl := SelStart;
      if (ss > pos(DateSeparator,s)) then
      begin
        ss := ss - pos(DateSeparator,s);
        Delete(s,1,pos(DateSeparator,s));
        if (ss > pos(DateSeparator,s)) then
        begin
          FCal.SelectedDate := Date;
          Date := FCal.SelectedDate;
        end
        else
        begin
          FCal.SelectedDate := Date;
          if dfus then
            Date := Date + 1
          else
          begin
            Date := FCal.SelectedDate;
          end;
        end;
      end
      else
      begin
        if dfus then
        begin
          Date := FCal.SelectedDate;
        end
        else
          Date := Date + 1;
      end;

      SelStart := ssl;
    end;
  end;
end;

procedure TAdvSmoothDatePicker.InitEvents;
begin
  FCal.OnKeyPress := CalendarKeypress;
  FCal.OnKeyUp := CalendarKeyUp;
  FCal.OnKeyDown := CalendarKeyDown;
  FCal.OnSelectDate := CalendarDaySelect;
  FCal.OnDateFill := CalendarDateFill;
  FCal.OnDateHint := CalendarDateHint;
  FCal.OnDateStatus := CalendarDateStatus;
end;

procedure TAdvSmoothDatePicker.Loaded;
begin
  inherited;
  InitEvents;
  Button.Enabled := not ReadOnly;
end;

procedure TAdvSmoothDatePicker.CalendarDateFill(Sender: TObject;
  AFill: TGDIPFill; AFont: TFont; Date: TDateTime;
  DateKind: TAdvSmoothCalendarDateKind);
begin
  if Assigned(FOnDateFill) then
    FOnDateFill(Self, AFill, AFont, Date, DateKind);
end;

procedure TAdvSmoothDatePicker.CalendarDateHint(Sender: TObject;
  Date: TDateTime; var hint: String);
begin
  if Assigned(FOnDateHint) then
    FOnDateHint(Self, Date, Hint);
end;

procedure TAdvSmoothDatePicker.CalendarDaySelect(Sender: TObject; Mode: TAdvSmoothCalendarDateMode; Date: TDateTime);
begin
  if FIgnoreSelect then
    Exit;
    
  if Mode = dmDay then
  begin
    if (Date = 0) and (Text = '') then
      Exit;
      
    Text := DateToStr(Date);

    if FHideCalendarAfterSelection then
    begin
      HideParent;
    end;

    if Assigned(FOnDaySelect) then
      FOnDaySelect(Self,Mode, Date);
  end;
end;

procedure TAdvSmoothDatePicker.CalendarDateStatus(Sender: TObject;
  Date: TDateTime; var StatusMessage: String; Fill: TGDIPStatus; var OffsetX,
  OffsetY: integer);
begin
  if Assigned(FOnDateStatus) then
    FOnDateStatus(Self, Date, StatusMessage, Fill, OffsetX, OffsetY);
end;

procedure TAdvSmoothDatePicker.CalendarKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then
    HideParent;

  if Assigned(OnKeyDown) then
    OnKeyDown(Self, Key, Shift);
end;

procedure TAdvSmoothDatePicker.CalendarKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Assigned(OnKeyUp) then
    OnKeyUp(Self, Key, Shift);
end;

procedure TAdvSmoothDatePicker.CalendarKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Assigned(OnKeyPress) then
    OnKeyPress(Self, Key);

  if (Key = char(VK_RETURN)) or (Key = char(VK_SPACE)) then
    CalendarDaySelect(Sender, dmDay, FCal.SelectedDate);

  if Key = #27 then
    HideParent;
end;

procedure TAdvSmoothDatePicker.CalParentDeactivate(Sender: TObject);
begin
  FDeactivating := true;
  (Sender as TForm).Hide;
  FTimer.Enabled := true;
end;

procedure TAdvSmoothDatePicker.WMSetFocus(var Message: TWMSetFocus);
begin
  if EditorEnabled then
    inherited
  else
    Button.SetFocus;
end;

procedure TAdvSmoothDatePicker.Change;
var
  dt: TDateTime;
begin
  inherited;

  // try to extract the date
  try
    if (Text = '') or
       (Pos(DateSeparator, Text) = 0) or
       (Text = '  /  /  ') then
    begin
      Cal.SelectedDate := 0;
      Text := DateToStr(Now);
    end
    else
    begin
      dt := StrToDate(Text);
      FIgnoreSelect := true;
      try
        Cal.SelectedDate := dt;
      finally
        FIgnoreSelect := false;
      end;
    end;
  except
  end;
end;

procedure TAdvSmoothDatePicker.CreateWnd;
begin
  inherited;
  InitEvents;
end;

function TAdvSmoothDatePicker.GetParentEx: TWinControl;
begin
  Result := inherited Parent;
end;

procedure TAdvSmoothDatePicker.SetParentEx(const Value: TWinControl);
begin
  inherited Parent := Value;
  InitEvents;
end;

function TAdvSmoothDatePicker.GetDate: TDateTime;
begin
  Result := FCal.SelectedDate;
end;

procedure TAdvSmoothDatePicker.SetDate(const Value: TDateTime);
begin
  FCal.SelectedDate := Value;
  if Value = 0 then
    Text := ''
  else
    Text := DateToStr(Value);
end;

function TAdvSmoothDatePicker.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

{ TAdvSmoothDatePickerCalendar }

procedure TAdvSmoothDatePickerCalendar.AnimationChanged(Sender: TObject);
begin
  FOwner.Fcal.Animation := Animation;
end;

procedure TAdvSmoothDatePickerCalendar.Assign(Source: TPersistent);
begin
  Fill.Assign((Source as TAdvSmoothDatePickerCalendar).Fill);
  DateAppearance.Assign((Source as TAdvSmoothDatePickerCalendar).DateAppearance);
  Footer.Assign((Source as TAdvSmoothDatePickerCalendar).Footer);
  Header.Assign((Source as TAdvSmoothDatePickerCalendar).Header);
  Width := (Source as TAdvSmoothDatePickerCalendar).Width;
  Height := (Source as TAdvSmoothDatePickerCalendar).Height;
  Animation := (Source as TadvSmoothDatePickerCalendar).Animation;
  ShowCurrentDate := (Source as TAdvSmoothDatePickerCalendar).ShowCurrentDate;
  MaxDate := (Source as TAdvSmoothDatePickerCalendar).MaxDate;
  MinDate := (Source as TAdvSmoothDatePickerCalendar).MinDate;
  StatusAppearance.Assign((source as TAdvSmoothDatePickerCalendar).StatusAppearance);
  ShowHint := (Source as TAdvSmoothDatePickerCalendar).ShowHint;
end;

constructor TAdvSmoothDatePickerCalendar.Create(AOwner: TAdvSmoothDatePicker);
begin
  FOwner := AOwner;
  FFill := TGDIPFill.Create;
  FHeader := TAdvSmoothCalendarHeader.Create(FOwner.FCal);
  FFooter := TAdvSmoothCalendarFooter.Create(Fowner.FCal);
  FDateAppearance := TAdvSmoothCalendarDateAppearance.Create(FOwner.FCal);
  FWidth := FOwner.FCal.Width;
  FHeight := FOwner.FCal.Height;
  FMaxDate := FOwner.Fcal.MaxDate;
  FMinDate := FOwner.Fcal.MinDate;
  FAnimation := FOwner.Fcal.Animation;
  FShowCurrentDate := FOwner.Fcal.ShowCurrentDate;
  FStatusAppearance := TGDIPStatus.Create;
  FShowHint := FOwner.Fcal.ShowHint;
end;

procedure TAdvSmoothDatePickerCalendar.DateAppearanceChanged(Sender: TObject);
begin
  FOwner.FCal.DateAppearance.Assign(DateAppearance);
end;

destructor TAdvSmoothDatePickerCalendar.Destroy;
begin
  FFill.Free;
  FHeader.Free;
  FFooter.Free;
  FDateAppearance.Free;
  FStatusAppearance.Free;
  inherited;
end;

procedure TAdvSmoothDatePickerCalendar.FillChanged(Sender: TObject);
begin
  FOwner.FCal.Fill.Assign(Fill);
end;

procedure TAdvSmoothDatePickerCalendar.FooterChanged(Sender: TObject);
begin
  FOwner.FCal.Footer.Assign(Footer);
end;

procedure TAdvSmoothDatePickerCalendar.HeaderChanged(Sender: TObject);
begin
  FOwner.FCal.Header.Assign(Header);
end;

procedure TAdvSmoothDatePickerCalendar.HeightChanged(Sender: TObject);
begin
  FOwner.FCal.Height := Height;
end;

procedure TAdvSmoothDatePickerCalendar.MaxDateChanged(Sender: TObject);
begin
  FOwner.FCal.MaxDate := MaxDate;
end;

procedure TAdvSmoothDatePickerCalendar.MinDateChanged(Sender: TObject);
begin
  FOwner.FCal.MinDate := MinDate;
end;

procedure TAdvSmoothDatePickerCalendar.ShowCurrentDateChanged(Sender: TObject);
begin
  FOwner.FCal.ShowCurrentDate := ShowCurrentDate;
end;

procedure TAdvSmoothDatePickerCalendar.ShowHintChanged(Sender: TObject);
begin
  FOwner.FCal.ShowHint := ShowHint;
end;

procedure TAdvSmoothDatePickerCalendar.StatusAppearanceChanged(Sender: TObject);
begin
  FOwner.Fcal.StatusAppearance.Assign(StatusAppearance);
end;

procedure TAdvSmoothDatePickerCalendar.WidthChanged(Sender: TObject);
begin
  FOwner.FCal.Width := Width;
end;

end.
