{***************************************************************************}
{ TAdvStringGrid demo application                                           }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2009                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{***************************************************************************}

unit Uasg26;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ESBPCSPanel, ESBPCSSpinEdit, ESBPCSDateTimeSpinEdit, Grids,
  AdvGrid, StdCtrls, ESBPCSEdit, ESBPCSNumEdit, esblinks, ESBPCSCurrEdit,
  ESBPCSDateTimeEdit, ESBPCSComplexEdit, ESBPCSFractionEdit,
  ESBPCSDateTimeComboBox, ESBPCSComboBox, ESBPCSCurrComboBox,
  ESBPCSCountryComboBox, JPMEFontComboBox, JPMEColorComboBox, jpmelinks,
  BaseGrid, ESBPCSCalcEdit, ESBPCSEdit2, ESBPCSDbSpinEdit, ESBPCSCalEdit,
  ESBPCSBtnEdit, ESBPCSCountries, ESBPCSCheckBox;

type

  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    AdvStringGrid2: TAdvStringGrid;
    elb8: TJPMEColorComboBoxEditLink;
    elb7: TJPMEFontComboBoxEditLink;
    elb1: TESBPCSEditLink;
    elb2: TESBPosEditLink;
    elb3: TESBIntEditLink;
    elb4: TESBFloatEditLink;
    elb5: TESBPercentEditLink;
    elb6: TESBIPEditLink;
    elb9: TESBSuperEditLink;
    elb10: TESBLookUpComboBoxEditLink;
    el2: TESBYearSpinEditLink;
    el3: TESBMonthSpinEditLink;
    el4: TESBDOWSpinEditLink;
    el5: TESBMonthComboBoxEditLink;
    el6: TESBDowComboBoxEditLink;
    el7: TESBTZComboBoxEditLink;
    el8: TESBEMUComboBoxEditLink;
    el9: TESBCountryComboBoxEditLink;
    el1: TESBIntSpinEditLink;

    procedure AdvStringGrid1GetEditorType(Sender: TObject; aCol,
      aRow: Integer; var aEditor: TEditorType);
    procedure AdvStringGrid2GetEditorType(Sender: TObject; aCol,
      aRow: Integer; var aEditor: TEditorType);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.AdvStringGrid1GetEditorType(Sender: TObject; aCol,
  aRow: Integer; var aEditor: TEditorType);
begin
  case acol of
    2: advstringgrid1.EditLink := el1;
    3: advstringgrid1.EditLink := el2;
    4: advstringgrid1.EditLink := el3;
    5: advstringgrid1.EditLink := el4;
    6: advstringgrid1.EditLink := el5;
    7: advstringgrid1.EditLink := el6;
    8: advstringgrid1.EditLink := el7;
    9: advstringgrid1.EditLink := el8;
    10: advstringgrid1.EditLink := el9;
  end;
  if (acol in [2..10]) then aEditor := edCustom;
end;


procedure TForm1.AdvStringGrid2GetEditorType(Sender: TObject; aCol,
  aRow: Integer; var aEditor: TEditorType);
begin
  case acol of
    2: advstringgrid2.EditLink := elb1;
    3: advstringgrid2.EditLink := elb2;
    4: advstringgrid2.EditLink := elb3;
    5: advstringgrid2.EditLink := elb4;
    6: advstringgrid2.EditLink := elb5;
    7: advstringgrid2.EditLink := elb6;
    8: advstringgrid2.EditLink := elb7;
    9: advstringgrid2.EditLink := elb8;
    10: advstringgrid2.EditLink := elb9;
    11: advstringgrid2.EditLink := elb10;
  end;
  if (acol in [2..12]) then aEditor := edCustom;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ReadCountryList(ESBCountryList, 'esbcountry.xml');
end;


end.
