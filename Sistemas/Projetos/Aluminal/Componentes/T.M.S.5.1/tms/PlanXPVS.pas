{***************************************************************************}
{ XPTheme interface                                                         }
{ for Delphi & C++Builder                                                   }
{ version 2.5                                                               }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1996-2006                                          }
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

{$HPPEMIT ''}
{$HPPEMIT '#include "uxtheme.h"'}
{$HPPEMIT ''}


unit PlanXPVS;

interface

uses
  Windows, Graphics;

const

//---------------------------------------------------------------------------------------
//   "Window" (i.e., non-client) Parts & States
//---------------------------------------------------------------------------------------

  WP_CAPTION = 1;
  {$EXTERNALSYM WP_CAPTION}
  WP_SMALLCAPTION = 2;
  {$EXTERNALSYM WP_SMALLCAPTION}
  WP_MINCAPTION = 3;
  {$EXTERNALSYM WP_MINCAPTION}
  WP_SMALLMINCAPTION = 4;
  {$EXTERNALSYM WP_SMALLMINCAPTION}
  WP_MAXCAPTION = 5;
  {$EXTERNALSYM WP_MAXCAPTION}
  WP_SMALLMAXCAPTION = 6;
  {$EXTERNALSYM WP_SMALLMAXCAPTION}
  WP_FRAMELEFT = 7;
  {$EXTERNALSYM WP_FRAMELEFT}
  WP_FRAMERIGHT = 8;
  {$EXTERNALSYM WP_FRAMERIGHT}
  WP_FRAMEBOTTOM = 9;
  {$EXTERNALSYM WP_FRAMEBOTTOM}
  WP_SMALLFRAMELEFT = 10;
  {$EXTERNALSYM WP_SMALLFRAMELEFT}
  WP_SMALLFRAMERIGHT = 11;
  {$EXTERNALSYM WP_SMALLFRAMERIGHT}
  WP_SMALLFRAMEBOTTOM = 12;
  {$EXTERNALSYM WP_SMALLFRAMEBOTTOM}

    //---- window frame buttons ----
  WP_SYSBUTTON = 13;
  {$EXTERNALSYM WP_SYSBUTTON}
  WP_MDISYSBUTTON = 14;
  {$EXTERNALSYM WP_MDISYSBUTTON}
  WP_MINBUTTON = 15;
  {$EXTERNALSYM WP_MINBUTTON}
  
  WP_MDIMINBUTTON = 16;
  {$EXTERNALSYM WP_MDIMINBUTTON}
  WP_MAXBUTTON = 17;
  {$EXTERNALSYM WP_MAXBUTTON}
  WP_CLOSEBUTTON = 18;
  {$EXTERNALSYM WP_CLOSEBUTTON}
  WP_SMALLCLOSEBUTTON = 19;
  {$EXTERNALSYM WP_SMALLCLOSEBUTTON}
  WP_MDICLOSEBUTTON = 20;
  {$EXTERNALSYM WP_MDICLOSEBUTTON}
  WP_RESTOREBUTTON = 21;
  {$EXTERNALSYM WP_RESTOREBUTTON}
  WP_MDIRESTOREBUTTON = 22;
  {$EXTERNALSYM WP_MDIRESTOREBUTTON}
  WP_HELPBUTTON = 23;
  {$EXTERNALSYM WP_HELPBUTTON}
  WP_MDIHELPBUTTON = 24;
  {$EXTERNALSYM WP_MDIHELPBUTTON}
  //---- scrollbars
  WP_HORZSCROLL = 25;
  {$EXTERNALSYM WP_HORZSCROLL}
  WP_HORZTHUMB = 26;
  {$EXTERNALSYM WP_HORZTHUMB}
  WP_VERTSCROLL = 27;
  {$EXTERNALSYM WP_VERTSCROLL}
  WP_VERTTHUMB = 28;
  {$EXTERNALSYM WP_VERTTHUMB}
  //---- dialog ----
  WP_DIALOG = 29;
  {$EXTERNALSYM WP_DIALOG}
  //---- hit-test templates ---
  WP_CAPTIONSIZINGTEMPLATE = 30;
  {$EXTERNALSYM WP_CAPTIONSIZINGTEMPLATE}
  WP_SMALLCAPTIONSIZINGTEMPLATE = 31;
  {$EXTERNALSYM WP_SMALLCAPTIONSIZINGTEMPLATE}
  WP_FRAMELEFTSIZINGTEMPLATE = 32;
  {$EXTERNALSYM WP_FRAMELEFTSIZINGTEMPLATE}
  WP_SMALLFRAMELEFTSIZINGTEMPLATE = 33;
  {$EXTERNALSYM WP_SMALLFRAMELEFTSIZINGTEMPLATE}
  WP_FRAMERIGHTSIZINGTEMPLATE = 34;
  {$EXTERNALSYM WP_FRAMERIGHTSIZINGTEMPLATE}
  WP_SMALLFRAMERIGHTSIZINGTEMPLATE = 35;
  {$EXTERNALSYM WP_SMALLFRAMERIGHTSIZINGTEMPLATE}
  WP_FRAMEBOTTOMSIZINGTEMPLATE = 36;
  {$EXTERNALSYM WP_FRAMEBOTTOMSIZINGTEMPLATE}
  WP_SMALLFRAMEBOTTOMSIZINGTEMPLATE = 37;
  {$EXTERNALSYM WP_SMALLFRAMEBOTTOMSIZINGTEMPLATE}

  FS_ACTIVE = 1;
  {$EXTERNALSYM FS_ACTIVE}
  FS_INACTIVE = 2;
  {$EXTERNALSYM FS_INACTIVE}

  CS_ACTIVE = 1;
  {$EXTERNALSYM CS_ACTIVE}
  CS_INACTIVE = 2;
  {$EXTERNALSYM CS_INACTIVE}
  CS_DISABLED = 3;
  {$EXTERNALSYM CS_DISABLED}

  MXCS_ACTIVE = 1;
  {$EXTERNALSYM MXCS_ACTIVE}
  MXCS_INACTIVE = 2;
  {$EXTERNALSYM MXCS_INACTIVE}
  MXCS_DISABLED = 3;
  {$EXTERNALSYM MXCS_DISABLED}

  MNCS_ACTIVE = 1;
  {$EXTERNALSYM MNCS_ACTIVE}
  MNCS_INACTIVE = 2;
  {$EXTERNALSYM MNCS_INACTIVE}
  MNCS_DISABLED = 3;
  {$EXTERNALSYM MNCS_DISABLED}

  HSS_NORMAL = 1;
  {$EXTERNALSYM HSS_NORMAL}
  HSS_HOT = 2;
  {$EXTERNALSYM HSS_HOT}
  HSS_PUSHED = 3;
  {$EXTERNALSYM HSS_PUSHED}
  HSS_DISABLED = 4;
  {$EXTERNALSYM HSS_DISABLED}

  HTS_NORMAL = 1;
  {$EXTERNALSYM HTS_NORMAL}
  HTS_HOT = 2;
  {$EXTERNALSYM HTS_HOT}
  HTS_PUSHED = 3;
  {$EXTERNALSYM HTS_PUSHED}
  HTS_DISABLED = 4;
  {$EXTERNALSYM HTS_DISABLED}

  VSS_NORMAL = 1;
  {$EXTERNALSYM VSS_NORMAL}
  VSS_HOT = 2;
  {$EXTERNALSYM VSS_HOT}
  VSS_PUSHED = 3;
  {$EXTERNALSYM VSS_PUSHED}
  VSS_DISABLED = 4;
  {$EXTERNALSYM VSS_DISABLED}

  VTS_NORMAL = 1;
  {$EXTERNALSYM VTS_NORMAL}
  VTS_HOT = 2;
  {$EXTERNALSYM VTS_HOT}
  VTS_PUSHED = 3;
  {$EXTERNALSYM VTS_PUSHED}
  VTS_DISABLED = 4;
  {$EXTERNALSYM VTS_DISABLED}

  SBS_NORMAL = 1;
  {$EXTERNALSYM SBS_NORMAL}
  SBS_HOT = 2;
  {$EXTERNALSYM SBS_HOT}
  SBS_PUSHED = 3;
  {$EXTERNALSYM SBS_PUSHED}
  SBS_DISABLED = 4;
  {$EXTERNALSYM SBS_DISABLED}

  MINBS_NORMAL = 1;
  {$EXTERNALSYM MINBS_NORMAL}
  MINBS_HOT = 2;
  {$EXTERNALSYM MINBS_HOT}
  MINBS_PUSHED = 3;
  {$EXTERNALSYM MINBS_PUSHED}
  MINBS_DISABLED = 4;
  {$EXTERNALSYM MINBS_DISABLED}

  MAXBS_NORMAL = 1;
  {$EXTERNALSYM MAXBS_NORMAL}
  MAXBS_HOT = 2;
  {$EXTERNALSYM MAXBS_HOT}
  MAXBS_PUSHED = 3;
  {$EXTERNALSYM MAXBS_PUSHED}
  MAXBS_DISABLED = 4;
  {$EXTERNALSYM MAXBS_DISABLED}

  RBS_NORMAL = 1;
  {$EXTERNALSYM RBS_NORMAL}
  RBS_HOT = 2;
  {$EXTERNALSYM RBS_HOT}
  RBS_PUSHED = 3;
  {$EXTERNALSYM RBS_PUSHED}
  RBS_DISABLED = 4;
  {$EXTERNALSYM RBS_DISABLED}

  HBS_NORMAL = 1;
  {$EXTERNALSYM HBS_NORMAL}
  HBS_HOT = 2;
  {$EXTERNALSYM HBS_HOT}
  HBS_PUSHED = 3;
  {$EXTERNALSYM HBS_PUSHED}
  HBS_DISABLED = 4;
  {$EXTERNALSYM HBS_DISABLED}

  CBS_NORMAL = 1;
  {$EXTERNALSYM CBS_NORMAL}
  CBS_HOT = 2;
  {$EXTERNALSYM CBS_HOT}
  CBS_PUSHED = 3;
  {$EXTERNALSYM CBS_PUSHED}
  CBS_DISABLED = 4;
  {$EXTERNALSYM CBS_DISABLED}

