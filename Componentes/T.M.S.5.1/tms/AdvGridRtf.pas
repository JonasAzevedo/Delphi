{***************************************************************************}
{ TAdvGridRTFIO component                                                   }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 1996-2008                                          }
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
unit AdvGridRTF;

interface

{$I TMSDEFS.INC}

uses
  Windows, SysUtils, Classes, AdvGrid, BaseGrid, Controls, Grids, Graphics,
  Dialogs, ShellAPI, RTFEngine, AdvObj
  {$IFDEF TMSDOTNET}
  , WinUtils
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 1; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 1; // Build nr.

  // version history
  // v1.0.0.0 : first release
  // v1.0.0.1 : Workaround for display issue in Word with exporting grid with lots of columns
  // v1.1.0.0 : New : option ExportSelectedCells
  // v1.1.0.1 : Fixed : export of grid with Y merged cells

type

  TASGIOProgressEvent = procedure(Sender: TObject; RowNum, RowTot: integer) of object;
  TASGIOPageBreak = procedure(Sender: TObject; ARow: Integer; var DoPageBreak: boolean) of object;

  TOverwriteMode = (omNever, omAlways, omWarn);
  TExportMode = (emFile, emStream, emString);

  TASGRTFIOOptions = class(TPersistent)
  private
    //FExportCellSizes: Boolean;
    FExportCellProperties: Boolean;
    FExportHiddenColumns: Boolean;
    FExportOverwriteMessage: string;
    FExportOverwrite: TOverwriteMode;
    FConvertHTML: Boolean;
    FExportShowInWord: Boolean;
    FExportBackGround: Boolean;
    FExportMsWordFeatures: Boolean;
    FExportImages: Boolean;
    FExportRTFCell: Boolean;
    FExportSelectedCells: Boolean;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property ExportBackGround: Boolean read FExportBackGround write FExportBackGround default false;
    property ExportOverwrite: TOverwriteMode read FExportOverwrite write FExportOverwrite default omNever;
    property ExportOverwriteMessage: string read FExportOverwriteMessage write FExportOverwriteMessage;
    property ExportCellProperties: Boolean read FExportCellProperties write FExportCellProperties default True;
    //property ExportCellSizes: Boolean read FExportCellSizes write FExportCellSizes default True;
    property ExportHiddenColumns: Boolean read FExportHiddenColumns write FExportHiddenColumns default False;
    property ExportShowInWord: Boolean read FExportShowInWord write FExportShowInWord;
    property ExportMsWordFeatures: Boolean read FExportMsWordFeatures write FExportMsWordFeatures;
    property ExportImages: Boolean read FExportImages write FExportImages;
    property ConvertHTML: Boolean read FConvertHTML write FConvertHTML;
    property ExportRTFCell: Boolean read FExportRTFCell write FExportRTFCell;
    property ExportSelectedCells: Boolean read FExportSelectedCells write FExportSelectedCells default false;
  end;

  TProGrid = class(TAdvStringGrid)
  end;

  TAdvGridRTFIO = class(TComponent)
  private
    FAdvStringGrid: TAdvStringGrid;
    //FAutoResizeGrid: boolean;
    FOptions : TASGRTFIOOptions;
    FOnProgress: TASGIOProgressEvent;
    FGridStartRow: integer;
    FGridStartCol: integer;
    FOnPageBreak: TASGIOPageBreak;
    procedure SetAdvStringGrid(const Value: TAdvStringGrid);
    function CurrentGrid: TProGrid;
    procedure SetOptions(const Value: TASGRTFIOOptions);
    procedure SetGridStartCol(const Value: integer);
    procedure SetGridStartRow(const Value: integer);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    procedure ExportInternal(FileName: TFileName; st: TStream; var S: String; ExportMode: TExportMode);
  protected
    function GetVersionNr: Integer; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ExportRTF(Const FileName: TFileName);
    function ExportToString: string;
    procedure ExportToStream(st: TStream);
  published
    property AdvStringGrid: TAdvStringGrid read FAdvStringGrid write SetAdvStringGrid;
    //property AutoResizeGrid: Boolean read FAutoResizeGrid write FAutoResizeGrid default true;
    property GridStartRow: integer read FGridStartRow write SetGridStartRow default 1;
    property GridStartCol: integer read FGridStartCol write SetGridStartCol default 1;
    property Options: TASGRTFIOOptions read FOptions write SetOptions;
    property Version: string read GetVersion write SetVersion;

    //Events
    property OnProgress: TASGIOProgressEvent read FOnProgress write FOnProgress;
    property OnPageBreak: TASGIOPageBreak read FOnPageBreak write FOnPageBreak;
  end;

