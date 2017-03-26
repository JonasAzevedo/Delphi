{@unit RLUtils - Rotinas de uso geral. }
unit RLUtils;

interface

uses
  SysUtils, Classes, Math,
{$ifndef LINUX}
  Windows,
{$else}
  Types,
{$endif}
{$ifndef LINUX}
  Graphics, Forms;
{$else}
  QGraphics, QForms;
{$endif}

{@var TempDir - Especifica aonde deverão ser criados os arquivos temporários.
 Na inicialização do sistema é atribuido um valor padrão a esta variável. Este valor pode ser alterado depois.
 No Windows o diretório padrão é "WINDOWS\TEMP", e no Linux é o "/tmp".
 @links GetTempFileName. :/}
var TempDir:string='.';

{@proc FreeObj - Libera objeto se não for nil e em seguida limpa a variável.
 @links FreePtr. :/}
procedure FreeObj(var aObj);

{@proc FreePtr - Libera ponteiro se não for nil e em seguida limpa a variável.
 @links FreeObj. :/}
procedure FreePtr(var aPtr);

{@func ByteToHex - Retorna o byte em notação hexadecimal de dois dígitos.
 @links HexToByte. :/}
function  ByteToHex(const aByte:byte):string;

{@func HexToByte - Retorna o valor hexadecimal como byte.
 @links ByteToHex. :/}
function  HexToByte(const aHex:string):byte;

{@func HexToBitmap - Cria bitmap a partir de uma cadeia hexadecimal.
 @links HexToGraphic, HexToByte. :/}
function  HexToBitmap(const aHex:string):TBitmap;

{@func HexToGraphic - Cria um gráfico qualquer a partir de uma cadeia hexadecimal.
 @links HexToBitmap, HexToByte. :/}
function  HexToGraphic(const aHex:string):TGraphic;

{@func NewComponentName - Cria um nome para um novo componente. :/}
function  NewComponentName(aComponent:TComponent):string;

{@func GetTempFileName - Retorna nome de arquivo temporário.
 @links TempDir. :/}
function  GetTempFileName:string;

{@func Token - Retorna a parte de número aIndex da string aTokenList cujas partes são separadas pelo caractere aTokenSeparator. :/}
function  Token(const aTokenList:string; aIndex:integer; aTokenSeparator:char='|'):string;

{@func ThreadIt - Executa um método ou procedure em segundo plano. :}
function  ThreadIt(aMethod:TThreadMethod; aLoop:boolean=false):TThread; overload;
{/@func}

{@func FormatFileExt - Adiciona ponto a uma extensão, se não houver. :/}
function  FormatFileExt(const aExt:string):string;

{@func AddFileFilter - Adiciona filtro de arquivos com nome aFilter, descrição aDescription e extensão padrão aExt. :/}
function  AddFileFilter(const aFilter:string; const aDescription,aExt:string):string;

{@func GetFileFilterExt - Devolve a extensão padrão para arquivos correspondentes ao filtro aFilter. :/}
function  GetFileFilterExt(const aFilter:string; aIndex:integer):string;

{@func RotatePoints - Rotaciona os pontos aPoints em 2D de acordo com o ângulo aAngle.
 @links RotateBitmap. :/}
procedure RotatePoints(var aPoints:array of TPoint; const aAngle:double);

{@func RotateBitmap - Rotaciona o bitmap TBitmap em 2D de acordo com o ângulo aAngle e devolve em aDest.
 Nota: O bitmap aDest deve ter tamanho suficiente para a imagem rotacionada. Este cálculo pode ser feito
 previamente com a proc RotatePoints.
 @links RotatePoints, RotatedBitmap. :/}
procedure RotateBitmap(aSource,aDest:TBitmap; aAngle:double; aAxis,aOffset:TPoint);

{@func RotatedBitmap - Cria e devolve um bitmap compatível com o bitmap aSource rotacionado em 2D de acordo com o ângulo aAngle com
 tamanho calculado.
 @links RotateBitmap. :/}
function  RotatedBitmap(aSource:TBitmap; aAngle:double):TBitmap;

{@func PointsRect - Retorna um retângulo delimitando a área definida pelos pontos aPoints.
 @links PointsSize. :/}
function  PointsRect(const aPoints:array of TPoint):TRect;

{@func PointsSize - Retorna o tamanho da área definida pelos pontos aPoints.
 @links PointsRect. :/}
function  PointsSize(const aPoints:array of TPoint):TPoint;

