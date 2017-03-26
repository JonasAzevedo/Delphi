{****************************************************************}
{ TWebUpdate & TWebUpdate Wizard component                       }
{ for Delphi & C++Builder                                        }
{                                                                }
{ written by                                                     }
{   TMS Software                                                 }
{   copyright © 1998-2008                                        }
{   Email : info@tmssoftware.com                                 }
{   Web : http://www.tmssoftware.com                             }
{****************************************************************}
unit wupdreg;

{$I TMSDEFS.INC}

interface

uses
  Classes, WUpdate, WUpdateWiz, WUpdateLanguages;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TMS Web',[TWebUpdate
  , TWebUpdateWizard
  , TWebUpdateWizardDutch
  , TWebUpdateWizardEnglish
  , TWebUpdateWizardFrench
  , TWebUpdateWizardGerman
  , TWebUpdateWizardPortugese
  , TWebUpdateWizardSpanish
  , TWebUpdateWizardDanish
  , TWebUpdateWizardItalian
  , TWebUpdateWizardNorwegian
  , TWebUpdateWizardHungarian
  , TWebUpdateWizardSwedish
  , TWebUpdateWizardCzech
  , TWebUpdateWizardPolish
  ]);
end;

end.

