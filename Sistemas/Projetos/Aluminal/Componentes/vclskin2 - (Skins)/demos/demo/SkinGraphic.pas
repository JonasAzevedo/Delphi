unit SkinGraphic;

interface
uses Windows,SysUtils,Classes,Graphics,Jpeg;

type
  TSkinGraphic = Class (TJPEGImage)
  private
  protected
  public
     procedure LoadFromFile(const FileName: string);override;
  end;

implementation

procedure TSkinGraphic.LoadFromFile(const FileName: string);
var s,s1:string;
    temp:Tbitmap;
begin
   s1:= ExtractFileExt(filename);
   s:= FileName;
   s:= StringReplace(s,s1,'.jpg',[rfIgnoreCase]);
   if fileexists(s) then
     inherited loadfromfile(s)
   else begin
     temp:=Tbitmap.create;
     temp.Width:=150;
     temp.height:=25;
     temp.Canvas.TextOut(1,1,'No Preview Image Found');
     assign(temp);
     temp.free;
   end;
end;

initialization
  TPicture.RegisterFileFormat('skn','Skin File', TSkinGraphic);
finalization
  TPicture.UnregisterGraphicClass(TSkinGraphic);
end.
