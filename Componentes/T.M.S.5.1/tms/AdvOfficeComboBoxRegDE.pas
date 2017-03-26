{***************************************************************************}
{ TAdvOfficeComboBox component                                              }
{ for Delphi & C++Builder                                                   }
{ version 1.0                                                               }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2006                                               }
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

unit AdvOfficeComboBoxRegDE;

interface

{$I TMSDEFS.INC}

uses
  Classes, Graphics, Comctrls, Windows, Forms, TypInfo, Dialogs, ExtCtrls,
  Controls, AdvOfficeComboBox, ExtDlgs, AdvStyleIF
{$IFDEF DELPHI6_LVL}
  {$IFNDEF TMSDOTNET}
  , DesignIntf, DesignEditors, ContNrs
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  , Borland.Vcl.design.DesignIntf, Borland.Vcl.design.DesignEditors, ContNrs
  {$ENDIF}
{$ELSE}
  , DsgnIntf
{$ENDIF}
  ;

type

  TAdvOfficeComboBoxEditor = class(TDefaultEditor)
  protected
  public
    function GetVerb(Index: Integer):string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

procedure Register;


implementation

uses
  SysUtils;


{ TAdvOfficeComboBoxEditor }

procedure TAdvOfficeComboBoxEditor.ExecuteVerb(Index: Integer);
begin
  inherited;

  if (Component is TAdvCustomOfficeComboBox) then
  begin
      if Index in [0..7] then
        (Component as TAdvCustomOfficeComboBox).SetComponentStyle(TTMSStyle(Index));
      (Component as TAdvCustomOfficeComboBox).Repaint;
      Exit;
    end;
end;

function TAdvOfficeComboBoxEditor.GetVerb(Index: Integer): string;
begin
  if (Component is TAdvCustomOfficeComboBox) then
  begin
    //tsOffice2003Blue, tsOffice2003Silver, tsOffice2003Olive, tsOffice2003Classic,
    //tsOffice2007Luna, tsOffice2007Obsidian, tsWindowsXP, tsWhidbey
    case Index of
    0: Result := 'Office 2003 Blue';
    1: Result := 'Office 2003 Silver';
    2: Result := 'Office 2003 Olive';
    3: Result := 'Office 2003 Classic';
    4: Result := 'Office 2007 Luna';
    5: Result := 'Office 2007 Obsidian';
    6: Result := 'Windows XP';
    7: Result := 'Visual Studio 2005';
    end;
  end;
end;

function TAdvOfficeComboBoxEditor.GetVerbCount: Integer;
begin
  Result := 8;
end;

procedure Register;
begin
  RegisterComponentEditor(TAdvCustomOfficeComboBox,TAdvOfficeComboBoxEditor);
end;


end.
