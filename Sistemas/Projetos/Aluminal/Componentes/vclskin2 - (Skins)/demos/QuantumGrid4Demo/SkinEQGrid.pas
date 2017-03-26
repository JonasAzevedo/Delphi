unit SkinEQGrid;

interface

uses Classes,Controls,Graphics,
     WinSkinData,winsubclass,
     cxStyles,cxControls,cxEdit, cxGridCustomView, cxGrid,
     cxGridTableView,cxDropDownEdit,cxCheckBox;

type
TmyGridTableViewAccess = class(TcxGridTableView);
TmycxCustomEdit = class(TcxCustomEdit);

procedure InitStyle(SD:Tskindata);
procedure DoSkinControl(
  Sender: TComponent; SkinData: TSkinData; Form, Control: TControl;
  ControlClass: String; var SkinnedControl: TComponent);
procedure DoSkinChanged(Sender: TObject);

var skinstyle:TcxStyle;
    SData:Tskindata;

implementation

//Replace cxgrid styles with skinstyle
procedure DoSkinControl(
  Sender: TComponent; SkinData: TSkinData; Form, Control: TControl;
  ControlClass: String; var SkinnedControl: TComponent);
var cxgrid:TcxCustomGrid;
    i:integer;
    Styles: TcxGridTableViewStyles;
begin
   if control is TcxCustomGrid then begin
     cxgrid:=TcxCustomGrid(control);
     for i:= 0 to cxgrid.ViewCount-1 do begin
       if cxgrid.Views[i] is TcxGridTableView then begin
          Styles:=TcxGridTableViewStyles(TmyGridTableViewAccess(cxgrid.Views[i]).Styles);
          Styles.Header:=skinstyle;
          styles.Indicator:=skinstyle;
          styles.Footer:=skinstyle;
//          styles.GroupByBox:=skinstyle;
//          styles.FilterBox:=skinstyle;
       end;
     end;
   end
   else if control is TcxCustomDropDownEdit then begin
      TmycxCustomEdit(control).style.borderstyle:=   ebsflat;
      SkinnedControl:=Tskincombox.create(control);
   end
   else if control is TcxCustomCheckBox then begin
      TcxCustomCheckBox(control).style.TransparentBorder:= false;
   end;
end;

procedure DoSkinChanged(Sender: TObject);
begin
  if sdata.active then
    skinstyle.Color:=sdata.colors[csButtonFace]
  else
    skinstyle.Color:=clbtnface;
end;

procedure InitStyle(SD:Tskindata);
begin
   sdata:=sd;
   skinstyle:=TcxStyle.create(sd.Owner);
   skinstyle.Color:=sd.colors[csButtonFace];
end;

end.
