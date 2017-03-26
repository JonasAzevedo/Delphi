{***************************************************************************}
{ TAdvOfficeHint component                                                  }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2006 - 2008                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit AdvOfficeHint;

interface

{$I TMSDEFS.INC}

uses
  Classes, Controls, Windows, Forms, SysUtils, Graphics,
  AdvHintInfo, TypInfo, AdvGDIP, GDIPicture, Math, AdvStyleIF,
  Messages
  {$IFDEF DELPHI6_LVL}
  , AppEvnts
  {$ENDIF}
  ;

const
  HINTROUNDING = 4;

  MAJ_VER = 1; // Major version nr.
  MIN_VER = 1; // Minor version nr.
  REL_VER = 5; // Release nr.
  BLD_VER = 1; // Build nr.

  // version history
  // 1.0.0.0 : first release
  // 1.1.0.0 : Added new event OnBeforeShowHint
  //         : Added styler interface
  // 1.1.0.1 : Fixed positioning issue with large HintHelpPicture
  // 1.1.0.2 : Fixed issue with positioning of hint exceeding screen width, height
  // 1.1.2.0 : New support for Office 2007 silver style added
  // 1.1.2.1 : Fixed issue with positioning of normal hints exceeding screen width, height
  // 1.1.2.2 : Fixed issue for using hint with non TMS components that directly use the hintwindowclass
  // 1.1.2.3 : Fixed issue when showing normal hint only for controls with OfficeHint property
  // 1.1.3.0 : New : property SystemFont added
  // 1.1.3.1 : Fixed : issue with rounded hint on always on top forms
  // 1.1.3.2 : Improved : autosizing of hint wrt text
  // 1.1.3.3 : Improved : repainting of hint
  // 1.1.4.0 : Improved : multimonitor support
  // 1.1.4.1 : Fixed : rare issue with multimonitor support
  // 1.1.5.0 : Improved : applied HintWidth also for non Office2007 hint style hints
  // 1.1.5.1 : Fixed : autosizing hint for text where wordbreak is not possible 