{@func ScalePoints - Modifica as dimensões dos pontos aPoints para que caibam no retângulo definido por aRect respeitando a proporção.
 @links PointsRect. :/}
procedure ScalePoints(var aPoints:array of TPoint; const aRect:TRect);

{@func StretchPoints - Amplia ou reduz as dimensões dos pontos aPoints para que caibam no retângulo definido por aRect.
 @links PointsRect. :/}
procedure StretchPoints(var aPoints:array of TPoint; const aRect:TRect);

{@func CenterPoints - Centraliza os pontos aPoints no retâgulo aRect.
 @links PointsRect. :/}
procedure CenterPoints(var aPoints:array of TPoint; const aRect:TRect);

{@func TextBounds - Calcula as dimensões do texto aText de acordo com a fonte aFont e opcionalmente rotacionado em
 2D de acordo com o ângulo aAngle.
 @links PointsRect. :/}
function  TextBounds(const aText:string; aFont:TFont; aAngle:double):TPoint;

{@proc MoveRect - Desloca o retângulo horizontalmente de acordo com aX e verticalmente de acordo com aY.
 Nota: Valores positivos deslocam o retângulo para a direita ou abaixo. :/}
procedure MoveRect(var aRect:TRect; aX,aY:integer);

{@func RectWidth - Retorna a largura do retângulo aRect.
 @links RectHeight. :/}
function  RectWidth(const aRect:TRect):integer;

{@func RectHeight - Retorna a largura do retângulo aRect.
 @links RectWidth. :/}
function  RectHeight(const aRect:TRect):integer;

{@func ReduceRect - Retorna o retângulo aRect reduzido de acordo com os decrementos especificados em aPixels. :/}
function  ReduceRect(const aRect:TRect; aPixels:TRect):TRect;

{@func IncreaseRect - Retorna o retângulo aRect ampliado de acordo com os incrementos especificados em aPixels. :/}
function  IncreaseRect(const aRect:TRect; aPixels:TRect):TRect;

{@func DiffRect - Retorna a diferença entre os retângulos aRectOut e aRectIn, desde que aRectIn esteja dentro
 de aRectOut. :/}
function  DiffRect(const aRectOut,aRectIn:TRect):TRect;

{@func IterateJustification - Faz a justificação do texto distribuindo espaços. A função deve ser executada até
 se obter a largura total do texto. :/}
function  IterateJustification(var aText:string; var aIndex:integer):boolean;

{@func ScaleRect - Calcula a maior amostra do retângulo aSource escalonado de modo a caber em aTarget. :/}
function  ScaleRect(const aSource,aTarget:TRect; aCenter:boolean):TRect;

procedure StreamWrite(aStream:TStream; const aStr:string);
procedure StreamWriteLn(aStream:TStream; const aStr:string='');

{@proc RegisterTempFile - Registra um arquivo temporário para ser excluído na finalização. :/}
procedure RegisterTempFile(const aFileName:string);
{@proc UnregisterTempFile - Retira arquivo temporário da lista de arquivos a excluir na finalizacão. :/}
procedure UnregisterTempFile(const aFileName:string);
{@proc ClearTempFiles - Destroi arquivos temporários registrados pela proc RegisterTempFile. :/}
procedure ClearTempFiles;

procedure CRC16Add(var Result:word; Data:char);
function  CRC16(const Data; DataLen:integer):word; overload;
function  CRC16(const Str:string):word; overload;
function  CRC16(Stream:TStream):word; overload;

var
  LogFileName:string='rlib.log';

procedure LogClear;
procedure Log(const aMsg:string);

type
{$ifdef KYLIX}
  TRGBQuad=packed record
    rgbBlue    :byte;
    rgbGreen   :byte;
    rgbRed     :byte;
    rgbReserved:byte;
  end;
{$endif}
  TRGBArray=array[0..0] of TRGBQuad;
  PRGBArray=^TRGBArray;

{$ifdef KYLIX}
function RGB(r, g, b: Byte): TColor;
{$endif}

{/@unit}

implementation

procedure LogClear;
begin
  if FileExists(LogFileName) then
    SysUtils.DeleteFile(LogFileName);
end;

procedure Log(const aMsg:string);
var
  loghandle:textfile;
begin
  AssignFile(loghandle,LogFileName);
  if FileExists(LogFileName) then
    Append(loghandle)
  else
    Rewrite(loghandle);
  WriteLn(loghandle,TimeToStr(Time)+': '+aMsg);
  CloseFile(loghandle);
