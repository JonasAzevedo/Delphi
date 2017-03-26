unit BitmapEditorForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ResourceEditorForm, cmpBitmapEditor, ExtCtrls, ResourceModule, ImgList,
  Menus, ActnList, ComCtrls, ToolWin, ColorSelector, cmpSizingPageControl,
  StdCtrls;

type
  TfmBitmapEditor = class(TfmResourceEditor)
    Splitter1: TSplitter;
    sbBitmap: TScrollBox;
    BitmapEditor: TBitmapEditor;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    actBitmapZoomIn: TAction;
    actBitmapZoomOut: TAction;
    Bitmap1: TMenuItem;
    ZoomIn1: TMenuItem;
    ZoomOut1: TMenuItem;
    N1: TMenuItem;
    pomBitmap: TPopupMenu;
    ZoomIn2: TMenuItem;
    ZoomOut2: TMenuItem;
    SizingPageControl1: TSizingPageControl;
    pnlGraphics: TPanel;
    ToolBar1: TToolBar;
    tbSelectRect: TToolButton;
    tbSelectShape: TToolButton;
    tbDropper: TToolButton;
    tbEraser: TToolButton;
    tbFloodFill: TToolButton;
    tbMagnifier: TToolButton;
    tbPencil: TToolButton;
    tbBrush: TToolButton;
    tbAirbrush: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    tbFrameRect: TToolButton;
    tbFillRect: TToolButton;
    tbRect: TToolButton;
    tbFrameRoundRect: TToolButton;
    tbFillRoundRect: TToolButton;
    tbRoundRect: TToolButton;
    tbFrameEllipse: TToolButton;
    tbFillEllipse: TToolButton;
    tbEllipse: TToolButton;
    pnlColours: TPanel;
    shpBack: TShape;
    shpFore: TShape;
    ColorSelector1: TColorSelector;
    Panel1: TPanel;
    sbThumbnail: TScrollBox;
    imgThumbnail: TImage;
    ColorDialog1: TColorDialog;
    actBitmapRotate180: TAction;
    Rotate1801: TMenuItem;
    actBitmapRotateClockwise90: TAction;
    actBitmapRotateAntiClockwise90: TAction;
    RotateClockwise901: TMenuItem;
    RotateAnticlockwise901: TMenuItem;
    N4: TMenuItem;
    Rotate1802: TMenuItem;
    RotateClockwise902: TMenuItem;
    RotateAnticlockwise902: TMenuItem;
    pnlTransparent: TPanel;
    Panel2: TPanel;
    Splitter2: TSplitter;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edWidth: TEdit;
    edHeight: TEdit;
    cbPixelFormat: TComboBox;
    actBitmapNewImage: TAction;
    mnuNewImageDivider: TMenuItem;
    NewImage1: TMenuItem;
    pomNewImageDivider: TMenuItem;
    NewImage2: TMenuItem;
    procedure actBitmapZoomInExecute(Sender: TObject);
    procedure actBitmapZoomOutExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbPencilClick(Sender: TObject);
    procedure BitmapEditorChange(Sender: TObject);
    procedure ColorSelector1ColorSelect(Sender: TObject);
    procedure SizingPageControl1DockDrop(Sender: TObject;
      Source: TDragDockObject; X, Y: Integer);
    procedure SizingPageControl1UnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure BitmapEditorDrawToolChange(Sender: TObject);
    procedure ColorSelector1DblClick(Sender: TObject);
    procedure actBitmapRotate180Execute(Sender: TObject);
    procedure actBitmapRotateClockwise90Execute(Sender: TObject);
    procedure actBitmapRotateAntiClockwise90Execute(Sender: TObject);
    procedure pnlTransparentMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pnlTransparentDblClick(Sender: TObject);
    procedure actBitmapNewImageExecute(Sender: TObject);
    procedure BitmapEditorEndChange(Sender: TObject);
    procedure edWidthExit(Sender: TObject);
    procedure edHeightExit(Sender: TObject);
    procedure sbThumbnailDblClick(Sender: TObject);
  private
    fPanelNames : TStringList;
    fPCWidth : Integer;
    fPalette : HPALETTE;
    procedure SetPalette (value : HPALETTE);
    procedure CopyImageToThumbnailImage;
    procedure SaveResource (const undoDescription : string);
  protected
    procedure UpdateActions; override;
    function GetEditSupport: TEditSupport; override;

  public
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
    procedure DoResourceChanged; override;
    procedure EditCopyToClipboard; override;
    procedure EditCutToClipboard; override;
    procedure EditPaste; override;
    procedure EditDelete; override;
    procedure EditSelectAll; override;
  end;