type
  {$IFDEF DELPHI_UNICODE}
  THintInfo = Controls.THintInfo;
  PHintInfo = Controls.PHintInfo;
  {$ENDIF}

  TBeforeShowHint = procedure(Sender: TObject; AControl: TControl; AHintInfo: TAdvHintInfo; var UseOfficeHint: boolean) of object;

  TAdvOfficeHint = class(TComponent, ITMSStyle)
  private
    FHintInfo: TAdvHintInfo;
    FHintControl: TControl;
    FFont: TFont;
    FHintWidth: integer;
    FHintHelpText: string;
    FHintHelpPicture: TGDIPPicture;
    FHintColor: TColor;
    FHintColorTo: TColor;
    FHintHelpLineColor: TColor;
    FUseOfficeHint: boolean;
    FIsOfficeHint: boolean;
    FSystemFont: boolean;
    FOnBeforeShowHint: TBeforeShowHint;
    procedure SetHintHelpPicture(const Value: TGDIPPicture);
    procedure SetFont(const Value: TFont);
    procedure SetSystemFont(const Value: boolean);
  protected
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    function GetVersionNr: Integer;
    procedure GetHintInfo(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
  protected
    property HintControl: TControl read FHintControl write FHintControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetComponentStyle(AStyle: TTMSStyle);
  published
    property Font: TFont read FFont write SetFont;
    property HintColor: TColor read FHintColor write FHintColor default clWhite;
    property HintColorTo: TColor read FHintColorTo write FHintColorTo default $EFD9CA;
    property HintWidth: integer read FHintWidth write FHintWidth default 200;
    property HintHelpText: string read FHintHelpText write FHintHelpText;
    property HintHelpPicture: TGDIPPicture read FHintHelpPicture write SetHintHelpPicture;
    property HintHelpLineColor: TColor read FHintHelpLineColor write FHintHelpLineColor default $FFC69A;
    property SystemFont: boolean read FSystemFont write SetSystemFont default true;
    property Version: string read GetVersion write SetVersion;
    property OnBeforeShowHint: TBeforeShowHint read FOnBeforeShowHint write FOnBeforeShowHint;
  end;

  { TAdvOfficeHintWindow }
  TAdvOfficeHintWindow = class(THintWindow)
  private
    FIsPainting: boolean;
    FIsActivating: boolean;
    FHint: TAdvOfficeHint;
    function FindHintControl: TAdvOfficeHint;
    procedure WMEraseBkGnd(var Message:TMessage); message WM_ERASEBKGND;
  protected
    function GetPointIfOnPager(Ctrl: TControl; var P: TPoint):Boolean;
    procedure Paint; override;
    {$IFNDEF DELPHI9_LVL}
    procedure WndProc(var Msg:TMessage); override;
    {$ENDIF}
    procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure ActivateHint(Rect: TRect; const AHint: string); override;
    {$IFDEF DELPHI9_LVL}
    function ShouldHideHint: Boolean; override;
    {$ENDIF}    
  published
  end;




implementation

procedure DrawGradient(Canvas: TCanvas; FromColor,ToColor: TColor; Steps: Integer;R:TRect; Direction: Boolean);
var
  diffr,startr,endr: Integer;
  diffg,startg,endg: Integer;
  diffb,startb,endb: Integer;
  iend: Integer;
  rstepr,rstepg,rstepb,rstepw: Real;
  i,stepw: Word;
begin
  if Steps = 0 then
    Steps := 1;

  if R.Right <= R.Left then
    Exit;
  if R.Bottom <= R.Top then
    Exit;

  FromColor := ColorToRGB(FromColor);
  ToColor := ColorToRGB(ToColor);

  startr := (FromColor and $0000FF);
  startg := (FromColor and $00FF00) shr 8;
  startb := (FromColor and $FF0000) shr 16;
  endr := (ToColor and $0000FF);
  endg := (ToColor and $00FF00) shr 8;
  endb := (ToColor and $FF0000) shr 16;

  diffr := endr - startr;
  diffg := endg - startg;
  diffb := endb - startb;

  rstepr := diffr / (steps - 1);
  rstepg := diffg / (steps - 1);
  rstepb := diffb / (steps - 1);

  if Direction then
    rstepw := (R.Right - R.Left) / (Steps )
  else
    rstepw := (R.Bottom - R.Top) / (Steps );

  with Canvas do
  begin
    for i := 0 to Steps - 1 do
    begin
      endr := startr + Round(rstepr*i);
      endg := startg + Round(rstepg*i);
      endb := startb + Round(rstepb*i);
      stepw := Round(i * rstepw);
      Pen.Color := endr + (endg shl 8) + (endb shl 16);
      Brush.Color := Pen.Color;
      if Direction then
      begin
        iend := R.Left + stepw + Trunc(rstepw) + 1;
        if iend > R.Right then
          iend := R.Right;
        Rectangle(R.Left + stepw,R.Top,iend,R.Bottom)
      end
      else
      begin
        iend := R.Top + stepw + Trunc(rstepw)+1;
        if iend > r.Bottom then
          iend := r.Bottom;
        Rectangle(R.Left,R.Top + stepw,R.Right,iend);
      end;
    end;
  end;
end;


{ TAdvOfficeHint }

constructor TAdvOfficeHint.Create(AOwner: TComponent);
var
  I,Instances:Integer;
  {$IFDEF DELPHI6_LVL}
  FApplicationEvents: TApplicationEvents;
  {$ENDIF}
begin
  inherited Create(AOwner);
  if not (Owner is TForm) then
    raise Exception.Create('Control parent must be a form!');


        
  Instances := 0;

  for I := 0 to Owner.ComponentCount - 1 do
    if (Owner.Components[I] is TAdvOfficeHint) then Inc(Instances);
  if (Instances > 1) then
    raise Exception.Create('Only one instance of TAdvOfficeHint allowed on form');


  if not (csDesigning in ComponentState) then
  begin
    HintWindowClass := TAdvOfficeHintWindow;

    {$IFDEF DELPHI6_LVL}
    FApplicationEvents := TApplicationEvents.Create(self);
    with Application do
    begin
      ShowHint := not ShowHint;
      ShowHint := not ShowHint;
    end;
    FApplicationEvents.OnShowHint := GetHintInfo;
    {$ELSE}
    with Application do
    begin
      ShowHint := not ShowHint;
      ShowHint := not ShowHint;
      OnShowHint := GetHintInfo;
    end;
    {$ENDIF}
  end;

  FHintInfo := TAdvHintInfo.Create;

  FFont := TFont.Create;
  FSystemFont := true;

  if IsVista then
    FFont.Name := 'Segoe UI'
  else
    FFont.Name := 'Tahoma'; 

  FHintWidth := 200;
  FHintHelpText := 'Press F1 for more help.';
  FHintHelpPicture := TGDIPPicture.Create;
  FHintColor := clWhite;
  FHintColorTo := $EFD9CA;
  FHintHelpLineColor := $FFC69A;
end;

destructor TAdvOfficeHint.Destroy;
begin
  FFont.Free;
  FHintHelpPicture.Free;
  FHintInfo.Free;
  inherited;
end;

function TAdvOfficeHint.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TAdvOfficeHint.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TAdvOfficeHint.SetComponentStyle(AStyle: TTMSStyle);
begin
  case AStyle of
    tsOffice2003Blue:
      begin
        HintColor := $FCE1CB;
        HintColorTo := $E0A57D;
        HintHelpLineColor := $962D00;
      end;
    tsOffice2003Silver:
      begin                            
        HintColor := $ECE2E1;
        HintColorTo := $B39698;
        HintHelpLineColor := $947C7C;
      end;
    tsOffice2003Olive:
      begin
        HintColor := $CFF0EA;
        HintColorTo := $8CC0B1;
        HintHelpLineColor := $588060;
      end;
    tsOffice2003Classic:
      begin
        HintColor := clWhite;
        HintColorTo := $C9D1D5;
        HintHelpLineColor := $8C8D8E;
      end;
    tsOffice2007Luna:
      begin
        HintColor := clWhite;
        HintColorTo := $EFD9CA;
        HintHelpLineColor := $FFC69A;
      end;
    tsOffice2007Obsidian:
      begin
        HintColor := $F2F1F0;
        HintColorTo := $C9C2BD;
        HintHelpLineColor := $C9C2BD;
      end;
    tsOffice2007Silver:
      begin
        HintColor := $F2F1F0;
        HintColorTo := $C9C2BD;
        HintHelpLineColor := $C9C2BD;
      end;      
    tsWindowsXP:
      begin
        HintColor := clWhite;
        HintColorTo := clBtnFace;
        HintHelpLineColor := clGray;
      end;
    tsWhidbey:
      begin
        HintColor := $F5F9FA;
        HintColorTo := $A8C0C0;
        HintHelpLineColor := $7E9898;
      end;
  end;
end;

procedure TAdvOfficeHint.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TAdvOfficeHint.SetHintHelpPicture(const Value: TGDIPPicture);
begin
  FHintHelpPicture.Assign(Value);
end;

procedure TAdvOfficeHint.SetSystemFont(const Value: boolean);
begin
  if (FSystemFont <> Value) then
  begin
    FSystemFont := Value;

    if value then
    begin
      if IsVista then
        FFont.Name := 'Segoe UI'
      else
        FFont.Name := 'Tahoma';
    end;
  end;
end;

procedure TAdvOfficeHint.SetVersion(const Value: string);
begin

end;

procedure TAdvOfficeHint.GetHintInfo(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
var
  AHintInfo: TAdvHintInfo;
  obj: TObject;
begin
  FHintControl := HintInfo.HintControl;

  FIsOfficeHint := false;

  if Assigned(HintInfo.HintControl) then
  begin
    if IsPublishedProp(HintInfo.HintControl,'OfficeHint') then
    begin
      obj := GetObjectProp(HintInfo.HintControl,'OfficeHint');

      if Assigned(obj) then
      begin
        FUseOfficeHint := true;
        FIsOfficeHint := true;

        AHintInfo := TAdvHintInfo(obj);
        FHintInfo.Assign(AHintInfo);

        CanShow := (AHintInfo.Title <> '') or (AHintInfo.Notes.Text <> '') or (HintStr <> '')
          or (AHintInfo.WideTitle <> '') or (AHintInfo.WideNotes <> '');


        if (FHintInfo.Title = '') and (FHintInfo.Notes.Text = '') and
           (FHintInfo.WideTitle = '') and (FHintInfo.WideNotes = '') then
        begin
          FHintInfo.Notes.Text := HintStr;
          FHintInfo.Title := '';
          FHintInfo.Picture.Assign(nil);
          FIsOfficeHint := false;
          FUseOfficeHint := false;
        end;

      end;

      // force the hint to display when TAdvHintInfo is used
      if CanShow and FIsOfficeHint then
        HintStr := '*';
    end
    else
    begin
      FHintInfo.Title := '';
      FHintInfo.WideTitle := '';
      FHintInfo.Notes.Text := HintStr;
      FHintInfo.ShowHelp := false;
      FHintInfo.Picture.Assign(nil);
      FUseOfficeHint := false;
    end;

    if Assigned(OnBeforeShowHint) then
      OnBeforeShowHint(Self, HintInfo.HintControl, FHintInfo, FUseOfficeHint);
  end;
end;


{ TAdvOfficeHintWindow }

procedure TAdvOfficeHintWindow.ActivateHint(Rect: TRect; const AHint: string);
var
  Pnt, P: TPoint;
  hr: TRect;
  //rgn:  THandle;
  AHintInfo: TAdvHintInfo;
  ImgW, ImgH, TxtH, TxtHDiv: integer;
  s: string;
  dtfmt: DWORD;
  i, w: Integer;
  IsOnPager: Boolean;
  CurrentMonRect: TRect;
  {$IFDEF DELPHI6_LVL}
  CurrentMonitor: TMonitor;
  {$ENDIF}
begin
  if FIsActivating then
    Exit;

  Caption := AHint;

  FHint := FindHintControl;

  if not Assigned(FHint) then
    Exit;

  FIsActivating := true;

  P := Point(-100, -100);
  IsOnPager := False;

  Rect.Right := Rect.Right + 4;

  if Assigned(FHint.HintControl) then
  begin
    if (IsPublishedProp(FHint.HintControl,'OfficeHint') and FHint.FIsOfficeHint) or FHint.FUseOfficeHint then
    begin

       { calculate rectangle here }
       ImgH := 0;
       ImgW := 0;

       Rect.Right := Rect.Right + FHint.HintWidth;

        if GetPointIfOnPager(FHint.HintControl, P) then
        begin
          IsOnPager := True;
          if Assigned(FHint.FHintInfo) and Assigned(FHint.FHintInfo.Picture) and (not FHint.FHintInfo.Picture.Empty) then
            w := 318
          else
            w := 210;
          Rect.Right := Rect.Left + w;
        end;


       begin
         AHintInfo := FHint.FHintInfo;

         Canvas.Font.Assign(FHint.Font);

         if FHint.SystemFont then
         begin
           if IsVista then
             Canvas.Font.Name := 'Segoe UI'
           else
             Canvas.Font.Name := 'Tahoma';
         end;

         hr := Rect;
         hr.Right := hr.Right - 16;

         if Assigned(AHintInfo.Picture) then
         begin
           if not AHintInfo.Picture.Empty then
           begin
             AHintInfo.Picture.GetImageSizes;
             ImgW := AHintInfo.Picture.Width;
             ImgH := AHintInfo.Picture.Height;

             if ImgW > 0 then
               hr.Right := hr.Right - ImgW - 2;
           end;
         end;

         s := AHintInfo.Notes.Text;

         if (s <> '') then
         begin
           if s[length(s)-1] = #13 then
           begin
             delete(s,length(s)-1,2);
           end;
         end;

         //if (length(s) > 1) and (AHintInfo.Title = '') then
         //begin
         //  delete(s, length(s) - 1, 2);
         //end;

         dtfmt := DT_LEFT or DT_CALCRECT;

         if FHint.HintWidth = 0 then
           dtfmt := dtfmt + DT_SINGLELINE
         else
           dtfmt := dtfmt + DT_WORDBREAK;

         if (s <> '') then
           TxtH := Max(ImgH,DrawText(Canvas.Handle,PChar(s), Length(s), hr, dtfmt))
         else
           TxtH := Max(ImgH,DrawTextW(Canvas.Handle,PWideChar(AHintInfo.WideNotes), Length(AHintInfo.WideNotes), hr, dtfmt));


         TxtHDiv := Canvas.TextHeight('gh');

         TxtH := TxtH + (TxtHDiv div 2);

         if fHint.HintWidth = 0 then
         begin
           Rect.Right := hr.Right + 24 + ImgW;
         end;

         if (AHintInfo.Title <> '') or (AHintInfo.WideTitle <> '') then
           TxtH := TxtH + TxTHDiv + (TxtHDiv div 2)
         else
           Rect.Right := hr.Right + 24 + ImgW;

         if AHintInfo.ShowHelp then
         begin
           if Assigned(FHint.HintHelpPicture) then
           begin
             if not FHint.HintHelpPicture.Empty then
             begin
               FHint.HintHelpPicture.GetImageSizes;
               TxtHDiv := Max(FHint.HintHelpPicture.Height, TxtHDiv);
             end;
           end;

           TxtH := TxtH + TxtHDiv + TxtHDiv div 2;
         end;

       end;

       //if (AHintInfo.Title <> '') or (AHintInfo.WideTitle <> '') then
       Rect.Bottom := Rect.Top + TxtH;
     end
     else
     begin
       if FHint.HintWidth > 0 then
       begin
         Rect.Right := Rect.Left + FHint.HintWidth;
         TxtH := 0;
         hr := Classes.Rect(0,0,FHint.HintWidth,0);
         dtfmt := DT_LEFT or DT_CALCRECT or DT_WORDBREAK or DT_NOPREFIX;

         if (AHint <> '') then
           TxtH := DrawText(Canvas.Handle, PChar(AHint), Length(AHint), hr, dtfmt);

         if hr.Right < FHint.HintWidth then
           Rect.Right := Rect.Left + hr.Right + 10
         else
           if hr.Right > FHint.HintWidth then
             Rect.Right := Rect.Left + hr.Right + 10;

         Rect.Bottom := Rect.Top + TxtH + 8;
       end
       else
         Rect.Bottom := Rect.Bottom + 8;
     end;

     Pnt.X := Rect.Left;
     Pnt.Y := Rect.Top;

     {$IFDEF DELPHI6_LVL}
     CurrentMonitor := Screen.MonitorFromPoint(Pnt, mdNearest);
     if Assigned(CurrentMonitor) then
       CurrentMonRect := CurrentMonitor.BoundsRect
     else
       CurrentMonRect := Classes.Rect(0,0,GetSystemMetrics(SM_CXSCREEN),GetSystemMetrics(SM_CYSCREEN));
     {$ENDIF}
     {$IFNDEF DELPHI6_LVL}
     CurrentMonRect := Classes.Rect(0,0,GetSystemMetrics(SM_CXSCREEN),GetSystemMetrics(SM_CYSCREEN));
     {$ENDIF}

     if (Rect.Right > CurrentMonRect.Right) then
     begin
       OffsetRect(Rect, - (Rect.Right - CurrentMonRect.Right),0);
     end;

     if (Rect.Bottom > CurrentMonRect.Bottom) then
     begin
       OffsetRect(Rect, 0, -(Rect.Bottom - CurrentMonRect.Bottom));
     end;

     {if (Rect.Right > Screen.DesktopWidth) then
     begin
       OffsetRect(Rect, - (Rect.Right - Screen.DesktopWidth),0);
     end;

     if (Rect.Bottom > Screen.DesktopHeight) then
     begin
       OffsetRect(Rect, 0, -(Rect.Bottom - Screen.DesktopHeight));
     end; }
  end;

//  inherited;

  if Rect.Bottom - Rect.Top < 22 then
    Rect.Bottom  := Rect.Top + 22;

  if IsOnPager  and (P.X >= 0) and (P.Y >= 0) then
  begin
    i := P.X - Rect.Left;
    Rect.Left := Rect.Left + i;
    Rect.Right := Rect.Right + i;
    i := P.Y - Rect.Top;
    Rect.Top := Rect.Top + i;
    Rect.Bottom := Rect.Bottom + i;

    if Rect.Bottom - Rect.Top < 50 then
      Rect.Bottom  := Rect.Top + 50;
  end;

  BoundsRect := Rect;

  if (P.X > 0) and (P.Y > 0) then
    Pnt := P
  else
    Pnt := ClientToScreen(Point(0, 0));

{
  rgn := CreateRoundRectRgn(0,0,Rect.Right - Rect.Left,Rect.Bottom-Rect.Top,HINTROUNDING,HINTROUNDING);
  if rgn > 0 then
  begin
    try
      SetWindowRgn(Handle,rgn,true);
    finally
      DeleteObject(rgn);
    end;
  end;
}
    SetWindowPos(Handle, HWND_TOPMOST, Pnt.X, Pnt.Y, 0, 0,
                 SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOSIZE);

  FIsActivating := false;

  Invalidate;
end;

function TAdvOfficeHintWindow.GetPointIfOnPager(Ctrl: TControl;
  var P: TPoint): Boolean;
var
  PrtCtrl: TControl;
  RP: TPoint;
begin
  Result := False;
  if not Assigned(Ctrl) then
    Exit;

  RP := P;
  if ((UpperCase(Ctrl.ClassName) = 'TADVTOOLBAR') or (UpperCase(Ctrl.ClassName) = 'TADVCUSTOMTOOLBAR')) and Assigned(Ctrl.Parent) then
  begin
    RP.X := Ctrl.Left;
    RP.Y := Ctrl.BoundsRect.Bottom + 7;
    RP := Ctrl.Parent.ClientToScreen(RP);
  end;

  PrtCtrl := Ctrl.Parent;
  while (PrtCtrl <> nil) do
  begin
    if (UpperCase(PrtCtrl.ClassName) = 'TADVTOOLBAR') or (UpperCase(PrtCtrl.ClassName) = 'TADVCUSTOMTOOLBAR') then
    begin
      RP.X := Ctrl.Left;
      RP.Y := PrtCtrl.BoundsRect.Bottom + 4;
      RP := PrtCtrl.ClientToScreen(RP);
    end
    else if ((UpperCase(PrtCtrl.ClassName) = 'TADVTOOLBARPAGER') or (UpperCase(PrtCtrl.ClassName) = 'TCOMPACTWINDOW')) then
    begin
      P := RP;
      Result := True;
      Break;
    end;
    PrtCtrl := PrtCtrl.Parent;
  end;
end;

procedure TAdvOfficeHintWindow.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;

begin
  inherited CreateParams(Params);
  Params.Style := Params.Style - WS_BORDER;

  if (Win32Platform = VER_PLATFORM_WIN32_NT) and
     ((Win32MajorVersion > 5) or
      ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1))) then
    Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;