//---------------------------------------------------------------------------------------
//   "Button" Parts & States
//---------------------------------------------------------------------------------------
  BP_PUSHBUTTON = 1;
  {$EXTERNALSYM BP_PUSHBUTTON}
  BP_RADIOBUTTON = 2;
  {$EXTERNALSYM BP_RADIOBUTTON}
  BP_CHECKBOX = 3;
  {$EXTERNALSYM BP_CHECKBOX}
  BP_GROUPBOX = 4;
  {$EXTERNALSYM BP_GROUPBOX}
  BP_USERBUTTON = 5;
  {$EXTERNALSYM BP_USERBUTTON}

  PBS_NORMAL = 1;
  {$EXTERNALSYM PBS_NORMAL}
  PBS_HOT = 2;
  {$EXTERNALSYM PBS_HOT}
  PBS_PRESSED = 3;
  {$EXTERNALSYM PBS_PRESSED}
  PBS_DISABLED = 4;
  {$EXTERNALSYM PBS_DISABLED}
  PBS_DEFAULTED = 5;
  {$EXTERNALSYM PBS_DEFAULTED}

  RBS_UNCHECKEDNORMAL = 1;
  {$EXTERNALSYM RBS_UNCHECKEDNORMAL}
  RBS_UNCHECKEDHOT = 2;
  {$EXTERNALSYM RBS_UNCHECKEDHOT}
  RBS_UNCHECKEDPRESSED = 3;
  {$EXTERNALSYM RBS_UNCHECKEDPRESSED}
  RBS_UNCHECKEDDISABLED = 4;
  {$EXTERNALSYM RBS_UNCHECKEDDISABLED}
  RBS_CHECKEDNORMAL = 5;
  {$EXTERNALSYM RBS_CHECKEDNORMAL}
  RBS_CHECKEDHOT = 6;
  {$EXTERNALSYM RBS_CHECKEDHOT}
  RBS_CHECKEDPRESSED = 7;
  {$EXTERNALSYM RBS_CHECKEDPRESSED}
  RBS_CHECKEDDISABLED = 8;
  {$EXTERNALSYM RBS_CHECKEDDISABLED}

  CBS_UNCHECKEDNORMAL = 1;
  {$EXTERNALSYM CBS_UNCHECKEDNORMAL}
  CBS_UNCHECKEDHOT = 2;
  {$EXTERNALSYM CBS_UNCHECKEDHOT}
  CBS_UNCHECKEDPRESSED = 3;
  {$EXTERNALSYM CBS_UNCHECKEDPRESSED}
  CBS_UNCHECKEDDISABLED = 4;
  {$EXTERNALSYM CBS_UNCHECKEDDISABLED}
  CBS_CHECKEDNORMAL = 5;
  {$EXTERNALSYM CBS_CHECKEDNORMAL}
  CBS_CHECKEDHOT = 6;
  {$EXTERNALSYM CBS_CHECKEDHOT}
  CBS_CHECKEDPRESSED = 7;
  {$EXTERNALSYM CBS_CHECKEDPRESSED}
  CBS_CHECKEDDISABLED = 8;
  {$EXTERNALSYM CBS_CHECKEDDISABLED}
  CBS_MIXEDNORMAL = 9;
  {$EXTERNALSYM CBS_MIXEDNORMAL}
  CBS_MIXEDHOT = 10;
  {$EXTERNALSYM CBS_MIXEDHOT}
  CBS_MIXEDPRESSED = 11;
  {$EXTERNALSYM CBS_MIXEDPRESSED}
  CBS_MIXEDDISABLED = 12;
  {$EXTERNALSYM CBS_MIXEDDISABLED}

  GBS_NORMAL = 1;
  {$EXTERNALSYM GBS_NORMAL}
  GBS_DISABLED = 2;
  {$EXTERNALSYM GBS_DISABLED}