var
  fmBitmapEditor: TfmBitmapEditor;

 implementation

{$R *.DFM}

uses ResourceGraphics, unitExGraphics, ClipBrd, NewImageForm;

resourcestring
  rstPaletteChange = 'change palette';
  rstRotate270     = 'rotate 90° anticlockwise';
  rstRotate90      = 'rotate 90° clockwise';
  rstRotate180     = 'rotate 180°';
  rstResizeImage   = 'resize image';

procedure TfmBitmapEditor.DoResourceChanged;
var
  pixelFormat : TPixelFormat;
begin
  TGraphicsResource (resource).GetImage (BitmapEditor.Picture);

  pixelFormat := pfCustom;

  with BitmapEditor.Picture do
    if Graphic is TBitmap then
      pixelFormat := TBitmap (Graphic).PixelFormat
    else
      if Graphic is TIconCursor then
        pixelFormat := TIconCursor (Graphic).PixelFormat;

  if (pixelFormat >= pf1Bit) and (pixelFormat <= pf8Bit) then
    SetPalette (BitmapEditor.Picture.Graphic.Palette)
  else
    SetPalette (0);

  BitmapEditor.PictureChanged;
  imgThumbnail.Picture.Assign (Nil);
  CopyImageToThumbnailImage;

  edWidth.Text := IntToStr (BitmapEditor.Picture.Width);
  edHeight.Text := IntToStr (BitmapEditor.Picture.Height);

  cbPixelFormat.ItemIndex := Integer (pixelFormat) - 1;

  if (resource is TCursorResource) or (resource is TIconResource) then
  begin
    pnlTransparent.Visible := True;
    pomNewImageDivider.Visible := True;
    mnuNewImageDivider.Visible := True;
    actBitmapNewImage.Visible := True
  end
  else
  begin
    pnlTransparent.Visible := False;
    pomNewImageDivider.Visible := False;
    mnuNewImageDivider.Visible := False;
    actBitmapNewImage.Visible := False
  end;
  BitmapEditor.DrawPen.Color := clWhite;
  BitmapEditor.DrawBrush.Color := clBlack;
  shpFore.Brush.Color := BitmapEditor.DrawPen.Color;
  shpBack.Brush.Color := BitmapEditor.DrawBrush.Color
end;

procedure TfmBitmapEditor.actBitmapZoomInExecute(Sender: TObject);
begin
  inherited;
  BitmapEditor.ZoomIn
end;

procedure TfmBitmapEditor.actBitmapZoomOutExecute(Sender: TObject);
begin
  inherited;
  with BitmapEditor do
    if Magnification = 2 then
      Magnification := 1
    else
      if Magnification > 1 then
        Magnification := Magnification - 2
end;

procedure TfmBitmapEditor.UpdateActions;
begin
  inherited;
  actBitmapZoomIn.Enabled := BitmapEditor.Magnification < 32;
  actBitmapZoomOut.Enabled := BitmapEditor.Magnification > 1
end;

procedure TfmBitmapEditor.FormShow(Sender: TObject);
begin
  inherited;

  actBitmapZoomOut.ShortCut := ShortCut (VK_SUBTRACT, []);
  actBitmapZoomIn.ShortCut := ShortCut (VK_ADD, []);
  actBitmapZoomIn.Caption := ZoomIn1.Caption + #9#9'Keypad  +';
  actBitmapZoomOut.Caption := ZoomOut1.Caption + #9'Keypad  -';
  BitmapEditor.DrawingTool := dtPencil;
  BitmapEditor.DrawPen.Color := clWhite;
  BitmapEditor.DrawBrush.Color := clBlack;

  fPCWidth := pnlGraphics.Width;
  if pnlColours.Width > fPCWidth then
    fPCWidth := pnlColours.Width;

  pnlGraphics.Tag := fPanelNames.Add (pnlGraphics.Caption);
  pnlColours.Tag := fPanelNames.Add (pnlColours.Caption);
  pnlGraphics.Caption := '';
  pnlColours.Caption := '';

  pnlGraphics.ManualDock (SizingPageControl1, Nil, alNone);
  pnlColours.ManualDock (SizingPageControl1, Nil, alNone);

  shpFore.Brush.Color := BitmapEditor.DrawPen.Color;
  shpBack.Brush.Color := BitmapEditor.DrawBrush.Color