function TAdvOfficeHintWindow.FindHintControl: TAdvOfficeHint;
var
  I: Integer;
begin
  Result := nil;
  
  If not Assigned(Application.MainForm) then
    Exit;

  with Application.MainForm do
  for I := 0 to ComponentCount-1 do
    if Components[I] is TAdvOfficeHint then
    begin
      Result := TAdvOfficeHint(Components[I]);
      Break;
    end;
end;

procedure TAdvOfficeHintWindow.Paint;
var
  R, DR: TRect;
  s:string;
  h: Integer;
  AHintInfo: TAdvHintInfo;
  ImgW, ImgH: integer;
  rgn: THandle;

begin
  if FIsPainting then
    Exit;

  if not Assigned(FHint) then
    Exit;

  FIsPainting := true;

  rgn := CreateRoundRectRgn(0,0,ClientRect.Right - ClientRect.Left,ClientRect.Bottom-ClientRect.Top,HINTROUNDING,HINTROUNDING);
  if rgn > 0 then
  begin
    try
      SetWindowRgn(Handle,rgn,true);
    finally
      DeleteObject(rgn);
    end;
  end;

  // draw background
  R := ClientRect;
  DrawGradient(Canvas, FHint.HintColor, FHint.HintColorTo, 64, R, false);
  Canvas.Pen.Color := clGray;
  Canvas.Pen.Width := 1;
  Canvas.Brush.Style := bsClear;
  Canvas.RoundRect(R.Left, R.Top, R.Right - 1, R.Bottom - 1, HINTROUNDING + 1, HINTROUNDING + 1);

  Canvas.Font.Assign(FHint.Font);

  if FHint.SystemFont then
  begin
    if IsVista then
      Canvas.Font.Name := 'Segoe UI'
    else
      Canvas.Font.Name := 'Tahoma';
  end;


  R.Top := R.Top + HINTROUNDING;
  R.Left := R.Left + 2;

  ImgH := 0;

  // try to find out of the HintControl has a property OfficeHint and if so, use it.
  s := '';
  if Assigned(FHint.HintControl) then
  begin
    if (IsPublishedProp(FHint.HintControl,'OfficeHint') and FHint.FIsOfficeHint) or FHint.FUseOfficeHint then
    begin
      // try to get the property here
      //obj := GetObjectProp(FHint.HintControl,'OfficeHint');

      //if Assigned(obj) then
      begin
        //AHintInfo := TAdvHintInfo(obj);
        AHintInfo := FHint.FHintInfo;

        Canvas.Font.Style := [fsBold];
        DR := R;
        DR.Left := DR.Left + 4;
        DR.Right := DR.Right - 4;
        h := 0;

        if (AHintInfo.Title <> '') then
          h := DrawText(Canvas.Handle, PChar(AHintInfo.Title), Length(AHintInfo.Title), DR, DT_LEFT or DT_SINGLELINE or DT_END_ELLIPSIS)
        else
          if (AHintInfo.WideTitle <> '') then
            h := DrawTextW(Canvas.Handle, PWideChar(AHintInfo.WideTitle), Length(AHintInfo.WideTitle), DR, DT_LEFT or DT_SINGLELINE or DT_END_ELLIPSIS);

        R.Top := R.Top + h + (h div 3);

        DR := R;

        if Assigned(AHintInfo.Picture) then
        begin
          if not AHintInfo.Picture.Empty then
          begin
            AHintInfo.Picture.GetImageSizes;
            ImgW := AHintInfo.Picture.Width;
            ImgH := AHintInfo.Picture.Height;
            Canvas.Draw(r.Left + 4, r.Top, AHintInfo.Picture);
            DR.Left := DR.Left + ImgW;
          end;
        end;

        s := AHintInfo.Notes.Text;

        if (s <> '') then
        begin
          if s[length(s)-1] = #13 then
          begin
            delete(s,length(s)-1,2);
          end;
        end;


        Canvas.Font.Style := [];
        DR.Left := DR.Left + 8;
        DR.Right := DR.Right - 8;

        if s <> '' then
          h := Max(ImgH , DrawText(Canvas.Handle, PChar(s), Length(s), DR, DT_LEFT or DT_WORDBREAK))
        else
          h := Max(ImgH , DrawTextW(Canvas.Handle, PWideChar(AHintInfo.WideNotes), Length(AHintInfo.WideNotes), DR, DT_LEFT or DT_WORDBREAK));


        R.Top := R.Top + h + (Canvas.TextHeight('gh') div 3);

        if AHintInfo.ShowHelp then
        begin
          Canvas.Pen.Color := FHint.HintHelpLineColor;
          Canvas.Pen.Width := 1;
          Canvas.MoveTo(R.Left - 1, R.Top);
          Canvas.LineTo(R.Right - 2, R.Top);
          R.Top := R.Top + 4;
          Canvas.Font.Style := [fsBold];
          s := FHint.HintHelpText;
          DR := R;
          DR.Left := DR.Left + 4;
          DR.Right := DR.Right - 4;

          if Assigned(FHint.HintHelpPicture) then
          begin
            if not FHint.HintHelpPicture.Empty then
            begin
              FHint.HintHelpPicture.GetImageSizes;
              Canvas.Draw(DR.Left, DR.Top, FHint.HintHelpPicture);
              DR.Left := DR.Left + FHint.HintHelpPicture.Width + 4;
            end;
          end;

          if (s <> '') then
            DrawText(Canvas.Handle, PChar(s), Length(s), DR, DT_LEFT or DT_SINGLELINE or DT_END_ELLIPSIS)
          else
            DrawTextW(Canvas.Handle, PWideChar(AHintInfo.WideNotes), Length(AHintInfo.WideNotes), DR, DT_LEFT or DT_SINGLELINE or DT_END_ELLIPSIS)
        end;
      end;
    end
    else
    begin
      R.Left := R.Left + 2;
      DrawText(Canvas.Handle, PChar(Caption), Length(Caption), R, DT_LEFT or DT_WORDBREAK)
    end;
  end
  else
  begin
    R.Left := R.Left + 4;
    DrawText(Canvas.Handle, PChar(Caption), Length(Caption), R, DT_LEFT or DT_WORDBREAK)
  end;
  FIsPainting := false;
end;

procedure TAdvOfficeHintWindow.WMEraseBkGnd(var Message: TMessage);
begin
  Message.Result := 1;
end;

{$IFNDEF DELPHI9_LVL}
procedure TAdvOfficeHintWindow.WndProc(var Msg:TMessage);
begin
  inherited;

  if (Msg.Msg = WM_SHOWWINDOW) and not Bool(Msg.WParam) then
  begin
     FHint := FindHintControl;
     if not Assigned(FHint) then
       Exit;
     if Assigned(FHint.HintControl) then
       FHint.HintControl := nil;
  end;

end;
{$ENDIF}

{$IFDEF DELPHI9_LVL}
function TAdvOfficeHintWindow.ShouldHideHint: Boolean;
begin
  Result := inherited ShouldHideHint;

  if Result then
  begin
    FHint := FindHintControl;
    if not Assigned(FHint) then
      Exit;
    if Assigned(FHint.HintControl) then
      FHint.HintControl := nil;
  end;

end;
{$ENDIF}

end.