//---------------------------------------------------------------------------------------
//   "Rebar" Parts & States
//---------------------------------------------------------------------------------------

  RP_GRIPPER = 1;
  {$EXTERNALSYM RP_GRIPPER}
  RP_GRIPPERVERT = 2;
  {$EXTERNALSYM RP_GRIPPERVERT}
  RP_BAND = 3;
  {$EXTERNALSYM RP_BAND}
  RP_CHEVRON = 4;
  {$EXTERNALSYM RP_CHEVRON}
  RP_CHEVRONVERT = 5;
  {$EXTERNALSYM RP_CHEVRONVERT}

  CHEVS_NORMAL = 1;
  {$EXTERNALSYM CHEVS_NORMAL}
  CHEVS_HOT = 2;
  {$EXTERNALSYM CHEVS_HOT}
  CHEVS_PRESSED = 3;
  {$EXTERNALSYM CHEVS_PRESSED}

//---------------------------------------------------------------------------------------
//   "Toolbar" Parts & States
//---------------------------------------------------------------------------------------

  TP_BUTTON = 1;
  {$EXTERNALSYM TP_BUTTON}
  TP_DROPDOWNBUTTON = 2;
  {$EXTERNALSYM TP_DROPDOWNBUTTON}
  TP_SPLITBUTTON = 3;
  {$EXTERNALSYM TP_SPLITBUTTON}
  TP_SPLITBUTTONDROPDOWN = 4;
  {$EXTERNALSYM TP_SPLITBUTTONDROPDOWN}
  TP_SEPARATOR = 5;
  {$EXTERNALSYM TP_SEPARATOR}
  TP_SEPARATORVERT = 6;
  {$EXTERNALSYM TP_SEPARATORVERT}

  TS_NORMAL = 1;
  {$EXTERNALSYM TS_NORMAL}
  TS_HOT = 2;
  {$EXTERNALSYM TS_HOT}
  TS_PRESSED = 3;
  {$EXTERNALSYM TS_PRESSED}
  TS_DISABLED = 4;
  {$EXTERNALSYM TS_DISABLED}
  TS_CHECKED = 5;
  {$EXTERNALSYM TS_CHECKED}
  TS_HOTCHECKED = 6;
  {$EXTERNALSYM TS_HOTCHECKED}