end;

type
  dw=record
    h,l:word;
  end;

const
  HEXDIGITS:string[16]='0123456789ABCDEF';

function ByteToHex(const aByte:byte):string;
begin
  Result:=HEXDIGITS[(aByte and $f0) shr 4+1]+HEXDIGITS[(aByte and $0f)+1];
end;

function HexToByte(const aHex:string):byte;
begin
  Result:=(Pos(UpCase(aHex[1]),HEXDIGITS)-1)*16+Pos(UpCase(aHex[2]),HEXDIGITS)-1;
end;

procedure FreeObj(var aObj);
begin
  if assigned(TObject(aObj)) then
    TObject(aObj).free;
{$ifdef Win32}
  TObject(aObj):=nil;
{$endif}
end;

procedure FreePtr(var aPtr);
begin
{$ifdef Win32}
  if assigned(pointer(aPtr)) then
    FreeMem(pointer(aPtr));
  pointer(aPtr):=nil;
{$endif}
end;

{$ifdef KYLIX}
function RGB(r, g, b: Byte): TColor;
begin
  Result := (r or (g shl 8) or (b shl 16));
end;
{$endif}

type
  TPublicGraphic=class(TGraphic)
  end;

function HexToBitmap(const aHex:string):TBitmap;
var
  stream:TStringStream;
  i,l   :integer;
begin
  stream:=TStringStream.Create('');
  try
    // traduz string hex em binária
    l:=Length(aHex);
    i:=1;
    while i<l do
    begin
      stream.WriteString(char(HexToByte(aHex[i]+aHex[i+1])));
      inc(i,2);
    end;
    // procura referência para a classe
    Result:=TBitmap.Create;
    try
      stream.Seek(0,soFromBeginning);
      //corrigir aqui
      TPublicGraphic(Result).ReadData(stream);
    except
      FreeObj(Result);
      raise;
    end;
  finally
    FreeObj(stream);
  end;
end;

function HexToGraphic(const aHex:string):TGraphic;
var
  graphclassname:string[63];
  graphclass    :TGraphicClass;
  stream        :TStringStream;
  i,l           :integer;
begin
  Result:=nil;
  stream:=TStringStream.Create('');
  try
    // traduz string hex em binária
    l:=Length(aHex);
    i:=1;
    while i<l do
    begin
      stream.WriteString(char(HexToByte(aHex[i]+aHex[i+1])));
      inc(i,2);
    end;
    // pega o nome da classe
    stream.Seek(0,soFromBeginning);
    //corrigir aqui
    stream.Read(graphclassname[0],1);
    stream.Read(graphclassname[1],byte(graphclassname[0]));

    // procura referência para a classe
    graphclassname:=UpperCase(graphclassname);
    if graphclassname='TBITMAP' then
      graphclass:=TBitmap
    else if graphclassname='TICON' then
      graphclass:=TIcon
    else
      graphclass:=nil;
    // instancia e carrega o grafico
    if graphclass<>nil then
    begin
      Result:=graphclass.Create;
      try
        TPublicGraphic(Result).ReadData(stream);
      except
        FreeObj(Result);
        raise;
      end;
    end;
  finally
    FreeObj(stream);
  end;
end;

// diretório temporário
function GetTempDir:string;
{$ifndef LINUX}
var
  p:array[0..255] of char;
  h:string;
{$endif}
begin
{$ifndef LINUX}
  GetDir(0,h);                 // salva diretório atual
  GetWindowsDirectory(@p,256); // diretório do windows
  ChDir(strpas(p));
  try
    GetTempPath(256,@p);
    Result:=strpas(p);
  finally
    ChDir(h);
  end;
{$else}
  Result:='/tmp';
{$endif}
end;

function NewComponentName(aComponent:TComponent):string;
var
  p,n:string;
  i,m:integer;
begin
  p:=aComponent.ClassName;
  if UpperCase(p[1])='T' then
    delete(p,1,1);
  m:=0;
  for i:=0 to aComponent.Owner.ComponentCount-1 do
  begin
    n:=aComponent.Owner.Components[i].Name;
    if AnsiSameText(Copy(n,1,Length(p)),p) then
      m:=Max(m,StrToIntDef(Copy(n,Length(p)+1,Length(n)),0));
  end;
  Result:=p+IntToStr(m+1);
end;

function GetTempFileName:string;
var
  tmppath:string;
