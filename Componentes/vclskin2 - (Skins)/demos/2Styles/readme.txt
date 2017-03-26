              Delphi  VclSkin 2 Styles Demo

This demo has 2 skin file in application, one for main form, another for other forms.

1). put 2 skindata on main form, 
    sd1.SkinFormtype=sfMainform, 
    sd2.SkinFormtype=sfOnlyThisForm
2). add code in sd1.onskinform event

procedure TForm1.sd1FormSkin(Sender: TObject; aName: String;
  var DoSkin: Boolean);
begin
   if aname='Form1' then doskin:=false; //mainform name
end;


website : http://www.link-rank.com
email : info@link-rank.com