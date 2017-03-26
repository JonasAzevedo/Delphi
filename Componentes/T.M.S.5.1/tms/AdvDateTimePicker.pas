{*************************************************************************}
{ TAdvDateTimePicker component                                            }
{ for Delphi & C++Builder                                                 }
{                                                                         }
{ written by TMS Software                                                 }
{           copyright © 2007 - 2009                                       }
{           Email : info@tmssoftware.com                                  }
{           Website : http://www.tmssoftware.com/                         }
{                                                                         }
{ The source code is given as is. The author is not responsible           }
{ for any possible damage done due to the use of this code.               }
{ The component can be freely used in any application. The complete       }
{ source code remains property of the author and may not be distributed,  }
{ published, given or sold in any form as such. No parts of the source    }
{ code can be included in any other component or application without      }
{ written authorization of the author.                                    }
{*************************************************************************}

unit AdvDateTimePicker;

{$I TMSDEFS.INC}

interface
                
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, CommCtrl
  {$IFDEF TMSDOTNET}
  ,System.Drawing
  ,System.Text
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 7; // Build nr.

  // version history
  // v1.0.0.0 : First release
  // v1.0.0.1 : Fixed issue with DB-aware version
  // v1.0.0.2 : Improved : force milliseconds to zero
  // v1.0.0.3 : Improved : position of internal datetimepickers with XP theming enabled
  // v1.0.0.4 : Fixed : issue with DB aware version
  // v1.0.0.5 : Fixed : issue with timeformat setting
  // v1.0.0.6 : Fixed : issue with use in VCL.NET
  // v1.0.0.7 : Fixed : issue with initializing time in older Delphi versions

  DROPDOWNBTN_WIDTH = 21;

type
  TAdvDateTimeKind = (dkDate, dkTime, dkDateTime);

  TCustomDateTimePicker = class(TDateTimePicker)
  private
    FBorderStyle: TBorderStyle;
    FBorderColor: TColor;
    FIsThemed: Boolean;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure NCPaintProc;
    procedure SetBorderColor(const Value: TColor);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure SetBorderStyle(const Value: TBorderStyle); virtual;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TAdvDateTimePicker = class(TCustomDateTimePicker)
  private
    FKind: TAdvDateTimeKind;
    FOnTimeChange: TNotifyEvent;
    FTimeFormat: string;
    procedure OnTimePickerChanged(Sender: TObject);
    procedure OnTimePickerClicked(Sender: TObject);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure SetKind(const Value: TAdvDateTimeKind);
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    function GetTimeEx: TTime;
    procedure SetTimeEx(const Value: TTime);
    function GetDateTimeEx: TDateTime;
    function GetFormatEx: String;
    procedure SetFormatEx(const Value: String);
    function GetTimeFormat: String;
    procedure SetTimeFormat(const Value: String);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
  protected
    FTimePicker: TCustomDateTimePicker;
    procedure CreateTimePicker;
    procedure UpdateTimePicker;
    procedure Loaded; override;
    procedure SetBorderStyle(const Value: TBorderStyle); override;
    procedure CreateWnd; override;
    procedure TimePickerChanged; virtual;
    procedure TimePickerClicked; virtual;
    procedure SetDateTimeEx(const Value: TDateTime); virtual;
    procedure TimePickerKeyPress(Sender: TObject; var Key: Char); virtual;
    procedure TimePickerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property BorderColor;
    function GetVersionNr: integer;
    property OnTimeChange: TNotifyEvent read FOnTimeChange write FOnTimeChange;
  published
    property BorderStyle;
    property Ctl3D;
    property DateTime: TDateTime read GetDateTimeEx write SetDateTimeEx;
    {$IFDEF DELPHI6_LVL}
    property Format: String read GetFormatEx write SetFormatEx;
    property TimeFormat: String read GetTimeFormat write SetTimeFormat;
    {$ENDIF}
    property Kind: TAdvDateTimeKind read FKind write SetKind;
    property Time: TTime read GetTimeEx write SetTimeEx;
    property Version: string read GetVersion write SetVersion;
  end;

implementation

uses
  ComStrs;


//------------------------------------------------------------------------------

{$IFNDEF TMSDOTNET}
function IsVista: boolean;
var
  hKernel32: HMODULE;
begin
  hKernel32 := GetModuleHandle('kernel32');
  if (hKernel32 > 0) then
  begin
    Result := GetProcAddress(hKernel32, 'GetLocaleInfoEx') <> nil;
  end
  else
    Result := false;
end;

//------------------------------------------------------------------------------


function GetFileVersion(FileName:string): Integer;
var
  FileHandle:dword;
  l: Integer;
  pvs: PVSFixedFileInfo;
  lptr: uint;
  querybuf: array[0..255] of char;
  buf: PChar;
begin
  Result := -1;

  StrPCopy(querybuf,FileName);
  l := GetFileVersionInfoSize(querybuf,FileHandle);
  if (l>0) then
  begin
    GetMem(buf,l);
    GetFileVersionInfo(querybuf,FileHandle,l,buf);
    if VerQueryValue(buf,'\',Pointer(pvs),lptr) then
    begin
      if (pvs^.dwSignature=$FEEF04BD) then
      begin
        Result := pvs^.dwFileVersionMS;
      end;
    end;
    FreeMem(buf);
  end;
end;
{$ENDIF}

//------------------------------------------------------------------------------

function IsComCtl6: Boolean;
var
  i: Integer;
begin
  i := GetFileVersion('COMCTL32.DLL');
  i := (i shr 16) and $FF;

  Result := (i > 5);
end;

//------------------------------------------------------------------------------

function GetTextSize(WinCtrl: TWinControl; Text: string; font: TFont): TSize;
var
  Canvas: TCanvas;
  R: TRect;
begin
  Canvas := TCanvas.Create;
  Canvas.Handle := GetWindowDC(WinCtrl.Handle);
  Canvas.Font.Assign(font);

  {$IFNDEF TMSDOTNET}
  R := Rect(0, 0, 1000, 200);
  DrawText(Canvas.Handle,PChar(Text),Length(Text), R, DT_CALCRECT or DT_LEFT or DT_SINGLELINE);
  {$ELSE}
  R := TRect.Create(0,0,1000,200);
  DrawText(Canvas.Handle,Text,Length(Text), R, DT_CALCRECT or DT_LEFT or DT_SINGLELINE);
  {$ENDIF}
  Result.cx := R.Right - R.Left;
  Result.cy := R.Bottom - R.Top;
  ReleaseDC(WinCtrl.Handle, Canvas.Handle);
  Canvas.Free;
end;

//------------------------------------------------------------------------------

{ TCustomDateTimePicker }

constructor TCustomDateTimePicker.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited;
  DoubleBuffered := True;
  ParentCtl3D := False;
  Ctl3D := false;
  FBorderStyle := bsNone;
  FBorderColor := clBlack;
  i := GetFileVersion('COMCTL32.DLL');
  i := (i shr 16) and $FF;
  FIsThemed := (i > 5);
  //CalExceptionClass := nil;
end;

//------------------------------------------------------------------------------

destructor TCustomDateTimePicker.Destroy;
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TCustomDateTimePicker.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomDateTimePicker.CreateWnd;
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TCustomDateTimePicker.NCPaintProc;
var
  DC: HDC;
  //WindowBrush:hBrush;
  Canvas: TCanvas;

begin
  if Ctl3D then
    Exit;

  DC := GetWindowDC(Handle);
  //WindowBrush := 0;
  try
    Canvas := TCanvas.Create;
    Canvas.Handle := DC;

    //WindowBrush := CreateSolidBrush(ColorToRGB(clRed));

    if (BorderStyle = bsNone) and (Parent is TWinControl) then
      Canvas.Pen.Color := (Parent as TWinControl).Brush.Color
    else
    begin
      if FIsThemed then
        Canvas.Pen.Color := $B99D7F
      else
        Canvas.Pen.Color := BorderColor;
    end;

    Canvas.MoveTo(0,Height);
    Canvas.LineTo(0,0);
    Canvas.LineTo(Width - 1,0);
    Canvas.LineTo(Width - 1,Height - 1);
    Canvas.LineTo(0,Height-1);

    if (BorderStyle = bsSingle) and (Parent is TWinControl) then
      Canvas.Pen.Color := (Parent as TWinControl).Brush.Color;

    if (BorderStyle in [bsNone, bsSingle]) and (Parent is TWinControl) then
    begin
      Canvas.MoveTo(1,Height - 2);
      Canvas.LineTo(1,1);
      Canvas.LineTo(Width - 1,1);
    end;

    Canvas.Free;

    // FrameRect(DC, ARect, WindowBrush);
  finally
    //DeleteObject(WindowBrush);
    ReleaseDC(Handle,DC);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomDateTimePicker.WMNCPaint(var Message: TMessage);
begin
  inherited;
  NCPaintProc;
  Message.Result := 0;
end;

//------------------------------------------------------------------------------

procedure TCustomDateTimePicker.WMPaint(var Message: TWMPaint);
var
  DC: HDC;
  ACanvas: TCanvas;

begin
  inherited;

  {$IFNDEF TMSDOTNET}
  if Ctl3D or not IsVista then
    Exit;

  DC := GetWindowDC(Handle);
  ACanvas := TCanvas.Create;

  try
    ACanvas.Handle := DC;

    if (BorderStyle = bsNone) and (Parent is TWinControl) then
      ACanvas.Pen.Color := (Parent as TWinControl).Brush.Color
    else
    begin
      if FIsThemed then
        ACanvas.Pen.Color := $B99D7F
      else
        ACanvas.Pen.Color := BorderColor;
    end;

    ACanvas.MoveTo(0,Height);
    ACanvas.LineTo(0,0);
    ACanvas.LineTo(Width - 1,0);
    ACanvas.LineTo(Width - 1,Height - 1);
    ACanvas.LineTo(0,Height-1);
  finally
    ACanvas.Free;
    ReleaseDC(Handle,DC);
  end;
  {$ENDIF}
end;

//------------------------------------------------------------------------------
procedure TCustomDateTimePicker.WMSize(var Message: TWMSize);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TCustomDateTimePicker.SetBorderStyle(const Value: TBorderStyle);
begin
  if (FBorderStyle <> Value) then
  begin
    FBorderStyle := Value;
    {if (FBorderStyle = bsCtl3D) then
    begin
      ParentCtl3D := True;
      Ctl3D := True;
    end
    else if Ctl3D then
    begin
      ParentCtl3D := False;
      Ctl3D := false;
    end;
    }
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomDateTimePicker.SetBorderColor(const Value: TColor);
begin
  if (FBorderColor <> Value) then
  begin
    FBorderColor := Value;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomDateTimePicker.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

//------------------------------------------------------------------------------

{ TAdvDateTimePicker }

procedure TAdvDateTimePicker.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if Assigned(FTimePicker) then
    FTimePicker.Enabled := Enabled;
end;

//------------------------------------------------------------------------------

constructor TAdvDateTimePicker.Create(AOwner: TComponent);
begin
  inherited;
  {
  if (inherited Kind = dtkDate) then
    FKind := dkDateTime
  else
    FKind := dkTime;
  }
  FTimePicker := nil;
  FKind := dkDateTime;
  //CreateTimePicker;
  BorderStyle := bsSingle;
  Ctl3D := true;
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.CreateTimePicker;
begin
  if not Assigned(FTimePicker) then
  begin
    FTimePicker := TCustomDateTimePicker.Create(Self);
    if not ((csLoading in ComponentState) and (csDesigning in ComponentState)) then
      FTimePicker.Parent := Self;
    FTimePicker.Width := 90;
    FTimePicker.Height := 17;
    FTimePicker.Visible := False;
    FTimePicker.Enabled := Enabled;
    FTimePicker.Kind := dtkTime;
    FTimePicker.OnChange := OnTimePickerChanged;
    FTimePicker.OnClick := OnTimePickerClicked;
    FTimePicker.OnKeyPress := TimePickerKeyPress;
    FTimePicker.OnKeyDown := TimePickerKeyDown;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.CreateWnd;
var
  oldKind: TAdvDateTimeKind;
begin
  inherited;
  oldKind := FKind;
  FKind := dkDate;
  Kind := oldKind;
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.UpdateTimePicker;
var
  i,j: Integer;
  {$IFNDEF TMSDOTNET}
  lpstr: array[0..255] of char;
  {$ELSE}
  lpstr: StringBuilder;
  {$ENDIF}
begin
  if Assigned(FTimePicker) then
  begin
    if (FTimePicker.Parent <> Self) then
      FTimePicker.Parent := Self;
    FTimePicker.Color := Self.Color;
    FTimePicker.Enabled := Self.Enabled;
    FTimePicker.Visible := (FKind = dkDateTime);
    FTimePicker.Time := Self.Time;
    FTimePicker.DateTime := Self.DateTime;
    {$IFDEF DELPHI6_LVL}
    FTimePicker.Format := Self.TimeFormat;
    {$ENDIF}
    FTimePicker.Font.Assign(Self.Font);

    if not FTimePicker.Visible and (csDesigning in ComponentState) then
    begin
      FTimePicker.Free;
      FTimePicker := nil;
    end
    else
    begin
      {$IFNDEF TMSDOTNET}
      GetWindowText(FTimepicker.Handle, lpstr,255);
      i := GetTextSize(Self, strpas(lpstr), Font).cx + DROPDOWNBTN_WIDTH + 10;
      {$ELSE}
      lpstr := StringBuilder.Create(255);
      try
        GetWindowText(FTimepicker.Handle, lpstr,255);
        i := GetTextSize(Self, lpstr.ToString, Self.Font).cx + DROPDOWNBTN_WIDTH + 10;
      finally
        lpstr.Free;
      end;
      {$ENDIF}

      {$IFNDEF TMSDOTNET}
      if IsVista then
      begin
        //FTimePicker.SetBounds(Width - i - DROPDOWNBTN_WIDTH - 13, 0, i, Height)
        j := 0;
        if ((BevelInner <> bvNone) or (BevelOuter <> bvNone)) and (BevelKind <> bkNone) then
          j := 4;
        if IsComCtl6 then
          FTimePicker.SetBounds(Width - i - DROPDOWNBTN_WIDTH - 13 - j, 1, i, Height - 2 - j)
        else
          FTimePicker.SetBounds(Width - i - DROPDOWNBTN_WIDTH - 2 - j, -2, i, Height - j)
      end
      else
      {$ENDIF}
      begin
        if Ctl3D then
          FTimePicker.SetBounds(Width - i - DROPDOWNBTN_WIDTH, -2, i, Height)
        else
          FTimePicker.SetBounds(Width - i - DROPDOWNBTN_WIDTH, -2, i, Height);
      end;  
    end;
  end;
end;

//------------------------------------------------------------------------------

destructor TAdvDateTimePicker.Destroy;
begin
  if Assigned(FTimePicker) then
    FTimePicker.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.SetKind(const Value: TAdvDateTimeKind);
begin
  if (FKind <> Value) then
  begin
    FKind := Value;
    if (FKind = dkTime) then
      inherited Kind := dtkTime
    else
      inherited Kind := dtkDate;

    if (FKind = dkDateTime) then
      CreateTimePicker;

    UpdateTimePicker;
  end;
end;

//------------------------------------------------------------------------------


procedure TAdvDateTimePicker.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateTimePicker;
end;

//------------------------------------------------------------------------------

function TAdvDateTimePicker.GetTimeEx: TTime;
begin
  Result := inherited Time;
  if (FKind = dkDateTime) and Assigned(FTimePicker) then
    Result := FTimePicker.Time;
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.SetTimeEx(const Value: TTime);
begin
  inherited Time := Value;
  UpdateTimePicker;
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.SetBorderStyle(const Value: TBorderStyle);
begin
  inherited;
  UpdateTimePicker;
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.CMColorChanged(var Message: TMessage);
begin
  inherited;
  UpdateTimePicker;
end;

//------------------------------------------------------------------------------

function TAdvDateTimePicker.GetDateTimeEx: TDateTime;
begin
  if Assigned(FTimePicker) then
    inherited Time := FTimePicker.Time;
  Result := inherited DateTime;
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.SetDateTimeEx(const Value: TDateTime);
var
  ho,mi,se,se100:word;
begin
  decodetime(value, ho, mi, se, se100);

  inherited DateTime := int(value) + encodetime(ho,mi,se,0);
  CreateTimePicker;
  FTimePicker.DateTime := int(value) + encodetime(ho,mi,se,0);
end;

//------------------------------------------------------------------------------

function TAdvDateTimePicker.GetFormatEx: String;
begin
  {$IFDEF DELPHI6_LVL}
  Result := inherited Format;
  {$ELSE}
  Result := '';
  {$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.SetFormatEx(const Value: String);
begin
  {$IFDEF DELPHI6_LVL}
  inherited Format := Value;
  {$ENDIF}
end;

//------------------------------------------------------------------------------

function TAdvDateTimePicker.GetTimeFormat: String;
begin
  (*{$IFDEF DELPHI6_LVL}
  if Assigned(FTimePicker) then
    Result := FTimePicker.Format;
  {$ELSE}
  Result := '';
  {$ENDIF}*)
  Result := FTimeFormat;
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.SetTimeFormat(const Value: String);
begin
  {$IFDEF DELPHI6_LVL}
  if Assigned(FTimePicker) then
    FTimePicker.Format := Value;

  FTimeFormat := Value;
  UpdateTimePicker;
  {$ENDIF}
end;

//------------------------------------------------------------------------------

function TAdvDateTimePicker.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

//------------------------------------------------------------------------------

function TAdvDateTimePicker.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    CreateTimePicker;
    UpdateTimePicker;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.SetVersion(const Value: string);
begin

end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.OnTimePickerChanged(Sender: TObject);
begin
  TimePickerChanged;
  if Assigned(OnTimeChange) then
    OnTimeChange(self);
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.OnTimePickerClicked(Sender: TObject);
begin
  TimePickerClicked;
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.TimePickerChanged;
begin
  if Assigned(OnChange) then
    OnChange(Self);
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.TimePickerClicked;
begin
  if Assigned(OnClick) then
    OnClick(Self);
end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.TimePickerKeyPress(Sender: TObject;
  var Key: Char);
begin

end;

//------------------------------------------------------------------------------

procedure TAdvDateTimePicker.TimePickerKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  KeyDown(Key,Shift);
end;

//------------------------------------------------------------------------------


{$IFDEF FREEWARE}
{$I TRIAL.INC}
{$ENDIF}


end.
