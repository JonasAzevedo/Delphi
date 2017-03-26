{***************************************************************************}
{ TAdvCardList component                                                    }
{ for Delphi & C++Builder                                                   }
{ version 1.0                                                               }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2005 - 2007                                        }
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

unit AdvCardListStyler;

interface

uses
  Classes, AdvCardList, Graphics, Controls, AdvStyleIF;

const
  TMS_COLOR_MENUBAR = 30;
  clSystemColor = $FF000000;
  clMenuBar = TColor(clSystemColor or TMS_COLOR_MENUBAR);
  clCream = TColor($F0FBFF);

type

  TAdvCardListStyle = (clsXPBlue, clsAquaBlue, clsSilverFox, clsBasicBeige, clsTerminalGreen2, clsMacOS, clsOffice2003, clsOffice2007Luna, clsOffice2007Obsidian, clsWhidbey, clsOffice2007Silver);

  TAdvCustomCardListStyler = class(TComponent)
  private
    FCardList: TCustomAdvCardList;
    procedure SetCardList(const Value: TCustomAdvCardList);
  protected
    procedure ApplyStyle; virtual;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;    
  published
    property CardList: TCustomAdvCardList read FCardList write SetCardList;
  end;

  TAdvCardListStyler = class(TAdvCustomCardListStyler, ITMSStyle)
  private
    FStyle: TAdvCardListStyle;
    procedure SetStyle(const Value: TAdvCardListStyle);
  protected
    procedure ApplyStyle; override;
  public
    procedure SetComponentStyle(AStyle: TTMSStyle);
  published
    property Style: TAdvCardListStyle read FStyle write SetStyle default clsXPBlue;
  end;

implementation

{ TAdvCardListStyler }

procedure TAdvCardListStyler.ApplyStyle;
begin
  inherited;
  SetStyle(FStyle);
end;

procedure TAdvCardListStyler.SetComponentStyle(AStyle: TTMSStyle);
begin
  case AStyle of
    tsOffice2003Blue: Style := clsXPBlue;
    tsOffice2003Olive: Style := clsXPBlue;
    tsOffice2003Silver: Style := clsXPBlue;
    tsOffice2003Classic: Style := clsOffice2003;
    tsOffice2007Luna: Style := clsOffice2007Luna;
    tsOffice2007Obsidian: Style := clsOffice2007Obsidian;
    tsWindowsXP: Style := clsOffice2003;
    tsWhidbey: Style := clsWhidbey;
    tsOffice2007Silver: Style := clsOffice2007Silver;    
  end;
end;


procedure TAdvCardListStyler.SetStyle(const Value: TAdvCardListStyle);

  procedure ApplyTemplate;
  var
    i: Integer;
  begin
     for i := 1 to CardList.CardTemplate.Items.Count do
     begin
       CardList.CardTemplate.Items[i - 1].AssignVisuals(CardList.CardTemplate.DefaultItem);
     end;
  end;