//---------------------------------------------------------------------------------------
//   "Status" Parts & States
//---------------------------------------------------------------------------------------
  SP_PANE = 1;
  {$EXTERNALSYM SP_PANE}
  SP_GRIPPERPANE = 2;
  {$EXTERNALSYM SP_GRIPPERPANE}
  SP_GRIPPER = 3;
  {$EXTERNALSYM SP_GRIPPER}

//---------------------------------------------------------------------------------------
//   "Menu" Parts & States
//---------------------------------------------------------------------------------------

  MP_MENUITEM = 1;
  {$EXTERNALSYM MP_MENUITEM}
  MP_MENUDROPDOWN = 2;
  {$EXTERNALSYM MP_MENUDROPDOWN}
  MP_MENUBARITEM = 3;
  {$EXTERNALSYM MP_MENUBARITEM}
  MP_MENUBARDROPDOWN = 4;
  {$EXTERNALSYM MP_MENUBARDROPDOWN}
  MP_CHEVRON = 5;
  {$EXTERNALSYM MP_CHEVRON}
  MP_SEPARATOR = 6;
  {$EXTERNALSYM MP_SEPARATOR}

  MS_NORMAL = 1;
  {$EXTERNALSYM MS_NORMAL}
  MS_SELECTED = 2;
  {$EXTERNALSYM MS_SELECTED}
  MS_DEMOTED = 3;
  {$EXTERNALSYM MS_DEMOTED}