begin
  Randomize;
  tmppath:=TempDir;
  if tmppath<>'' then
    tmppath:=IncludeTrailingPathDelimiter(tmppath);
  repeat
    Result:=tmppath+'~fr'+IntToStr(Random(MaxInt))+'.tmp';
  until not FileExists(Result);
end;


function Token(const aTokenList:string; aIndex:integer; aTokenSeparator:char='|'):string;
var
  i,m,count:integer;
begin
  Result:='';
  count:=0;
  i:=1;
  while i<=Length(aTokenList) do
  begin
    m:=i;
    while (i<=Length(aTokenList)) and (aTokenList[i]<>aTokenSeparator) do
      inc(i);
    inc(count);
    if count=aIndex then
    begin
      Result:=Copy(aTokenList,m,i-m);
      break;
    end;
    inc(i);
  end;
end;

type
  TInternalThread=class(TThread)
  protected
    fMethod:TThreadMethod;
    fProc  :TProcedure;
    fLoop  :boolean;
    //
    procedure   Execute; override;
    //
    procedure   Call;
  public
    constructor Create(aMethod:TThreadMethod; aLoop:boolean); overload;
    constructor Create(aProc:TProcedure; aLoop:boolean); overload;
  end;

constructor TInternalThread.Create(aMethod:TThreadMethod; aLoop:boolean);
begin
  FreeOnTerminate:=true;
  fMethod        :=aMethod;
  fProc          :=nil;
  fLoop          :=aLoop;
  //
  inherited Create(false);
end;

constructor TInternalThread.Create(aProc:TProcedure; aLoop:boolean);
begin
  FreeOnTerminate:=true;
  fMethod        :=nil;
  fProc          :=aProc;
  fLoop          :=aLoop;
  //
  inherited Create(false);
end;

procedure TInternalThread.Call;
begin
  while fLoop and not Terminated do
  begin
    if assigned(@fProc) then
      fProc;
    if assigned(@fMethod) then
      fMethod;
  end;
end;

procedure TInternalThread.Execute;
begin
  Synchronize(Call);
end;

function ThreadIt(aMethod:TThreadMethod; aLoop:boolean=false):TThread;
begin
  Result:=TInternalThread.Create(aMethod,aLoop);
end;


function FormatFileExt(const aExt:string):string;
begin
  if (aExt<>'') and (aExt[1]<>'.') then
    Result:='.'+aExt
  else
    Result:=aExt;
end;

function AddFileFilter(const aFilter:string; const aDescription,aExt:string):string;
begin
  Result:=aFilter;
  if Result<>'' then
    Result:=Result+'|';
  Result:=Result+aDescription+' (*'+FormatFileExt(aExt)+')';
{$ifdef Win32}
  Result:=Result+'|*'+FormatFileExt(aExt);
{$else} {$ifdef DELPHI7}
  Result:=Result+'|*'+FormatFileExt(aExt);
{$endif}
{$endif}
end;

function GetFileFilterExt(const aFilter:string; aIndex:integer):string;
var
  p,i:integer;
  m:string;
begin
  if aIndex=0 then
    aIndex:=1;
  i:=1;
  while i<=aIndex do
  begin
    m:=Token(aFilter,i,'|');
    p:=Pos('(',m);
    if p>0 then
      delete(m,1,p);
    p:=Pos(')',m);
    if p>0 then
      m:=Copy(m,1,p-1);
    inc(i);
{$ifdef Win32}
    inc(i);
{$else} {$ifdef DELPHI7}
    inc(i);
{$endif}
{$endif}
  end;
  p:=Pos('.',m);
  if p>0 then
    delete(m,1,p);
  Result:=FormatFileExt(m);
end;

procedure RotatePoints(var aPoints:array of TPoint; const aAngle:double);
var
  theta   :double;
  costheta:double;
  sintheta:double;
  center  :TPoint;
  i,q     :integer;
procedure RotatePoint(var aPoint:TPoint);
var
  saved:TPoint;
begin
  saved   :=aPoint;
  aPoint.x:=round(saved.x*costheta-saved.y*sintheta);
  aPoint.y:=round(saved.x*sintheta+saved.y*costheta);
end;
begin
  theta   :=-aAngle*pi/180; // radians
  sintheta:=sin(theta);
  costheta:=cos(theta);
  // calcula centro
  center.x:=0;
  center.y:=0;
  q:=High(aPoints)+1;
  for i:=0 to q-1 do
  begin
    inc(center.x,aPoints[i].x);
    inc(center.y,aPoints[i].y);
  end;
  center.x:=round(center.x/q);
  center.y:=round(center.y/q);
  // roda
  for i:=0 to q-1 do
  begin
    dec(aPoints[i].x,center.x);
    dec(aPoints[i].y,center.y);
    RotatePoint(aPoints[i]);
    inc(aPoints[i].x,center.x);
    inc(aPoints[i].y,center.y);
  end;
