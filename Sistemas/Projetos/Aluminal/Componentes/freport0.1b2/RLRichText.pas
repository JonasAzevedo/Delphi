{@unit RLRichText - Implementação dos componentes de impressão de texto no formato RichText.}
unit RLRichText;

interface

uses
  Classes, SysUtils, Contnrs, Math,
{$ifndef LINUX}
  Windows,
{$else}
  Types,
{$endif}
{$ifdef CLX}
  QGraphics, RLMetaCLX,
{$else}
  Graphics, RLMetaVCL,
{$endif}
  RLReport, RLUtils, RLMetaFile;

const
  MaxTabs=255;
  TabSize=48;

type
  TRLRichFont=class
  public
    Num    :integer;
    Family :string;
    Charset:integer;
    Name   :string;
  end;

  TRLRichFontList=class(TObjectList)
  private
    function GetFonts(i: integer): TRLRichFont;
  public
    property Fonts[i:integer]:TRLRichFont read GetFonts; default;
  end;

  TRLRichColor=class
  public
    Red  :byte;
    Green:byte;
    Blue :byte;
  end;

  TRLRichColorList=class(TObjectList)
  private
    function GetColors(i: integer): TRLRichColor;
  public
    property Colors[i:integer]:TRLRichColor read GetColors; default;
  end;

  TRLRichStyle=class
  public
    Bold     :boolean;
    Italic   :boolean;
    Underline:boolean;
    FontSize :integer;
    FontNum  :integer;
    ForeColor:integer;
    BkgdColor:integer;
    //
    procedure Assign(Style:TRLRichStyle);
    procedure Clear;
  end;

  TRLRichWord=class;
  TRLRichTab=class;
  TRLRichParser=class;
  TRLRichParagraph=class;
  TRLRichElement=class;

  TRLRichElementList=class(TObjectList)
  private
    function GetElements(i: integer): TRLRichElement;
  public
    property Elements[i:integer]:TRLRichElement read GetElements; default;
  end;

  TRLRichElement=class
  public
    Parent  :TRLRichElement;
    Children:TRLRichElementList;
    //
    constructor Create(aParent:TRLRichElement); virtual;
    destructor  Destroy; override;
    //
    function Paragraph:TRLRichParagraph;
    function Parser:TRLRichParser;
  end;

  TRLRichObject=class(TRLRichElement)
  public
    Position:TPoint;
    constructor Create(aParent:TRLRichElement); override;
    function GetBaseLine:integer; virtual; abstract;
    function GetSize:TPoint; virtual; abstract;
    function GetBounds:TRect;
  end;

  TRLRichParagraph=class(TRLRichElement)
  public
    Alignment:char;
    Tabs     :array[1..MaxTabs] of integer;
    //
    constructor Create(aParent:TRLRichElement); override;
    //
    function  NextTab(AfterPos:integer):integer;
    function  NeedCurrentWord:TRLRichWord;
    function  NewWord:TRLRichWord;
    function  NewTab:TRLRichTab;
    function  CurrentWord: TRLRichWord;
  end;

  TRLRichWordPart=class;

  TRLRichWord=class(TRLRichObject)
  private
    function GetParts(i: integer): TRLRichWordPart;
  public
    function GetBaseLine:integer; override;
    function GetSize:TPoint; override;
    //
    function GetText:string;
    function NewPart(const Text:string):TRLRichWordPart;
    //
    property Parts[i:integer]:TRLRichWordPart read GetParts; default;
  end;

  TRLRichTab=class(TRLRichElement)
  public
  end;

  TRLRichWordPart=class(TRLRichObject)
  public
    Text    :string;
    Style   :TRLRichStyle;
    BaseLine:integer;
    Size    :TPoint;
    //
    constructor Create(aParent:TRLRichElement); override;
    function GetBaseLine:integer; override;
    function GetSize:TPoint; override;
    function Word:TRLRichWord;
  end;

  TRLRichImg=class(TRLRichObject)
  public
    Data:string;
    Size:TPoint;
    function GetBaseLine:integer; override;
    function GetSize:TPoint; override;
  end;

  TBookmark=integer;

  TRLRichParser=class(TRLRichElement)
  private
    FileVer         :integer;
    FileAnsi        :boolean;
    FileDeff        :integer;
    FileDefLang     :integer;
    FileAnsiCpg     :integer;
    FileViewKind    :integer;
    FontList        :TRLRichFontList;
    ColorList       :TRLRichColorList;
    CurrentStyle    :TRLRichStyle;
    CurrentParagraph:TRLRichParagraph;
    AuxBmp          :TBitmap;
    Stream          :TStream;
    FormattedWidth  :integer;
    FormattedWrap   :boolean;
    function GetFont(Index: integer): TRLRichFont;
    function GetColor(Index: integer): TRLRichColor;
    function NeedCurrentStyle: TRLRichStyle;
    function NeedCurrentParagraph: TRLRichParagraph;
    function GetParagraphs(i: integer): TRLRichParagraph;
  protected
    function  NeedAuxBmp:TBitmap;
    function  GetBookmark:TBookmark;
    procedure GotoBookmark(Bookmark:TBookmark);
    procedure SkipNulls;
    procedure SkipSpaces;
    function  ReadCh(var Ch:char):boolean;
    function  ReadThisCh(Ch: char): boolean;
    function  ReadThisText(const Text: string): boolean;
    function  ReadAnyWord(var Word: string): boolean;
    function  ReadThisWord(const Word: string): boolean;
    function  ReadAnyNum(var Num: integer): boolean;
    function  ReadAnyLiteralCh(var Ch: char): boolean;
    function  ReadAnyTextualCh(var Ch: char): boolean;
    function  ReadAnyCtrlCh(var Ch: char): boolean;
    function  ReadAnyLiteral(var Literal: string): boolean;
    function  ReadAnyTextual(var Textual: string): boolean;
    function  ReadAnyCtrlWord(var Word: string; var Param: integer): boolean;
    function  ReadThisCtrlWord(const Word: string; var Param: integer): boolean; overload;
    function  ReadThisCtrlWord(const Word: string): boolean; overload;
    function  ReadFileHeader: boolean;
    function  ReadFontItem: boolean;
    function  ReadFontTable: boolean;
    function  ReadColorItem: boolean;
    function  ReadColorTable: boolean;
    function  ReadAnyImage: boolean;
    function  ReadAnyGroup: boolean;
    function  ReadDocumentBody: boolean;
    function  ReadDocument:boolean;
    //
    function  NewParagraph(Reset:boolean):TRLRichParagraph;
    procedure CopyStyleToCanvas(Style:TRLRichStyle; Canvas: TObject);
  public
    DefaultFontName  :string;
    DefaultRedValue  :byte;
    DefaultGreenValue:byte;
    DefaultBlueValue :byte;
    WordWrap         :boolean;
    WrapMargin       :integer;
    TextCRC          :word;
    TextLength       :integer;
    TextSize         :TPoint;
    //
    constructor Create(aParent:TRLRichElement); override;
    destructor Destroy; override;
    //
    procedure Clear; 
    procedure LoadFromStream(Stream:TStream);
    procedure SetText(const NewText:string);
    procedure PaintTo(Canvas:TObject; const Rect:TRect);
    procedure Format(RightMargin:integer);
    //
    property Paragraphs[i:integer]:TRLRichParagraph read GetParagraphs; default;
  end;

  { TRLCustomRichText }

  {@class TRLCustomRichText - Classe base para caixa de texto formato RichText. }
  TRLCustomRichText=class(TRLCustomMemo)
  private
    fParser:TRLRichParser;
    procedure PrepareParser;
    procedure FormatNeeded(Width:integer);
  protected
    // override & reintroduce
    procedure   CalcSize(var aSize:TPoint); override;
    function    InternalMakeCaption: string; override;
    procedure   InternalPrint; override;
    procedure   InternalPaint; override;
  public
    // constructors & destructors
    constructor Create(aOwner:TComponent); override;
    destructor Destroy; override;
  end;
  {/@class}

  { TRLCustomDBRichText }

  {@class TRLCustomDBRichText - Classe base para caixa de texto formato RichText ligado a campo de dataset. }
  TRLCustomDBRichText=class(TRLCustomDBMemo)
  private
    fParser:TRLRichParser;
    procedure PrepareParser;
    procedure FormatNeeded(Width: integer);
  protected
    // override & reintroduce
    procedure   CalcSize(var aSize:TPoint); override;
    function    InternalMakeCaption: string; override;
    procedure   InternalPrint; override;
    procedure   InternalPaint; override;
  public
    // constructors & destructors
    constructor Create(aOwner:TComponent); override;
    destructor Destroy; override;
  end;
  {/@class}
  

  { TRLRichText }

  {@class TRLRichText - Componente para texto multilinhas em formato RichText. 
   @pub }
  TRLRichText=class(TRLCustomRichText)
  published

    // properties

    {@prop Align = ancestor /}
    property    Align;
    {@prop Alignment = ancestor /}
    property    Alignment;
    {@prop Anchors = ancestor /}
    property    Anchors;
    {@prop AutoSize = ancestor /}
    property    AutoSize;
    {@prop Behavior = ancestor /}
    property    Behavior;
    {@prop Borders = ancestor /}
    property    Borders;
    {@prop Color = ancestor /}
    property    Color;
    {@prop Constraints = ancestor /}
    property    Constraints;
    {@prop Font = ancestor /}
    property    Font;
    {@prop FriendlyName = ancestor /}
    property    FriendlyName;
    {@prop Holder = ancestor /}
    property    Holder;
    {@prop HoldStyle = ancestor /}
    property    HoldStyle;
    {@prop IntegralHeight = ancestor /}
    property    IntegralHeight;
    {@prop Layout = ancestor /}
    property    Layout;
    {@prop Lines = ancestor /}
    property    Lines;
    {@prop ParentColor = ancestor /}
    property    ParentColor;
    {@prop ParentFont = ancestor /}
    property    ParentFont;
    {@prop RealBounds = ancestor /}
    property    RealBounds;
    {@prop SecondHolder = ancestor /}
    property    SecondHolder;
    {@prop SecondHoldStyle = ancestor /}
    property    SecondHoldStyle;
    {@prop Transparent = ancestor /}
    property    Transparent;
    {@prop Visible = ancestor /}
    property    Visible;
    {@prop WordWrap = ancestor /}
    property    WordWrap;

    // events

    {@prop AfterPrint = ancestor /}
    property    AfterPrint;
    {@prop BeforePrint = ancestor /}
    property    BeforePrint;
    {@prop OnMeasureHeight = ancestor /}
    property    OnMeasureHeight;
  end;
  {/@class}
  

  { TRLDBRichText }

  {@class TRLDBRichText - Componente para texto multilinhas em formato RichText ligado a campo de dataset.
   @pub }
  TRLDBRichText=class(TRLCustomDBRichText)
  published

    // properties

    {@prop Align = ancestor /}
    property    Align;
    {@prop Alignment = ancestor /}
    property    Alignment;
    {@prop Anchors = ancestor /}
    property    Anchors;
    {@prop AutoSize = ancestor /}
    property    AutoSize;
    {@prop Behavior = ancestor /}
    property    Behavior;
    {@prop Borders = ancestor /}
    property    Borders;
    {@prop Color = ancestor /}
    property    Color;
    {@prop Constraints = ancestor /}
    property    Constraints;
    {@prop DataField = ancestor /}
    property    DataField;
    {@prop DataFormula = ancestor /}
    property    DataFormula;
    {@prop DataSource = ancestor /}
    property    DataSource;
    {@prop Font = ancestor /}
    property    Font;
    {@prop FriendlyName = ancestor /}
    property    FriendlyName;
    {@prop Holder = ancestor /}
    property    Holder;
    {@prop HoldStyle = ancestor /}
    property    HoldStyle;
    {@prop IntegralHeight = ancestor /}
    property    IntegralHeight;
    {@prop Layout = ancestor /}
    property    Layout;
    {@prop ParentColor = ancestor /}
    property    ParentColor;
    {@prop ParentFont = ancestor /}
    property    ParentFont;
    {@prop RealBounds = ancestor /}
    property    RealBounds;
    {@prop SecondHolder = ancestor /}
    property    SecondHolder;
    {@prop SecondHoldStyle = ancestor /}
    property    SecondHoldStyle;
    {@prop Transparent = ancestor /}
    property    Transparent;
    {@prop Visible = ancestor /}
    property    Visible;
    {@prop WordWrap = ancestor /}
    property    WordWrap;

    // events

    {@prop AfterPrint = ancestor /}
    property    AfterPrint;
    {@prop BeforePrint = ancestor /}
    property    BeforePrint;
    {@prop OnMeasureHeight = ancestor /}
    property    OnMeasureHeight;
  end;
  {/@class}