//---------------------------------------------------------------------------------------
//   "ListView" Parts & States
//---------------------------------------------------------------------------------------

  LVP_LISTITEM = 1;
  {$EXTERNALSYM LVP_LISTITEM}
  LVP_LISTGROUP = 2;
  {$EXTERNALSYM LVP_LISTGROUP}
  LVP_LISTDETAIL = 3;
  {$EXTERNALSYM LVP_LISTDETAIL}
  LVP_LISTSORTEDDETAIL = 4;
  {$EXTERNALSYM LVP_LISTSORTEDDETAIL}
  LVP_EMPTYTEXT = 5;
  {$EXTERNALSYM LVP_EMPTYTEXT}

  LIS_NORMAL = 1;
  {$EXTERNALSYM LIS_NORMAL}
  LIS_HOT = 2;
  {$EXTERNALSYM LIS_HOT}
  LIS_SELECTED = 3;
  {$EXTERNALSYM LIS_SELECTED}
  LIS_DISABLED = 4;
  {$EXTERNALSYM LIS_DISABLED}
  LIS_SELECTEDNOTFOCUS = 5;
  {$EXTERNALSYM LIS_SELECTEDNOTFOCUS}

//---------------------------------------------------------------------------------------
//   "Header" Parts & States
//---------------------------------------------------------------------------------------
  HP_HEADERITEM = 1;
  {$EXTERNALSYM HP_HEADERITEM}
  HP_HEADERITEMLEFT = 2;
  {$EXTERNALSYM HP_HEADERITEMLEFT}
  HP_HEADERITEMRIGHT = 3;
  {$EXTERNALSYM HP_HEADERITEMRIGHT}
  HP_HEADERSORTARROW = 4;
  {$EXTERNALSYM HP_HEADERSORTARROW}

  HIS_NORMAL = 1;
  {$EXTERNALSYM HIS_NORMAL}
  HIS_HOT = 2;
  {$EXTERNALSYM HIS_HOT}
  HIS_PRESSED = 3;
  {$EXTERNALSYM HIS_PRESSED}

  HILS_NORMAL = 1;
  {$EXTERNALSYM HILS_NORMAL}
  HILS_HOT = 2;
  {$EXTERNALSYM HILS_HOT}
  HILS_PRESSED = 3;
  {$EXTERNALSYM HILS_PRESSED}

  HIRS_NORMAL = 1;
  {$EXTERNALSYM HIRS_NORMAL}
  HIRS_HOT = 2;
  {$EXTERNALSYM HIRS_HOT}
  HIRS_PRESSED = 3;
  {$EXTERNALSYM HIRS_PRESSED}

  HSAS_SORTEDUP = 1;
  {$EXTERNALSYM HSAS_SORTEDUP}
  HSAS_SORTEDDOWN = 2;
  {$EXTERNALSYM HSAS_SORTEDDOWN}

//---------------------------------------------------------------------------------------
//   "Progress" Parts & States
//---------------------------------------------------------------------------------------
  PP_BAR = 1;
  {$EXTERNALSYM PP_BAR}
  PP_BARVERT = 2;
  {$EXTERNALSYM PP_BARVERT}
  PP_CHUNK = 3;
  {$EXTERNALSYM PP_CHUNK}
  PP_CHUNKVERT = 4;
  {$EXTERNALSYM PP_CHUNKVERT}

