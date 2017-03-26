{*************************************************************************}
{ TAdvSmoothComboBox component                                            }
{ for Delphi & C++Builder                                                 }
{                                                                         }
{ written by TMS Software                                                 }
{           copyright � 2009                                              }
{           Email : info@tmssoftware.com                                  }
{           Website : http://www.tmssoftware.com/                         }
{                                                                         }
{ The source code is given as is. The author is not responsible           }
{ for any possible damage done due to the use of this code.               }
{ The component can be freely used in any application. The complete       }
{ source code remains property of the author and may not be distributed,  }
{ published, given or sold in any form as such. No parts of the source    }
{ code can be included in any other component or application without      }
{ written authorization of the author.                                    }
{*************************************************************************}
unit AdvSmoothComboBox;

{$I TMSDEFS.INC}

interface

uses
  Classes, Graphics, Forms, Controls, Windows, GDIPFill, AdvSmoothGDIP, AdvSmoothListBox,
  AdvStyleIf, SysUtils, Messages, ExtCtrls, Math;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 2; // Build nr.

  // v1.0.0.0 : First Release
  // v1.0.0.1 : Fixed : Issue with font creation in Delphi7
  // v1.0.0.2 : Fixed : OnItemSelected event issue with VK_F4 key and after dropdown

type
  TAdvSmoothComboBox = class;

  TAdvSmoothComboBoxButtonState = (bsDown, bsUp, bsHover);

  TAdvSmoothComboBoxButtonAppearance = class(TPersistent)
  private
    FButtonState: TAdvSmoothComboBoxButtonState;
    FButtonWidth: integer;
    FOnChange: TNotifyEvent;
    FFill: TGDIPFill;
    FFillDown: TGDIPFill;
    FFillHover: TGDIPFill;
    procedure SetButtonWidth(const Value: integer);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetFillDown(const Value: TGDIPFill);
    procedure SetFillHover(const Value: TGDIPFill);
  protected
    procedure Changed;
    procedure FillChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvSmoothComboBox);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Width: integer read FButtonWidth write SetButtonWidth default 30;
    property Fill: TGDIPFill read FFill write SetFill;
    property FillDown: TGDIPFill read FFillDown write SetFillDown;
    property FillHover: TGDIPFill read FFillHover write SetFillHover;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothComboBox = class(TAdvSmoothListBox)
  private
    FTimerCount: integer;
    FLookupKey: String;
    FFocused, FMouseDown: Boolean;
    FClickY, FClickX: integer;
    FListBoxMouseDown, FListBoxMouseMoved, FDesignTime, FConstructed: Boolean;
    CancelThisBtnClick : Boolean;
    FTimer: TTimer;
    FDeactivating: boolean;
    LstParent : TForm;
    FFill: TGDIPFill;
    FListBox: TAdvSmoothListBox;
    FSelectedItemIndex: integer;
    FButtonAppearance: TAdvSmoothComboBoxButtonAppearance;
    FAutoHeight: Boolean;
    FDropDownHeight: integer;
    FDropDownWidth: integer;
    FOnCloseUp: TNotifyEvent;
    FOnDropDown: TNotifyEvent;
    procedure SetFill(const Value: TGDIPFill);
    procedure SetSelectedItemIndex(const Value: integer);
    procedure SetButtonAppearance(
      const Value: TAdvSmoothComboBoxButtonAppearance);
    procedure HideParent;
    function GetParentEx: TWinControl;
    procedure SetParentEx(const Value: TWinControl);
    procedure SetAutoHeight(const Value: Boolean);
    procedure SetDropDownHeight(const Value: integer);
    procedure SetDropDownWidth(const Value: integer);
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignCombo(Source: TPersistent);
    procedure Paint; override;
    procedure DropDown; virtual;
    property Parent: TWinControl read GetParentEx write SetParentEx;
    procedure CancelBtnClick;
    procedure CreateWnd; override;
    procedure Resize; override;
    procedure SetComponentStyle(AStyle: TTMSStyle); override;
  protected
    procedure Changed;
    procedure FillChanged(Sender: TObject);
    procedure ButtonAppearanceChanged(Sender: TObject);
    procedure DrawBackGround;
    procedure DrawButton;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: char); override;
    procedure DoButtonClick;
    procedure LstParentDeactivate(Sender: TObject);
    function InsideRect: TRect;
    function GetItemRectangle: TRect;
    function GetButtonRectangle: TRect;
    procedure TimerEvent(Sender: TObject);
    procedure ItemAppearanceChanged(Sender: TObject); override;
    function GetVersionNr: Integer; override;
    procedure DoGraphicMouseDown(X, Y: integer);
    procedure DoGraphicMouseUp(X, Y: integer);
    //Assign listbox events
    procedure ItemChanged(Sender: TObject; itemindex: integer);
    procedure ListBoxItemChanged(Sender: TObject; itemindex: integer);
    procedure ListBoxMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ListBoxMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ListBoxMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ListBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListBoxKeyPress(Sender: TObject; var Key: Char);
    procedure ListBoxItemClick(Sender: TObject; itemindex: integer);
    procedure ListBoxItemSelected(Sender: TObject; itemindex: integer);
    procedure ListBoxItemSelectionChanged(Sender: TObject; previousitemindex, itemindex: integer);
    procedure ListBoxItemChecked(Sender: TObject; itemindex: integer; checked: Boolean);
    procedure ListBoxItemRadioClick(Sender: TObject; itemindex: integer; checked: Boolean);
    procedure ListBoxItemImageClick(Sender: TObject; itemindex: integer);
    procedure ListBoxItemButtonClick(Sender: TObject; itemindex: integer);
    procedure ListBoxScroll(Sender: TObject; CurrentPosition, EndPosition: Double);
    procedure ListBoxShowDetail(Sender: TObject; itemindex: integer);
    procedure ListBoxHideDetail(Sender: TObject; itemindex: integer);
    procedure ListBoxItemText(Sender: TObject; itemindex: integer; var itemcaption: string; var iteminfo: String; var itemnotes: String);
    procedure ListBoxItemBkgDraw(Sender: TObject; Canvas: TCanvas; itemindex: integer; itemRect: TRect; var defaultdraw: Boolean);
    procedure ListBoxItemDraw(Sender: TObject; Canvas: TCanvas; itemindex: integer; itemRect: TRect; var defaultdraw: Boolean);
    procedure ListBoxAnchorClick(Sender: TObject; Anchor: String);
    procedure ListBoxItemAnchorClick(Sender: TObject; Anchor: String; itemindex: integer);
    procedure ListBoxItemCaptionClick(Sender: TObject; itemindex: integer);
    procedure ListBoxItemInfoClick(Sender: TObject; itemindex: integer);
    procedure ListBoxItemMouseLeave(Sender: TObject; itemindex: integer);
    procedure ListBoxItemMouseEnter(Sender: TObject; itemindex: integer);    
    procedure ListBoxLookUpClick(Sender: TObject; lookupindex: integer; lookupvalue: String);
    procedure ListBoxItemHint(Sender: TObject; itemindex: integer; var hint: string);
    procedure ListBoxFooterClick(Sender: TObject; X, Y: integer);
    procedure ListBoxHeaderClick(Sender: TObject; X, Y: integer);
    procedure ListBoxItemDragStart(Sender: TObject; DragItemIndex: integer; var allowdrag: Boolean);
    procedure ListBoxItemDragDrop(Sender: TObject; DragItemIndex, DropItemIndex: integer; var allowdrop: Boolean);
    procedure ListBoxItemDragEnd(Sender: TObject; DragItemIndex: integer);
    procedure ListBoxItemDragOver(Sender: TObject; DragItemIndex, DropItemIndex: integer);
    procedure ListBoxItemDblClick(Sender: TObject; itemindex: integer);
    {$IFDEF DELPHI2006_LVL}
    procedure ListBoxMouseActivate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; HitTest: Integer; var MouseActivate: TMouseActivate);
    procedure ListboxMouseEnter(Sender: TObject);
    procedure ListboxMouseLeave(Sender: TObject);
    {$ENDIF}
    procedure ListBoxEnter(Sender: TObject);
    procedure ListBoxExit(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
    procedure ListBoxDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBoxDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ListBoxStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure ListBoxEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ListBoxResize(Sender: TObject);
  published
    property ItemBackGroundFill: TGDIPFill read FFill write SetFill;
    property SelectedItemIndex: integer read FSelectedItemIndex write SetSelectedItemIndex default -1;
    property ButtonAppearance: TAdvSmoothComboBoxButtonAppearance read FButtonAppearance write SetButtonAppearance;
    property AutoHeight: Boolean read FAutoHeight write SetAutoHeight default true;
    property DropDownHeight: integer read FDropDownHeight write SetDropDownHeight default 350;
    property DropDownWidth: integer read FDropDownWidth write SetDropDownWidth default 250;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
  end;


implementation

{ TAdvSmoothComboBox }

procedure TAdvSmoothComboBox.Assign(Source: TPersistent);
begin
  inherited;
  AssignCombo(Source);
end;

procedure TAdvSmoothComboBox.AssignCombo(Source: TPersistent);
begin
  if (Source is TAdvSmoothComboBox) then
  begin
    FFill.Assign((Source as TAdvSmoothComboBox).Fill);
    FSelectedItemIndex := (Source as TAdvSmoothComboBox).SelectedItemIndex;
    FButtonAppearance.Assign((Source as TAdvSmoothComboBox).ButtonAppearance);
    FAutoHeight := (Source as TAdvSmoothComboBox).AutoHeight;
    Changed;
  end;
end;

procedure TAdvSmoothComboBox.ButtonAppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothComboBox.ListBoxAnchorClick(Sender: TObject;
  Anchor: String);
begin
  if Assigned(OnAnchorClick) then
    OnAnchorClick(Sender, Anchor);
end;

procedure TAdvSmoothComboBox.ListBoxClick(Sender: TObject);
begin
  if Assigned(OnClick) then
    OnClick(Sender);
end;

procedure TAdvSmoothComboBox.ListBoxDblClick(Sender: TObject);
begin
  if Assigned(OnDblClick) then
    OnDblClick(Sender);
end;

procedure TAdvSmoothComboBox.ListBoxItemDblClick(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(OnItemDblClick) then
    OnItemDblClick(Sender, itemindex);
end;

procedure TAdvSmoothComboBox.ListBoxShowDetail(Sender: TObject; itemindex: integer);
begin
  if Assigned(OnShowDetail) then
    OnShowDetail(Sender, itemindex);
end;

procedure TAdvSmoothComboBox.ListBoxStartDrag(Sender: TObject;
    var DragObject: TDragObject);
begin
  if Assigned(OnStartDrag) then
    OnStartDrag(Sender, DragObject);
end;

procedure TAdvSmoothComboBox.ListBoxFooterClick(Sender: TObject; X, Y: integer);
begin
  if Assigned(OnFooterClick) then
    OnFooterClick(Sender, X, Y);
end;

procedure TAdvSmoothComboBox.ListBoxHeaderClick(Sender: TObject; X, Y: integer);
begin
  if Assigned(OnHeaderClick) then
    OnHeaderClick(Sender, X, Y);
end;

procedure TAdvSmoothComboBox.ListBoxHideDetail(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(OnHideDetail) then
    OnHideDetail(Sender, itemindex);
end;

procedure TAdvSmoothComboBox.ListBoxItemAnchorClick(Sender: TObject;
  Anchor: String; itemindex: integer);
begin
  if Assigned(OnItemAnchorClick) then
    OnItemAnchorClick(Sender, Anchor, itemindex);
end;

procedure TAdvSmoothComboBox.ListBoxItemBkgDraw(Sender: TObject;
  Canvas: TCanvas; itemindex: integer; itemRect: TRect;
  var defaultdraw: Boolean);
begin
  if Assigned(OnItemBkgDraw) then
    OnItemBkgDraw(Sender, Canvas, itemindex, itemrect, defaultdraw);
end;

procedure TAdvSmoothComboBox.ListBoxItemButtonClick(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(OnItemButtonClick) then
    OnItemButtonClick(Sender, itemindex);
end;

procedure TAdvSmoothComboBox.ListBoxItemCaptionClick(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(OnItemCaptionClick) then
    OnItemCaptionClick(Sender, itemindex);
end;

procedure TAdvSmoothComboBox.ListBoxItemChanged(Sender: TObject; itemindex: integer);
begin
  if (itemindex >= 0) and (itemindex < FListBox.Items.Count) and (itemindex < Items.Count) then
  begin
    Items.BeginUpdate;
    Items[itemindex].CopySettings(FListBox.Items[itemindex]);
    Items.EndUpdate;    
    Changed;
  end;
end;

procedure TAdvSmoothComboBox.ListBoxItemChecked(Sender: TObject;
  itemindex: integer; checked: Boolean);
begin
  if Assigned(OnItemCheckClick) then
    OnItemCheckClick(Sender, itemindex, checked);
end;

procedure TAdvSmoothComboBox.ListBoxItemClick(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(OnItemClick) then
    OnItemClick(Sender, itemindex);
end;

procedure TAdvSmoothComboBox.ListBoxItemDragDrop(Sender: TObject; DragItemIndex,
  DropItemIndex: integer; var allowdrop: Boolean);
begin
  if Assigned(OnItemDragDrop) then
    OnItemDragDrop(Sender, DragItemIndex, DropItemIndex, AllowDrop);
end;

procedure TAdvSmoothComboBox.ListBoxItemDragEnd(Sender: TObject;
  DragItemIndex: integer);
begin
  if Assigned(OnItemDragEnd) then
    OnItemDragEnd(Sender, DragItemIndex);
end;

procedure TAdvSmoothComboBox.ListBoxItemDragOver(Sender: TObject; DragItemIndex,
  DropItemIndex: integer);
begin
  if Assigned(OnItemDragOver) then
    OnItemDragOver(Sender, DragItemIndex, DropItemIndex);
end;

procedure TAdvSmoothComboBox.ListBoxItemDragStart(Sender: TObject;
  DragItemIndex: integer; var allowdrag: Boolean);
begin
  if Assigned(OnItemDragStart) then
    OnItemDragStart(Sender, DragItemIndex, allowdrag);
end;

procedure TAdvSmoothComboBox.ListBoxItemDraw(Sender: TObject; Canvas: TCanvas;
  itemindex: integer; itemRect: TRect; var defaultdraw: Boolean);
begin
  if Assigned(OnItemDraw) then
    OnItemDraw(Sender, Canvas, itemindex, itemRect, defaultdraw);
end;

procedure TAdvSmoothComboBox.ListBoxItemHint(Sender: TObject;
  itemindex: integer; var hint: string);
begin
  if Assigned(OnItemHint) then
    OnItemHint(Sender, itemindex, hint);
end;

procedure TAdvSmoothComboBox.ListBoxItemImageClick(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(OnItemImageClick) then
    OnItemImageClick(Sender, itemindex);
end;

procedure TAdvSmoothComboBox.ListBoxItemInfoClick(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(OnItemInfoClick) then
    OnItemInfoClick(Sender, itemindex);
end;

procedure TAdvSmoothComboBox.ListBoxItemMouseEnter(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(OnItemMouseEnter) then
    OnItemMouseEnter(Sender, itemindex);
end;

procedure TAdvSmoothComboBox.ListBoxItemMouseLeave(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(OnItemMouseLeave) then
    OnItemMouseLeave(Sender, itemindex);
end;

procedure TAdvSmoothComboBox.ListBoxItemRadioClick(Sender: TObject;
  itemindex: integer; checked: Boolean);
begin
  if Assigned(OnItemRadioClick) then
    OnItemRadioClick(Sender, itemindex, checked);
end;

procedure TAdvSmoothComboBox.ListBoxItemSelected(Sender: TObject;
  itemindex: integer);
begin
  SelectedItemIndex := itemindex;
  if Assigned(OnItemSelected) then
    OnItemSelected(Sender, itemindex);
end;

procedure TAdvSmoothComboBox.ListBoxItemSelectionChanged(Sender: TObject;
  previousitemindex, itemindex: integer);
begin
  if Assigned(OnItemSelectionChanged) then
    OnItemSelectionChanged(Sender, previousitemindex, itemindex);
end;

procedure TAdvSmoothComboBox.ListBoxItemText(Sender: TObject;
  itemindex: integer; var itemcaption, iteminfo, itemnotes: String);
begin
  if Assigned(OnItemText) then
    OnItemText(Sender, itemindex, itemcaption, iteminfo, itemnotes);
end;

procedure TAdvSmoothComboBox.ListBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F4) then
  begin
    if LstParent.Visible then
      HideParent
    else
      DoButtonClick;
  end;

  if Assigned(OnKeyDown) then
    OnKeyDown(Sender, Key, Shift);
end;

procedure TAdvSmoothComboBox.ListBoxKeyPress(Sender: TObject; var Key: Char);
begin
  if Assigned(OnKeyPress) then
    OnKeyPress(Sender, Key);
end;

procedure TAdvSmoothComboBox.ListBoxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    HideParent;

  if Assigned(OnKeyUp) then
    OnKeyUp(Sender, Key, Shift);
end;

procedure TAdvSmoothComboBox.ListBoxLookUpClick(Sender: TObject;
  lookupindex: integer; lookupvalue: String);
begin
  if Assigned(OnLookUpClick) then
    OnLookUpClick(Sender, lookupindex, lookupvalue);
end;

procedure TAdvSmoothComboBox.ListBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  itemindex: integer;
begin
  FListBoxMouseMoved := false;
  FListBoxMouseDown := true;
  FClickX := X;
  FClickY := Y;
  itemindex := FListBox.ItemAtXY(X, Y);
  if (itemindex > -1) and (itemindex <= FListBox.Items.Count - 1) and FListBox.CheckSelection(x, Y) then
  begin
    FListBox.SelectedItemIndex := itemindex;
    FListBox.Invalidate;
  end;
  if Assigned(OnMouseDown) then
    OnMouseDown(Sender, Button, Shift, X, Y);
end;

{$IFDEF DELPHI2006_LVL}
procedure TAdvSmoothComboBox.ListBoxMouseActivate(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
begin
  if Assigned(OnMouseActivate) then
    OnMouseActivate(Sender, Button, Shift, X, Y, HitTest, MouseActivate);
end;

procedure TAdvSmoothComboBox.ListboxMouseEnter(Sender: TObject);
begin
  if Assigned(OnMouseEnter) then
    OnMouseEnter(Sender);
end;

procedure TAdvSmoothComboBox.ListboxMouseLeave(Sender: TObject);
begin
  if Assigned(OnMouseLeave) then
    OnMouseLeave(Sender);
end;
{$ENDIF}

procedure TAdvSmoothComboBox.ListBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if csDesigning in ComponentState then
    Exit;

  FListBoxMouseMoved := FListBoxMouseDown and ((X + 2 < FClickX) or (X - 2 > FClickX) or (Y + 2 < FClickY) or (Y - 2 > FClickY));
  if Assigned(OnMouseMove) then
    OnMouseMove(Sender, Shift, X, Y);
end;

procedure TAdvSmoothComboBox.ListBoxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not FListBoxMouseMoved and FListBox.CheckSelection(X, Y) then
  begin
    HideParent;
    FListBoxMouseDown := false;
  end;
  if Assigned(OnMouseUp) then
    OnMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TAdvSmoothComboBox.ListBoxResize(Sender: TObject);
begin
  if Assigned(OnResize) then
    OnResize(Sender);
end;

procedure TAdvSmoothComboBox.ListBoxScroll(Sender: TObject; CurrentPosition,
  EndPosition: Double);
begin
  if Assigned(OnScroll) then
    OnScroll(Sender, CurrentPosition, EndPosition);
end;

procedure TAdvSmoothComboBox.LstParentDeactivate(Sender: TObject);
begin
  FDeactivating := true;
  Assign(FListBox);
  FButtonAppearance.FButtonState := bsUp;
  (Sender as TForm).Hide;
  Setfocus;
  FFocused := true;  
  FTimer.Enabled := true;
  if Assigned(FOnCloseUp) then
    FOnCloseUp(Self);
end;

procedure TAdvSmoothComboBox.CancelBtnClick;
begin
  CancelThisBtnClick := True;
end;

procedure TAdvSmoothComboBox.Changed;
begin
  Invalidate;
end;

procedure TAdvSmoothComboBox.CMMouseLeave(var Message: TMessage);
begin
  FButtonAppearance.FButtonState := bsUp;
  Changed;
end;

constructor TAdvSmoothComboBox.Create(AOwner: TComponent);
begin
  FConstructed := false;
  inherited;
  Width := 250;
  Height := 30;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  LstParent := TForm.Create(Self);
  LstParent.BorderStyle := bsNone;

  LstParent.Width := 0;
  LstParent.Height := 0;

  FAutoHeight := true;

  OnItemChanged := ItemChanged;

  FListBox := TAdvSmoothListBox.Create(Self);
  FListBox.OnItemChanged := ListBoxItemChanged;
  FListBox.OnItemSelected := ListBoxItemSelected;
  FListBox.OnMouseMove := ListBoxMouseMove;
  FListBox.OnMouseUp := ListBoxMouseUp;
  FListBox.OnMouseDown := ListBoxMouseDown;
  FListBox.OnKeyUp := ListBoxKeyUp;
  FListBox.OnHeaderClick := ListBoxHeaderClick;
  FListBox.OnFooterClick := ListBoxFooterClick;
  FListBox.OnItemDragStart := ListBoxItemDragStart;
  FListBox.OnItemDragEnd := ListBoxItemDragEnd;
  FListBox.OnItemDragOver := ListBoxItemDragOver;
  FListBox.OnItemDragDrop := ListBoxItemDragDrop;
  FListBox.OnItemMouseLeave := ListBoxItemMouseLeave;
  FListBox.OnItemMouseEnter := ListBoxItemMouseEnter;
  FListBox.OnLookUpClick := ListBoxLookUpClick;
  FListBox.OnItemHint := ListBoxItemHint;
  FListBox.OnItemDblClick := ListBoxItemDblClick;
  FListBox.OnItemClick := ListBoxItemClick;
  FListBox.OnItemSelectionChanged := ListBoxItemSelectionChanged;
  FListBox.OnItemCheckClick := ListBoxItemChecked;
  FListBox.OnItemRadioClick := ListBoxItemRadioClick;
  FListBox.OnItemImageClick := ListBoxItemImageClick;
  FListBox.OnItemButtonClick := ListBoxItemButtonClick;
  FListBox.OnScroll := ListBoxScroll;
  FListBox.OnHideDetail := ListBoxHideDetail;
  FListBox.OnShowDetail := ListBoxShowDetail;
  FListBox.OnItemDraw := ListBoxItemDraw;
  FListBox.OnItemBkgDraw := ListBoxItemBkgDraw;
  FListBox.OnItemText := ListBoxItemText;
  FListBox.OnAnchorClick := ListBoxAnchorClick;
  FListBox.OnItemAnchorClick := ListBoxItemAnchorClick;
  FListBox.OnItemCaptionClick := ListBoxItemCaptionClick;
  FListBox.OnItemInfoClick := ListBoxItemInfoClick;
  FListBox.OnKeyDown := ListBoxKeyDown;
  FListBox.OnKeyPress := ListBoxKeyPress;
  {$IFDEF DELPHI2006_LVL}
  FListBox.OnMouseActivate := ListBoxMouseActivate;
  FListBox.OnMouseLeave := ListboxMouseLeave;
  FListBox.OnMouseEnter := ListboxMouseEnter;
  {$ENDIF}
  FListBox.OnResize := ListBoxResize;
  FListBox.OnDblClick := ListBoxDblClick;
  FListBox.OnClick := ListBoxClick;
  FListBox.OnEnter := ListBoxEnter;
  FListBox.OnExit := ListBoxExit;
  FListBox.OnDragDrop := ListBoxDragDrop;
  FListBox.OnDragOver := ListBoxDragOver;
  FListBox.OnStartDrag := ListBoxStartDrag;
  FListBox.OnEndDrag := ListBoxEndDrag;

  FListBox.Parent := LstParent;
  FListBox.SetComponentStyle(tsOffice2003Blue);
  FSelectedItemIndex := -1;
  FButtonAppearance := TAdvSmoothComboBoxButtonAppearance.Create(Self);
  FButtonAppearance.OnChange := ButtonAppearanceChanged;
  FTimer := TTimer.Create(self);
  FTimer.Enabled := false;
  FTimer.OnTimer := TimerEvent;
  FTimer.Interval := 100;
  LstParent.OnDeactivate := LstParentDeactivate;

  FDropDownHeight := 350;
  FDropDownWidth := 250;

  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));
end;

procedure TAdvSmoothComboBox.CreateWnd;
begin
  inherited;
  if FAutoHeight then
    Height := ItemAppearance.Height;

  if FConstructed then
    Exit;

  if FDesignTime then
  begin
    //Default combobox style
//    ItemBackGroundFill.Color := RGB(240, 240, 240);
//    ItemBackGroundFill.GradientType := gtSolid;
//    ItemBackGroundFill.BorderColor := clDkGray;
//    ItemBackGroundFill.ColorMirror := RGB(216, 216, 216);
//    ButtonAppearance.Fill.Assign(ItemBackGroundFill);
    SetComponentStyle(tsOffice2007Luna);
  end;

  FConstructed := true;
end;

destructor TAdvSmoothComboBox.Destroy;
begin
  FFill.Free;
  FListBox.Free;
  LstParent.Free;
  FButtonAppearance.Free;
  FTimer.Free;
  inherited;
end;

procedure TAdvSmoothComboBox.DoButtonClick;
begin
  CancelThisBtnClick := False;
  
  inherited;

  if CancelThisBtnClick then
    Exit;

  if FDeactivating then
  begin
    FDeactivating := false;
    Exit;
  end;

  if Assigned(LstParent) then
  begin
    if LstParent.Visible then
    begin
      FDeactivating := true;
      LstParent.Hide;
      Exit;
    end
    else
      DropDown;
  end
  else
    DropDown;
end;

procedure TAdvSmoothComboBox.DoEnter;
begin
  inherited;
  FFocused := true;
  Changed;  
end;

procedure TAdvSmoothComboBox.DoExit;
begin
  inherited;
  FFocused := false;
  ButtonAppearance.FButtonState := bsUp;  
  Changed;
end;

procedure TAdvSmoothComboBox.DoGraphicMouseDown(X, Y: integer);
var
  item: integer;
  AnchorI: string;
begin
 //ITEMS
  item := SelectedItemIndex;
  if item <> -1 then
  begin
    with Items[SelectedItemIndex] do
    begin
      AnchorI := GetAnchorAt(X, Y);

      if IsInfo(X, Y) then
        DoItemInfoClick(Self, Index);

      if IsCaption(X, Y) then
        DoItemCaptionClick(Self, Index);

      if (IsGraphicLeft(X, Y)  or ((x = -1) and (y = -1))) and Enabled then
      begin
        if (x = -1) and (y = -1) then
        begin
          case GraphicLeftType of
            gtButton, gtSmoothButton: ButtonLeftDown := true;
          end;
        end
        else
        begin
          case GraphicLeftType of
            gtButton, gtSmoothButton: ButtonLeftDown := not ButtonLeftDown;
          end;
        end;
        Changed;
      end;

      if (IsGraphicRight(X, Y)  or ((x = -1) and (y = -1))) and Enabled then
      begin
        if (x = -1) and (y = -1) then
        begin
          case GraphicRightType of
            gtButton, gtSmoothButton: ButtonRightDown := true;
          end;
        end
        else
        begin
          case GraphicRightType of
            gtButton, gtSmoothButton: ButtonRightDown := not ButtonRightDown;
          end;
        end;
        Changed;
      end;
    end;
  end;

  if AnchorI <> '' then
  begin
    if item <> -1 then
    begin
      with Items[SelectedItemIndex] do
        DoItemAnchorClick(Self, AnchorI, Index);
    end;
  end;
end;

procedure TAdvSmoothComboBox.DoGraphicMouseUp(X, Y: integer);
var
  item, i: integer;
begin
  item := SelectedItemIndex;
  if (item <> -1) and (item <= Items.Count - 1) then
  begin

    with Items[item] do
    begin
      if (IsGraphicLeft(X, Y) or ((x = -1) and (y = -1))) and Enabled and (GraphicLeftType <> gtNone) then
      begin
         case GraphicLeftType of
           gtSmoothButton, gtCommonDetailImage, gtImage, gtCommonImage, gtDetailImage: Expanded := not Expanded;
         end;
         case GraphicLeftType of
           gtCheckBox:
           begin
             Checked := not Checked;
             DoItemCheckClick(Self, Index, Checked);
           end;
           gtRadio:
           begin
             for I := 0 to Items.Count - 1 do
               Items[I].Checked := false;

             Checked := not Checked;
             DoItemRadioClick(Self, Index, Checked);
           end;
           gtButton, gtSmoothButton: DoItemButtonClick(Self, Index);
           gtImage, gtCommonImage: DoItemImageClick(Self, Index);
           gtDetailImage, gtCommonDetailImage:
           begin
             DoItemImageClick(Self, Index);
           end;
        end
      end
      else if (IsGraphicRight(X, Y)  or ((x = -1) and (y = -1))) and Enabled and (GraphicRightType <> gtNone) then
      begin
        case GraphicRightType of
         gtCheckBox:
         begin
           Checked := not Checked;
           DoItemCheckClick(Self, Index, Checked);
         end;
         gtRadio:
         begin
           for I := 0 to Items.Count - 1 do
             Items[I].Checked := false;

           Checked := not Checked;
           DoItemRadioClick(Self, Index, Checked);
         end;
         gtButton, gtSmoothButton: DoItemButtonClick(Self, Index);
         gtImage, gtCommonImage: DoItemImageClick(Self, Index);
         gtDetailImage, gtCommonDetailImage:
         begin
           DoItemImageClick(Self, Index);
         end;
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothComboBox.DrawBackGround;
var
  g: TGPGraphics;
begin
  g := TGPGraphics.Create(Canvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  FFill.Fill(g, MakeRect(0, 0, ClientWidth - 1, ClientHeight - 1));
  g.Free;
end;

procedure DrawArrow(Canvas : TCanvas; ArrowColor: TColor; ArrowSize: integer; origin, target : TGPPointF);
type
  TArrayOfPointF = array of TGPPointF;
var
  quarter: byte;
  fx, px: Double;
  fy, py: double;
  x, y: Double;
  arrowpts: TArrayOfPointF;
  p: TGPPointF;
  ar: TGPPointF;
  h: Integer;
  arx, ary: integer;
  g: TGPGraphics;
  b: TGPSolidBrush;
begin

  arx := ArrowSize;
  ary := ArrowSize div 2;

  SetLength(arrowpts, 4);

  arrowpts[0] := target;

  x := target.x - origin.x;
  y := target.y - origin.y;
  h := round(sqrt(sqr(x) + sqr(y)));

  if h = 0 then
    h := 1;

  // quarter?
  if origin.x < target.x then
  begin
    if origin.y < target.y then
      quarter := 1
    else
      quarter := 3;
  end
  else
  begin
    if origin.y < target.y then
      quarter := 2
    else
      quarter := 4;
  end;

  // calculate the actual P position using the adjustments px and py.
  px := x * arx / h;
  py := y * ary / h;
  case quarter of
    1 :
      begin
        p.x := target.x - px;
        p.y := target.y - py;
        ar.x := target.x - (x * arx / h);
        ar.y := target.y - (y * ary / h);
      end;
    2 :
      begin
        p.x := target.x - px;
        p.y := target.y - py;
        ar.x := target.x - (x * arx / h);
        ar.y := target.y - (y * ary / h);
      end;
    3 :
      begin
        p.x := target.x - px;
        p.y := target.y - py;
        ar.x := target.x - (x * arx / h);
        ar.y := target.y - (y * ary / h);
      end;
    4 :
      begin
        p.x := Target.x - px;
        p.y := Target.y - py;
        ar.x := target.x - (x * arx / h);
        ar.y := target.y - (y * ary / h);
      end;
  end;

  //calculate pts[1] and pts[2] from the P position to give us the back of the arrow.
  fx := y * (arx div 2) / h;
  fy := x * (ary div 2) / h;
  case quarter of
    1 :
      begin
        arrowpts[1].x := p.x - fx;
        arrowpts[1].y := p.y + fy;
        arrowpts[3].x := p.x + fx;
        arrowpts[3].y := p.y - fy;
      end;
    2 :
      begin
        arrowpts[1].x := p.x + fx;
        arrowpts[1].y := p.y - fy;
        arrowpts[3].x := p.x - fx;
        arrowpts[3].y := p.y + fy;
      end;
    3 :
      begin
        arrowpts[1].x := p.x + fx;
        arrowpts[1].y := p.y - fy;
        arrowpts[3].x := p.x - fx;
        arrowpts[3].y := p.y + fy;
      end;
    4 :
      begin
        arrowpts[1].x := p.x + fx;
        arrowpts[1].y := p.y - fy;
        arrowpts[3].x := p.x - fx;
        arrowpts[3].y := p.y + fy;
      end;
  end;

  arrowpts[2] := ar;
  if ArrowColor <> clNone then
    canvas.Brush.color := ArrowColor
  else
    canvas.Brush.Style := bsClear;

  g := TGPGraphics.Create(Canvas.Handle);
  b := TGPSolidBrush.Create(MakeColor(255, ArrowColor));
  g.FillPolygon(b, PGPPointF(arrowpts), Length(arrowpts));
  b.Free;
  g.Free;
end;

procedure TAdvSmoothComboBox.DrawButton;
var
  g: TGPGraphics;
  ap: TGPPointF;
  s: Integer;
  f: TGDIPFill;
begin
  with FButtonAppearance do
  begin
    f := FFill;
    case FButtonState of
      bsDown: f := FFillDown;
      bsHover: f := FFillHover;
    end;
    g := TGPGraphics.Create(Canvas.Handle);
    g.SetSmoothingMode(SmoothingModeAntiAlias);
    f.Fill(g, MakeRect(GetButtonRectangle.Left, GetButtonRectangle.Top, GetButtonRectangle.Right - GetButtonRectangle.Left, GetButtonRectangle.Bottom - GetbuttonRectangle.Top));
    g.Free;
    if f.Picture.Empty then
    begin
      s := 8;
      ap.Y := GetButtonRectangle.Top + ((GetButtonRectangle.Bottom - GetButtonRectangle.Top + (s div 2)) div 2);
      ap.X := GetButtonRectangle.Left + ((GetButtonRectangle.Right - GetButtonRectangle.Left) div 2);

      DrawArrow(Canvas, clWindowText, S, MakePoint(ap.X, ap.Y - (s / 2)), MakePoint(ap.x, ap.Y));
    end;
  end;
end;

procedure TAdvSmoothComboBox.DropDown;
var
  LstPos: TPoint;
  r: TRect;

  function GetParentWnd: HWnd;
  var
    Last, P: HWnd;
  begin
    P := GetParent((Owner as TWinControl).Handle);
    Last := P;
    while P <> 0 do
    begin
      Last := P;
      P := GetParent(P);
    end;
    Result := Last;
  end;
begin
if (Parent is TForm) then
  begin
    if (Parent as TForm).FormStyle = fsStayOnTop then
      LstParent.FormStyle := fsStayOnTop;
  end
  else
    LstParent.FormStyle := fsStayOnTop;

  LstPos.x := 0;
  LstPos.y := Height;
  LstPos := ClientToScreen(LstPos);

  {$IFNDEF TMSDOTNET}
  SystemParametersInfo(SPI_GETWORKAREA, 0,@r,0); //account for taskbar...
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  SystemParametersInfo(SPI_GETWORKAREA, 0,r,0); //account for taskbar...
  {$ENDIF}

  FListBox.Assign(Self);

  if (LstPos.y + FListBox.Height > r.Bottom) then
    LstPos.Y := LstPos.Y - FListBox.Height - Height + 3;

  if (LstPos.x + FListBox.Width > r.right) then
    LstPos.x := LstPos.x - (FListBox.Width - Width);

  // Set planner date
  try
    if (FSelectedItemIndex <> -1) and (FSelectedItemIndex >= 0) and (FSelectedItemIndex <= Items.Count - 1) then
      FListBox.Items.Select(FSelectedItemIndex);
  except
    on Exception do
       Text := 'exception';
  end;  

  LstParent.Width := 0;
  LstParent.Height := 0;
  LstParent.Show;

  LstParent.Left := LstPos.x;
  LstParent.Top := LstPos.y;
  FListbox.Width := DropDownWidth;
  FListBox.Height := DropDownHeight; 
  LstParent.Width := FListBox.Width;
  LstParent.Height := FListBox.Height;
  FListBox.InitState;
  FListBox.SelectedItemIndex := SelectedItemIndex;
  Invalidate;

  FListBox.TabStop := true;  
  FListBox.SetFocus;
  FFocused := false;

  if Assigned(FOnDropDown) then
    FOnDropDown(Self);

  SendMessage(GetParentWnd, WM_NCACTIVATE, 1, 0);
end;

procedure TAdvSmoothComboBox.FillChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothComboBox.GetButtonRectangle: TRect;
begin
  result := Bounds(InsideRect.Right - ButtonAppearance.Width - 1, InsideRect.Top, ButtonAppearance.Width + 1, InsideRect.Bottom - InsideRect.Top);
end;

function TAdvSmoothComboBox.GetItemRectangle: TRect;
begin
  result := Bounds(InsideRect.Left, InsideRect.Top, InsideRect.Right - InsideRect.Left - ButtonAppearance.Width, InsideRect.Bottom - InsideRect.Top);
end;

function TAdvSmoothComboBox.GetParentEx: TWinControl;
begin
  Result := inherited Parent;
end;

function TAdvSmoothComboBox.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TAdvSmoothComboBox.HideParent;
begin
  FDeactivating := false;
  FButtonAppearance.FButtonState := bsUp;
  Assign(FListBox);  
  LstParent.Hide;
  try
    SetFocus;
    FFocused := true;
  except
  end;
end;

function TAdvSmoothComboBox.InsideRect: TRect;
var
  bw: integer;
begin
  Result := ClientRect;
  // adapt width & height for GDI+ drawing rect
  Result.Right := Result.Right - 1;
  Result.Bottom := Result.Bottom - 1;

  if (Fill.BorderColor <> clNone) then
  begin
    if Fill.BorderWidth = 1 then
      bw := 1
    else
      bw := (Fill.BorderWidth + 1) div 2;

    InflateRect(Result, -bw, -bw);
  end;
end;

procedure TAdvSmoothComboBox.ItemAppearanceChanged(Sender: TObject);
begin
  if FAutoHeight then
    Height := ItemAppearance.Height;
  Changed;
end;

procedure TAdvSmoothComboBox.ItemChanged(Sender: TObject; itemindex: integer);
begin
  if (itemindex >= 0) and (itemindex < FListBox.Items.Count) and (itemindex < Items.Count) then
  begin
    FListBox.Items.BeginUpdate;
    FListBox.Items[itemindex].CopySettings(Items[itemindex]);
    FListBox.Items.EndUpdate;
    Changed;
  end;
end;

procedure TAdvSmoothComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = VK_F4) then
  begin
    if LstParent.Visible then
      HideParent
    else
      DoButtonClick;
  end
  else if (Key = VK_SPACE) then
  begin
    DoGraphicMouseDown(-1, -1);
  end
  else
  begin
    case Key of
      VK_DOWN,VK_RIGHT: Inc(FSelectedItemIndex);
      VK_UP,VK_LEFT: Dec(FSelectedItemIndex);
      VK_HOME: FSelectedItemIndex := 0;
      VK_END: FSelectedItemIndex := Items.Count - 1;
      VK_NEXT: FSelectedItemIndex := FSelectedItemIndex + 5;
      VK_PRIOR: FSelectedItemIndex := FSelectedItemIndex - 5;
    end;

    FSelectedItemIndex := Min(Items.Count - 1, Max(0, FSelectedItemIndex));
    while Items[FSelectedItemIndex].Splitter and (FSelectedItemIndex > 0) do
    begin
      case Key of
        VK_DOWN,VK_RIGHT: Inc(FSelectedItemIndex);
        VK_UP,VK_LEFT: Dec(FSelectedItemIndex);
        VK_HOME: FSelectedItemIndex := 0;
        VK_END: FSelectedItemIndex := Items.Count - 1;
        VK_NEXT: FSelectedItemIndex := FSelectedItemIndex + 5;
        VK_PRIOR: FSelectedItemIndex := FSelectedItemIndex - 5;
      end;
    end;
    Changed;
  end;
end;

procedure TAdvSmoothComboBox.KeyPress(var Key: char);
var
  i: integer;
  flg: boolean;
begin
  inherited;

  if not KeyBoardLookup then
    Exit;

  FTimerCount := 0;

  if (Key >= '0') and (Key <= 'z') then
  begin
    FLookupKey := FLookupKey + key;
  end;

  if Key = #8 then
  begin
    if Length(FLookupKey) > 0 then
      Delete(FLookupKey, Length(FLookupKey), 1);
  end;

  flg := false;

  for i := 0 to Items.Count - 1 do
  begin
    if pos(Uppercase(FLookupKey), Uppercase(Items[i].Caption)) = 1 then
    begin
      SelectedItemIndex := i;
      FLookupKey := '';
      flg := true;
      break;
    end;
  end;

  if not flg then
    FLookupKey := '';
end;

procedure TAdvSmoothComboBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_SPACE then
  begin
    DoGraphicMouseUp(-1, -1);
  end;
end;

procedure TAdvSmoothComboBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;

  if csDesigning in ComponentState then
    Exit;

  FMouseDown := true;  
  if PtInRect(GetButtonRectangle, Point(X, Y)) then
  begin
    ButtonAppearance.FButtonState := bsDown;
    Changed;    
  end
  else
  begin
    DoGraphicMouseDown(X, Y);
  end;
end;

procedure TAdvSmoothComboBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  item: integer;
  AnchorI: String;
begin
  if PtInRect(GetButtonRectangle, Point(X, Y)) then
  begin
    if (ButtonAppearance.FButtonState <> bsHover) and not FMouseDown then
    begin
      ButtonAppearance.FButtonState := bsHover;
      Changed;
    end;
  end
  else
  begin
    if ButtonAppearance.FButtonState <> bsUp then
    begin
      ButtonAppearance.FButtonState := bsUp;
      Changed;
    end;

    //ITEM ANCHOR
    item := SelectedItemIndex;
    if (item >= 0) and (item <= Items.Count - 1) then
    begin
      with Items[item] do
        AnchorI := GetAnchorAt(X, Y);
    end;

    if (AnchorI <> '') then
      Cursor := crHandPoint
    else
      Cursor := crArrow;
  end;
end;

procedure TAdvSmoothComboBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;

  if csDesigning in ComponentState then
    Exit;

  FMouseDown := false;

  if PtInRect(GetButtonRectangle, Point(X, Y)) then
  begin
    ButtonAppearance.FButtonState := bsUp;
    Changed;
    DoButtonClick;
  end
  else
    DoGraphicMouseUp(X, Y);
end;

procedure TAdvSmoothComboBox.Paint;
var
  ir: TRect;
  c: Boolean;
  g: TGPGraphics;
  pfocus: TGPPen;
begin
  DrawBackGround;
  c := (FSelectedItemIndex <> -1) and (FSelectedItemIndex >= 0) and (FSelectedItemIndex <= Items.Count - 1);
  if c then
  begin
    ir := GetItemRectangle;
    ir.Top := ir.Top + GetPosition;
    ir.Bottom := ir.Bottom + GetPosition;
    InitSelection(FSelectedItemIndex);
    Items[FSelectedItemIndex].Draw(Canvas, ir, GetDisplayIndex(FSelectedItemIndex));
  end;
  DrawButton;
  if FFocused and TabStop and ShowFocus then
  begin
    g := TGPGraphics.Create(Canvas.Handle);
    g.SetSmoothingMode(SmoothingModeDefault);
    pfocus := TGPPen.Create(MakeColor(255, clBlack), 1);
    pfocus.SetDashStyle(DashStyleDot);
    g.DrawRectangle(pfocus, MakeRect(GetItemRectangle.Left + 1, GetItemRectangle.Top + 1, GetItemRectangle.Right - GetItemRectangle.Left - 2, GetItemRectangle.Bottom - GetItemRectangle.Top - 2));
    pfocus.Free;
    g.Free;
  end;
end;

procedure TAdvSmoothComboBox.Resize;
begin
  inherited;
  if FAutoHeight then
    Height := ItemAppearance.Height;
end;

procedure TAdvSmoothComboBox.SetAutoHeight(const Value: Boolean);
begin
  if FAutoHeight <> value then
  begin
    FAutoHeight := Value;
    if Value then
      Height := ItemAppearance.Height
    else
      Changed;
  end;
end;

procedure TAdvSmoothComboBox.SetButtonAppearance(
  const Value: TAdvSmoothComboBoxButtonAppearance);
begin
  if FButtonAppearance <> value then
  begin
    FButtonAppearance := Value;
    Changed;
  end;
end;

procedure TAdvSmoothComboBox.SetComponentStyle(AStyle: TTMSStyle);
begin
  inherited;
  ItemBackGroundFill.Assign(ItemAppearance.Fill);
  ButtonAppearance.Fill.Assign(ItemAppearance.Fill);
  ItemBackGroundFill.BorderColor := Header.Fill.BorderColor;
  ButtonAppearance.Fill.BorderColor := Header.Fill.BorderColor;
  ButtonAppearance.FillDown.Assign(ItemAppearance.FillSelected);
  ButtonAppearance.FillDown.BorderColor := Header.Fill.BorderColor;
  // TODO : do color settings here
 case AStyle of
    tsOffice2003Blue:
      begin
        ButtonAppearance.FillHover.Color := $EBFDFF;
        ButtonAppearance.FillHover.ColorTo := $ACECFF;
        ButtonAppearance.FillHover.ColorMirror := $59DAFF;
        ButtonAppearance.FillHover.ColorMirrorTo := $A4E9FF;
        ButtonAppearance.FillHover.BorderColor :=  $99CEDB;
        ButtonAppearance.FillHover.GradientMirrorType := gtVertical;
      end;
    tsOffice2003Silver:
      begin
        ButtonAppearance.FillHover.Color := $EBFDFF;
        ButtonAppearance.FillHover.ColorTo := $ACECFF;
        ButtonAppearance.FillHover.ColorMirror := $59DAFF;
        ButtonAppearance.FillHover.ColorMirrorTo := $A4E9FF;
        ButtonAppearance.FillHover.BorderColor :=  $99CEDB;
        ButtonAppearance.FillHover.GradientMirrorType := gtVertical;
      end;
    tsOffice2003Olive:
      begin
        ButtonAppearance.FillHover.Color := $EBFDFF;
        ButtonAppearance.FillHover.ColorTo := $ACECFF;
        ButtonAppearance.FillHover.ColorMirror := $59DAFF;
        ButtonAppearance.FillHover.ColorMirrorTo := $A4E9FF;
        ButtonAppearance.FillHover.BorderColor :=  $99CEDB;
        ButtonAppearance.FillHover.GradientMirrorType := gtVertical;
      end;
    tsOffice2003Classic:
      begin
        ButtonAppearance.FillHover.Color := $D2BDB6;
        ButtonAppearance.FillHover.ColorTo := $D2BDB6;
        ButtonAppearance.FillHover.ColorMirror := clNone;
        ButtonAppearance.FillHover.ColorMirrorTo := clNone;
        ButtonAppearance.FillHover.BorderColor := $808080;
        ButtonAppearance.FillHover.GradientMirrorType := gtVertical;
      end;
    tsOffice2007Luna:
      begin
        ButtonAppearance.FillHover.Color := $EBFDFF;
        ButtonAppearance.FillHover.ColorTo := $ACECFF;
        ButtonAppearance.FillHover.ColorMirror := $59DAFF;
        ButtonAppearance.FillHover.ColorMirrorTo := $A4E9FF;
        ButtonAppearance.FillHover.BorderColor :=  $99CEDB;
        ButtonAppearance.FillHover.GradientMirrorType := gtVertical;
      end;
    tsOffice2007Obsidian:
      begin
        ButtonAppearance.FillHover.Color := $EBFDFF;
        ButtonAppearance.FillHover.ColorTo := $ACECFF;
        ButtonAppearance.FillHover.ColorMirror := $59DAFF;
        ButtonAppearance.FillHover.ColorMirrorTo := $A4E9FF;
        ButtonAppearance.FillHover.BorderColor :=  $99CEDB;
        ButtonAppearance.FillHover.GradientMirrorType := gtVertical;
      end;
    tsWindowsXP:
      begin
        ButtonAppearance.FillHover.Color := $EFD3C6;
        ButtonAppearance.FillHover.ColorTo := $EFD3C6;
        ButtonAppearance.FillHover.ColorMirror := clNone;
        ButtonAppearance.FillHover.ColorMirrorTo := clNone;
        ButtonAppearance.FillHover.BorderColor :=  clHighlight;
        ButtonAppearance.FillHover.GradientMirrorType := gtVertical;
      end;
    tsWhidbey:
      begin
        ButtonAppearance.FillHover.Color := $EBFDFF;
        ButtonAppearance.FillHover.ColorTo := $ACECFF;
        ButtonAppearance.FillHover.ColorMirror := $59DAFF;
        ButtonAppearance.FillHover.ColorMirrorTo := $A4E9FF;
        ButtonAppearance.FillHover.BorderColor :=  $99CEDB;
        ButtonAppearance.FillHover.GradientMirrorType := gtVertical;
      end;
    tsCustom: ;
    tsOffice2007Silver:
      begin
        ButtonAppearance.FillHover.Color := $EBFDFF;
        ButtonAppearance.FillHover.ColorTo := $ACECFF;
        ButtonAppearance.FillHover.ColorMirror := $59DAFF;
        ButtonAppearance.FillHover.ColorMirrorTo := $A4E9FF;
        ButtonAppearance.FillHover.BorderColor :=  $99CEDB;
        ButtonAppearance.FillHover.GradientMirrorType := gtVertical;
      end;
  end;

  ButtonAppearance.FillHover.BorderColor := Header.Fill.BorderColor;  
end;

procedure TAdvSmoothComboBox.SetDropDownHeight(const Value: integer);
begin
  if FDropDownHeight <> value then
  begin
    FDropDownHeight := Value;
    Changed;
  end;
end;

procedure TAdvSmoothComboBox.SetDropDownWidth(const Value: integer);
begin
  if FDropDownWidth <> value then
  begin
    FDropDownWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothComboBox.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothComboBox.SetParentEx(const Value: TWinControl);
begin
  inherited Parent := Value;
end;

procedure TAdvSmoothComboBox.SetSelectedItemIndex(const Value: integer);
begin
  if FSelectedItemIndex <> value then
  begin
    FSelectedItemIndex := Value;
    Changed;
  end;
end;

procedure TAdvSmoothComboBox.TimerEvent(Sender: TObject);
begin
  FDeactivating := false;
  FTimer.Enabled :=false;
end;

procedure TAdvSmoothComboBox.WMSetFocus(var Message: TWMSetFocus);
begin
  SetFocus;
end;

procedure TAdvSmoothComboBox.ListBoxDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if Assigned(OnDragDrop) then
    OnDragDrop(Sender, Source, X, Y);
end;

procedure TAdvSmoothComboBox.ListBoxDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Assigned(OnDragOver) then
    OnDragOver(Sender, Source, X, Y, State, Accept);
end;

procedure TAdvSmoothComboBox.ListBoxEndDrag(Sender, Target: TObject;
    X, Y: Integer);
begin
  if Assigned(OnEndDrag) then
    OnEndDrag(Sender, Target, X, Y);
end;

procedure TAdvSmoothComboBox.ListBoxEnter(Sender: TObject);
begin
  if Assigned(OnEnter) then
    OnEnter(Sender);
end;

procedure TAdvSmoothComboBox.ListBoxExit(Sender: TObject);
begin
  if Assigned(OnExit) then
    OnExit(Sender);
end;

{ TAdvSmoothComboBoxButtonAppearance }

procedure TAdvSmoothComboBoxButtonAppearance.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothComboBoxButtonAppearance) then
  begin
    FButtonWidth := (Source as TAdvSmoothComboBoxButtonAppearance).Width;
    FFill.Assign((Source as TAdvSmoothComboBoxButtonAppearance).Fill);
    Changed;
  end;
end;

procedure TAdvSmoothComboBoxButtonAppearance.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TAdvSmoothComboBoxButtonAppearance.Create(
  AOwner: TAdvSmoothComboBox);
begin
  FButtonWidth := 30;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FButtonState := bsUp;
  FFillDown := TGDIPFill.Create;
  FFillDown.OnChange := FillChanged;
  FFillHover := TGDIPFill.Create;
  FFillHover.OnChange := FillChanged;
end;

destructor TAdvSmoothComboBoxButtonAppearance.Destroy;
begin
  FFill.Free;
  FFillDown.Free;
  FFillHover.Free;
  inherited;
end;

procedure TAdvSmoothComboBoxButtonAppearance.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothComboBoxButtonAppearance.SetButtonWidth(
  const Value: integer);
begin
  if FButtonWidth <> Value then
  begin
    FButtonWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothComboBoxButtonAppearance.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill := Value;
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothComboBoxButtonAppearance.SetFillDown(
  const Value: TGDIPFill);
begin
  if FFillDown <> value then
  begin
    FFillDown.Assign(Value);
    FillChanged(self);
  end;
end;

procedure TAdvSmoothComboBoxButtonAppearance.SetFillHover(
  const Value: TGDIPFill);
begin
  if FFillHover <> value then
  begin
    FFillHover := Value;
    FillChanged(self);
  end;
end;

end.