procedure Register;

implementation
{$R *.RES}

{$IFNDEF DELPHI5_LVL}
procedure FreeAndNil(var Obj);
var
  Temp: TObject;
begin
  Temp := TObject(Obj);
  Pointer(Obj) := nil;
  Temp.Free;
end;
{$ENDIF}

//------------------------------------------------------------------------------

procedure Register;
begin
  RegisterComponents('TMS Grids', [TAdvGridRTFIO]);
end;

//------------------------------------------------------------------------------

function IsHyperLink(Text: String): Boolean;
begin
  Result := (pos('http://', Text) > 0) or (pos('file://', Text) > 0) or (pos('ftp://', Text) > 0)
             or (pos('nntp://', Text) > 0) or (pos('https://', Text) > 0) or (pos('mailto:', Text) > 0);
end;

//------------------------------------------------------------------------------

{ TASGRTFIOOptions }

procedure TASGRTFIOOptions.Assign(Source: TPersistent);
begin
  if Source is TASGRTFIOOptions then
  begin
    FExportCellProperties := (Source as TASGRTFIOOptions).FExportCellProperties;
    //FExportCellSizes := (Source as TASGRTFIOOptions).FExportCellSizes;
    FExportHiddenColumns := (Source as TASGRTFIOOptions).FExportHiddenColumns;
    FExportOverwrite := (Source as TASGRTFIOOptions).FExportOverwrite;
    FExportOverwriteMessage := (Source as TASGRTFIOOptions).FExportOverwriteMessage;
    FExportSelectedCells := (Source as TASGRTFIOOptions).FExportSelectedCells;

    FExportBackGround := (Source as TASGRTFIOOptions).FExportBackGround;
    FExportShowInWord:= (Source as TASGRTFIOOptions).FExportShowInWord;
    FExportMsWordFeatures := (Source as TASGRTFIOOptions).FExportMsWordFeatures;
    FConvertHTML := (Source as TASGRTFIOOptions).FConvertHTML;
    FExportRTFCell := (Source as TASGRTFIOOptions).FExportRTFCell;
  end;
end;

//------------------------------------------------------------------------------

constructor TASGRTFIOOptions.Create;
begin
  inherited Create;
  FExportCellProperties := True;
  //FExportCellSizes := True;
  FExportHiddenColumns := False;
  FExportOverwrite := omNever;
  FExportOverwriteMessage := 'File already exists'#13'Ok to overwrite ?';
  FConvertHTML := True;
  FExportBackGround := False;
  FExportMsWordFeatures := True;
  FExportImages := False;
  FExportRTFCell := True;
end;

//------------------------------------------------------------------------------

{ TAdvGridRTFIO }

constructor TAdvGridRTFIO.Create(AOwner: TComponent);
begin
  inherited;
  //FAutoResizeGrid := true;
  FGridStartCol := 1;
  FGridStartRow := 1;
  FOptions := TASGRTFIOOptions.Create;
end;

//------------------------------------------------------------------------------

function TAdvGridRTFIO.CurrentGrid: TProGrid;
begin
  Result := TProGrid(FAdvStringGrid);