begin
  FStyle := Value;
  if not Assigned(CardList) then
    Exit;

  case FStyle of
  clsAquaBlue :
    begin
     with CardList.Color do
      begin
        Color := $00E6E0B0;
        ColorTo := clWhite;
        Direction := gdHorizontal;
      end;
      with CardList.CardNormalAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvSpace;

        BorderColor := clNone;
        BorderWidth := 0;

        CaptionBorderColor := clHighlight;
        CaptionBorderWidth := 1;
        CaptionColor.Color := $00FEF17E;
        CaptionColor.ColorTo := $00D08130;
        CaptionColor.Direction := gdHorizontal;
        CaptionFont.Color := clBlack;
        CaptionFont.Name := 'Tahoma';
        CaptionFont.Size := 10;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := clWhite;
        Color.Direction := gdHorizontal;

        Enabled := true;

        ItemEditFont.Color := $00D08130;
        ItemEditFont.Name := 'Tahoma';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := $00D08130;
        ItemLabelFont.Name := 'Tahoma';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [fsBold];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
      with CardList.CardHoverAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvSpace;

        BorderColor := clNone;
        BorderWidth := 0;

        CaptionBorderColor := clHighlight;
        CaptionBorderWidth := 1;
        CaptionColor.Color := $00F9FFBF;
        CaptionColor.ColorTo := $00E6E0B0;
        CaptionColor.Direction := gdHorizontal;
        CaptionFont.Color := $00D08130;
        CaptionFont.Name := 'Tahoma';
        CaptionFont.Size := 10;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := $00E6E0B0;
        Color.Direction := gdHorizontal;

        Enabled := true;

        ItemEditFont.Color := $00D08130;
        ItemEditFont.Name := 'Tahoma';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := $00D08130;
        ItemLabelFont.Name := 'Tahoma';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [fsBold];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
      with CardList.CardSelectedAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvSpace;

        BorderColor := clNone;
        BorderWidth := 0;

        CaptionBorderColor := clHighlight;
        CaptionBorderWidth := 1;
        CaptionColor.Color := $00FEF17E;
        CaptionColor.ColorTo := $00D08130;
        CaptionColor.Direction := gdHorizontal;
        CaptionFont.Color := $000080FF;
        CaptionFont.Name := 'Tahoma';
        CaptionFont.Size := 10;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := $00E6E0B0;
        Color.Direction := gdHorizontal;

        Enabled := true;

        ItemEditFont.Color := $00D08130;
        ItemEditFont.Name := 'Tahoma';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := $00D08130;
        ItemLabelFont.Name := 'Tahoma';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [fsBold];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
      with CardList.CardEditingAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvSpace;

        BorderColor := clNone;
        BorderWidth := 0;

        CaptionBorderColor := clHighlight;
        CaptionBorderWidth := 1;
        CaptionColor.Color := $00FEF17E;
        CaptionColor.ColorTo := $00D08130;
        CaptionColor.Direction := gdHorizontal;
        CaptionFont.Color := $000080FF;
        CaptionFont.Name := 'Tahoma';
        CaptionFont.Size := 10;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := clWhite;
        Color.Direction := gdHorizontal;

        Enabled := true;

        ItemEditFont.Color := $00D08130;
        ItemEditFont.Name := 'Tahoma';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := $00D08130;
        ItemLabelFont.Name := 'Tahoma';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [fsBold];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
    with CardList.CardTemplate do
        CardCaptionAlignment := taLeftJustify;

    with CardList.CardTemplate.DefaultItem do
      begin
        CaptionFont.Name := 'Tahoma';
        CaptionColor := clNone;
        ValueFont.Name := 'Tahoma';
        ValueColor := clNone;
        EditColor := clNone;
      end;
  end;
  clsSilverFox :
    begin
     with CardList.Color do
      begin
        Color := $00F0F0F0;
        ColorTo := $00F0F0F0;
        Direction := gdVertical;
      end;
      with CardList.CardNormalAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clNone;
        BorderWidth := 0;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 1;
        CaptionColor.Color := clWhite;
        CaptionColor.ColorTo := $00C5BAB7;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clWindowText;
        CaptionFont.Name := 'Tahoma';
        CaptionFont.Size := 10;
        CaptionFont.Style := [fsBold];

        Color.Color := $00E4DCDA;
        Color.ColorTo := $00E4DCDA;
        Color.Direction := gdHorizontal;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Tahoma';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Tahoma';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
     with CardList.CardHoverAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clNone;
        BorderWidth := 0;

        CaptionBorderColor := $006A240A;
        CaptionBorderWidth := 1;
        CaptionColor.Color := $00D2BDB5;
        CaptionColor.ColorTo := $00D2BDB5;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := $000000B0;
        CaptionFont.Name := 'Tahoma';
        CaptionFont.Size := 10;
        CaptionFont.Style := [fsBold];

        Color.Color := $00E4DCDA;
        Color.ColorTo := $00E4DCDA;
        Color.Direction := gdHorizontal;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Tahoma';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Tahoma';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
     with CardList.CardSelectedAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clNone;
        BorderWidth := 0;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 1;
        CaptionColor.Color := clWhite;
        CaptionColor.ColorTo := $00D2BDB5;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clWindowText;
        //CaptionFont.Name := 'Tahoma';
        CaptionFont.Size := 10;
        CaptionFont.Style := [fsBold];

        Color.Color := $00E4DCDA;
        Color.ColorTo := $00E4DCDA;
        Color.Direction := gdHorizontal;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Tahoma';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Tahoma';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
     with CardList.CardEditingAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clNone;
        BorderWidth := 0;

        CaptionBorderColor := $006A240A;
        CaptionBorderWidth := 1;
        CaptionColor.Color := clWhite;
        CaptionColor.ColorTo := $00D2BDB5;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := $000000B0;
        CaptionFont.Name := 'Tahoma';
        CaptionFont.Size := 10;
        CaptionFont.Style := [fsBold];

        Color.Color := $00E4DCDA;
        Color.ColorTo := $00E4DCDA;
        Color.Direction := gdHorizontal;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Tahoma';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Tahoma';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
    with CardList.CardTemplate do
        CardCaptionAlignment := taLeftJustify;

    with CardList.CardTemplate.DefaultItem do
      begin
        CaptionFont.Name := 'Tahoma';
        CaptionColor := clNone;
        ValueFont.Name := 'Tahoma';
        ValueColor := clNone;
        EditColor := clNone;
      end;
    end;
  clsBasicBeige :
    begin
     with CardList.Color do
      begin
        Color := clWhite;
        ColorTo := clMenuBar;
        Direction := gdVertical;
      end;
      with CardList.CardNormalAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clInactiveBorder;
        BorderWidth := 1;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 0;
        CaptionColor.Color := clCream;
        CaptionColor.ColorTo := clMenuBar;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clOlive;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 10;
        CaptionFont.Style := [fsBold];

        Color.Color := clBtnFace;
        Color.ColorTo := clScrollBar;
        Color.Direction := gdHorizontal;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 9;
        ItemEditFont.Style := [fsBold];
        ItemLabelFont.Color := clOlive;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 9;
        ItemLabelFont.Style := [fsBold, fsUnderline];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
     with CardList.CardHoverAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clInactiveBorder;
        BorderWidth := 1;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $00D9FFFF;
        CaptionColor.ColorTo := $00C1FFFE;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clOlive;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 10;
        CaptionFont.Style := [fsBold];

        Color.Color := clBtnFace;
        Color.ColorTo := clScrollBar;
        Color.Direction := gdHorizontal;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 9;
        ItemEditFont.Style := [fsBold];
        ItemLabelFont.Color := clOlive;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 9;
        ItemLabelFont.Style := [fsBold, fsUnderline];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
    with CardList.CardSelectedAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clActiveBorder;
        BorderWidth := 1;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $00D7EDED;
        CaptionColor.ColorTo := $008AC2C1;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clMaroon;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 10;
        CaptionFont.Style := [fsBold];

        Color.Color := clBtnFace;
        Color.ColorTo := clScrollBar;
        Color.Direction := gdHorizontal;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        //ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 9;
        ItemEditFont.Style := [fsBold];
        ItemLabelFont.Color := clOlive;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 9;
        ItemLabelFont.Style := [fsBold, fsUnderline];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
   with CardList.CardEditingAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clMaroon;
        BorderWidth := 1;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $00D7EDED;
        CaptionColor.ColorTo := $008AC2C1;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clMaroon;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 10;
        CaptionFont.Style := [fsBold];

        Color.Color := clBtnFace;
        Color.ColorTo := clScrollBar;
        Color.Direction := gdHorizontal;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 9;
        ItemEditFont.Style := [fsBold];
        ItemLabelFont.Color := clOlive;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 9;
        ItemLabelFont.Style := [fsBold, fsUnderline];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;
    end;
    with CardList.CardTemplate do
        CardCaptionAlignment := taCenter;

    with CardList.CardTemplate.DefaultItem do
      begin
        CaptionFont.Name := 'MS Sans Serif';
        CaptionColor := clNone;
        ValueFont.Name := 'MS Sans Serif';
        ValueColor := clNone;
        EditColor := clNone;
      end;
    end;
  clsTerminalGreen2 :
    begin
     with CardList.Color do
      begin
        Color := clWhite;
        ColorTo := $00EEFDF3;
        Direction := gdVertical;
      end;
      with CardList.CardNormalAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvRaised;

        BorderColor := clGreen;
        BorderWidth := 1;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $0089E0B7;
        CaptionColor.ColorTo := clWhite;
        CaptionColor.Direction := gdHorizontal;
        CaptionFont.Color := clGray;
        CaptionFont.Name := 'Verdana';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold, fsItalic];

        Color.Color := clWhite;
        Color.ColorTo := $00BAF5D0;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Arial';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Arial';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
     with CardList.CardHoverAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvRaised;

        BorderColor := clGreen;
        BorderWidth := 1;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $0089E0B7;
        CaptionColor.ColorTo := clWhite;
        CaptionColor.Direction := gdHorizontal;
        CaptionFont.Color := $000080FF;
        CaptionFont.Name := 'Verdana';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold, fsItalic];

        Color.Color := clWhite;
        Color.ColorTo := $00BAF5D0;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Arial';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Arial';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
    with CardList.CardSelectedAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvRaised;

        BorderColor := $000080FF;
        BorderWidth := 1;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $0089E0B7;
        CaptionColor.ColorTo := $0089E0B7;
        CaptionColor.Direction := gdHorizontal;
        CaptionFont.Color := $000080FF;
        CaptionFont.Name := 'Verdana';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold, fsItalic];

        Color.Color := clWhite;
        Color.ColorTo := $00BAF5D0;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Arial';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Arial';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
   with CardList.CardEditingAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvRaised;

        BorderColor := $000080FF;
        BorderWidth := 1;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $0089E0B7;
        CaptionColor.ColorTo := $0089E0B7;
        CaptionColor.Direction := gdHorizontal;
        CaptionFont.Color := $000080FF;
        CaptionFont.Name := 'Verdana';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold, fsItalic];

        Color.Color := clWhite;
        Color.ColorTo := clWhite;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Arial';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Arial';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
    with CardList.CardTemplate do
        CardCaptionAlignment := taLeftJustify;

    with CardList.CardTemplate.DefaultItem do
      begin
        CaptionFont.Name := 'Arial';
        CaptionColor := clNone;
        ValueFont.Name := 'Arial';
        ValueColor := clInfoBk;
        EditColor := clInfoBk;
      end;
    end;
 clsMacOS:
    begin
     with CardList.Color do
      begin
        Color := clWhite;
        ColorTo := $00F3F3F3;
        Direction := gdHorizontal;
      end;
      with CardList.CardNormalAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clGray;
        BorderWidth := 1;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 0;
        CaptionColor.Color := clNone;
        CaptionColor.ColorTo := clNone;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clGray;
        CaptionFont.Name := 'Arial';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := $00F3F3F3;
        Color.ColorTo := clWhite;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Arial';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Arial';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
    with CardList.CardHoverAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvRaised;

        BorderColor := clGray;
        BorderWidth := 1;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 0;
        CaptionColor.Color := clGray;
        CaptionColor.ColorTo := clGray;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clWhite;
        CaptionFont.Name := 'Arial';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := $00F5F5F5;
        Color.ColorTo := clWhite;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Arial';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Arial';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
   with CardList.CardSelectedAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvRaised;

        BorderColor := clGray;
        BorderWidth := 1;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $00F19546;
        CaptionColor.ColorTo := $00C34907;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clWhite;
        CaptionFont.Name := 'Arial';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := $00F5F5F5;
        Color.ColorTo := clWhite;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Arial';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Arial';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
   with CardList.CardEditingAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvRaised;

        BorderColor := clGray;
        BorderWidth := 1;

        CaptionBorderColor := clNone;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $00F19546;
        CaptionColor.ColorTo := $00C34907;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clWhite;
        CaptionFont.Name := 'Arial';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := $00F5F5F5;
        Color.ColorTo := clWhite;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Arial';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Arial';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
    with CardList.CardTemplate do
        CardCaptionAlignment := taCenter;

    with CardList.CardTemplate.DefaultItem do
      begin
        CaptionFont.Name := 'Arial';
        CaptionColor := clNone;
        ValueFont.Name := 'Arial';
        ValueColor := clNone;
        EditColor := clNone;
      end;

    end;
  clsXPBlue:
    begin
     with CardList.Color do
      begin
        Color := cl3DLight;
        ColorTo := clMenuBar;
        Direction := gdVertical;        
      end;
      with CardList.CardNormalAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clHighlight;
        BorderWidth := 1;

        CaptionBorderColor := clWhite;
        CaptionBorderWidth := 1;
        CaptionColor.Color := $00FDEADA;
        CaptionColor.ColorTo := $00E4AE88;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clHighlight;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := $00FDEADA;
        Color.ColorTo := clWhite;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
     with CardList.CardSelectedAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clHighlight;
        BorderWidth := 1;

        CaptionBorderColor := clWhite;
        CaptionBorderWidth := 1;
        CaptionColor.Color := $007CDAF7;
        CaptionColor.ColorTo := $00087FE8;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clWhite;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := $00D3F8FF;
        Color.ColorTo := clWhite;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
      with CardList.CardHoverAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clBlack;
        BorderWidth := 1;

        CaptionBorderColor := clWhite;
        CaptionBorderWidth := 1;
        CaptionColor.Color := $00FDEADA;
        CaptionColor.ColorTo := $00D08130;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clBlack;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := $00FDEADA;
        Color.ColorTo := clWhite;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
    with CardList.CardEditingAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clBlack;
        BorderWidth := 1;

        CaptionBorderColor := clWhite;
        CaptionBorderWidth := 1;
        CaptionColor.Color := clSilver;
        CaptionColor.ColorTo := clRed;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clWhite;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := $00D3F8FF;
        Color.ColorTo := clWhite;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;

    with CardList.CardTemplate do
      CardCaptionAlignment := taLeftJustify;

    with CardList.CardTemplate.DefaultItem do
      begin
        CaptionFont.Name := 'MS Sans Serif';
        CaptionColor := clNone;
        ValueFont.Name := 'MS Sans Serif';
        ValueColor := clNone;
        EditColor := clNone;
      end;

      ApplyTemplate;

    end;
    clsOffice2007Obsidian:
    begin
     with CardList.Color do
      begin
        Color := $EBEBEB;
        ColorTo := $EBEBEB;
        Direction := gdVertical;
      end;
      with CardList.CardNormalAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := $5C534C;
        BorderWidth := 1;

        CaptionBorderColor := $5C534C;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $F2F1F0;
        CaptionColor.ColorTo := $C9C2BD;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := $433C37;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := $F9F5F1;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
     with CardList.CardSelectedAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := $5C534C;
        BorderWidth := 1;

        CaptionBorderColor := $5C534C;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $94E6FB;
        CaptionColor.ColorTo := $1595EE;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clBlack;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clInfoBk;
        Color.ColorTo := $F9F5F1;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
      with CardList.CardHoverAppearance do
      begin
         BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := $5C534C;
        BorderWidth := 1;

        CaptionBorderColor := $5C534C;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $F2F1F0;
        CaptionColor.ColorTo := $C9C2BD;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := $433C37;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := $F9F5F1;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
    with CardList.CardEditingAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := $5C534C;
        BorderWidth := 1;

        CaptionBorderColor := $5C534C;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $94E6FB;
        CaptionColor.ColorTo := $1595EE;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clBlack;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clInfoBk;
        Color.ColorTo := $F9F5F1;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;

    with CardList.CardTemplate do
      CardCaptionAlignment := taLeftJustify;

    with CardList.CardTemplate.DefaultItem do
      begin
        CaptionFont.Name := 'MS Sans Serif';
        CaptionColor := clNone;
        ValueFont.Name := 'MS Sans Serif';
        ValueColor := clNone;
        EditColor := clNone;
      end;

      ApplyTemplate;

    end;
    clsOffice2007Luna:
    begin
     with CardList.Color do
      begin
        Color := $F2E4D5;
        ColorTo := $F2E4D5;
        Direction := gdVertical;
      end;
      with CardList.CardNormalAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := $CF9365;
        BorderWidth := 1;

        CaptionBorderColor := $CF9365;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $FFEFE3;
        CaptionColor.ColorTo := $FFD2AF;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := $723708;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := $F9F5F1;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
     with CardList.CardSelectedAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := $CF9365;
        BorderWidth := 1;

        CaptionBorderColor := $CF9365;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $94E6FB;
        CaptionColor.ColorTo := $1595EE;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clBlack;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clInfoBk;
        Color.ColorTo := $F9F5F1;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
      with CardList.CardHoverAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := $CF9365;
        BorderWidth := 1;

        CaptionBorderColor := $CF9365;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $FFEFE3;
        CaptionColor.ColorTo := $FFD2AF;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := $723708;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := $F9F5F1;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
    with CardList.CardEditingAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := $CF9365;
        BorderWidth := 1;

        CaptionBorderColor := $CF9365;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $94E6FB;
        CaptionColor.ColorTo := $1595EE;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clBlack;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clInfoBk;
        Color.ColorTo := $F9F5F1;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;

    with CardList.CardTemplate do
      CardCaptionAlignment := taLeftJustify;

    with CardList.CardTemplate.DefaultItem do
      begin
        CaptionFont.Name := 'MS Sans Serif';
        CaptionColor := clNone;
        ValueFont.Name := 'MS Sans Serif';
        ValueColor := clNone;
        EditColor := clNone;
      end;

      ApplyTemplate;

    end;
    clsOffice2007Silver:
    begin
     with CardList.Color do
      begin
        Color := $F2F1F0;
        ColorTo := $F2F1F0;
        Direction := gdVertical;
      end;
      with CardList.CardNormalAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := $74706F;
        BorderWidth := 1;

        CaptionBorderColor := $C1BFBE;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $F6EBE7;
        CaptionColor.ColorTo := $D3C9C7;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := $5C534C;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := $F9F5F1;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
     with CardList.CardSelectedAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := $CF9365;
        BorderWidth := 1;

        CaptionBorderColor := $CF9365;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $94E6FB;
        CaptionColor.ColorTo := $1595EE;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clBlack;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clInfoBk;
        Color.ColorTo := $F9F5F1;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
      with CardList.CardHoverAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := $74706F;
        BorderWidth := 1;

        CaptionBorderColor := $C1BFBE;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $F6EBE7;
        CaptionColor.ColorTo := $D3C9C7;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := $5C534C;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := $F9F5F1;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
    with CardList.CardEditingAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := $CF9365;
        BorderWidth := 1;

        CaptionBorderColor := $CF9365;
        CaptionBorderWidth := 0;
        CaptionColor.Color := $94E6FB;
        CaptionColor.ColorTo := $1595EE;
        CaptionColor.Direction := gdVertical;
        CaptionFont.Color := clBlack;
        CaptionFont.Name := 'MS Sans Serif';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clInfoBk;
        Color.ColorTo := $F9F5F1;
        Color.Direction := gdVertical;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'MS Sans Serif';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'MS Sans Serif';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;

    with CardList.CardTemplate do
      CardCaptionAlignment := taLeftJustify;

    with CardList.CardTemplate.DefaultItem do
      begin
        CaptionFont.Name := 'MS Sans Serif';
        CaptionColor := clNone;
        ValueFont.Name := 'MS Sans Serif';
        ValueColor := clNone;
        EditColor := clNone;
      end;

      ApplyTemplate;

    end;
  clsOffice2003:
    begin
      with CardList.Color do
      begin
        Color := clWhite;
        ColorTo := clWhite;
      end;
      with CardList.CardNormalAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clMenuBar;
        BorderWidth := 0;

        CaptionBorderColor := clWhite;
        CaptionBorderWidth := 1;
        CaptionColor.Color := clMenuBar;
        CaptionColor.ColorTo := clNone;
        CaptionFont.Color := clBlack;
        CaptionFont.Name := 'Verdana';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := clWhite;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Verdana';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Verdana';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
      with CardList.CardHoverAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clMenuBar;
        BorderWidth := 0;

        CaptionBorderColor := clWhite;
        CaptionBorderWidth := 1;
        CaptionColor.Color := clMenuBar;
        CaptionColor.ColorTo := clNone;
        CaptionFont.Color := clBlack;
        CaptionFont.Name := 'Verdana';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := clWhite;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Verdana';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Verdana';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
     with CardList.CardSelectedAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clMenuBar;
        BorderWidth := 2;

        CaptionBorderColor := clWhite;
        CaptionBorderWidth := 1;
        CaptionColor.Color := clHighLight;
        CaptionColor.ColorTo := clNone;
        CaptionFont.Color := clWhite;
        CaptionFont.Name := 'Verdana';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := clWhite;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Verdana';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Verdana';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
    with CardList.CardEditingAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clMenuBar;
        BorderWidth := 2;

        CaptionBorderColor := clWhite;
        CaptionBorderWidth := 1;
        CaptionColor.Color := clHighLight;
        CaptionColor.ColorTo := clNone;
        CaptionFont.Color := clWhite;
        CaptionFont.Name := 'Verdana';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := clWhite;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Verdana';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Verdana';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;

    with CardList.CardTemplate do
        CardCaptionAlignment := taLeftJustify;

    with CardList.CardTemplate.DefaultItem do
      begin
        CaptionFont.Name := 'Verdana';
        CaptionColor := clNone;
        ValueFont.Name := 'Verdana';
        ValueColor := clNone;
        EditColor := clNone;
      end;
      ApplyTemplate;
    end;
 clsWhidbey:
    begin
      with CardList.Color do
      begin
        Color := clWhite;
        ColorTo := clWhite;
      end;
      with CardList.CardNormalAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clMenuBar;
        BorderWidth := 0;

        CaptionBorderColor := clWhite;
        CaptionBorderWidth := 1;
        CaptionColor.Color := clMenuBar;
        CaptionColor.ColorTo := clNone;
        CaptionFont.Color := clBlack;
        CaptionFont.Name := 'Verdana';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := clWhite;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Verdana';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Verdana';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;
      end;
      with CardList.CardHoverAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clMenuBar;
        BorderWidth := 0;

        CaptionBorderColor := clWhite;
        CaptionBorderWidth := 1;
        CaptionColor.Color := clMenuBar;
        CaptionColor.ColorTo := clNone;
        CaptionFont.Color := clBlack;
        CaptionFont.Name := 'Verdana';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := clWhite;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Verdana';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Verdana';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
     with CardList.CardSelectedAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clMenuBar;
        BorderWidth := 2;

        CaptionBorderColor := clWhite;
        CaptionBorderWidth := 1;
        CaptionColor.Color := clHighLight;
        CaptionColor.ColorTo := clNone;
        CaptionFont.Color := clWhite;
        CaptionFont.Name := 'Verdana';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := clWhite;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Verdana';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Verdana';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;
    with CardList.CardEditingAppearance do
      begin
        BevelInner := bvNone;
        BevelOuter := bvNone;

        BorderColor := clMenuBar;
        BorderWidth := 2;

        CaptionBorderColor := clWhite;
        CaptionBorderWidth := 1;
        CaptionColor.Color := clHighLight;
        CaptionColor.ColorTo := clNone;
        CaptionFont.Color := clWhite;
        CaptionFont.Name := 'Verdana';
        CaptionFont.Size := 8;
        CaptionFont.Style := [fsBold];

        Color.Color := clWhite;
        Color.ColorTo := clWhite;

        Enabled := true;

        ItemEditFont.Color := clBlack;
        ItemEditFont.Name := 'Verdana';
        ItemEditFont.Size := 8;
        ItemEditFont.Style := [];
        ItemLabelFont.Color := clBlack;
        ItemLabelFont.Name := 'Verdana';
        ItemLabelFont.Size := 8;
        ItemLabelFont.Style := [];
        ReplaceEditFont := true;
        ReplaceLabelFont := true;

      end;

    with CardList.CardTemplate do
        CardCaptionAlignment := taLeftJustify;

    with CardList.CardTemplate.DefaultItem do
      begin
        CaptionFont.Name := 'Verdana';
        CaptionColor := clNone;
        ValueFont.Name := 'Verdana';
        ValueColor := clNone;
        EditColor := clNone;
      end;
      ApplyTemplate;
    end;
  end;
end;


{ TAdvCustomCardListStyler }

procedure TAdvCustomCardListStyler.ApplyStyle;
begin

end;

procedure TAdvCustomCardListStyler.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AOperation = opRemove) and (AComponent = CardList) then
    FCardList := nil;
end;

procedure TAdvCustomCardListStyler.SetCardList(const Value: TCustomAdvCardList);
var
  flg: boolean;
begin
  if (FCardList <> Value) and Assigned(Value) then
  begin
    flg := FCardList = nil;
    FCardList := Value;
    if flg and (csDesigning in ComponentState) then
      ApplyStyle;
  end;  
end;

end.
