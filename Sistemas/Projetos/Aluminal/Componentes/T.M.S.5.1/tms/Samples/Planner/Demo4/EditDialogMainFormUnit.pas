{***********************************************************************}
{ TPlanner component demo application                                   }
{ for Delphi 3.0,4.0,5.0,6.0 & C++Builder 3.0,4.0,5.0,6.0               }
{ version 1.6, July 2002                                                }
{                                                                       }
{ written by TMS Software                                               }
{            copyright © 1999-2002                                      }
{            Email: info@tmssoftware.com                                }
{            Web: http://www.tmssoftware.com                            }
{***********************************************************************}

unit EditDialogMainFormUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Planner, DBPlanner, PlanSimpleEdit, PlanItemEdit, ImgList,
  StdCtrls, ExtCtrls, PlanPeriodEdit;

{ This demo shows you how to bind use an Editor component for a PlannerItem

  You always have to drop a SimpleItemEditor, PeriodItemEditor or
  DefaultItemEditor on the form, and connect it to the Editor
  property of any PlannerItem.

  This way, when you click twice on any PlannerItem at run-time,
  the corresponding Editor will show its editing dialog.

  This method does not require any coding on your part.

  In addition, with a little coding, you can also call the Editor directly.
  This can for instance be done using a PopupMenu that has a MenuItem
  called 'Edit1'.
  The Edit1Click event method, should then call 'Planner.PopupPlannerItem.Edit'
  and you are done!

}

type
  TEditDialogMainForm = class(TForm)
    PopupMenu1: TPopupMenu;
    Edit1: TMenuItem;
    Planner: TPlanner;
    DefaultItemEditor1: TDefaultItemEditor;
    SimpleItemEditor1: TSimpleItemEditor;
    ImageList1: TImageList;
    Panel1: TPanel;
    OrientationRadioGroup: TRadioGroup;
    PeriodItemEditor1: TPeriodItemEditor;
    procedure Edit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OrientationRadioGroupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditDialogMainForm: TEditDialogMainForm;

implementation

{$R *.dfm}

procedure TEditDialogMainForm.Edit1Click(Sender: TObject);
begin
  Planner.PopupPlannerItem.Edit;
end;

procedure TEditDialogMainForm.FormCreate(Sender: TObject);
begin
  OrientationRadioGroup.ItemIndex := Ord(Planner.Sidebar.Position);
end;

procedure TEditDialogMainForm.OrientationRadioGroupClick(Sender: TObject);
begin
  Planner.Sidebar.Position := TSideBarPosition(OrientationRadioGroup.ItemIndex);
end;

end.
