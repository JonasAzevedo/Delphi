(*===========================================================================*
 | unit ResourceDialogs                                                      |
 |                                                                           |
 | Version  Date      By    Description                                      |
 | -------  --------  ----  -------------------------------------------------|
 | 1.0      24/11/98  CPWW  Original                                         |
 *===========================================================================*)

unit ResourceDialogs;

interface
uses Windows, Classes, SysUtils, ResourceModule, contnrs;

type
//=============================================================================
// TDialogResource.  Encapsulates dialog resources

  TDialogResource = class;

  TDialogResourceControl = class
  private
    fOwner: TDialogResource;
    fTop: Integer;
    fStyle: Integer;
    fLeft: Integer;
    fHeight: Integer;
    fWidth: Integer;
    fExStyle: Integer;
    fResId : word;
    fCaption: string;
    fClassId : word;
    fClassNm: string;
    fExDataSize : word;
    fExData : PChar;
    fID: Integer;
  public
    constructor Create (AOwner : TDialogResource);
    destructor Destroy; override;
    property Owner : TDialogResource read fOwner;

    property Left : Integer read fLeft write fLeft;
    property Top : Integer read fTop write fTop;
    property Width : Integer read fWidth write fWidth;
    property Height : Integer read fHeight write fHeight;
    property Style : Integer read fStyle write fStyle;
    property ExStyle : Integer read fExStyle write fExStyle;

    property ClassNm : string read fClassNm write fClassNm;
    property ClassId : word read fClassId write fClassId;

    property ResID : word read fResID write fResID;
    property Caption : string read fCaption write fCaption;
    
    property ID : Integer read fID write fID;

  end;

  TDialogResource = class (TWriteableResource)
  private
    fCaption: string;
    fControls : TObjectList;
    fFontSize: Integer;
    fFontName: string;
    fStyle: DWORD;
    fTop: Integer;
    fHeight: Integer;
    fWidth: Integer;
    fLeft: Integer;

    fClassName : string;
    fClassID : word;

    fMenuName : string;
    fMenuID : word;

    function GetDlgTemplate: pointer;
    function GetControlCount: Integer;
    procedure WriteDlgStrToData (id : word; const st : string);
    procedure ReadDlgStr (var id : word; var st : string);
    function GetDialogResourceControl(
      index: Integer): TDialogResourceControl;
    procedure SetCaption(const Value: string);
    procedure UpdateDialogTemplate;
    procedure SetFontName(const Value: string);
    procedure SetFontSize(const Value: Integer);
    procedure SetHeight(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetStyle(const Value: DWORD);
    procedure SetTop(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    function GetUniqueID : Integer;
  protected
    class function GetResourceTypeClass : string; override;
    procedure ExportToStream (stream : TStream; const ext : string); override;
  public
    constructor Create (AParent : TResourceModule; AName : PWideChar; ADataLen :  Integer; AData : pointer; ACustomType : PWideChar = Nil); overload; override;
    destructor Destroy; override;
    class function GetResourceType : word; override;
    property DlgTemplate : pointer read GetDlgTemplate;
    procedure Initialize; override;
    property ControlCount : Integer read GetControlCount;
    property Control [index : Integer] : TDialogResourceControl read GetDialogResourceControl;

    procedure DeleteControl (index : Integer);
    procedure AddControl (ctrl : TDialogResourceControl);

    property Caption : string read fCaption write SetCaption;
    property FontSize : Integer read fFontSize write SetFontSize;
    property FontName : string read fFontName write SetFontName;
    property Left : Integer read fLeft write SetLeft;
    property Top : Integer read fTop write SetTop;
    property Width : Integer read fWidth write SetWidth;
    property Height : Integer read fHeight write SetHeight;
    property Style : DWORD read fStyle write SetStyle;
  end;


implementation

{ TDialogResource }

resourcestring
  rstDialog       = 'Dialog';
  rstDialogTemplateChanged = 'change dialog';

procedure TDialogResource.AddControl(ctrl : TDialogResourceControl);
begin
  ctrl.fID := GetUniqueID;
  fControls.Add (ctrl);
  UpdateDialogTemplate
end;

constructor TDialogResource.Create (AParent : TResourceModule; AName : PWideChar; ADataLen :  Integer; AData : pointer; ACustomType : PWideChar);
var
  templ : PDlgTemplate;
  ctempl : PDlgItemTemplate;
  n : Integer;
  w : word;
  control : TDialogResourceControl;
begin
  inherited Create (AParent, AName, ADataLen, AData, ACustomType);
  fControls := TObjectList.Create;
  if AData = Nil then
  begin
    fLeft := 0;
    fTop := 0;
    fWidth := 150;
    fHeight := 100;
    fStyle := DS_SETFONT or DS_MODALFRAME or WS_CHILD or WS_CAPTION or WS_SYSMENU or WS_VISIBLE or DS_3DLOOK;
    fFontName := 'MS Sans Serif';
    fFontSize := 8;
    fCaption := ''
  end
  else
  begin
    templ := PDlgTemplate (data.Memory);

    if templ^.style = $ffff0001 then
    begin
      raise Exception.Create ('ExDlgTemplate not supported yet');
    end
    else
    begin
      fLeft := templ^.x;
      fTop := templ^.y;
      fWidth := templ^.cx;
      fHeight := templ^.cy;
      fStyle := templ^.style;
      data.Seek (sizeof (TdlgTemplate), soFromBeginning);
    end;

    ReadDlgStr (fMenuID, fMenuName);
    ReadDlgStr (fClassID, fClassName);
    ReadDlgStr (w, fCaption);

    if (fStyle and DS_SETFONT) <> 0 then
    begin
      data.Read (w, sizeof (w));
      fFontSize := w;
      readDlgStr (w, fFontName)
    end;

    for n := 0 to templ^.cdit - 1 do
    begin
      if (data.Position mod sizeof (DWORD)) <> 0 then
        data.Position := (data.Position + sizeof (DWORD)) div sizeof (DWORD) * sizeof (DWORD);

      ctempl := PDlgItemTemplate (PChar (data.Memory) + data.Position);

      control := TDialogResourceControl.Create (self);

      control.Left := ctempl^.x;
      control.Top := ctempl^.y;
      control.Width := ctempl^.cx;
      control.Height := ctempl^.cy;
      control.Style := ctempl^.style;
      control.ExStyle := ctempl^.dwExtendedStyle;
      control.ID := ctempl^.id;

      data.Position := data.Position + sizeof (DLGITEMTEMPLATE);
      with control do ReadDlgStr (fClassId, fClassNm);
      with control do ReadDlgStr (fResId, fCaption);
      data.Read (control.fExDataSize, sizeof (control.fExDataSize));
      ReallocMem (control.fExData, control.fExDataSize);
      data.Read (control.fExData^, control.fExDataSize);

      fControls.Add (control);
    end
  end
end;

procedure TDialogResource.DeleteControl(index: Integer);
begin
  fControls.Delete (index);
  UpdateDialogTemplate
end;

destructor TDialogResource.Destroy;
begin
  fControls.Free;
  inherited
end;

procedure TDialogResource.ExportToStream(stream: TStream;
  const ext: string);
begin
  inherited;
end;

function TDialogResource.GetControlCount: Integer;
begin
  result := fControls.Count;
end;

function TDialogResource.GetDialogResourceControl(
  index: Integer): TDialogResourceControl;
begin
  result := TDialogResourceControl (fControls [index]);
end;

function TDialogResource.GetDlgTemplate: pointer;
begin
  result := Data.Memory;
end;

class function TDialogResource.GetResourceType: word;
begin
  result := word (RT_DIALOG);
end;

class function TDialogResource.GetResourceTypeClass: string;
begin
  result := rstDialog
end;

function TDialogResource.GetUniqueID: Integer;
var
  i : Integer;
begin
  result := 1;
  for i := 0 to ControlCount - 1 do
    if Control [i].ID >= result then
      result := Control [i].ID + 1
end;

procedure TDialogResource.Initialize;
begin
  UpdateDialogTemplate;
  inherited;
end;


procedure TDialogResource.ReadDlgStr(var id: word; var st: string);
begin
  data.Read (id, sizeof (id));

  if id = $ffff then
  begin
    data.Read (id, sizeof (id));
    st := ''
  end
  else
    if id = 0 then
      st := ''
    else
    begin
      st := PWideChar (PChar (data.Memory) + data.Position) - 1;
      data.Seek (Length (st) * sizeof (WideChar), soFromCurrent);
    end

end;

procedure TDialogResource.SetCaption(const Value: string);
begin
  if value <> Caption then
  begin
    fCaption := Value;
    UpdateDialogTemplate
  end
end;

procedure TDialogResource.SetFontName(const Value: string);
begin
  if fFontName <> value then
  begin
    fFontName := Value;
    UpdateDialogTemplate
  end
end;

procedure TDialogResource.SetFontSize(const Value: Integer);
begin
  if value <> FontSize then
  begin
    fFontSize := Value;
    UpdateDialogTemplate
  end
end;

procedure TDialogResource.SetHeight(const Value: Integer);
begin
  if value <> Height then
  begin
    fHeight := value;
    UpdateDialogTemplate
  end
end;

procedure TDialogResource.SetLeft(const Value: Integer);
begin
  if value <> Left then
  begin
    fLeft := Value;
    UpdateDialogTemplate
  end
end;

procedure TDialogResource.SetStyle(const Value: DWORD);
begin
  if value <> Style then
  begin
    fStyle := Value;
    UpdateDialogTemplate
  end
end;

procedure TDialogResource.SetTop(const Value: Integer);
begin
  if value <> Top then
  begin
    fTop := Value;
    UpdateDialogTemplate
  end
end;

procedure TDialogResource.SetWidth(const Value: Integer);
begin
  if value <> Width then
  begin
    fWidth := Value;
    UpdateDialogTemplate
  end
end;

procedure TDialogResource.UpdateDialogTemplate;
var
  template : TDlgTemplate;
  itemTemplate : TDlgItemTemplate;
  i : Integer;
  w : word;
  padding : DWORD;
  ctrl : TDialogResourceControl;
begin
  AddUndoEntry (rstDialogTemplateChanged);
  try
    padding := 0;
    data.Seek (0, soFromBeginning);
    template.style := fStyle;
    template.dwExtendedStyle := 0;
    template.cdit := ControlCount;
    template.x := fLeft;
    template.y := fTop;
    template.cx := fWidth;
    template.cy := fHeight;
    data.Write (template, sizeof (template));

    WriteDlgStrToData (fMenuID, fMenuName);   // Menu
    WriteDlgStrToData (fClassID, fClassName);   // Class
    WriteDlgStrToData (0, fCaption);   // Title

    if (fStyle and DS_SETFONT) <> 0 then
    begin
      w := fFontSize;
      data.Write (w, sizeof (w));
      WriteDlgStrToData (0, fFontName)
    end;

    for i := 0 to ControlCount - 1 do
    begin
      if (data.Position mod sizeof (DWORD)) <> 0 then
        data.Write (padding, ((data.Position + sizeof (DWORD)) div sizeof (DWORD) * sizeof (DWORD)) - data.Position);

      ctrl := Control [i];

      itemTemplate.style := ctrl.Style;
      itemtemplate.dwExtendedStyle := ctrl.ExStyle;
      itemTemplate.x := ctrl.Left;
      itemTemplate.y := ctrl.Top;
      itemTemplate.cx := ctrl.Width;
      itemTemplate.cy := ctrl.Height;
      itemTemplate.id := ctrl.ID;

      data.Write (itemTemplate, sizeof (itemtemplate));
      with ctrl do WriteDlgStrToData (fClassId, fClassNm);
      with ctrl do WriteDlgStrToData (fResID, fCaption);
      with ctrl do data.Write (fExDataSize, sizeof (fExDataSize));

      with ctrl do
        if fExDataSize > 0 then
          data.Write (fExData^, fExDataSize)
    end
  finally
    NotifyChange
  end
end;

procedure TDialogResource.WriteDlgStrToData (id : word; const st : string);
var
  ws : WideString;
  w : word;
begin
  if st = '' then
  begin
    if id <> 0 then
    begin
      w := $ffff;
      data.Write (w, sizeof (w))
    end;
    data.Write (id, sizeof (id))
  end
  else
  begin
    ws := st;
    data.Write (PWideChar (ws)^, sizeof (WideChar) * (Length (st) + 1))
  end
end;

{ TDialogResourceControl }

constructor TDialogResourceControl.Create(AOwner: TDialogResource);
begin
  fOwner := AOwner;
end;

destructor TDialogResourceControl.Destroy;
begin
  ReallocMem (fExData, 0);
  inherited;
end;

initialization
  RegisterWriteableResources ([TDialogResource]);
end.

