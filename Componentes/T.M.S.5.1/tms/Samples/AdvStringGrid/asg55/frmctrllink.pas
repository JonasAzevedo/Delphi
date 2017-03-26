{**************************************************************************}
{ TADVSTRINGGRID FORM CONTROL EDITLINK                                     }
{                                                                          }
{ written by TMS Software                                                  }
{            copyright © 2009                                              }
{            Email : info@tmssoftware.com                                  }
{            Web : http://www.tmssoftware.com                              }
{                                                                          }
{ The source code is given as is. The author is not responsible            }
{ for any possible damage done due to the use of this code.                }
{ The component can be freely used in any application. The complete        }
{ source code remains property of the author and may not be distributed,   }
{ published, given or sold in any form as such. No parts of the source     }
{ code can be included in any other component or application without       }
{ written authorization of the author.                                     }
{**************************************************************************}

unit frmctrllink;

interface

uses
  Windows, Messages, Classes, Controls, StdCtrls, Graphics, Forms, SysUtils,
  Dialogs, AdvGrid;

type

  TSetEditorValueEvent = procedure(Sender: TObject; Grid: TAdvStringGrid; AValue: string) of object;
  TGetEditorValueEvent = procedure(Sender: TObject; Grid: TAdvStringGrid; var AValue: string) of object;
  TSetEditorProperties = procedure(Sender: TObject; Grid: TAdvStringGrid; AControl: TWinControl) of object;
  TSetEditorFocus = procedure(Sender: TObject; Grid: TAdvStringGrid; AControl: TWinControl) of object;

  TFormControlEditLink = class(TEditLink)
  private
    FControl: TWinControl;
    FOnGetEditorValue: TGetEditorValueEvent;
    FOnSetEditorValue: TSetEditorValueEvent;
    FOnSetEditorProperties: TSetEditorProperties;
    FOnSetEditorFocus: TSetEditorFocus;
  protected
    procedure EditExit(Sender: TObject);
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    function GetEditControl: TWinControl; override;
    procedure SetProperties; override;
    function GetEditorValue: string; override;
    procedure SetEditorValue(s: string); override;
    procedure SetFocus(Value: Boolean); override;
  published
    property Control: TWinControl read FControl write FControl;
    property OnSetEditorValue: TSetEditorValueEvent read FOnSetEditorValue write FOnSetEditorValue;
    property OnSetEditorFocus: TSetEditorFocus read FOnSetEditorFocus write FOnSetEditorFocus;
    property OnGetEditorValue: TGetEditorValueEvent read FOnGetEditorValue write FOnGetEditorValue;
    property OnSetEditorProperties: TSetEditorProperties read FOnSetEditorProperties write FOnSetEditorProperties;
  end;



procedure Register;

implementation

type
  TMyWinControl = class(TWinControl)
  published
 //   property OnExit;
  end;

procedure Register;
begin
  RegisterComponents('TMS Grids', [TFormControlEditLink]);
end;

{ TFormControlEditLink }

procedure TFormControlEditLink.EditExit(Sender: TObject);
begin
  FControl.Hide;
end;

function TFormControlEditLink.GetEditControl: TWinControl;
begin
  FControl.Parent := Grid;
  Result := FControl;
  TMyWinControl(FControl).OnExit := EditExit;
  TMyWinControl(FControl).OnKeyDown := EditKeyDown;
end;

function TFormControlEditLink.GetEditorValue: string;
begin
  if Assigned(FOnGetEditorValue) then
    FOnGetEditorValue(Self, Grid, Result);
end;

procedure TFormControlEditLink.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AOperation = opRemove) and (AComponent = FControl) then
    FControl := nil;
end;

procedure TFormControlEditLink.SetEditorValue(s: string);
begin
  if Assigned(FOnSetEditorValue) then
    FOnSetEditorValue(Self, Grid, s);
end;

procedure TFormControlEditLink.SetFocus(Value: Boolean);
begin
  inherited;
  if Value then
    if Assigned(FOnSetEditorFocus) then
      FOnSetEditorFocus(Self, Grid, FControl);
end;

procedure TFormControlEditLink.SetProperties;
begin
  inherited;
  if Assigned(FOnSetEditorProperties) then
    FOnSetEditorProperties(Self, Grid, FControl);
end;

end.