end;

procedure TfmBitmapEditor.tbPencilClick(Sender: TObject);
begin
  inherited;
  if Sender is TToolButton then
    BitmapEditor.DrawingTool := TDrawingTool (TToolButton (sender).Tag);
end;

procedure TfmBitmapEditor.BitmapEditorChange(Sender: TObject);
begin
  inherited;
  CopyImageToThumbnailImage;
end;

procedure TfmBitmapEditor.SaveResource (const undoDescription : string);
begin
  BitmapEditor.UpdatePicture (fPalette);
  TGraphicsResource (resource).SetImage (BitmapEditor.Picture, undoDescription);
end;

procedure TfmBitmapEditor.CopyImageToThumbnailImage;
var
  graphic : TGraphic;
  i : TIconCursor;
  colorCount : word;
begin
  case resource.RawType of
    Integer (RT_BITMAP) :
    begin
      imgThumbnail.Picture.Bitmap.Assign (bitmapEditor.DrawBmp);
      sbThumbnail.Cursor := crDefault;

      if fPalette <> 0 then
      begin
        ColorSelector1.Palette := fPalette;
        GetObject (fPalette, SizeOf (colorCount), @colorCount);
        case colorCount of
          1,2 : ColorSelector1.ColumnCount := 2;
          3..16 : ColorSelector1.ColumnCount := 4;
          17..256 : ColorSelector1.ColumnCount := 8
        end
      end
      else
      begin
        ColorSelector1.Palette := 0;
      end
    end;

    Integer (RT_ICON),
    Integer (RT_CURSOR):
      begin
        imgThumbnail.Picture.Assign (Nil);      // Need to clear transparent image each time
        if not Assigned (imgThumbnail.picture.Graphic) then
        begin
          if resource.RawType = Integer (RT_ICON) then
          begin
            graphic := TExIcon.Create;
            TExIcon (graphic).Width := TIconResource (resource).Width;
            TExIcon (graphic).Height := TIconResource (resource).Height;
            TExIcon (graphic).PixelFormat := TIconResource (resource).PixelFormat;
          end
          else
          begin
            graphic := TExCursor.Create;
            TExCursor (graphic).Width := TCursorResource (resource).Width;
            TExCursor (graphic).Height := TCursorResource (resource).Height;
            TExCursor (graphic).PixelFormat := TCursorResource (resource).PixelFormat;
            TExCursor (graphic).Hotspot := TCursorResource (resource).Hotspot
          end;
          try
            imgThumbnail.picture.Assign (graphic);
          finally
            graphic.Free
          end
        end;

        i := TIconCursor (imgThumbnail.Picture.Graphic);
        AssignIconCursorFromBitmap (i, bitmapEditor.DrawBmp, fPalette, bitmapEditor.TransparentColor);

        if resource.RawType = Integer (RT_CURSOR) then
        begin
          Screen.Cursors [20] := TExCursor (imgThumbnail.Picture.Graphic).Handle;
          sbThumbnail.Cursor := 20
        end
        else
          sbThumbnail.Cursor := crDefault;
        ColorSelector1.Palette := fPalette;
        case TIconCursor (imgThumbnail.Picture.Graphic).PixelFormat of
          pf1Bit : ColorSelector1.ColumnCount := 2;
          pf4Bit : ColorSelector1.ColumnCount := 4;
          pf8Bit : ColorSelector1.ColumnCount := 8
        end
      end;
  end
end;

