{***************************************************************************}
{ TMS Graphics Component Pack                                               }
{ for Delphi & C++Builder                                                   }
{ version 1.0.0.0                                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2004                                               }
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

{$I TMSDEFS.INC}

unit TMSGraphicsReg;

{$IFDEF TMSDOTNET}
{$R TAdvFontSelector.bmp}
{$R TAdvOfficeComboBox.bmp}
{$R TAdvPenStyleSelector.bmp}
{$R TAdvBrushStyleSelector.bmp}
{$R TAdvShadowSelector.bmp}
{$R TAdvTableBorderSelector.bmp}
{$R TAdvGradientDirectionSelector.bmp}
{$R TAdvPenWidthSelector.bmp}
{$R TAdvColorSelector.bmp}
{$R TAdvToolSelector.bmp}
{$R TAdvTextColorSelector.bmp}
{$R TAdvTableSelector.bmp}
{$R TAdvCharacterSelector.bmp}
{$ENDIF}

interface

uses
  Classes, AdvFontCombo, AdvSelectors;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TMS Graphics', [TAdvFontSelector,
                                      TAdvOfficeComboBox,
                                      TAdvPenStyleSelector,
                                      TAdvBrushStyleSelector,
                                      TAdvShadowSelector,
                                      TAdvTableBorderSelector,
                                      TAdvGradientDirectionSelector,
                                      TAdvPenWidthSelector,
                                      TAdvColorSelector,
                                      TAdvTextColorSelector,
                                      TAdvToolSelector,
                                      TAdvTableSelector,
                                      TAdvCharacterSelector]);
end;



end.