end;

//------------------------------------------------------------------------------

destructor TAdvGridRTFIO.Destroy;
begin
  FOptions.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvGridRTFIO.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FAdvStringGrid then
      FAdvStringGrid := nil;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvGridRTFIO.SetGridStartCol(const Value: integer);
begin
  if Value >= 0 then FGridStartCol := Value else FGridStartCol := 1;
end;

//------------------------------------------------------------------------------

procedure TAdvGridRTFIO.SetGridStartRow(const Value: integer);
begin
  if Value >= 0 then FGridStartRow := Value else FGridStartRow := 1;
end;

//------------------------------------------------------------------------------

procedure TAdvGridRTFIO.SetAdvStringGrid(const Value: TAdvStringGrid);
begin
  FAdvStringGrid := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvGridRTFIO.SetOptions(const Value: TASGRTFIOOptions);
begin
  FOptions.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvGridRTFIO.ExportRTF(const FileName: TFileName);
var
  S: string;
begin
  S := '';
  ExportInternal(FileName, nil, S, emFile);
end;

//------------------------------------------------------------------------------

procedure TAdvGridRTFIO.ExportInternal(FileName: TFileName; st: TStream;
  var S: String; ExportMode: TExportMode);
var
  rg, cg: integer;
  AState: TGridDrawState;
  ABrush: TBrush;
  AColorTo,AMirrorColor,AMirrorColorTo: TColor;
  AFont: TFont;
  HA: TAlignment;
  VA: TVAlignment; WW: Boolean;
  cp: TCellProperties;
  HiddenCount: Integer;
  CReal, i: Integer;
  CellData: String;
  MergeColWidth, cs: Integer;
  MergedCol: Boolean;
  RTFEngine: TRTFEngine;
  DoPageBreak: Boolean;
  Pic: TPicture;
  CellGraphic: TCellGraphic;
  CellDataAdded: Boolean;
  ImageAdded: Boolean;
  GD: TCellGradientDirection;
  skipCell: Boolean;

  function RowHasMergedCells(ARow: integer): boolean;
  var
    i: integer;
  begin
    Result := false;
    for i := GridStartCol to CurrentGrid.ColCount - 1 do
      if CurrentGrid.IsMergedCell(i, ARow) then
      begin
        if not CurrentGrid.IsYMergedCell(i, ARow) and CurrentGrid.IsXMergedCell(i, ARow) then   // FF: Row merge iss
        begin
        Result := true;
        Break;
      end;
    end;
  end;

  function cellwidth(Col, Row: integer; var CellSpan: Integer): integer;
  var
    pt: tpoint;
    i: integer;
  begin
    result := CurrentGrid.colWidths[col];
    pt := CurrentGrid.CellSpan(col,row);
    CellSpan := pt.X;
    if pt.x >= 1 then
      for i := 1 to pt.X {-1}do
      begin
        result := result + CurrentGrid.ColWidths[col + i]{ + CurrentGrid.gridlinewidth};
      end;
  end;

  procedure AddCellGraphics(CellGraphic: TCellGraphic);
  var
    APic: TPicture;
    bmp: TBitMap;
    idx: Integer;
  begin
    if CellGraphic <> nil then
    begin
      if ((CellGraphic.CellHAlign = haAfterText) or (CellGraphic.CellVAlign = vaUnderText)) and not CellDataAdded then
        Exit;

      if ImageAdded then
        Exit;
          
      APic := TPicture.Create;
      case CellGraphic.CellType of
        ctBitmap:
        begin
          APic.Bitmap := CellGraphic.CellBitmap;
          RTFEngine.AddPicture(APic);
          ImageAdded := True;
        end;
        ctIcon:
        begin
          APic.Graphic := CellGraphic.CellIcon;
          RTFEngine.AddPicture(APic);
          ImageAdded := True;
        end;
        ctImageList:
        begin
          if Assigned(CurrentGrid.GridImages) then
          begin
            bmp := TBitMap.Create;
            bmp.Height := CurrentGrid.GridImages.Height;
            bmp.Width := CurrentGrid.GridImages.Width;
            CurrentGrid.GridImages.Draw(bmp.Canvas, 0, 0, CellGraphic.CellIndex);
            APic.Bitmap := bmp;
            RTFEngine.AddPicture(APic);
            bmp.Free;
            ImageAdded := True;
          end;
        end;
        ctImages:
        begin
          if Assigned(CurrentGrid.GridImages) then
          begin
            ImageAdded := True;
            {$IFDEF TMSDOTNET}
            for idx := 1 to CellGraphic.CellList.Count do
            begin
               bmp := TBitMap.Create;
               bmp.Height := CurrentGrid.GridImages.Height;
               bmp.Width := CurrentGrid.GridImages.Width;
               CurrentGrid.GridImages.Draw(bmp.Canvas, 0, 0,CellGraphic.CellList.Items[idx-1]);
               APic.Bitmap := bmp;
               RTFEngine.AddPicture(APic);
               if not CellGraphic.CellBoolean then
                 RTFEngine.AddNewLine;
               bmp.Free;
            end;
            {$ENDIF}

            {$IFNDEF TMSDOTNET}
            for idx := 1 to TIntList(CellGraphic.CellBitmap).Count do
            begin
               bmp := TBitMap.Create;
               bmp.Height := CurrentGrid.GridImages.Height;
               bmp.Width := CurrentGrid.GridImages.Width;
               CurrentGrid.GridImages.Draw(bmp.Canvas, 0, 0,TIntList(CellGraphic.CellBitmap).Items[idx-1]);
               APic.Bitmap := bmp;
               RTFEngine.AddPicture(APic);
               if not CellGraphic.CellBoolean then
                 RTFEngine.AddNewLine;
               bmp.Free;
            end;
            {$ENDIF}
          end;
        end;
        ctPicture:
        begin

        end;
      end;
      APic.Free;
    end;
  end;

