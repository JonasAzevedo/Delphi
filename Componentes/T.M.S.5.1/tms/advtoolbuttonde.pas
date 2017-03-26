{***********************************************************************}
{ TAdvToolButton component design time code                             }
{ for Delphi & C++Builder                                               }
{ version 1.2.1                                                         }
{                                                                       }
{ written by TMS Software                                               }
{            copyright � 2002-2005                                      }
{            Email: info@tmssoftware.com                                }
{            Web: http://www.tmssoftware.com                            }
{                                                                       }
{ The source code is given as is. The author is not responsible         }
{ for any possible damage done due to the use of this code.             }
{ The component can be freely used in any application. The complete     }
{ source code remains property of the author and may not be distributed,}
{ published, given or sold in any form as such. No parts of the source  }
{ code can be included in any other component or application without    }
{ written authorization of the author.                                  }
{***********************************************************************}
{$I TMSDEFS.INC}
unit AdvToolButtonDE;

interface

uses
  Classes, Windows, SysUtils, Dialogs, AdvToolBtn, AdvToolButtonStyles, Forms, Controls
  {$IFDEF DELPHI6_LVL}
  {$IFNDEF TMSDOTNET}
  , DesignIntf, DesignEditors
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  , Borland.Vcl.Design.DesignIntf, Borland.Vcl.Design.DesignEditors
  {$ENDIF}

  {$ELSE}
  , DsgnIntf
  {$ENDIF}
  ;

type

  TAdvToolButtonEditor = class(TDefaultEditor)
  protected
  public
    function GetVerb(index:integer):string; override;
    function GetVerbCount:integer; override;
    procedure ExecuteVerb(Index:integer); override;
  end;

implementation

procedure TAdvToolButtonEditor.ExecuteVerb(Index: integer);
var
  psf: TAdvToolButtonStyleForm;
begin
  case Index of
  0: begin
       psf := TAdvToolButtonStyleForm.Create(Application);
       if psf.ShowModal = mrOK then
       begin
         psf.SetStyle(psf.RadioGroup1.ItemIndex,Component as TAdvToolButton);
         Designer.Modified;
       end;
       psf.Free;
     end;
  end;
end;



function TAdvToolButtonEditor.GetVerb(Index: Integer): string;
begin
  Result := '';
  case Index of
  0:Result := 'Styles';
  end;
end;

function TAdvToolButtonEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;



end.