//---------------------------------------------------------------------------------------
//   "Tab" Parts & States
//---------------------------------------------------------------------------------------

  TABP_TABITEM = 1;
  {$EXTERNALSYM TABP_TABITEM}
  TABP_TABITEMLEFTEDGE = 2;
  {$EXTERNALSYM TABP_TABITEMLEFTEDGE}
  TABP_TABITEMRIGHTEDGE = 3;
  {$EXTERNALSYM TABP_TABITEMRIGHTEDGE}
  TABP_TABITEMBOTHEDGE = 4;
  {$EXTERNALSYM TABP_TABITEMBOTHEDGE}
  TABP_TOPTABITEM = 5;
  {$EXTERNALSYM TABP_TOPTABITEM}
  TABP_TOPTABITEMLEFTEDGE = 6;
  {$EXTERNALSYM TABP_TOPTABITEMLEFTEDGE}
  TABP_TOPTABITEMRIGHTEDGE = 7;
  {$EXTERNALSYM TABP_TOPTABITEMRIGHTEDGE}
  TABP_TOPTABITEMBOTHEDGE = 8;
  {$EXTERNALSYM TABP_TOPTABITEMBOTHEDGE}
  TABP_PANE = 9;
  {$EXTERNALSYM TABP_PANE}
  TABP_BODY = 10;
  {$EXTERNALSYM TABP_BODY}

  TIS_NORMAL = 1;
  {$EXTERNALSYM TIS_NORMAL}
  TIS_HOT = 2;
  {$EXTERNALSYM TIS_HOT}
  TIS_SELECTED = 3;
  {$EXTERNALSYM TIS_SELECTED}
  TIS_DISABLED = 4;
  {$EXTERNALSYM TIS_DISABLED}
  TIS_FOCUSED = 5;
  {$EXTERNALSYM TIS_FOCUSED}

  TILES_NORMAL = 1;
  {$EXTERNALSYM TILES_NORMAL}
  TILES_HOT = 2;
  {$EXTERNALSYM TILES_HOT}
  TILES_SELECTED = 3;
  {$EXTERNALSYM TILES_SELECTED}
  TILES_DISABLED = 4;
  {$EXTERNALSYM TILES_DISABLED}
  TILES_FOCUSED = 5;
  {$EXTERNALSYM TILES_FOCUSED}

  TIRES_NORMAL = 1;
  {$EXTERNALSYM TIRES_NORMAL}
  TIRES_HOT = 2;
  {$EXTERNALSYM TIRES_HOT}
  TIRES_SELECTED = 3;
  {$EXTERNALSYM TIRES_SELECTED}
  TIRES_DISABLED = 4;
  {$EXTERNALSYM TIRES_DISABLED}
  TIRES_FOCUSED = 5;
  {$EXTERNALSYM TIRES_FOCUSED}

  TIBES_NORMAL = 1;
  {$EXTERNALSYM TIBES_NORMAL}
  TIBES_HOT = 2;
  {$EXTERNALSYM TIBES_HOT}
  TIBES_SELECTED = 3;
  {$EXTERNALSYM TIBES_SELECTED}
  TIBES_DISABLED = 4;
  {$EXTERNALSYM TIBES_DISABLED}
  TIBES_FOCUSED = 5;
  {$EXTERNALSYM TIBES_FOCUSED}

  TTIS_NORMAL = 1;
  {$EXTERNALSYM TTIS_NORMAL}
  TTIS_HOT = 2;
  {$EXTERNALSYM TTIS_HOT}
  TTIS_SELECTED = 3;
  {$EXTERNALSYM TTIS_SELECTED}
  TTIS_DISABLED = 4;
  {$EXTERNALSYM TTIS_DISABLED}
  TTIS_FOCUSED = 5;
  {$EXTERNALSYM TTIS_FOCUSED}

  TTILES_NORMAL = 1;
  {$EXTERNALSYM TTILES_NORMAL}
  TTILES_HOT = 2;
  {$EXTERNALSYM TTILES_HOT}
  TTILES_SELECTED = 3;
  {$EXTERNALSYM TTILES_SELECTED}
  TTILES_DISABLED = 4;
  {$EXTERNALSYM TTILES_DISABLED}
  TTILES_FOCUSED = 5;
  {$EXTERNALSYM TTILES_FOCUSED}

  TTIRES_NORMAL = 1;
  {$EXTERNALSYM TTIRES_NORMAL}
  TTIRES_HOT = 2;
  {$EXTERNALSYM TTIRES_HOT}
  TTIRES_SELECTED = 3;
  {$EXTERNALSYM TTIRES_SELECTED}
  TTIRES_DISABLED = 4;
  {$EXTERNALSYM TTIRES_DISABLED}
  TTIRES_FOCUSED = 5;
  {$EXTERNALSYM TTIRES_FOCUSED}

  TTIBES_NORMAL = 1;
  {$EXTERNALSYM TTIBES_NORMAL}
  TTIBES_HOT = 2;
  {$EXTE@GetThemeString := GetProcAddress(DLLHandle,'GetThemeString');
    Assert(@GetThemeString <> nil);

    @GetThemeBool := GetProcAddress(DLLHandle,'GetThemeBool');
    Assert(@GetThemeBool <> nil);

    @GetThemeInt := GetProcAddress(DLLHandle,'GetThemeInt');
    Assert(@GetThemeInt <> nil);

    @GetThemeEnumValue := GetProcAddress(DLLHandle,'GetThemeEnumValue');
    Assert(@GetThemeEnumValue <> nil);

    @GetThemePosition := GetProcAddress(DLLHandle,'GetThemePosition');
    Assert(@GetThemePosition <> nil);

    @GetThemeFont := GetProcAddress(DLLHandle,'GetThemeFont');
    Assert(@GetThemeFont <> nil);

    @GetThemeRect := GetProcAddress(DLLHandle,'GetThemeRect');
    Assert(@GetThemeRect <> nil);

    @GetThemeMargins := GetProcAddress(DLLHandle,'GetThemeMargins');
    Assert(@GetThemeMargins <> nil);

    @GetThemeIntList := GetProcAddress(DLLHandle,'GetThemeIntList');
    Assert(@GetThemeIntList <> nil);

    @SetWindowTheme := GetProcAddress(DLLHandle,'SetWindowTheme');
    Assert(@SetWindowTheme <> nil);

    @GetThemeFilename := GetProcAddress(DLLHandle,'GetThemeFilename');
    Assert(@GetThemeFilename <> nil);

    @GetThemeSysColor := GetProcAddress(DLLHandle,'GetThemeSysColor');
    Assert(@GetThemeSysColor <> nil);

    @GetThemeSysColorBrush := GetProcAddress(DLLHandle,'GetThemeSysColorBrush');
    Assert(@GetThemeSysColorBrush <> nil);

    @GetThemeSysBool := GetProcAddress(DLLHandle,'GetThemeSysBool');
    Assert(@GetThemeSysBool <> nil);

    @GetThemeSysSize := GetProcAddress(DLLHandle,'GetThemeSysSize');
    Assert(@GetThemeSysSize <> nil);

    @GetThemeSysFont := GetProcAddress(DLLHandle,'GetThemeSysFont');
    Assert(@GetThemeSysFont <> nil);

    @GetThemeSysString := GetProcAddress(DLLHandle,'GetThemeSysString');
    Assert(@GetThemeSysString <> nil);

    @GetThemeSysInt := GetProcAddress(DLLHandle,'GetThemeSysInt');
    Assert(@GetThemeSysInt <> nil);

    @IsThemeActive := GetProcAddress(DLLHandle,'IsThemeActive');
    Assert(@IsThemeActive <> nil);

    @IsAppThemed := GetProcAddress(DLLHandle,'IsAppThemed');
    Assert(@IsAppThemed <> nil);

    @GetWindowTheme := GetProcAddress(DLLHandle,'GetWindowTheme');
    Assert(@GetWindowTheme <> nil);

    @EnableThemeDialogTexture := GetProcAddress(DLLHandle,'EnableThemeDialogTexture');
    Assert(@EnableThemeDialogTexture <> nil);

    @IsThemeDialogTextureEnabled := GetProcAddress(DLLHandle,'IsThemeDialogTextureEnabled');
    Assert(@IsThemeDialogTextureEnabled <> nil);

    @GetThemeAppProperties := GetProcAddress(DLLHandle,'GetThemeAppProperties');
    Assert(@GetThemeAppProperties <> nil);

    @SetThemeAppProperties := GetProcAddress(DLLHandle,'SetThemeAppProperties');
    Assert(@SetThemeAppProperties <> nil);

    @GetCurrentThemeName := GetProcAddress(DLLHandle,'GetCurrentThemeName');
    Assert(@GetCurrentThemeName <> nil);

    @GetThemeDocumentationProperty := GetProcAddress(DLLHandle,'GetThemeDocumentationProperty');
    Assert(@GetThemeDocumentationProperty <> nil);

    @DrawThemeParentBackground := GetProcAddress(DLLHandle,'DrawThemeParentBackground');
    Assert(@DrawThemeParentBackground <> nil);

    @EnableTheming := GetProcAddress(DLLHandle,'EnableTheming');
    Assert(@EnableTheming <> nil);
  end
  else
  begin
    DLLLoaded := False;
    { Error: UXTHEME.DLL could not be loaded !! }
  end;

end;

initialization
  LoadDLL;
  
finalization
  UnLoadDLL;

end.





    