end;

procedure RotateBitmap(aSource,aDest:TBitmap; aAngle:double; aAxis,aOffset:TPoint);
type
{$ifdef KYLIX}
  TRGBQuad=packed record
    rgbBlue    :byte;
    rgbGreen   :byte;
    rgbRed     :byte;
    rgbReserved:byte;
  end;
{$endif}
  PRGBArray=^TRGBArray;
  TRGBArray=array[0..0] of TRGBQuad;
const
  RGBBlack:TRGBQuad=(rgbBlue:0; rgbGreen:0; rgbRed:0; rgbReserved:0);
var
  x            :integer;
  xDest        :integer;
  xOriginal    :integer;
  xPrime       :integer;
  xPrimeRotated:integer;
  //
  y            :integer;
  yDest        :integer;
  yOriginal    :integer;
  yPrime       :integer;
  yPrimeRotated:integer;
  //
  RowSource    :PRGBArray;
  RowDest      :PRGBArray;
  //
  Radians      :double;
  RadiansCos   :double;
  RadiansSin   :double;
begin
  // Convert degrees to radians. Use minus sign to force clockwise rotation.
  Radians   :=aAngle*PI/180;
  RadiansSin:=sin(Radians);
  RadiansCos:=cos(Radians);
  // Step through each row of rotated image.
  for y:=0 to aDest.Height-1 do
  begin
    RowDest:=aDest.ScanLine[y];
    yDest  :=y-aOffset.y;
    yPrime :=2*(yDest-aAxis.y)+1; // center y: -1,0,+1
    // Step through each col of rotated image.
    for x:=0 to aDest.Width-1 do
    begin
      xDest :=x-aOffset.x;
      xPrime:=2*(xDest-aAxis.x)+1; // center x: -1,0,+1
      // Rotate (xPrime, yPrime) to location of desired pixel
      // Note:  There is negligible difference between floating point and scaled integer arithmetic here, so keep the math simple (and readable).
      xPrimeRotated:=round(xPrime*RadiansCos-yPrime*RadiansSin);
      yPrimeRotated:=round(xPrime*RadiansSin+yPrime*RadiansCos);
      // Transform back to pixel coordinates of image, including translation
      // of origin from axis of rotation to origin of image.
      xOriginal:=(xPrimeRotated-1) div 2+aAxis.x;
      yOriginal:=(yPrimeRotated-1) div 2+aAxis.y;
      // Make sure (xOriginal, yOriginal) is in aSource.  If not, assign blue color to corner points.
      if (xOriginal>=0) and (xOriginal<=aSource.Width-1) and (yOriginal>=0) and (yOriginal<=aSource.Height-1) then
      begin
        // Assign pixel from rotated space to current pixel in aDest
        RowSource :=aSource.ScanLine[yOriginal];
        RowDest[x]:=RowSource[xOriginal];
      end
      else if aSource.Height>0 then
      begin
        RowSource :=aSource.ScanLine[0];
        RowDest[x]:=RowSource[0];
      end
      else
        RowDest[x]:=RGBBlack;
    end;
  end;
end;

function RotatedBitmap(aSource:TBitmap; aAngle:double):TBitmap;
var
  p:array[0..3] of TPoint;
  r:TRect;
begin
  p[0]:=Point(0,0);
  p[1]:=Point(aSource.Width-1,0);
  p[2]:=Point(aSource.Width-1,aSource.Height-1);
  p[3]:=Point(0,aSource.Height-1);
  RotatePoints(p,aAngle);
  r:=PointsRect(p);
  //
  Result:=TBitmap.Create;
  try
    Result.PixelFormat     :=pf32bit;
    Result.Width           :=r.Right-r.Left;
    Result.Height          :=r.Bottom-r.Top;
    Result.Transparent     :=aSource.Transparent;
    Result.TransparentColor:=aSource.TransparentColor;
    Result.TransparentMode :=aSource.TransparentMode;
    RotateBitmap(aSource,Result,aAngle,Point(aSource.Width div 2,aSource.Height div 2),Point(-r.Left,-r.Top));
  except
    Result.free;
    raise;
  end;
end;