procedure TfmBitmapEditor.ColorSelector1ColorSelect(Sender: TObject);
begin
  inherited;
  BitmapEditor.DrawPen.Color := ColorSelector1.ForegroundColor;
  shpFore.Brush.Color := ColorSelector1.ForegroundColor;
  BitmapEditor.DrawBrush.Color := ColorSelector1.BackgroundColor;
  shpBack.Brush.Color := ColorSelector1.BackgroundColor;
end;

procedure TfmBitmapEditor.SizingPageControl1DockDrop(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer);
var
  i : Integer;
begin
  inherited;
  with SizingPageControl1 do
  begin
    if Source.Control is TPanel then
      TPanel (Source.Control).Caption := '';

    for i := 0 to PageCount - 1 do
      Pages [i].Caption := fPanelNames [Pages [i].Controls [0].Tag];

    Width := fPCWidth + 8;
  end

end;

procedure TfmBitmapEditor.SizingPageControl1UnDock(Sender: TObject;
  Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
begin
  inherited;
  if SizingPageControl1.PageCount = 1 then
    SizingPageControl1.Width := 0;

  if Client is TPanel then
    TPanel (Client).Caption := fPanelNames [TPanel (Client).Tag];
end;

constructor TfmBitmapEditor.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  fPanelNames := TStringList.Create;
end;

destructor TfmBitmapEditor.Destroy;
begin
  fPanelNames.Free;
  SetPalette (0);
  inherited;
end;

function TfmBitmapEditor.GetEditSupport: TEditSupport;
begin
  result := inherited GetEditSupport;
  result := result + [esSelectAll, esPaste];
  if BitmapEditor.SelectionValid then
    result := result + [esCopy, esCut, esDelete];
end;

procedure TfmBitmapEditor.BitmapEditorDrawToolChange(Sender: TObject);
var
  dt : TDrawingTool;
  i : Integer;
begin
  dt := BitmapEditor.DrawingTool;

  for i := 0 to Toolbar1.ControlCount - 1 do
    if (Toolbar1.Controls [i] is TToolButton) and (Toolbar1.Controls [i].Tag = Ord (dt)) then
    begin
      TToolButton (Toolbar1.Controls [i]).Down := True;
      break
    end;

  shpFore.Brush.Color := BitmapEditor.DrawPen.Color;
  shpBack.Brush.Color := BitmapEditor.DrawBrush.Color
end;

procedure TfmBitmapEditor.ColorSelector1DblClick(Sender: TObject);
begin
  ColorDialog1.Color := BitmapEditor.DrawPen.Color;
  If ColorDialog1.Execute then
  begin
    ColorSelector1.SetSelectedPaletteColor (ColorDialog1.Color);

    SetPalette (ColorSelector1.Palette);

    BitmapEditor.DrawBmp.Palette := fPalette;
    BitmapEditor.DrawPen.Color := ColorSelector1.GetSelectedPaletteColor;
    shpFore.Brush.Color := ColorSelector1.GetSelectedPaletteColor;

    CopyImageToThumbnailImage;

    BitmapEditor.Invalidate;
    SaveResource (rstPaletteChange);
  end
end;

procedure TfmBitmapEditor.EditCopyToClipboard;
var
  s : TMemoryStream;
  data : THandle;
  dataPtr : PChar;
begin
  BitmapEditor.UpdatePicture (fPalette);
  s := TMemoryStream.Create;
  try
    BitmapEditor.Picture.Graphic.SaveToStream (s);

    s.Seek (sizeof (TBitmapFileHeader), soFromBeginning);

    // Put bitmap on clipboard in CF_DIB format, not CF_BITMAP to preserve correct
    // palette information.

    Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, s.Size - s.Position);
    try
      DataPtr := GlobalLock(Data);
      try
        Move((PChar (s.Memory) + sizeof (TBitmapFileHeader))^, DataPtr^, s.Size - s.Position);
        clipboard.SetAsHandle (CF_DIB, Data)
      finally
        GlobalUnlock(Data);
      end;
    except
      GlobalFree(Data);
      raise
    end
  finally
    s.Free
  end
end;

procedure TfmBitmapEditor.EditCutToClipboard;
begin

end;

procedure TfmBitmapEditor.EditDelete;
begin
  BitmapEditor.DeleteSelection
