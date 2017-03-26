{***************************************************************************}
{ TAdvOfficeImage component                                                 }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2006 - 2007                                        }
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

unit AdvOfficeImage;

{$I TMSDEFS.INC}

interface

uses
  Classes, Windows, Forms, Dialogs, Controls, Graphics, Messages, ExtCtrls,
  SysUtils, GDIPicture, AdvHintInfo;

const

  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 2; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.0.1.0 : Align property added
  // v1.0.2.0 : Center property added 

type
  TAdvOfficeImage = class(TGraphicControl)
  private
    FOffSet: integer;
    FMouseInControl: Boolean;
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FOfficeHint: TAdvHintInfo;
    FIPicture: TGDIPPicture;
    FCenter: boolean;
    procedure OnPictureChanged(Sender: TObject);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    procedure SetOfficeHint(const Value: TAdvHintInfo);
    procedure SetIPicture(const Value: TGDIPPicture);
    procedure SetCenter(const Value: boolean);
  protected
    procedure DrawImage(ACanvas: TCanvas); virtual;
    procedure Paint; override;
    property MouseInControl: Boolean read FMouseInControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetVersionNr: Integer; virtual;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Center: boolean read FCenter write SetCenter default true;
    property Constraints;
    property Picture: TGDIPPicture read FIPicture write SetIPicture;

    property PopupMenu;
    property ShowHint;
    property OfficeHint: TAdvHintInfo read FOfficeHint write SetOfficeHint;
    property Version: string read GetVersion write SetVersion;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;


implementation

//------------------------------------------------------------------------------

{ TAdvOfficeImage }

constructor TAdvOfficeImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIPicture := TGDIPPicture.Create;
  FIPicture.OnChange := OnPictureChanged;

  ControlStyle := [csCaptureMouse, csDoubleClicks,csClickEvents];

  FOffSet := 4;

  FOfficeHint := TAdvHintInfo.Create;

  ShowHint := False;
  Width := 32;
  Height := 32;
  FCenter := true;
end;

//------------------------------------------------------------------------------

destructor TAdvOfficeImage.Destroy;
begin
  FIPicture.Free;
  FOfficeHint.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficeImage.CMMouseEnter(var Message: TMessage);
begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;

  FMouseInControl := true;

  if Assigned(FOnMouseEnter) then
     FOnMouseEnter(Self);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficeImage.CMMouseLeave(var Message: TMessage);
begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;

  FMouseInControl := false;

  if Assigned(FOnMouseLeave) then
     FOnMouseLeave(Self);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficeImage.Paint;
begin
  inherited;
  DrawImage(Canvas);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficeImage.DrawImage(ACanvas: TCanvas);
var
  Pic: TGDIPPicture;
  x, y: Integer;
begin
  Pic := Picture;

  if Assigned(Pic) and not Pic.Empty then
  begin
    Pic.GetImageSizes;
    if Center then
    begin
      x := (Width - Pic.Width) div 2;
      y := (Height - Pic.Height) div 2;
    end
    else
    begin
      x := 0;
      y := 0;
    end;
    ACanvas.Draw(x, y, Pic);
  end
  else
  begin
    ACanvas.Pen.Style := psDot;
    ACanvas.Pen.Color := clBlue;
    ACanvas.Brush.Style := bsClear;
    ACanvas.Rectangle(ClientRect);
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficeImage.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

//------------------------------------------------------------------------------

function TAdvOfficeImage.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

//------------------------------------------------------------------------------

procedure TAdvOfficeImage.SetVersion(const Value: string);
begin

end;

//------------------------------------------------------------------------------

procedure TAdvOfficeImage.SetOfficeHint(const Value: TAdvHintInfo);
begin
  FOfficeHint.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficeImage.SetCenter(const Value: boolean);
begin
  if (FCenter <> Value) then
  begin
    FCenter := Value;
    Invalidate;
  end;
end;

procedure TAdvOfficeImage.SetIPicture(const Value: TGDIPPicture);
begin
  FIPicture.Assign(Value);
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficeImage.OnPictureChanged(Sender: TObject);
begin
  Invalidate;
end;

//------------------------------------------------------------------------------


{$IFDEF FREEWARE}
{$I TRIAL.INC}
{$ENDIF}


end.