function PointsRect(const aPoints:array of TPoint):TRect;
var
  i:integer;
begin
  for i:=0 to High(aPoints) do
    if i=0 then
    begin
      Result.Left  :=aPoints[i].x;
      Result.Top   :=aPoints[i].y;
      Result.Right :=aPoints[i].x;
      Result.Bottom:=aPoints[i].y;
    end
    else
    begin
      Result.Left  :=Min(Result.Left  ,aPoints[i].x);
      Result.Top   :=Min(Result.Top   ,aPoints[i].y);
      Result.Right :=Max(Result.Right ,aPoints[i].x);
      Result.Bottom:=Max(Result.Bottom,aPoints[i].y);
    end;
end;

function PointsSize(const aPoints:array of TPoint):TPoint;
begin
  with PointsRect(aPoints) do
  begin
    Result.x:=Right-Left;
    Result.y:=Bottom-Top;
  end;
end;

procedure ScalePoints(var aPoints:array of TPoint; const aRect:TRect);
var
  bounds:TRect;
  fx,fy :double;
  i,len :integer;
begin
  bounds:=PointsRect(aPoints);
  if RectWidth(bounds)<>0 then
    fx:=RectWidth(aRect)/RectWidth(bounds)
  else
    fx:=0;
  if RectHeight(bounds)<>0 then
    fy:=RectHeight(aRect)/RectHeight(bounds)
  else
    fy:=0;
  if fx=0 then
    fx:=fy;
  if fy=0 then
    fy:=fx;
  if (fx=0) or (fy=0) then
    Exit;  
  if fx<fy then
    fy:=fx
  else
    fx:=fy;
  len:=High(aPoints)+1;
  for i:=0 to len-1 do
    with aPoints[i] do
    begin
      x:=Round((x-bounds.Left)*fx)+aRect.Left;
      y:=Round((y-bounds.Top)*fy)+aRect.Top;
    end;
end;

procedure StretchPoints(var aPoints:array of TPoint; const aRect:TRect);
var
  bounds:TRect;
  fx,fy :double;
  i,len :integer;
begin
  bounds:=PointsRect(aPoints);
  if RectWidth(bounds)<>0 then
    fx:=RectWidth(aRect)/RectWidth(bounds)
  else
    fx:=0;
  if RectHeight(bounds)<>0 then
    fy:=RectHeight(aRect)/RectHeight(bounds)
  else
    fy:=0;
  if fx=0 then
    fx:=1;
  if fy=0 then
    fy:=1;
  if (fx=0) or (fy=0) then
    Exit;  
  len:=High(aPoints)+1;
  for i:=0 to len-1 do
    with aPoints[i] do
    begin
      x:=Round((x-bounds.Left)*fx)+aRect.Left;
      y:=Round((y-bounds.Top)*fy)+aRect.Top;
    end;
end;

procedure CenterPoints(var aPoints:array of TPoint; const aRect:TRect);
var
  bounds :TRect;
  ofx,ofy:integer;
  i,len  :integer;
begin
  bounds:=PointsRect(aPoints);
  ofx   :=(RectWidth(aRect)-RectWidth(bounds)) div 2;
  ofy   :=(RectHeight(aRect)-RectHeight(bounds)) div 2;
  len   :=High(aPoints)+1;
  for i:=0 to len-1 do
    with aPoints[i] do
    begin
      x:=x-bounds.Left+aRect.Left+ofx;
      y:=y-bounds.Top+aRect.Top+ofy;
    end;
end;

function TextBounds(const aText:string; aFont:TFont; aAngle:double):TPoint;
var
  b:TBitmap;
  p:array[0..3] of TPoint;
begin
  b:=TBitmap.Create;
  try
    b.Width :=1;
    b.Height:=1;
    b.Canvas.Font.Assign(aFont);
    Result.x:=b.Canvas.TextWidth(aText);
    Result.y:=b.Canvas.TextHeight(aText);
    if aAngle<>0 then
    begin
      p[0]:=Point(0,0);
      p[1]:=Point(Result.x,0);
      p[2]:=Point(Result.x,Result.y);
      p[3]:=Point(0,Result.y);
      RotatePoints(p,aAngle);
      Result:=PointsSize(p);
    end;
  finally
    b.free;
  end;
end;

procedure MoveRect(var aRect:TRect; aX,aY:integer);
begin
  OffsetRect(aRect,-aRect.Left+aX,-aRect.Top+aY);
end;

function RectWidth(const aRect:TRect):integer;
begin
  Result:=aRect.Right-aRect.Left;