{/@unit}

implementation

const
  NullSet   =[#13,#10,#26];
  SpaceSet  =NullSet+[#32];
  CtrlSet   =['{','}','\'];
  DigitSet  =['0'..'9'];
  HexSet    =DigitSet+['a'..'f','A'..'F'];
  AlphaSet  =['a'..'z','A'..'Z','_'];
  AlphaSetEx=AlphaSet+DigitSet;
  LiteralSet=[#9,#32..#126,#128..#255]-CtrlSet-NullSet;
  TextualSet=AlphaSet+DigitSet+[#32];
  NullParam =MaxInt;

procedure DoFillRect(Canvas:TObject; const Rect:TRect);
begin
  if Canvas is TCanvas then
    TCanvas(Canvas).FillRect(Rect)
  else if Canvas is TRLGraphicSurface then
    TRLGraphicSurface(Canvas).FillRect(Rect);
end;

procedure SetBrushStyle(Canvas:TObject; Style:TBrushStyle);
begin
  if Canvas is TCanvas then
    TCanvas(Canvas).Brush.Style:=Style
  else if Canvas is TRLGraphicSurface then
    TRLGraphicSurface(Canvas).Brush.Style:=Style;
end;

procedure SetBrushColor(Canvas:TObject; Color:TColor);
begin
  if Canvas is TCanvas then
    TCanvas(Canvas).Brush.Color:=Color
  else if Canvas is TRLGraphicSurface then
    TRLGraphicSurface(Canvas).Brush.Color:=Color;
end;

procedure SetFontName(Canvas:TObject; const Name:string);
begin
  if Canvas is TCanvas then
    TCanvas(Canvas).Font.Name:=Name
  else if Canvas is TRLGraphicSurface then
    TRLGraphicSurface(Canvas).Font.Name:=Name;
end;

procedure SetFontCharset(Canvas:TObject; Charset:TFontCharset);
begin
  if Canvas is TCanvas then
    TCanvas(Canvas).Font.Charset:=Charset
  else if Canvas is TRLGraphicSurface then
    TRLGraphicSurface(Canvas).Font.Charset:=Charset;
end;

function GetFontName(Canvas:TObject):string;
begin
  if Canvas is TCanvas then
    Result:=TCanvas(Canvas).Font.Name
  else if Canvas is TRLGraphicSurface then
    Result:=TRLGraphicSurface(Canvas).Font.Name;
end;

function GetFontCharset(Canvas:TObject):TFontCharset;
begin
  if Canvas is TCanvas then
    Result:=TCanvas(Canvas).Font.Charset
  else if Canvas is TRLGraphicSurface then
    Result:=TRLGraphicSurface(Canvas).Font.Charset
  else
    FillChar(Result,SizeOf(Result),0);
end;

function GetFontColor(Canvas:TObject):TColor;
begin
  if Canvas is TCanvas then
    Result:=TCanvas(Canvas).Font.Color
  else if Canvas is TRLGraphicSurface then
    Result:=TRLGraphicSurface(Canvas).Font.Color
  else
    Result:=0;
end;

procedure SetFontColor(Canvas:TObject; Color:TColor);
begin
  if Canvas is TCanvas then
    TCanvas(Canvas).Font.Color:=Color
  else if Canvas is TRLGraphicSurface then
    TRLGraphicSurface(Canvas).Font.Color:=Color;
end;

function GetFontStyle(Canvas:TObject):TFontStyles;
begin
  if Canvas is TCanvas then
    Result:=TCanvas(Canvas).Font.Style
  else if Canvas is TRLGraphicSurface then
    Result:=TRLGraphicSurface(Canvas).Font.Style;
end;

procedure SetFontStyle(Canvas:TObject; Style:TFontStyles);
begin
  if Canvas is TCanvas then
    TCanvas(Canvas).Font.Style:=Style
  else if Canvas is TRLGraphicSurface then
    TRLGraphicSurface(Canvas).Font.Style:=Style;
end;

procedure SetFontSize(Canvas:TObject; Size:integer);
begin
  if Canvas is TCanvas then
    TCanvas(Canvas).Font.Size:=Size
  else if Canvas is TRLGraphicSurface then
    TRLGraphicSurface(Canvas).Font.Size:=Size;
end;

function GetTextWidth(Canvas:TObject; const Text:string):integer;
begin
  if Canvas is TCanvas then
    Result:=TCanvas(Canvas).TextWidth(Text)
  else if Canvas is TRLGraphicSurface then
    Result:=TRLGraphicSurface(Canvas).TextWidth(Text)
  else
    Result:=0;
end;

function GetTextHeight(Canvas:TObject; const Text:string):integer;
begin
  if Canvas is TCanvas then
    Result:=TCanvas(Canvas).TextHeight(Text)
  else if Canvas is TRLGraphicSurface then
    Result:=TRLGraphicSurface(Canvas).TextHeight(Text)
  else
    Result:=0;
end;

procedure DoTextOut(Canvas:TObject; X,Y:integer; const Text:string);
begin
  if Canvas is TCanvas then
    TCanvas(Canvas).TextOut(X,Y,Text)
  else if Canvas is TRLGraphicSurface then
    TRLGraphicSurface(Canvas).TextOut(X,Y,Text);
end;

procedure DoTextRect(Canvas:TObject; const Rect:TRect; X,Y:integer; const Text:string);
begin
  if Canvas is TCanvas then
    TCanvas(Canvas).TextRect(Rect,X,Y,Text)
  else if Canvas is TRLGraphicSurface then
    TRLGraphicSurface(Canvas).TextRect(Rect,X,Y,Text);
end;

{ TRLRichFontList }

function TRLRichFontList.GetFonts(i: integer): TRLRichFont;
begin
  Result:=Items[i] as TRLRichFont;
end;

{ TRLRichColorList }

function TRLRichColorList.GetColors(i: integer): TRLRichColor;
begin
  Result:=Items[i] as TRLRichColor;
end;

{ TRLRichParser }

constructor TRLRichParser.Create(aParent:TRLRichElement);
begin
  inherited;
  //
  DefaultFontName  :='Arial';
  DefaultRedValue  :=0;
  DefaultGreenValue:=0;
  DefaultBlueValue :=0;
  //
  FileVer          :=0;
  FileAnsi         :=False;
  FileDeff         :=0;
  FileDefLang      :=0;
  FileAnsiCpg      :=0;
  FileViewKind     :=0;
  FontList         :=nil;
  ColorList        :=nil;
  CurrentStyle     :=nil;
  AuxBmp           :=nil;
  FormattedWidth   :=0;
  FormattedWrap    :=True;
  CurrentParagraph :=nil;
  //
  FontList :=TRLRichFontList.Create;
  ColorList:=TRLRichColorList.Create;
  //
  Stream    :=nil;
  WordWrap  :=True;
  WrapMargin:=0;
  TextSize  :=Point(0,0);
  TextCRC   :=0;
  TextLength:=0;
end;

destructor TRLRichParser.Destroy;
begin
  inherited;
  FontList.Free;
  ColorList.Free;
  if Assigned(CurrentStyle) then
    CurrentStyle.Free;
  if Assigned(AuxBmp) then
    AuxBmp.Free;
end;

procedure TRLRichParser.Clear;
begin
  FileVer       :=0;
  FileAnsi      :=False;
  FileDeff      :=0;
  FileDefLang   :=0;
  FileAnsiCpg   :=0;
  FileViewKind  :=0;
  FormattedWidth:=0;
  FormattedWrap :=True;
  //
  FontList.Clear;
  ColorList.Clear;
  Children.Clear;
  //
  NeedCurrentStyle.Clear;
  CurrentParagraph:=nil;
  //
  TextSize  :=Point(0,0);
  TextCRC   :=0;
  TextLength:=0;
end;

function TRLRichParser.NeedCurrentStyle:TRLRichStyle;
begin
  if not Assigned(CurrentStyle) then
    CurrentStyle:=TRLRichStyle.Create;
  Result:=CurrentStyle;
end;

function TRLRichParser.GetBookmark: TBookmark;
begin
  Result:=Stream.Position;
end;

procedure TRLRichParser.GotoBookmark(Bookmark: TBookmark);
begin
  Stream.Position:=Bookmark;
end;

function TRLRichParser.ReadCh(var Ch: char): boolean;
begin
  Result:=(Stream.Read(Ch,1)=1);
end;

procedure TRLRichParser.SkipNulls;
var
  ch:char;
  m :TBookmark;
begin
  repeat
    m:=GetBookmark;
    if not ReadCh(ch) then
      Break;
    if not (ch in NullSet) then
    begin
      GotoBookmark(m);
      Break;
    end;
  until False;
end;

procedure TRLRichParser.SkipSpaces;
var
  ch:char;
  m :TBookmark;
begin
  repeat
    m:=GetBookmark;
    if not ReadCh(ch) then
      Break;
    if not (ch in SpaceSet) then
    begin
      GotoBookmark(m);
      Break;
    end;
  until False;
end;

function TRLRichParser.ReadThisCh(Ch:char):boolean;
var
  Bookmark:TBookmark;
  c       :char;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    Result:=ReadCh(c) and (c=Ch);
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadThisText(const Text:string):boolean;
var
  Bookmark:TBookmark;
  ch      :char;
  i       :integer;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    i:=1;
    while (i<=Length(Text)) and ReadCh(ch) and (ch=Text[i]) do
      Inc(i);
    Result:=(i>Length(Text));
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadAnyWord(var Word: string): boolean;
var
  Bookmark:TBookmark;
  ch      :char;
begin
  Bookmark:=GetBookmark;
  try
    Word:='';
    while ReadCh(ch) and (ch in AlphaSet) do
    begin
      Word    :=Word+ch;
      Bookmark:=GetBookmark;
    end;
    Result:=(Word<>'');
  finally
    GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadThisWord(const Word:string):boolean;
var
  Bookmark:TBookmark;
  w       :string;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    Result:=ReadAnyWord(w) and SameText(w,Word);
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadAnyNum(var Num: integer): boolean;
var
  Bookmark:TBookmark;
  s       :string;
  ch      :char;
  i       :integer;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    s:='';
    i:=0;
    while ReadCh(ch) and ((ch in DigitSet) or ((ch in ['+','-']) and (i=0))) do
    begin
      s:=s+ch;
      Inc(i);
      Bookmark:=GetBookmark;
    end;
    if s<>'' then
    begin
      Num   :=StrToInt(s);
      Result:=True;
    end;
  finally
    GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadAnyLiteralCh(var Ch: char): boolean;
var
  Bookmark:TBookmark;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    if ReadCh(Ch) and (Ch in LiteralSet) then
      Result:=True;
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadAnyTextualCh(var Ch: char): boolean;
var
  Bookmark:TBookmark;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    if ReadCh(Ch) and (Ch in TextualSet) then
      Result:=True;
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadAnyCtrlCh(var Ch: char): boolean;
var
  Bookmark:TBookmark;
  c,h1,h2:char;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    if ReadCh(c) and (c='\') then
      if ReadThisWord('tab') then
      begin
        Ch    :=#9;
        Result:=True;
      end
      else if ReadCh(c) and (c='''') then
        if ReadCh(h1) and (h1 in HexSet) then
          if ReadCh(h2) and (h2 in HexSet) then
          begin
            Ch    :=Char(StrToInt('$'+h1+h2));
            Result:=True;
          end;
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadAnyLiteral(var Literal: string): boolean;
var
  Bookmark:TBookmark;
  ch      :char;
begin
  Bookmark:=GetBookmark;
  try
    Literal:='';
    while ReadAnyLiteralCh(ch) or ReadAnyCtrlCh(ch) do
    begin
      Literal :=Literal+ch;
      Bookmark:=GetBookmark;
    end;
    Result:=(Literal<>'');
  finally
    GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadAnyTextual(var Textual: string): boolean;
var
  Bookmark:TBookmark;
  ch      :char;
begin
  Bookmark:=GetBookmark;
  try
    Textual:='';
    while ReadAnyTextualCh(ch) or ReadAnyCtrlCh(ch) do
    begin
      Textual :=Textual+ch;
      Bookmark:=GetBookmark;
    end;
    Result:=(Textual<>'');
  finally
    GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadAnyCtrlWord(var Word: string; var Param: integer): boolean;
var
  Bookmark:TBookmark;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    if ReadThisCh('\') then
    begin
      if ReadThisCh(#13) then
      begin
        Word:='par';
        ReadThisCh(#10);
      end
      else if ReadThisCh(#10) then
        Word:='par'
      else if ReadThisCh('*') then
        Word:='*'
      else if ReadAnyWord(Word) then
        if SameText(Word,'tab') then
          Exit
        else
      else
        Exit;
      if not ReadAnyNum(Param) then
        Param:=NullParam;
      ReadThisCh(#32);
      Result:=True;
    end;
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadThisCtrlWord(const Word: string; var Param: integer): boolean;
var
  Bookmark:TBookmark;
  w       :string;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    if ReadAnyCtrlWord(w,Param) then
      if SameText(w,Word) then
        Result:=True;
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadThisCtrlWord(const Word: string): boolean;
var
  Param: integer;
begin
  Result:=ReadThisCtrlWord(Word,Param);
end;

function TRLRichParser.ReadFileHeader: boolean;
var
  Bookmark:TBookmark;
  Word    :string;
  Param   :integer;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    if ReadThisCtrlWord('rtf',Self.FileVer) then
    begin
      SkipSpaces;
      while ReadAnyCtrlWord(Word,Param) do
      begin
        if SameText(Word,'ansi') then
          Self.FileAnsi:=True
        else if SameText(Word,'ansicpg') then
          Self.FileAnsiCpg:=Param
        else if SameText(Word,'deff') then
          Self.FileDeff:=Param
        else if SameText(Word,'FileDefLang') then
          Self.FileDefLang:=Param
        else
          ;
        SkipSpaces;
      end;
      Result:=True;
    end;
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadFontItem: boolean;
var
  Bookmark:TBookmark;
  Word    :string;
  Param   :integer;
  Font    :TRLRichFont;
begin
  Result:=False;
  Font:=nil;
  Bookmark:=GetBookmark;
  try
    if ReadThisCh('{') then
    begin
      SkipSpaces;
      if ReadThisCtrlWord('f',Param) then
      begin
        Font:=TRLRichFont.Create;
        Font.Num:=Param;
        SkipSpaces;
        while ReadAnyCtrlWord(Word,Param) do
        begin
          if SameText(Word,'fnil') or SameText(Word,'froman') or SameText(Word,'fswiss') or
            SameText(Word,'fmodern') or SameText(Word,'fscript') or SameText(Word,'fdecor') or
            SameText(Word,'ftech') or SameText(Word,'fbidi') then
            Font.Family:=Copy(Word,2,MaxInt)
          else if SameText(Word,'fcharset') then
            Font.Charset:=Param;
          SkipSpaces;
        end;
        if ReadAnyTextual(Font.Name) then
          if ReadThisCh(';') then
            if ReadThisCh('}') then
            begin
              Self.FontList.Add(Font);
              Result:=True;
            end;
      end;
    end;  
  finally
    if not Result then
    begin
      if Assigned(Font) then
        Font.Free;
      GotoBookmark(Bookmark);
    end;
  end;
end;

function TRLRichParser.ReadFontTable: boolean;
var
  Bookmark:TBookmark;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    if ReadThisCh('{') then
      if ReadThisCtrlWord('fonttbl') then
      begin
        SkipSpaces;
        while ReadFontItem do
          SkipSpaces;
        if ReadThisCh('}') then
          Result:=True;
      end;
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadColorItem: boolean;
var
  Bookmark:TBookmark;
  Param   :integer;
  Color   :TRLRichColor;
begin
  Result:=False;
  Color:=nil;
  Bookmark:=GetBookmark;
  try
    if ReadThisCtrlWord('red',Param) then
    begin
      Color:=TRLRichColor.Create;
      Color.Red:=Param;
      SkipSpaces;
      if ReadThisCtrlWord('green',Param) then
      begin
        Color.Green:=Param;
        SkipSpaces;
        if ReadThisCtrlWord('blue',Param) then
        begin
          Color.Blue:=Param;
          SkipSpaces;
          if ReadThisCh(';') then
          begin
            Self.ColorList.Add(Color);
            Result:=True;
          end;
        end;
      end;
    end;  
  finally
    if not Result then
    begin
      if Assigned(Color) then
        Color.Free;
      GotoBookmark(Bookmark);
    end;  
  end;
end;

function TRLRichParser.ReadColorTable: boolean;
var
  Bookmark:TBookmark;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    if ReadThisCh('{') then
      if ReadThisCtrlWord('colortbl') then
      begin
        SkipSpaces;
        ReadThisCh(';');
        SkipSpaces;
        while ReadColorItem do
          SkipSpaces;
        if ReadThisCh('}') then
          Result:=True;
      end;
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadAnyImage: boolean;
var
  Bookmark:TBookmark;
  Word    :string;
  Param   :integer;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    if ReadThisCh('{') then
    begin
      repeat
        SkipSpaces;
        if ReadAnyCtrlWord(Word,Param) then
        else if ReadAnyGroup then
        else
          Break;
      until False;    
      if ReadThisCh('}') then
        Result:=True;
    end;  
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadAnyGroup: boolean;
var
  Bookmark:TBookmark;
  Level   :integer;
  ch      :char;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    Level:=0;
    if ReadThisCh('{') then
    begin
      Inc(Level);
      while (Level>0) and ReadCh(ch) do
        if ch='{' then
          Inc(Level)
        else if ch='}' then
          Dec(Level);
      Result:=True;
    end;
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.ReadDocumentBody: boolean;
  procedure NewObjs(const s:string);
  var
    i,m:integer;
  begin
    i:=1;
    while i<=Length(s) do
      case s[i] of
        #9: // adiciona tabulacao
        begin
          NeedCurrentParagraph.NewTab;
          Inc(i);
        end;
        #32: // adiciona espacos
        begin
          m:=i;
          while (i<=Length(s)) and (s[i]=#32) do
            Inc(i);
          NeedCurrentParagraph.NewWord.NewPart(Copy(s,m,i-m))
        end;
      else
        // adiciona pedaco de palavra a palavra corrente
        m:=i;
        while (i<=Length(s)) and not (s[i] in [#32,#9]) do
          Inc(i);
        NeedCurrentParagraph.NeedCurrentWord.NewPart(Copy(s,m,i-m));
      end;
  end;
var
  Word   :string;
  Param  :integer;
  Literal:string;
begin
  repeat
    SkipNulls;
    if ReadAnyCtrlWord(Word,Param) then
      if SameText(Word,'viewkind') then
        FileViewKind:=Param
      else if SameText(Word,'par') then
        NewParagraph(False)
      else if SameText(Word,'pard') then
        NewParagraph(True)
      else if SameText(Word,'plain') then
        NeedCurrentStyle.Clear
      else if SameText(Word,'f') then // font num
        NeedCurrentStyle.FontNum:=Param
      else if SameText(Word,'fs') then // font size
        NeedCurrentStyle.FontSize:=Param
      else if SameText(Word,'b') then // bold
        NeedCurrentStyle.Bold:=(Param<>0)
      else if SameText(Word,'i') then // italic
        NeedCurrentStyle.Italic:=(Param<>0)
      else if SameText(Word,'ul') then // continuous underline
        NeedCurrentStyle.Underline:=(Param<>0)
      else if SameText(Word,'ulnone') then // underline off
        NeedCurrentStyle.Underline:=False
      else if SameText(Word,'cf') then // foreground color
        NeedCurrentStyle.ForeColor:=Param
      else if SameText(Word,'cb') then // background color
        NeedCurrentStyle.BkgdColor:=Param
      else if SameText(Word,'ql') then // align left
        CurrentParagraph.Alignment:='l'
      else if SameText(Word,'qr') then // align right
        CurrentParagraph.Alignment:='r'
      else if SameText(Word,'qc') then // align center
        CurrentParagraph.Alignment:='c'
      else if SameText(Word,'qj') then // align justify
        CurrentParagraph.Alignment:='j'
      else if SameText(Word,'debug') then // debug
        Word:=''
      else
    else if ReadAnyLiteral(Literal) then
      NewObjs(Literal)
    else if ReadAnyImage then
    else if ReadAnyGroup then
    else
      Break; 
  until False;
  Result:=True;  
end;

function TRLRichParser.ReadDocument: boolean;
var
  Bookmark:TBookmark;
begin
  Result:=False;
  Bookmark:=GetBookmark;
  try
    if ReadThisCh('{') then
      if ReadFileHeader then
      begin
        SkipSpaces;
        ReadFontTable;
        SkipSpaces;
        ReadColorTable;
        SkipSpaces;
        ReadDocumentBody;
        if ReadThisCh('}') then
          Result:=True;
      end
      else
    else if ReadDocumentBody then
      Result:=True;
  finally
    if not Result then
      GotoBookmark(Bookmark);
  end;
end;

function TRLRichParser.GetFont(Index: integer): TRLRichFont;
var
  Font:TRLRichFont;
begin
  while FontList.Count<Index+1 do
  begin
    Font:=TRLRichFont.Create;
    Font.Name   :=DefaultFontName;
    Font.Family :='nil';
    Font.Charset:=0;
    Font.Num    :=FontList.Count;
    FontList.Add(Font);
  end;
  Result:=FontList[Index];
end;

function TRLRichParser.GetColor(Index:integer):TRLRichColor;
var
  Color:TRLRichColor;
begin
  while ColorList.Count-1<Index do
  begin
    Color:=TRLRichColor.Create;
    Color.Red   :=DefaultRedValue;
    Color.Green :=DefaultGreenValue;
    Color.Blue  :=DefaultBlueValue;
    ColorList.Add(Color);
  end;
  Result:=ColorList[Index];
end;

procedure TRLRichParser.CopyStyleToCanvas(Style:TRLRichStyle; Canvas:TObject);
var
  NewStyle:TFontStyles;
begin
  SetFontName(Canvas,GetFont(Style.FontNum).Name);
  SetFontSize(Canvas,Style.FontSize div 2);
  NewStyle:=GetFontStyle(Canvas);
  if Style.Bold then
    Include(NewStyle,fsBold)
  else
    Exclude(NewStyle,fsBold);
  if Style.Italic then
    Include(NewStyle,fsItalic)
  else
    Exclude(NewStyle,fsItalic);
  if Style.Underline then
    Include(NewStyle,fsUnderline)
  else
    Exclude(NewStyle,fsUnderline);
  SetFontStyle(Canvas,NewStyle);
  if Style.BkgdColor=0 then
    SetBrushColor(Canvas,clWindow)
  else
    with GetColor(Style.BkgdColor-1) do
      SetBrushColor(Canvas,RGB(Red,Green,Blue));
  if Style.ForeColor=0 then
    SetFontColor(Canvas,clWindowText)
  else
    with GetColor(Style.ForeColor-1) do
      SetFontColor(Canvas,RGB(Red,Green,Blue));
end;

function TRLRichParser.NeedCurrentParagraph:TRLRichParagraph;
begin
  if not Assigned(CurrentParagraph) then
    NewParagraph(False);
  Result:=CurrentParagraph;  
end;

function TRLRichParser.NewParagraph(Reset:boolean):TRLRichParagraph;
begin
  CurrentParagraph:=TRLRichParagraph.Create(Self);
  if Reset then
    NeedCurrentStyle.Clear;
  Result:=CurrentParagraph;
end;

procedure TRLRichParser.LoadFromStream(Stream:TStream);
var
  StreamText:string;
begin
  SetLength(StreamText,Stream.Size);
  if Stream.Size>0 then
    Stream.Read(StreamText[1],Stream.Size);
  SetText(StreamText);
end;

procedure TRLRichParser.SetText(const NewText: string);
var
  OldCRC,NewCRC:word;
  OldLen,NewLen:integer;
begin
  NewLen:=Length(NewText);
  NewCRC:=CRC16(NewText);
  OldLen:=TextLength;
  OldCRC:=TextCRC;
  if (NewLen=OldLen) and (NewCRC=OldCRC) then
    Exit;
  //
  Clear;
  FormattedWidth:=0;
  Self.Stream:=TStringStream.Create(NewText);
  try
    Self.Stream.Position:=0;
    ReadDocument;
  finally
    Self.Stream:=nil;
  end;
  TextLength:=NewLen;
  TextCRC   :=NewCRC;
end;

procedure TRLRichParser.Format(RightMargin:integer);
var
  lineheight:integer;
  linewidth :integer;
  linecols  :integer;
  maxbaselin:integer;
  wrapwidth :integer;
  off       :integer;
  ipar      :integer;
  obji      :integer;
  obj0      :integer;
  iprt      :integer;
  obj       :TRLRichElement;
  par       :TRLRichParagraph;
  prt       :TRLRichWordPart;
  wrd       :TRLRichWord;
  sz        :TPoint;
  bd        :TRect;
  curx,cury :integer;
  oobj      :TRLRichObject;
  objw      :integer;
  objh      :integer;
  objbase   :integer;
  tab       :integer;
begin
  TextSize.x:=0;
  TextSize.y:=0;
  //
  curx:=0;
  cury:=0;
  if WordWrap then
    wrapwidth:=RightMargin
  else
    wrapwidth:=MaxInt;
  for ipar:=0 to Self.Children.Count-1 do
  begin
    par:=Paragraphs[ipar];
    if par.Children.Count>0 then
    begin
      // processa todos os elementos do paragrafo
      obji:=0;
      while obji<par.Children.Count do
      begin
        // calc quantos objetos cabem e quais as dimensoes da linha
        linewidth :=0;
        lineheight:=0;
        maxbaselin:=0;
        obj0      :=obji; // marca o primeiro obj da linha
        while obji<par.Children.Count do
        begin
          obj:=par.Children[obji];
          // pega a largura dependendo do tipo de objeto
          if obj is TRLRichObject then
          begin
            oobj   :=obj as TRLRichObject;
            sz     :=oobj.GetSize;
            objw   :=sz.x;
            objh   :=sz.y;
            objbase:=oobj.GetBaseLine;
          end
          else if obj is TRLRichTab then
          begin
            tab:=par.NextTab(linewidth);
            if tab>0 then
              objw:=tab-linewidth
            else
              objw:=TabSize;
            objh   :=0;
            objbase:=0;
          end
          else
          begin
            objw   :=0;
            objh   :=0;
            objbase:=0;
          end;
          // quebra linha somente apos o primeiro obj e se ainda houver outros objs
          if (obji>obj0) and (obji<par.Children.Count-1) and (linewidth+objw>wrapwidth) then
            Break;
          Inc(linewidth,objw);
          lineheight:=Max(lineheight,objh);
          maxbaselin:=Max(maxbaselin,objbase);
          Inc(obji);
        end;
        linecols:=obji-obj0;
        // faz a distribuição dos objetos com o devido alinhamento
        while obj0<obji do
        begin
          obj:=par.Children[obj0];
          if obj is TRLRichObject then
          begin
            oobj:=obj as TRLRichObject;
            oobj.Position.y:=cury+lineheight-oobj.GetSize.y-(maxbaselin-oobj.GetBaseLine);
            sz:=oobj.GetSize;
            case par.Alignment of
              'l':
              begin
                oobj.Position.x:=curx;
                Inc(curx,sz.x);
              end;
              'r':
              begin
                oobj.Position.x:=RightMargin-linewidth+curx;
                Inc(curx,sz.x);
              end;
              'c':
              begin
                oobj.Position.x:=(RightMargin-linewidth) div 2+curx;
                Inc(curx,sz.x);
              end;
              'j':
              begin
                oobj.Position.x:=curx;
                Inc(curx,sz.x);
                // o ultimo obj da linha que nao e o ultimo do paragrafo, e colado a direita
                if obji<par.Children.Count-1 then
                  if obj0=obji-1 then
                    curx:=RightMargin-sz.x
                  else
                    Inc(curx,(RightMargin-linewidth) div linecols);
              end;
            end;
            // ajusta a posicao das partes se for palavra
            if oobj is TRLRichWord then
            begin
              wrd:=(oobj as TRLRichWord);
              off:=0;
              for iprt:=0 to wrd.Children.Count-1 do
              begin
                prt:=wrd[iprt];
                prt.Position.x:=wrd.Position.x+off;
                prt.Position.y:=wrd.GetBounds.Bottom-prt.Size.y-(maxbaselin-prt.BaseLine);
                Inc(off,prt.Size.x);
              end;
            end;
            // recalcula dimensao do richtext
            bd        :=oobj.GetBounds;
            TextSize.x:=Max(TextSize.x,bd.Right);
            TextSize.y:=Max(TextSize.y,bd.Bottom);
          end
          else if obj is TRLRichTab then
          begin
            tab:=par.NextTab(curx);
            if tab=0 then
              Inc(curx,TabSize)
            else
              Inc(curx,tab-curx);
          end;
          //
          Inc(obj0);
        end;
        //
        Inc(cury,lineheight);
        curx:=0;
      end;
    end
    else
      Inc(cury,10); /// 10?
  end;
  FormattedWidth:=RightMargin;
  FormattedWrap :=WordWrap;
end;

procedure TRLRichParser.PaintTo(Canvas:TObject; const Rect:TRect);
var
  ipar,obji,iprt:integer;
  wrd:TRLRichWord;
  par:TRLRichParagraph;
  prt:TRLRichWordPart;
  obj:TRLRichElement;
  aux:TRect;
  nww:integer;
begin
  nww:=Rect.Right-Rect.Left;
  if (nww<>FormattedWidth) or (WordWrap<>FormattedWrap) then
    Format(nww);
  SetBrushColor(Canvas,clWindow);
  SetFontColor(Canvas,clWindowText);
  DoFillRect(Canvas,Rect);
  for ipar:=0 to Children.Count-1 do
  begin
    par:=Paragraphs[ipar];
    for obji:=0 to par.Children.Count-1 do
    begin
      obj:=par.Children[obji];
      if obj is TRLRichWord then
      begin
        wrd:=obj as TRLRichWord;
        for iprt:=0 to wrd.Children.Count-1 do
        begin
          prt:=wrd[iprt];
          CopyStyleToCanvas(prt.Style,Canvas);
          aux:=prt.GetBounds;
          OffsetRect(aux,Rect.Left,Rect.Top);
          DoTextOut(Canvas,aux.Left,aux.Top,prt.Text);
        end;
      end
      else if obj is TRLRichImg then
      begin
      end;
    end;
  end;
end;

function TRLRichParser.NeedAuxBmp: TBitmap;
begin
  if not Assigned(AuxBmp) then
  begin
    AuxBmp:=TBitmap.Create;
    AuxBmp.Width :=1;
    AuxBmp.Height:=1;
  end;
  Result:=AuxBmp;
end;

function TRLRichParser.GetParagraphs(i: integer): TRLRichParagraph;
begin
  Result:=Children[i] as TRLRichParagraph;
end;

{ TRLRichParagraph }

constructor TRLRichParagraph.Create(aParent:TRLRichElement);
var
  i:integer;
begin
  inherited;
  Alignment:='l';
  for i:=1 to MaxTabs do
    Tabs[i]:=i*TabSize;
end;

function TRLRichParagraph.CurrentWord: TRLRichWord;
begin
  if (Children.Count>0) and (Children[Children.Count-1] is TRLRichWord) then
    Result:=Children[Children.Count-1] as TRLRichWord
  else
    Result:=nil;
end;

function TRLRichParagraph.NeedCurrentWord: TRLRichWord;
begin
  if (CurrentWord=nil) or (Copy(CurrentWord.GetText,1,1)=#32) then
    NewWord;
  Result:=CurrentWord;
end;

function TRLRichParagraph.NewTab: TRLRichTab;
begin
  Result:=TRLRichTab.Create(Self);
end;

function TRLRichParagraph.NewWord: TRLRichWord;
begin
  Result:=TRLRichWord.Create(Self);
end;

function TRLRichParagraph.NextTab(AfterPos: integer): integer;
var
  i:integer;
begin
  i:=1;
  while (i<=MaxTabs) and (AfterPos>=Tabs[i]) do
    Inc(i);
  if i<=MaxTabs then
    Result:=Tabs[i]
  else
    Result:=0;
end;

{ TRLRichElement }

constructor TRLRichElement.Create(aParent: TRLRichElement);
begin
  inherited Create;
  Parent:=aParent;
  Children :=TRLRichElementList.Create;
  if Assigned(Parent) then
    Parent.Children.Add(Self);
end;

destructor TRLRichElement.Destroy;
begin
  if Assigned(Parent) then
    Parent.Children.Extract(Self);
  ///Children.Free;
  inherited;
end;

function TRLRichElement.Paragraph: TRLRichParagraph;
begin
  Result:=Parent as TRLRichParagraph;
end;

function TRLRichElement.Parser: TRLRichParser;
begin
  if Assigned(Parent) then
    if Parent is TRLRichParser then
      Result:=Parent as TRLRichParser
    else
      Result:=Parent.Parser
  else
    Result:=nil;
end;

{ TRLRichWord }

function TRLRichWord.GetBaseLine: integer;
var
  i:integer;
begin
  Result:=0;
  for i:=0 to Children.Count-1 do
    Result:=Max(Result,Parts[i].BaseLine);
end;

function TRLRichWord.GetParts(i: integer): TRLRichWordPart;
begin
  Result:=Children[i] as TRLRichWordPart;
end;

function TRLRichWord.GetSize: TPoint;
var
  i:integer;
begin
  Result:=Point(0,0);
  for i:=0 to Children.Count-1 do
  begin
    Inc(Result.x,Parts[i].Size.x);
    Result.y:=Max(Result.y,Parts[i].Size.y);
  end;
end;

function TRLRichWord.GetText: string;
var
  i:integer;
begin
  Result:='';
  for i:=0 to Children.Count-1 do
    Result:=Result+Parts[i].Text;
end;

function TRLRichWord.NewPart(const Text:string):TRLRichWordPart;
var
  bmp:TBitmap;
begin
  Result     :=TRLRichWordPart.Create(Self);
  Result.Text:=Text;
  Result.Style.Assign(Parser.NeedCurrentStyle);
  // calcula size
  bmp:=Parser.NeedAuxBmp;
  Parser.CopyStyleToCanvas(Result.Style,bmp.Canvas);
  Result.Size.x  :=bmp.Canvas.TextWidth(Result.Text);
  Result.Size.y  :=bmp.Canvas.TextHeight(Result.Text);
  Result.BaseLine:=CanvasGetDescent(bmp.Canvas);
end;

{ TRLCustomRichText }

constructor TRLCustomRichText.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  fParser:=nil;
end;

destructor TRLCustomRichText.Destroy;
begin
  inherited;
  FreeObj(fParser);
end;

procedure TRLCustomRichText.FormatNeeded(Width:integer);
begin
  if (Width<>fParser.FormattedWidth) or (WordWrap<>fParser.FormattedWrap) then
    fParser.Format(Width);
end;

procedure TRLCustomRichText.PrepareParser;
var
  s:string;
begin
  if not Assigned(fParser) then
    fParser:=TRLRichParser.Create(nil);
  // texto a utilizar para o cálculo
  s:=Caption;
  if (s='') and not IsPreparing then
    s:=Name;
  fParser.SetText(s);
  fParser.WordWrap:=Self.WordWrap;
  FormatNeeded(Self.ClientWidth);
end;

procedure TRLCustomRichText.CalcSize(var aSize:TPoint);
var
  w:integer;
begin
  aSize:=Point(Width,Height);
  if not AutoSize then
    Exit;
  // dimensões do texto
  PrepareParser;
  FormatNeeded(Self.ClientWidth);
  aSize.y:=fParser.TextSize.y;
  // adicional das bordas
  w:=Borders.Width;
  if w>0 then
  begin
    Inc(w);
    if Borders.CanDrawTop then
      Inc(aSize.y,w);
    if Borders.CanDrawBottom then
      Inc(aSize.y,w);
  end;
end;

function TRLCustomRichText.InternalMakeCaption: string;
begin
  Result:=Lines.Text;
end;

procedure TRLCustomRichText.InternalPrint;
begin
  PrintAsCustomControl;
  PrepareParser;
  fParser.PaintTo(RequestParentSurface,CalcPrintClientRect);
end;

procedure TRLCustomRichText.InternalPaint;
begin
  PaintAsCustomControl;
  PrepareParser;
  fParser.PaintTo(Canvas,GetClientRect);
end;

{ TRLCustomDBRichText }

constructor TRLCustomDBRichText.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  fParser:=nil;
end;

destructor TRLCustomDBRichText.Destroy;
begin
  inherited;
  FreeObj(fParser);
end;

procedure TRLCustomDBRichText.FormatNeeded(Width:integer);
begin
  if (Width<>fParser.FormattedWidth) or (WordWrap<>fParser.FormattedWrap) then
    fParser.Format(Width);
end;

procedure TRLCustomDBRichText.PrepareParser;
var
  s:string;
begin
  if not Assigned(fParser) then
    fParser:=TRLRichParser.Create(nil);
  // texto a utilizar para o cálculo
  s:=Caption;
  if (s='') and not IsPreparing then
    if DataField<>'' then
      s:=DataField
    else
      s:=Name;
  fParser.SetText(s);
  fParser.WordWrap:=Self.WordWrap;
  FormatNeeded(Self.ClientWidth);
end;

procedure TRLCustomDBRichText.CalcSize(var aSize:TPoint);
var
  w:integer;
begin
  aSize:=Point(Width,Height);
  if not AutoSize then
    Exit;
  // dimensões do texto
  PrepareParser;
  FormatNeeded(Self.ClientWidth);
  aSize.y:=fParser.TextSize.y;
  // adicional das bordas
  w:=Borders.Width;
  if w>0 then
  begin
    Inc(w);
    if Borders.CanDrawTop then
      Inc(aSize.y,w);
    if Borders.CanDrawBottom then
      Inc(aSize.y,w);
  end;
end;

function TRLCustomDBRichText.InternalMakeCaption: string;
begin
  Result:=GetFieldText;
end;

procedure TRLCustomDBRichText.InternalPrint;
begin
  PrintAsCustomControl;
  PrepareParser;
  fParser.PaintTo(RequestParentSurface,CalcPrintClientRect);
end;

procedure TRLCustomDBRichText.InternalPaint;
begin
  PaintAsCustomControl;
  PrepareParser;
  fParser.PaintTo(Canvas,GetClientRect);
end;

{ TRLRichWordPart }

constructor TRLRichWordPart.Create(aParent:TRLRichElement);
begin
  inherited;
  Text    :='';
  Style   :=TRLRichStyle.Create;
  BaseLine:=0;
  Size    :=Point(0,0);
end;

function TRLRichWordPart.GetBaseLine: integer;
begin
  Result:=BaseLine;
end;

function TRLRichWordPart.GetSize: TPoint;
begin
  Result:=Size;
end;

function TRLRichWordPart.Word: TRLRichWord;
begin
  Result:=Parent as TRLRichWord;
end;

{ TRLRichStyle }

procedure TRLRichStyle.Assign(Style: TRLRichStyle);
begin
  Self.Bold     :=Style.Bold;
  Self.Italic   :=Style.Italic;
  Self.Underline:=Style.Underline;
  Self.FontSize :=Style.FontSize;
  Self.FontNum  :=Style.FontNum;
  Self.ForeColor:=Style.ForeColor;
  Self.BkgdColor:=Style.BkgdColor;
end;

procedure TRLRichStyle.Clear;
begin
  Bold     :=False;
  Italic   :=False;
  Underline:=False;
  FontSize :=0;
  FontNum  :=0;
  ForeColor:=0;
  BkgdColor:=0;
end;

{ TRLRichObject }

constructor TRLRichObject.Create(aParent:TRLRichElement);
begin
  inherited;
  Position:=Point(0,0);
end;

function TRLRichObject.GetBounds: TRect;
var
  sz:TPoint;
begin
  Result.TopLeft:=Position;
  sz            :=GetSize;
  Result.Right  :=Result.Left+sz.x;
  Result.Bottom :=Result.Top +sz.y;
end;

{ TRLRichImg }

function TRLRichImg.GetBaseLine: integer;
begin
  Result:=0;
end;

function TRLRichImg.GetSize: TPoint;
begin
  Result:=Size;
end;

{ TRLRichElementList }

function TRLRichElementList.GetElements(i: integer): TRLRichElement;
begin
  Result:=Items[i] as TRLRichElement;
end;

end.