end;

procedure TfmBitmapEditor.EditPaste;
begin

end;

procedure TfmBitmapEditor.EditSelectAll;
begin
  BitmapEditor.SelectAll
end;

procedure TfmBitmapEditor.SetPalette(value: HPALETTE);
begin
  if fPalette <> 0 then
    DeleteObject (fPalette);

  if value <> 0 then
    fPalette := CopyPalette (value)
  else
    fPalette := 0;
end;

procedure TfmBitmapEditor.actBitmapRotate180Execute(Sender: TObject);
begin
  BitmapEditor.Rotate180;
  SaveResource (rstRotate180);
end;

procedure TfmBitmapEditor.actBitmapRotateClockwise90Execute(
  Sender: TObject);
begin
  BitmapEditor.Rotate90;
  SaveResource (rstRotate90);
end;

procedure TfmBitmapEditor.actBitmapRotateAntiClockwise90Execute(
  Sender: TObject);
begin
  BitmapEditor.Rotate270;
  SaveResource (rstRotate270);
end;

procedure TfmBitmapEditor.pnlTransparentMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    BitmapEditor.DrawPen.Color := BitmapEditor.TransparentColor
  else
    if Button = mbRight then
      BitmapEditor.DrawBrush.Color := BitmapEditor.TransparentColor;

  shpFore.Brush.Color := BitmapEditor.DrawPen.Color;
  shpBack.Brush.Color := BitmapEditor.DrawBrush.Color
end;

procedure TfmBitmapEditor.pnlTransparentDblClick(Sender: TObject);
begin
  ColorDialog1.Color := BitmapEditor.TransparentColor;
  If ColorDialog1.Execute then
  begin
    BitmapEditor.UpdatePicture (fPalette);
    BitmapEditor.TransparentColor := ColorDialog1.Color;
    pnlTransparent.Color := ColorDialog1.Color
  end
end;

procedure TfmBitmapEditor.actBitmapNewImageExecute(Sender: TObject);
var
  dlg : TfmNewImage;
  resGrp : TGroupResource;
  res : TIconCursorResource;
  nm : PWideChar;
begin
  dlg := TfmNewImage.Create (Nil);
  try
    if dlg.ShowModal = mrOK then
    begin
      resGrp := (Resource as TIconCursorResource).GetResourceGroup;


      if resource is TIconResource then
      begin
        nm := PWideChar (Resource.parent.GetUniqueResourceName (TIconResource));
        res := TIconResource.Create (Resource.Parent, nm)
      end
      else
      begin
        nm := PWideChar (Resource.parent.GetUniqueResourceName (TCursorResource));
        res := TCursorResource.Create (Resource.Parent, nm)
      end;

      res.PixelFormat := dlg.PixelFormat;
      res.Width := StrToInt (dlg.edWidth.Text);
      res.Height := StrToInt (dlg.edHeight.Text);
      res.Initialize;

      resGrp.AddResource (res)
    end
  finally
    dlg.Free
  end
end;

procedure TfmBitmapEditor.BitmapEditorEndChange(Sender: TObject);
begin
  inherited;
  SaveResource (BitmapEditor.GetDrawingChangeDescription);
end;

procedure TfmBitmapEditor.edWidthExit(Sender: TObject);
begin
  BitmapEditor.Picture.Graphic.Width := StrToInt (edWidth.Text);
  BitmapEditor.PictureChanged;
  imgThumbnail.Picture.Assign (Nil);
  CopyImageToThumbnailImage;
  SaveResource (rstResizeImage);
end;

procedure TfmBitmapEditor.edHeightExit(Sender: TObject);
begin
  BitmapEditor.Picture.Graphic.Height := StrToInt (edHeight.Text);
  BitmapEditor.PictureChanged;
  imgThumbnail.Picture.Assign (Nil);
  CopyImageToThumbnailImage;
  SaveResource (rstResizeImage);
end;

procedure TfmBitmapEditor.sbThumbnailDblClick(Sender: TObject);
begin
  ColorDialog1.Color := sbThumbnail.Color;
  If ColorDialog1.Execute then
    sbThumbnail.Color := ColorDialog1.Color;
end;

end.