begin
  if CurrentGrid = nil then
    raise Exception.Create('There is no AdvStringGrid assigned to this component');

  case ExportMode of
    emFile:   if (FileName = '') then raise Exception.Create('Invalid File Name');
    emStream: if not Assigned(st) then raise Exception.Create('Invalid Stream');
  end;

  if ExportMode = emFile then
  begin
    case Options.ExportOverwrite of
    omAlways:
      begin
        if FileExists(FileName) then
          DeleteFile(FileName);
      end;
    omWarn:
      begin
        if FileExists(FileName) then
        begin
          if MessageDlg(Format(Options.ExportOverwriteMessage,[FileName]),mtCOnfirmation,[mbYes,mbNo],0) = mrYes then
            DeleteFile(FileName)
          else
            Exit;
        end;
      end;
    omNever:
      if FileExists(FileName) then
        Exit;
    end;
  end;

  RTFEngine := TRTFEngine.Create;
  RTFEngine.Images := CurrentGrid.GridImages;

 {
  if Options.ExportCellSizes then
  begin
    for rg := GridStartRow to CurrentGrid.RowCount - 1 do
    begin
      rx := rg - GridStartRow + XlsStartRow;
      Workbook.RowHeight[rx] := Round(CurrentGrid.RowHeights[rg] * RowMult / Zoom100) - CellOfs;
    end;

    for cg := GridStartCol to CurrentGrid.ColCount - 1 do
    begin
      cx := cg - GridStartCol + XlsStartCol;
      Workbook.ColumnWidth[cx] := Round(CurrentGrid.ColWidths[cg] * ColMult / Zoom100) - CellOfs;
    end;
  end;
  }

  RTFEngine.AddFont(CurrentGrid.Font);
  RTFEngine.AddForeColor(CurrentGrid.Font.Color);
  RTFEngine.AddNewLine; // Extra new line added to avoid msword issue
  RTFEngine.StartTable(taCenter);
  if RowHasMergedCells(GridStartRow) then
  begin
    i:= GridStartCol;
    MergedCol := True;
    while i <= CurrentGrid.ColCount-1 do
    begin
      MergeColWidth := cellwidth(i, GridStartRow, cs);
      RTFEngine.AddColumn(MergeColWidth*14);
      i := i + cs + 1;
    end;
  end
  else
  begin
    MergedCol := False;
    for i:= GridStartCol to CurrentGrid.ColCount-1 do
      RTFEngine.AddColumn(CurrentGrid.ColWidths[i]*14);
  end;

  CurrentGrid.ExportNotification(esExportStart,-1);

  HiddenCount := CurrentGrid.NumHiddenColumns;

  if Options.ExportHiddenColumns then
    CurrentGrid.ColCount := CurrentGrid.ColCount + HiddenCount;

  //Export data
  for rg := GridStartRow to CurrentGrid.RowCount - 1 do
  begin
    if (rg > GridStartRow) then
    begin
      if RowHasMergedCells(rg) then
      begin
        i:= GridStartCol;
        MergedCol := True;
        RTFEngine.ReDefColWidth;
        while i <= CurrentGrid.ColCount-1 do
        begin
          MergeColWidth := cellwidth(i, rg, cs);
          RTFEngine.AddColumn(MergeColWidth*14);
          i := i + cs + 1;
        end;
      end
      else
      begin
        if MergedCol then
        begin
          MergedCol := False;
          RTFEngine.ReDefColWidth;
          for i:= GridStartCol to CurrentGrid.ColCount-1 do
            RTFEngine.AddColumn(CurrentGrid.ColWidths[i]*14);
        end;
      end;

    end;

    RTFEngine.StartRow;
    CurrentGrid.ExportNotification(esExportNewRow,rg);

    for cg := GridStartCol to CurrentGrid.ColCount - 1 do
    begin
      CellDataAdded := False;
      ImageAdded := False;
      
      if Options.ExportHiddenColumns then
        creal := cg
      else
        creal := CurrentGrid.RealColIndex(cg);

      //Merged Cells
      cp:= TCellProperties(CurrentGrid.GridObjects[cg,rg]);
      if (cp <> nil) and not (cp.IsBaseCell) and not CurrentGrid.IsYMergedCell(cg, rg) then
        Continue;                                // FF: Row merge Iss

      AFont := TFont.Create;
      try
        ABrush := TBrush.Create;
        ABrush.Color := CurrentGrid.Color;
        try
          CurrentGrid.GetVisualProperties(cg, rg, AState, false, false, not Options.ExportHiddenColumns , ABrush, AColorTo,AMirrorColor,AMirrorColorTo, AFont, HA, VA, WW, GD);

          if Self.Options.FExportCellProperties then
          begin
            RTFEngine.AddFont(AFont);
            if (RTFEngine.FonSize <> AFont.Size*2) or (cg = GridStartCol) then
              RTFEngine.AddFontSize(AFont.Size*2);
            if (RTFEngine.ForeColor <> AFont.Color) or (cg = GridStartCol) then
              RTFEngine.AddForeColor(AFont.Color);

            if (RTFEngine.HAlignment <> HA) or (cg = GridStartCol) then
              RTFEngine.AddHAlignment(HA);
            if (fsBold in Afont.Style) then
            begin
              if not RTFEngine.Bold then
                RTFEngine.AddBold(True);
            end
            else
            begin
              if RTFEngine.Bold then
                RTFEngine.AddBold(False);
            end;

            if (fsItalic in Afont.Style) then
            begin
              if not RTFEngine.Italic then
                RTFEngine.AddItalic(True);
            end
            else
            begin
              if RTFEngine.Italic then
                RTFEngine.AddItalic(False);
            end;

            if (fsUnderLine in Afont.Style) then
            begin
              if not RTFEngine.UnderLine then
                RTFEngine.AddUnderLine(True);
            end
            else
            begin
              if RTFEngine.UnderLine then
                RTFEngine.AddUnderLine(False);
            end;

          end;

          if Options.ExportBackGround and Options.ExportMsWordFeatures and (ABrush.Color <> clWhite) and (ABrush.Color <> clWindow) then
          begin
            {if (ABrush.Color = clBtnFace) then
              RTFEngine.AddCellColor(clGray)
            else }
              RTFEngine.AddCellColor(ABrush.Color);
          end;

        finally
          FreeAndNil(ABrush);
        end; //finally
      finally
        FreeAndNil(AFont);
      end; //finally

      skipCell := Options.ExportSelectedCells and not CurrentGrid.SelectedCells[creal, rg] and not (CurrentGrid.IsFixed(cg, rg));

      // Checkbox
      CellGraphic := CurrentGrid.CellGraphics[{cg}creal, rg];
      if (CellGraphic <> nil) and not skipCell then
      begin
        if (CellGraphic.CellType in [ctCheckBox, ctDataCheckBox]) then
        begin
          Pic := TPicture.Create;
          if CellGraphic.CellBoolean then
            Pic.Bitmap.LoadFromResourceName(hinstance,'ASGRTFCHK01')
          else
            Pic.Bitmap.LoadFromResourceName(hinstance,'ASGRTFCHK02');
          RTFEngine.AddPicture(Pic);
          Pic.Free;
        end
        else
          AddCellGraphics(CellGraphic);
      end;

      CellData := CurrentGrid.SaveCell(creal, rg);
      if skipCell then
        CellData := '';

      // do not export text of a checkbox
      //if CurrentGrid.HasCheckBox(creal,rg) then
        //CellData := '';

      if (Pos('{\rtf', CellData) > 0) then
      begin
        if Options.ExportRTFCell then
        begin
          RTFEngine.AddRTF(CellData);
        end
        else
        begin
          CurrentGrid.CellToRich(creal, rg, CurrentGrid.RichEdit);
          CellData := CurrentGrid.RichEdit.Text;
          RTFEngine.AddText(CellData);
        end;
      end
      else if (pos('</',CellData) > 0) and Options.ConvertHTML then
      begin
        {aFont := TFont.Create;
        CellData := HTMLToRTF(CellData, aFont, RTFEngine);
        aFont.Free; }
        RTFEngine.AddHTML(CellData);
      end
      else if IsHyperLink(CellData) and CurrentGrid.URLShow then
      begin
        aFont := TFont.Create;
        aFont.Assign(CurrentGrid.Font);
        aFont.Color := CurrentGrid.URLColor;
        RTFEngine.AddHyperLink(CellData, CellData, aFont);
        aFont.Free;
      end
      else
        RTFEngine.AddText(CellData);
        
      CellDataAdded := True;

      if (CellGraphic <> nil) and not skipCell then
        AddCellGraphics(CellGraphic);
        
      //Export Images
      Pic := CurrentGrid.GetPicture(cg, rg);
      if Options.ExportImages and (Pic <> nil) and not skipCell then
      begin
        RTFEngine.AddPicture(Pic);
      end;

      RTFEngine.NextCell;
    end;
    RTFEngine.EndRow;

    if Assigned(FOnPageBreak) then
    begin
      DoPageBreak := False;
      FOnPageBreak(self, rg - GridStartRow, DoPageBreak);
      if DoPageBreak then
        RTFEngine.AddPageBreak;
    end;

    if Assigned(FOnProgress) then
      FOnProgress(Self, rg - GridStartRow, CurrentGrid.RowCount - 1 - GridStartRow);
  end;
  RTFEngine.EndTable;

  case ExportMode of
    emFile: RTFEngine.SaveToFile(FileName);
    {$IFNDEF TMSDOTNET}
    emStream: RTFEngine.SaveToStream(st);
    {$ENDIF}
    emString: S := RTFEngine.GetText;
  end;

    {     if ColorToRGB(ABrush.Color) = $FFFFFF then
          begin
            Fm.FillPattern.Pattern := 1; //no fill
          end else
          begin
            Fm.FillPattern.Pattern := 2; //Solid fill
            Fm.FillPattern.FgColorIndex := MatchNearestColor(Workbook, ColorToRGB(ABrush.Color));
          end;

          if FUseUnicode then
            w := SupressCR(CurrentGrid.WideCells[creal, rg])
          else
            w := SupressCR(CurrentGrid.SaveCell(creal, rg));

          Formula := SupressCR(CurrentGrid.SaveCell(creal, rg));

          if not Options.ExportHTMLTags then
          begin
            StringReplace(w,'<br>','#13#10',[rfReplaceAll, rfIgnoreCase]);
          end;

          if (pos('</',w) > 0) and not Options.ExportHTMLTags then
            w := HTMLStrip(w);

          //Cell Align
          case HA of
            taLeftJustify: Fm.HAlignment := fha_left;
            taCenter: Fm.HAlignment := fha_center;
            taRightJustify: Fm.HAlignment := fha_right;
          else Fm.HAlignment := fha_general;
          end; //case

          case VA of
            vtaTop: Fm.VAlignment := fva_top;
            vtaCenter: Fm.VAlignment := fva_center;
          else Fm.VAlignment := fva_bottom;
          end; //case

          if Assigned(OnCellFormat) then
            OnCellFormat(CurrentGrid, creal, rg, cx, rx, w, Fm);

              Workbook.CellValue[rx, cx] := w;
              if Options.ExportCellProperties then
              begin
                Workbook.CellFormat[rx, cx] := Workbook.AddFormat(Fm);
              CopyFmToMerged(Workbook, cp, rx, cx, Fm) ;
              end;
            end;
          end;
        finally
          FreeAndNil(ABrush);
        end; //finally
      finally
        FreeAndNil(AFont);
      end; //finally

    end;

    //Export Nodes
    if Options.ExportCellProperties then
      if (CurrentGrid.GetNodeLevel(rg)>=0) and (CurrentGrid.GetNodeLevel(rg)<=7) then
        Workbook.SetRowOutlineLevel(rx+1, rx+CurrentGrid.GetNodeSpan(rg)-1, CurrentGrid.GetNodeLevel(rg));
  end;
  }
  CurrentGrid.ExportNotification(esExportDone,-1);

  if Options.ExportHiddenColumns then
    CurrentGrid.ColCount := CurrentGrid.ColCount - HiddenCount;

  RTFEngine.Free;

  if Options.ExportShowInWord and (ExportMode = emFile) then
  {$IFNDEF TMSDOTNET}
    ShellExecute(0,'open',pchar(FileName),nil,nil,SW_NORMAL);
  {$ENDIF}
  {$IFDEF TMSDOTNET}
    ShellExecute(0,'open',FileName,'','',SW_NORMAL);  
  {$ENDIF}

end;

//------------------------------------------------------------------------------

function TAdvGridRTFIO.ExportToString: string;
begin
  ExportInternal('', nil, Result, emString);
end;

//------------------------------------------------------------------------------

procedure TAdvGridRTFIO.ExportToStream(st: TStream);
var
  S: String;
begin
  S := '';
  ExportInternal('', st, S, emStream);
end;

//------------------------------------------------------------------------------

function TAdvGridRTFIO.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

//------------------------------------------------------------------------------

procedure TAdvGridRTFIO.SetVersion(const Value: string);
begin

end;

//------------------------------------------------------------------------------

function TAdvGridRTFIO.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

//------------------------------------------------------------------------------

end.
