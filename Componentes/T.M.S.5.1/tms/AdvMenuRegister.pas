{***************************************************************************}
{ TAdvMenu & TAdvPopupMenu component                                        }
{ for Delphi & C++Builder                                                   }
{ version 1.2.1.0                                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2004 - 2005                                        }
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

unit AdvMenuRegister;

{$I TMSDEFS.INC}

interface

{$IFDEF TMSDOTNET}
{$R TAdvMainMenu.bmp}
{$R TAdvPopupMenu.bmp}
{$R TAdvMenuStyler.bmp}
{$R TAdvMenuOfficeStyler.bmp}
{$R TAdvMenuFantasyStyler.bmp}
{$ENDIF}

uses
  Classes;

procedure Register;

implementation

uses
  AdvMenus, AdvMenuStylers;

procedure Register;
begin
  RegisterComponents('TMS Menus', [TAdvPopupMenu, TAdvMainMenu, TAdvMenuStyler,
    TAdvMenuOfficeStyler, TAdvMenuFantasyStyler]);
end;

end.