end;

function RectHeight(const aRect:TRect):integer;
begin
  Result:=aRect.Bottom-aRect.Top;
end;

function ReduceRect(const aRect:TRect; aPixels:TRect):TRect;
begin
  Result.Left  :=aRect.Left  +aPixels.Left;
  Result.Top   :=aRect.Top   +aPixels.Top;
  Result.Right :=aRect.Right -aPixels.Right;
  Result.Bottom:=aRect.Bottom-aPixels.Bottom;
end;

function IncreaseRect(const aRect:TRect; aPixels:TRect):TRect;
begin
  Result.Left  :=aRect.Left  -aPixels.Left;
  Result.Top   :=aRect.Top   -aPixels.Top;
  Result.Right :=aRect.Right +aPixels.Right;
  Result.Bottom:=aRect.Bottom+aPixels.Bottom;
end;

function DiffRect(const aRectOut,aRectIn:TRect):TRect;
begin
  Result.Left  :=aRectIn.Left   +aRectOut.Left;
  Result.Top   :=aRectIn.Top    +aRectOut.Top;
  Result.Right :=aRectOut.Right -aRectIn.Right;
  Result.Bottom:=aRectOut.Bottom-aRectIn.Bottom;
end;

function IterateJustification(var aText:string; var aIndex:integer):boolean;
  function FindSpc:boolean;
  const
    SPC=[#32,#9,#13,#10];
  begin
    Result:=false;
    while (aIndex>0) and (aText[aIndex] in SPC) do
      Dec(aIndex);
    while aIndex>0 do
      if aText[aIndex] in SPC then
      begin
        while (aIndex>0) and (aText[aIndex] in SPC) do
          Dec(aIndex);
        if aIndex>0 then
        begin
          Insert(#32,aText,aIndex+1);
          Result:=true;
        end;
        break;
      end
      else
        Dec(aIndex);
  end;
begin
  Result:=FindSpc;
  if not Result then
  begin
    aIndex:=Length(aText);
    Result:=FindSpc;
  end;
end;

function ScaleRect(const aSource,aTarget:TRect; aCenter:boolean):TRect;
var
  sw,sh,tw,th,w,h:integer;
  fw,fh:double;
begin
  sw:=aSource.Right-aSource.Left;
  sh:=aSource.Bottom-aSource.Top;
  tw:=aTarget.Right-aTarget.Left;
  th:=aTarget.Bottom-aTarget.Top;
  // calcula o maior dos fatores de proporção entre largura e altura
  fw:=tw/sw;
  fh:=th/sh;
  if fw>fh then
  begin
    h:=th;
    w:=round(h*sw/sh);
  end
  else
  begin
    w:=tw;
    h:=round(w*sh/sw);
  end;
  Result.Left  :=aTarget.Left;
  Result.Top   :=aTarget.Top;
  Result.Right :=Result.Left+w;
  Result.Bottom:=Result.Top+h;
  if aCenter then
    OffsetRect(Result,(tw-w) div 2,(th-h) div 2);
end;

procedure StreamWrite(aStream:TStream; const aStr:string);
begin
  if aStr<>'' then
    aStream.Write(aStr[1],Length(aStr));
end;

procedure StreamWriteLn(aStream:TStream; const aStr:string='');
begin
  StreamWrite(aStream,aStr);
  StreamWrite(aStream,#13#10);
end;

var
  TempFileNames:TStringList=nil;

procedure RegisterTempFile(const aFileName:string);
begin
  if not Assigned(TempFileNames) then
    TempFileNames:=TStringList.Create;
  TempFileNames.Add(aFileName);
end;

procedure UnregisterTempFile(const aFileName:string);
var
  i:integer;
begin
  if Assigned(TempFileNames) then
  begin
    i:=TempFileNames.IndexOf(aFileName);
    if i<>-1 then
      TempFileNames.Delete(i);
  end;
end;

procedure ClearTempFiles;
var
  i:integer;
begin
  if Assigned(TempFileNames) then
  begin
    for i:=0 to TempFileNames.Count-1 do
      SysUtils.DeleteFile(TempFileNames[i]);
    TempFileNames.Free;
    TempFileNames:=nil;
  end;
end;

const
  tab:array[0..255] of word=(
    $0000, $1021, $2042, $3063, $4084, $50a5, $60c6, $70e7,
    $8108, $9129, $a14a, $b16b, $c18c, $d1ad, $e1ce, $f1ef,
    $1231, $0210, $3273, $2252, $52b5, $4294, $72f7, $62d6,
    $9339, $8318, $b37b, $a35a, $d3bd, $c39c, $f3ff, $e3de,
    $2462, $3443, $0420, $1401, $64e6, $74c7, $44a4, $5485,
    $a56a, $b54b, $8528, $9509, $e5ee, $f5cf, $c5ac, $d58d,
    $3653, $2672, $1611, $0630, $76d7, $66f6, $5695, $46b4,
    $b75b, $a77a, $9719, $8738, $f7df, $e7fe, $d79d, $c7bc,
    $48c4, $58e5, $6886, $78a7, $0840, $1861, $2802, $3823,
    $c9cc, $d9ed, $e98e, $f9af, $8948, $9969, $a90a, $b92b,
    $5af5, $4ad4, $7ab7, $6a96, $1a71, $0a50, $3a33, $2a12,
    $dbfd, $cbdc, $fbbf, $eb9e, $9b79, $8b58, $bb3b, $ab1a,
    $6ca6, $7c87, $4ce4, $5cc5, $2c22, $3c03, $0c60, $1c41,
    $edae, $fd8f, $cdec, $ddcd, $ad2a, $bd0b, $8d68, $9d49,
    $7e97, $6eb6, $5ed5, $4ef4, $3e13, $2e32, $1e51, $0e70,
    $ff9f, $efbe, $dfdd, $cffc, $bf1b, $af3a, $9f59, $8f78,
    $9188, $81a9, $b1ca, $a1eb, $d10c, $c12d, $f14e, $e16f,
    $1080, $00a1, $30c2, $20e3, $5004, $4025, $7046, $6067,
    $83b9, $9398, $a3fb, $b3da, $c33d, $d31c, $e37f, $f35e,
    $02b1, $1290, $22f3, $32d2, $4235, $5214, $6277, $7256,
    $b5ea, $a5cb, $95a8, $8589, $f56e, $e54f, $d52c, $c50d,
    $34e2, $24c3, $14a0, $0481, $7466, $6447, $5424, $4405,
    $a7db, $b7fa, $8799, $97b8, $e75f, $f77e, $c71d, $d73c,
    $26d3, $36f2, $0691, $16b0, $6657, $7676, $4615, $5634,
    $d94c, $c96d, $f90e, $e92f, $99c8, $89e9, $b98a, $a9ab,
    $5844, $4865, $7806, $6827, $18c0, $08e1, $3882, $28a3,
    $cb7d, $db5c, $eb3f, $fb1e, $8bf9, $9bd8, $abbb, $bb9a,
    $4a75, $5a54, $6a37, $7a16, $0af1, $1ad0, $2ab3, $3a92,
    $fd2e, $ed0f, $dd6c, $cd4d, $bdaa, $ad8b, $9de8, $8dc9,
    $7c26, $6c07, $5c64, $4c45, $3ca2, $2c83, $1ce0, $0cc1,
    $ef1f, $ff3e, $cf5d, $df7c, $af9b, $bfba, $8fd9, $9ff8,
    $6e17, $7e36, $4e55, $5e74, $2e93, $3eb2, $0ed1, $1ef0);

procedure CRC16Add(var Result:word; Data:char);
begin
  Result:=((Hi(tab[Hi(Result)]) xor Lo(Result)) shl 8)+(Lo(tab[Hi(Result)]) xor Byte(Data));
end;

function CRC16(const Data; DataLen:integer):word;
var
  i:integer;
  p:PChar;
begin
  Result:=0;
  p:=@Data;
  for i:=0 to DataLen-1 do
    CRC16Add(Result,p[i]);
end;

function CRC16(const Str:string):word;
var
  len:integer;
begin
  len:=Length(Str);
  if len=0 then
    result:=0
  else
    result:=CRC16(Str[1],len);
end;

function CRC16(Stream:TStream):word;
const
  MaxBuffer=16384;
var
  Buffer:packed array[0..MaxBuffer-1] of char;
  BufferLength,i:integer;
begin
  Result:=0;
  repeat
    BufferLength:=Stream.Read(Buffer,MaxBuffer);
    if BufferLength=0 then
      Break;
    for i:=0 to BufferLength-1 do   
      CRC16Add(Result,Buffer[i]);
  until False;
end;

initialization
  LogFileName:=IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'RLib.log';
  TempDir:=GetTempDir;
  LogClear;

finalization
  ClearTempFiles;

end.


