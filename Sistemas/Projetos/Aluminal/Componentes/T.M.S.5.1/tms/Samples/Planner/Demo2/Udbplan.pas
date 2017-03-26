{*******************************************************************}
{ TDBPLANNER component demo application                             }
{ version 2.0                                                       }
{                                                                   }
{ written by TMS Software                                           }
{            copyright � 2001 - 2004                                }
{            Email : info@tmssoftware.com                           }
{            Web : http://www.tmssoftware.com                       }
{*******************************************************************}

unit Udbplan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBPlanner, Planner, Db, DBTables, Grids, DBGrids, ComObj, StdCtrls, ActiveX,
  ExtCtrls, DBCtrls, Menus, ImgList, Mask, ComCtrls, Spin;

type
  TForm1 = class(TForm)
    DBPlanner1: TDBPlanner;
    DBDaySource1: TDBDaySource;
    PlannerTable: TTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBDaySource2: TDBDaySource;
    DBPlanner2: TDBPlanner;
    ItemPopup: TPopupMenu;
    Color1: TMenuItem;
    Caption1: TMenuItem;
    ColorDialog1: TColorDialog;
    ImageList1: TImageList;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBMemo1: TDBMemo;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MonthCalendar1: TMonthCalendar;
    Label5: TLabel;
    DoFilter: TCheckBox;
    Button1: TButton;
    Edit1: TEdit;
    Label6: TLabel;
    SpinEdit1: TSpinEdit;
    Label7: TLabel;
    procedure DBPlanner1ItemInsert(Sender: TObject; Position, FromSel,
      FromSelPrecise, ToSel, ToSelPrecise: Integer);
    procedure DBPlanner1ItemDelete(Sender: TObject; Item: TPlannerItem);
    procedure PlannerTableAfterDelete(DataSet: TDataSet);
    procedure DBDaySource1FieldsToItem(Sender: TObject; Fields: TFields;
      Item: TPlannerItem);
    procedure Color1Click(Sender: TObject);
    procedure DBDaySource1ItemToFields(Sender: TObject; Fields: TFields;
      Item: TPlannerItem);
    procedure DBPlanner1ItemPopupPrepare(Sender: TObject;
      PopupMenu: TPopupMenu; Item: TPlannerItem);
    procedure Caption1Click(Sender: TObject);
    procedure DBPlanner1ItemImageClick(Sender: TObject; Item: TPlannerItem;
      ImageIndex: Integer);
    procedure DBPlanner1PlannerNext(Sender: TObject);
    procedure DBPlanner1PlannerPrev(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MonthCalendar1Click(Sender: TObject);
    procedure DBDaySource1SetFilter(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateHeaders;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.DBPlanner1ItemInsert(Sender: TObject; Position, FromSel,
  FromSelPrecise, ToSel, ToSelPrecise: Integer);
begin
  { creates an item in the planner at the selected cells which is automatically
    propagated to the database
    All planner item settings are taken from the Planner.DefaultItem properties.
    After changing properties of the planner item, it is necessary to call the
    item's Update method to make sure that changes are propagated to the database
  }
  with DBPlanner1.CreateItemAtSelection do
  begin
    Text.Text:='Item created at runtime on '+Formatdatetime('hh:nn dd/mm/yyyy',Now);
    Update;
  end;
end;

procedure TForm1.DBPlanner1ItemDelete(Sender: TObject; Item: TPlannerItem);
begin
  { the Planner.FreeItem call removes the item from the planner and deletes
    its entry from the database
  }
  DBPlanner1.FreeItem(Item);
end;

procedure TForm1.PlannerTableAfterDelete(DataSet: TDataSet);
begin
  { When a record is deleted from the database from another place than the
    planner itself, the planner must be notified and the items must be
    re-synchronized to reflect the changes. This is achieved through the
    SynchDBItems method
    Note that changes to records from other DB-aware controls are automatically
    reflected in the Planner Items.
   }
  DBDaySource1.SynchDBItems;
  DBDaySource2.SynchDBItems;
end;

procedure TForm1.DBDaySource1FieldsToItem(Sender: TObject; Fields: TFields;
  Item: TPlannerItem);
begin
   { The FieldsToItem event is called when records are read from the database
     and extra properties are set from database fields. With this code, any
     field from the database can be connected in a custom way to planner item
     properties.
   }
   Item.Color := TColor(Fields.FieldByName('COLOR').AsInteger);
   Item.CaptionBkg := Item.Color;
   Item.ImageID := Fields.FieldByName('IMAGE').AsInteger;
   if Fields.FieldByName('CAPTION').AsBoolean then
     Item.CaptionType := ctTime
   else
     Item.CaptionType := ctNone;
end;

procedure TForm1.Color1Click(Sender: TObject);
begin
  { Sets the planner item color }
  ColorDialog1.Color := DBPlanner1.PopupPlannerItem.Color;
  if ColorDialog1.Execute then
  begin
    DBPlanner1.PopupPlannerItem.Color := ColorDialog1.Color;
    DBPlanner1.PopupPlannerItem.CaptionBkg := ColorDialog1.Color;
    DBPlanner1.PopupPlannerItem.Update;
  end;
end;

procedure TForm1.DBDaySource1ItemToFields(Sender: TObject; Fields: TFields;
  Item: TPlannerItem);
begin
   { The ItemToFields event is called when items are written to the database
     and extra properties are stored in database fields. With this code, any
     property of the item can be saved into any field of the database in
     a custom way to be retrieved later with the inverse event FieldsToItem
   }

  Fields.FieldByName('COLOR').AsInteger := Integer(Item.Color);
  Fields.FieldByName('CAPTION').AsBoolean := Item.CaptionType = ctTime;
  Fields.FieldByName('IMAGE').AsInteger := Item.ImageID;
end;

procedure TForm1.DBPlanner1ItemPopupPrepare(Sender: TObject;
  PopupMenu: TPopupMenu; Item: TPlannerItem);
begin
   { Event is called before the popup menu for a planner item is displayed.
     With this event, the popup menu state can be set according the the
     planner item properties.
   }

  ItemPopup.Items[1].Checked := Item.CaptionType = ctTime;
end;

procedure TForm1.Caption1Click(Sender: TObject);
begin
  if DBPlanner1.PopupPlannerItem.CaptionType = ctTime then
    DBPlanner1.PopupPlannerItem.CaptionType := ctNone
  else
    DBPlanner1.PopupPlannerItem.CaptionType := ctTime;

  DBPlanner1.PopupPlannerItem.Update;
end;

procedure TForm1.DBPlanner1ItemImageClick(Sender: TObject;
  Item: TPlannerItem; ImageIndex: Integer);
begin
  if Item.ImageID < 5 then
    Item.ImageID := Item.ImageID + 1
  else
    Item.ImageID := 0;

  Item.Update;
end;

procedure TForm1.DBPlanner1PlannerNext(Sender: TObject);
begin
  { Update the planner headers to set the date shown }
  UpdateHeaders;
  MonthCalendar1.Date := DBDaySource1.Day;
end;

procedure TForm1.DBPlanner1PlannerPrev(Sender: TObject);
begin
  { Update the planner headers to set the date shown }
  UpdateHeaders;
  MonthCalendar1.Date := DBDaySource1.Day;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PlannerTable.DatabaseName := GetCurrentDir;
  PlannerTable.TableName := 'plandb.db';

  DBDaySource1.Day := EncodeDate(2001,3,14);
  DBDaySource2.Day := EncodeDate(2001,3,14);
  MonthCalendar1.Date := EncodeDate(2001,3,14);

  PlannerTable.Active := true;
  UpdateHeaders;
end;

procedure TForm1.UpdateHeaders;
var
  i:integer;
begin
  DBPlanner1.Header.Captions.Clear;
  DBPlanner1.Header.Captions.Add('');
  for i := 1 to DBPlanner1.Positions  do
  begin
    DBPlanner1.Header.Captions.Add(FormatDateTime('dd/mm/yyyy',DBDaySource1.Day + i - 1 ));
  end;
end;

procedure TForm1.MonthCalendar1Click(Sender: TObject);
begin
  DBDaySource1.Day := MonthCalendar1.Date;
  DBDaySource2.Day := MonthCalendar1.Date;  
  UpdateHeaders;
end;

procedure TForm1.DBDaySource1SetFilter(Sender: TObject);
var
  sd1,sd2:string;
begin
  { Before the planner needs to be reloaded with records from the database
    a custom filter can be applied to minimize the nr. of records the planner
    must check to load into the planner.
  }
  sd1 := DateToStr(DBDaySource1.Day);
  sd1 := #39+sd1+#39;

  sd2 := DateToStr(DBDaySource1.Day+7);
  sd2 := #39+sd2+#39;

  PlannerTable.Filter:=  'STARTTIME > '+sd1+' AND ENDTIME < '+sd2;
  PlannerTable.Filtered := DoFilter.Checked;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 dt1,dt2:tdatetime;
 key:string;
 plIt: TPlannerItem;
begin
  if DBDaySource1.LocateFirstItem('*'+edit1.text+'*',[fnMatchRegular,fnText,fnCaptionText],dt1,dt2,key) then
  begin
    DBDaySource1.Day := dt1;
    MonthCalendar1.Date := dt1;
    plIt := DBPlanner1.Items.FindKey(key);

    if Assigned(plIt) then
    begin
      plIt.Selected := true;
      plIt.Focus := true;
    end;

    if MessageDlg('Search next ?', mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      while DBDaySource1.LocateNextItem(dt1,dt2,key) do
      begin
        DBDaySource1.Day := dt1;
        MonthCalendar1.Date := dt1;
        plIt := DBPlanner1.Items.FindKey(key);

        if Assigned(plIt) then
        begin
          plIt.Selected := true;
          plIt.Focus := true;
        end;

        if MessageDlg('Search next ?', mtConfirmation,[mbYes,mbNo],0) = mrNo then
          Break;
      end;

    end;

  end;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  DBDaySource1.NumberOfDays := SpinEdit1.Value;
end;

end.
